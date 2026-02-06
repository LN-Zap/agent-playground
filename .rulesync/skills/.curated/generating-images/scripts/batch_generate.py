#!/usr/bin/env python3
# /// script
# requires-python = ">=3.10"
# dependencies = [
#     "google-genai",
#     "pillow",
#     "python-dotenv",
# ]
# ///
"""
Batch generate images using Google's Gemini image models.

Usage:
    uv run batch_generate.py --prompt "A colorful abstract pattern" -n 20 -d ./patterns -p pattern
    uv run batch_generate.py --prompt "Minimalist icon" -n 10 --aspect 1:1 --model pro --size 2K
    uv run batch_generate.py --prompt "Product mockup" -n 5 --aspect landscape --parallel 3
    uv run batch_generate.py --prompt "Real landmark" -n 10 --search
"""

import argparse
import os
import sys
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from threading import Lock

from dotenv import load_dotenv
from google import genai
from google.genai import types
from PIL import Image

# Load environment variables from .env if it exists
load_dotenv()

MODEL_IDS = {
    "flash": "gemini-2.5-flash-image",
    "pro": "gemini-3-pro-image-preview",
}

# Thread-safe print lock for parallel execution
print_lock = Lock()


def get_aspect_instruction(aspect: str) -> str:
    """Return aspect ratio instruction for the prompt."""
    aspects = {
        "square": "Generate a square image (1:1 aspect ratio).",
        "landscape": "Generate a landscape/wide image (16:9 aspect ratio).",
        "portrait": "Generate a portrait/tall image (9:16 aspect ratio).",
        "1:1": "Generate a square image (1:1 aspect ratio).",
        "2:3": "Generate a 2:3 portrait image.",
        "3:2": "Generate a 3:2 landscape image.",
        "3:4": "Generate a 3:4 tall portrait image.",
        "4:3": "Generate a 4:3 standard image.",
        "4:5": "Generate a 4:5 portrait image.",
        "5:4": "Generate a 5:4 landscape image.",
        "9:16": "Generate a 9:16 tall portrait image.",
        "16:9": "Generate a 16:9 widescreen image.",
        "21:9": "Generate a 21:9 ultra-wide cinematic image.",
    }
    return aspects.get(aspect, aspects["square"])


def find_project_root() -> Path:
    """Find the project root by traversing up from the current working directory."""
    markers = [".git", "package.json", "devenv.nix", "pyproject.toml", "Cargo.toml"]
    
    curr = Path.cwd().resolve()
    for parent in [curr] + list(curr.parents):
        if any((parent / marker).exists() for marker in markers):
            return parent
    
    return curr


def generate_single_image(
    prompt: str,
    output_path: str,
    aspect: str = "square",
    model: str = "flash",
    size: str = "1K",
    use_search: bool = False,
) -> dict:
    """Generate a single image and return result info."""
    api_key = os.environ.get("GEMINI_API_KEY")
    if not api_key:
        return {
            "success": False,
            "error": "GEMINI_API_KEY not set",
            "path": None,
        }

    try:
        client = genai.Client(api_key=api_key)

        aspect_instruction = get_aspect_instruction(aspect)
        full_prompt = f"{aspect_instruction} {prompt}"

        model_id = MODEL_IDS[model]

        # Pro model supports additional config for resolution
        if model == "pro":
            aspect_ratios = {"square": "1:1", "landscape": "16:9", "portrait": "9:16"}
            if aspect in aspect_ratios:
                aspect_ratio = aspect_ratios[aspect]
            else:
                aspect_ratio = aspect if aspect not in ["square", "landscape", "portrait"] else aspect_ratios.get(aspect, "1:1")
            
            config = types.GenerateContentConfig(
                response_modalities=["TEXT", "IMAGE"],
                image_config=types.ImageConfig(
                    aspect_ratio=aspect_ratio,
                    image_size=size,
                ),
            )
            
            if use_search:
                config = types.GenerateContentConfig(
                    response_modalities=["TEXT", "IMAGE"],
                    image_config=types.ImageConfig(
                        aspect_ratio=aspect_ratio,
                        image_size=size,
                    ),
                    tools=[types.Tool(google_search=types.GoogleSearch())],
                )
            
            response = client.models.generate_content(
                model=model_id,
                contents=[full_prompt],
                config=config,
            )
        else:
            response = client.models.generate_content(
                model=model_id,
                contents=[full_prompt],
            )

        # Ensure output directory exists
        output_dir = os.path.dirname(output_path)
        if output_dir:
            os.makedirs(output_dir, exist_ok=True)

        # Validate response
        if response is None:
            return {
                "success": False,
                "error": "API returned no response",
                "path": None,
            }

        # Check for blocked content
        if hasattr(response, 'prompt_feedback') and response.prompt_feedback:
            feedback = response.prompt_feedback
            if hasattr(feedback, 'block_reason') and feedback.block_reason:
                return {
                    "success": False,
                    "error": f"Blocked: {feedback.block_reason}",
                    "path": None,
                }

        # Check if parts is empty
        if response.parts is None:
            return {
                "success": False,
                "error": "No image in response (safety filter or quota)",
                "path": None,
            }

        # Extract image from response
        for part in response.parts:
            if part.inline_data is not None:
                image = part.as_image()
                image.save(output_path)
                return {
                    "success": True,
                    "path": output_path,
                    "error": None,
                }

        return {
            "success": False,
            "error": "No image data in response",
            "path": None,
        }

    except Exception as e:
        error_msg = str(e)
        if "rate" in error_msg.lower():
            error_msg = "Rate limit exceeded"
        elif "quota" in error_msg.lower():
            error_msg = "Quota exceeded"
        
        return {
            "success": False,
            "error": error_msg,
            "path": None,
        }


