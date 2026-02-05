{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

let
  agents = [
    "github-copilot"
    "gemini-cli"
    "antigravity"
    "codex"
    "claude-code"
    "opencode"
  ];
  agentFlags = builtins.concatStringsSep " " (map (a: "--agent ${a}") agents);
in
{
  # https://devenv.sh/basics/
  env.GREET = "devenv";

  # https://devenv.sh/dotenv/
  dotenv.enable = true;

  # https://devenv.sh/packages/
  packages = [
    pkgs.git
    pkgs.nodejs
  ];

  # https://devenv.sh/languages/
  languages.python.enable = true;
  languages.python.venv.enable = true;
  languages.python.uv.enable = true;

  # https://devenv.sh/integrations/treefmt/
  treefmt = {
    enable = true;
    config.programs = {
      nixfmt.enable = true;
    };
  };

  # https://devenv.sh/processes/
  # processes.cargo-watch.exec = "cargo-watch";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo hello from $GREET
  '';

  enterShell = ''
    hello
    git --version
    python3 --version
  '';

  # https://devenv.sh/tasks/

  # Generate rules using rulesync. Runs automatically when entering the shell.
  tasks."rulesync:generate" = {
    exec = "npx rulesync generate";
    execIfModified = [
      ".rulesync"
    ];
    before = [ "devenv:enterShell" ];
  };

  # Install Zap skills
  tasks."skills:add:zap" = {
    exec = "npx skills add LN-Zap/zap-skills ${agentFlags} -y";
  };
  # Add third-party skills
  tasks."skills:add:skill-creator" = {
    exec = "npx skills add anthropics/skills --skill skill-creator ${agentFlags} -y";
  };
  tasks."skills:add:figma" = {
    exec = "npx skills add openai/skills --skill figma --skill figma-implement-design ${agentFlags} -y";
  };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  # https://devenv.sh/git-hooks/
  # git-hooks.hooks.shellcheck.enable = true;

  # https://devenv.sh/integrations/codespaces-devcontainer/
  devcontainer.enable = true;
  devcontainer.settings.name = "Agent Playground Dev Container";
  devcontainer.settings.customizations.vscode.extensions = [
    "github.copilot-chat"
    "arrterian.nix-env-selector"
    "jraylan.seamless-agent"
    "Rubymaniac.vscode-direnv"
  ];
  devcontainer.settings.customizations.codespaces.openFiles = [
    "README.md"
  ];
  devcontainer.settings.secrets = {
    GEMINI_API_KEY = {
      description = "API key for Gemini access";
      documentationUrl = "https://aistudio.google.com/api-keys";
    };
  };

  # See full reference at https://devenv.sh/reference/options/
}
