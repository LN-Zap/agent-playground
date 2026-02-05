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

  languages.javascript.enable = true;
  languages.javascript.package = pkgs.nodejs-slim_22;
  languages.javascript.npm.enable = true;
  languages.javascript.npm.install.enable = true;

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

  # Aggregate task to generate all skills.
  tasks."skills:generate" = {
    exec = "devenv tasks run skills:add";
  };

  # Generate rules using rulesync.
  tasks."rulesync:generate" = {
    exec = "npx rulesync generate";
    execIfModified = [
      ".rulesync"
    ];
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
  devcontainer.settings.postCreateCommand = "direnv allow && devenv test";
  devcontainer.settings.updateContentCommand = null; # Disable - already run sequentially in postCreateCommand
  devcontainer.settings.customizations.vscode.extensions = [
    "github.copilot-chat"
    "arrterian.nix-env-selector"
    "jraylan.seamless-agent"
    "Rubymaniac.vscode-direnv"
  ];
  devcontainer.settings.customizations.codespaces.openFiles = [
    "README.md"
  ];
  devcontainer.settings.customizations.codespaces.repositories = {
    "LN-Zap/zap-skills" = {
      permissions = {
        contents = "read";
      };
    };
  };
  devcontainer.settings.secrets = {
    GEMINI_API_KEY = {
      description = "API key for Gemini access";
      documentationUrl = "https://aistudio.google.com/api-keys";
    };
  };

  # See full reference at https://devenv.sh/reference/options/
}