def batch_generate(
    prompt: str,
    count: int = 10,
    output_dir: str = "./generated-images",
    prefix: str = "image",
    aspect: str = "square",
    model: str = "flash",
    size: str = "1K",
    use_search: bool = False,
    delay: float = 3.0,
    parallel: int = 1,
    verbose: bool = True,
) -> list[dict]:
    """Generate multiple images with sequential naming.
    
    Args:
        prompt: Text description for image generation
        count: Number of images to generate
        output_dir: Directory to save images
        prefix: Filename prefix
        aspect: Aspect ratio (square, landscape, portrait, or specific ratios)
        model: Model to use (flash or pro)
        size: Resolution for pro model (1K, 2K, 4K)
        use_search: Enable Google Search grounding
        delay: Seconds to wait between generations (ignored if parallel > 1)
        parallel: Number of concurrent requests
        verbose: Print progress
    
    Returns:
        List of result dicts with success/path/error info
    """
    output_path = Path(output_dir)
    output_path.mkdir(parents=True, exist_ok=True)

    if verbose:
        print(f"Generating {count} images with {prefix} prefix...")
        print(f"Prompt: {prompt}")
        print(f"Output directory: {output_dir}")
        print(f"Aspect ratio: {aspect}")
        print(f"Model: {model}, Size: {size}")
        if use_search:
            print("Search grounding: Enabled")
        if parallel > 1:
            print(f"Parallel workers: {parallel}")
        else:
            print(f"Delay between requests: {delay}s")
        print()

    # Prepare all tasks
    tasks = []
    for i in range(1, count + 1):
        filename = f"{prefix}-{str(i).zfill(2)}.png"
        filepath = output_path / filename
        tasks.append((i, count, str(filepath), prompt, aspect, model, size, use_search))

    results = []

    if parallel > 1:
        # Parallel execution
        with ThreadPoolExecutor(max_workers=parallel) as executor:
            futures = [
                executor.submit(
                    generate_single_image,
                    task[3], task[2], task[4], task[5], task[6], task[7]
                )
                for task in tasks
            ]
            
            for i, future in enumerate(as_completed(futures), 1):
                result = future.result()
                results.append(result)
                
                if verbose:
                    filename = Path(result["path"]).name if result["path"] else "unknown"
                    status = "✓" if result["success"] else f"✗ {result['error']}"
                    with print_lock:
                        print(f"[{i}/{count}] {filename}: {status}")
    else:
        # Sequential execution with delay
        for i, task in enumerate(tasks, 1):
            task_index, count_total, filepath, prompt_text, aspect_val, model_val, size_val, search_val = task
            
            result = generate_single_image(
                prompt_text, filepath, aspect_val, model_val, size_val, search_val
            )
            results.append(result)
            
            if verbose:
                filename = Path(filepath).name
                status = "✓" if result["success"] else f"✗ {result['error']}"
                print(f"[{i}/{count}] {filename}: {status}")
            
            # Delay between requests (except for last one)
            if i < count and delay > 0:
                time.sleep(delay)

    # Summary statistics
    success_count = sum(1 for r in results if r["success"])
    
    if verbose:
        print()
        print(f"Complete: {success_count}/{count} images generated successfully")
        if success_count < count:
            print(f"Failed: {count - success_count} images")
        print(f"Saved to: {output_dir}/")

    return results


def main():
    parser = argparse.ArgumentParser(
        description="Batch generate images using Gemini (Flash or Pro)",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  %(prog)s "pixel art logo" -n 20 -d ./logos -p logo
  %(prog)s "product photo" -n 10 --aspect 1:1 --size 4K
  %(prog)s "landscape" -n 20 --parallel 5
  %(prog)s "real landmark" -n 10 --search
        """,
    )

    parser.add_argument(
        "prompt",
        help="Text prompt for image generation",
    )
    parser.add_argument(
        "-n", "--count",
        type=int,
        default=10,
        help="Number of images to generate (default: 10)",
    )
    parser.add_argument(
        "-d", "--dir",
        default="./generated-images",
        help="Output directory (default: ./generated-images)",
    )
    parser.add_argument(
        "-p", "--prefix",
        default="image",
        help="Filename prefix (default: image)",
    )
    parser.add_argument(
        "--aspect",
        choices=["square", "landscape", "portrait", "1:1", "2:3", "3:2", "3:4", "4:3", "4:5", "5:4", "9:16", "16:9", "21:9"],
        default="square",
        help="Aspect ratio (default: square)",
    )
    parser.add_argument(
        "--model",
        choices=["flash", "pro"],
        default="flash",
        help="Model: flash (fast) or pro (high-quality) (default: flash)",
    )
    parser.add_argument(
        "--size",
        choices=["1K", "2K", "4K"],
        default="1K",
        help="Resolution for pro model (default: 1K, ignored for flash)",
    )
    parser.add_argument(
        "--search",
        action="store_true",
        help="Enable Google Search grounding",
    )
    parser.add_argument(
        "--delay",
        type=float,
        default=3.0,
        help="Delay between generations in seconds (default: 3, ignored if --parallel > 1)",
    )
    parser.add_argument(
        "--parallel",
        type=int,
        default=1,
        help="Number of concurrent requests (default: 1, max recommended: 5)",
    )
    parser.add_argument(
        "-q", "--quiet",
        action="store_true",
        help="Suppress progress output",
    )

    args = parser.parse_args()

    batch_generate(
        prompt=args.prompt,
        count=args.count,
        output_dir=args.dir,
        prefix=args.prefix,
        aspect=args.aspect,
        model=args.model,
        size=args.size,
        use_search=args.search,
        delay=args.delay,
        parallel=args.parallel,
        verbose=not args.quiet,
    )


if __name__ == "__main__":
    main()
