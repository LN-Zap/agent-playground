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
Generate images using Google's Gemini image models.

Usage:
    uv run image.py --prompt "A colorful abstract pattern" --output "./hero.png"
    uv run image.py --prompt "Minimalist icon" --output "./icon.png" --aspect landscape
    uv run image.py --prompt "Make the background blue" --output "./edited.png" --reference "./existing.png"
    uv run image.py --prompt "High quality art" --output "./art.png" --model pro --size 2K
    uv run image.py --prompt "A statue of liberty" --output "./landmark.png" --search
    uv run image.py --prompt "Product mockup" --output "./product.png" --aspect 1:1 --size 4K
"""

import argparse
import os
import sys
from pathlib import Path

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
    """Find the project root by traversing up from the current working directory.
    
    Uses common project markers to identify the root. Only searches from CWD
    to ensure images are saved relative to where the user invoked the command,
    not relative to where this script is located.
    """
    # Markers that indicate a project root (ordered by priority)
    markers = [".git", "package.json", "devenv.nix", "pyproject.toml", "Cargo.toml"]
    
    # Search from CWD only - never from script location
    # This ensures output goes to the user's project, not the skill directory
    curr = Path.cwd().resolve()
    for parent in [curr] + list(curr.parents):
        if any((parent / marker).exists() for marker in markers):
            return parent
    
    # If no markers found, use CWD as the project root
    return curr

def generate_image(
    prompt: str,
    output_path: str | None = None,
    aspect: str = "square",
    reference: str | None = None,
    model: str = "flash",
    size: str = "1K",
    use_search: bool = False,
) -> None:
    """Generate or edit an image using Gemini and save to output_path.
    
    Args:
        prompt: Text description or editing instruction
        output_path: Where to save the image
        aspect: Aspect ratio (square, landscape, portrait, or specific ratio)
        reference: Path to reference/input image
        model: Model to use (flash or pro)
        size: Output resolution for pro model (1K, 2K, 4K)
        use_search: Enable Google Search grounding for accuracy
    """
    api_key = os.environ.get("GEMINI_API_KEY")
    if not api_key:
        print("\033[91mError: GEMINI_API_KEY environment variable not set.\033[0m", file=sys.stderr)
        print("\nTo fix this, you can either:", file=sys.stderr)
        print("1. Set it in your terminal: export GEMINI_API_KEY='your_key_here'", file=sys.stderr)
        print("2. Create a .env file in the project root with: GEMINI_API_KEY=your_key_here", file=sys.stderr)
        sys.exit(1)

    # Handle default output path if not provided
    if not output_path:
        root = find_project_root()
        output_dir = root / "assets"
        os.makedirs(output_dir, exist_ok=True)
        import time
        timestamp = int(time.time())
        output_path = str(output_dir / f"generated_{timestamp}.png")
        print(f"No output path specified. Defaulting to: {output_path}")

    client = genai.Client(api_key=api_key)

    aspect_instruction = get_aspect_instruction(aspect)
    full_prompt = f"{aspect_instruction} {prompt}"

    # Build contents with optional reference image
    contents: list = []
    if reference:
        if not os.path.exists(reference):
            print(f"Error: Reference image not found: {reference}", file=sys.stderr)
            sys.exit(1)
        ref_image = Image.open(reference)
        contents.append(ref_image)
        
        # Auto-detect resolution based on input image dimensions (for editing)
        if model == "pro" and size == "1K":
            width, height = ref_image.size
            max_dim = max(width, height)
            if max_dim >= 3000:
                size = "4K"
            elif max_dim >= 1500:
                size = "2K"
        
        full_prompt = f"{full_prompt} Use the provided image as a reference or input for editing/modification."
    contents.append(full_prompt)

    model_id = MODEL_IDS[model]

    # Pro model supports additional config for resolution
    if model == "pro":
        aspect_ratios = {"square": "1:1", "landscape": "16:9", "portrait": "9:16"}
        # Handle numeric aspect ratios
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
        
        # Add search grounding if enabled
        if use_search:
            # Note: Google Search grounding is enabled at the API level
            # when the model supports it. This is a hint for the API.
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
            contents=contents,
            config=config,
        )
    else:
        response = client.models.generate_content(
            model=model_id,
            contents=contents,
        )

    # Ensure output directory exists
    output_dir = os.path.dirname(output_path)
    if output_dir:
        os.makedirs(output_dir, exist_ok=True)

    # Validate response before processing
    if response is None:
        print("\033[91mError: API returned no response.\033[0m", file=sys.stderr)
        print("This may be a temporary API issue. Try again in a few seconds.", file=sys.stderr)
        sys.exit(1)

    # Check for blocked content or safety filters
    if hasattr(response, 'prompt_feedback') and response.prompt_feedback:
        feedback = response.prompt_feedback
        if hasattr(feedback, 'block_reason') and feedback.block_reason:
            print(f"\033[91mError: Prompt was blocked by safety filters.\033[0m", file=sys.stderr)
            print(f"Block reason: {feedback.block_reason}", file=sys.stderr)
            if hasattr(feedback, 'safety_ratings') and feedback.safety_ratings:
                print("Safety ratings:", file=sys.stderr)
                for rating in feedback.safety_ratings:
                    print(f"  - {rating.category}: {rating.probability}", file=sys.stderr)
            print("\nTry rephrasing your prompt to avoid content that may trigger filters.", file=sys.stderr)
            sys.exit(1)

    # Check if parts is None or empty
    if response.parts is None:
        print("\033[91mError: API returned empty response (no parts).\033[0m", file=sys.stderr)
        # Try to extract any error information from the response
        if hasattr(response, 'candidates') and response.candidates:
            for i, candidate in enumerate(response.candidates):
                if hasattr(candidate, 'finish_reason') and candidate.finish_reason:
                    print(f"Candidate {i} finish reason: {candidate.finish_reason}", file=sys.stderr)
                if hasattr(candidate, 'safety_ratings') and candidate.safety_ratings:
                    print(f"Candidate {i} safety ratings:", file=sys.stderr)
                    for rating in candidate.safety_ratings:
                        print(f"  - {rating.category}: {rating.probability}", file=sys.stderr)
        print("\nPossible causes:", file=sys.stderr)
        print("  1. Content safety filters blocked the generation", file=sys.stderr)
        print("  2. The prompt references a real person (try fictional descriptions)", file=sys.stderr)
        print("  3. Rate limiting or quota exceeded", file=sys.stderr)
        print("  4. Temporary API issue - try again", file=sys.stderr)
        sys.exit(1)

    # Extract image from response
    for part in response.parts:
        if part.text is not None:
            print(f"Model response: {part.text}")
        elif part.inline_data is not None:
            image = part.as_image()
            image.save(output_path)
            print(f"\033[92mImage saved to: {output_path}\033[0m")
            return

    print("\033[91mError: Response contained no image data.\033[0m", file=sys.stderr)
    print("The model returned text or other content but no image.", file=sys.stderr)
    sys.exit(1)


def main():
    parser = argparse.ArgumentParser(
        description="Generate images using Gemini (Flash or Pro)"
    )
    parser.add_argument(
        "--prompt",
        required=True,
        help="Description of the image to generate",
    )
    parser.add_argument(
        "--output",
        help="Output file path (PNG format). Defaults to assets/generated_<timestamp>.png in the project root.",
    )
    parser.add_argument(
        "--aspect",
        choices=["square", "landscape", "portrait", "1:1", "2:3", "3:2", "3:4", "4:3", "4:5", "5:4", "9:16", "16:9", "21:9"],
        default="square",
        help="Aspect ratio: square, landscape, portrait, or ratios like 1:1, 16:9, 21:9, etc. (default: square)",
    )
    parser.add_argument(
        "--reference",
        help="Path to a reference image for style guidance or image to edit (optional)",
    )
    parser.add_argument(
        "--model",
        choices=["flash", "pro"],
        default="flash",
        help="Model: flash (fast, 1024px) or pro (high-quality, up to 4K) (default: flash)",
    )
    parser.add_argument(
        "--size",
        choices=["1K", "2K", "4K"],
        default="1K",
        help="Image resolution for pro model (default: 1K, ignored for flash)",
    )
    parser.add_argument(
        "--search",
        action="store_true",
        help="Enable Google Search grounding for factually accurate images (real people, landmarks, products, etc.)",
    )

    args = parser.parse_args()
    generate_image(args.prompt, args.output, args.aspect, args.reference, args.model, args.size, args.search)


if __name__ == "__main__":
    main()
