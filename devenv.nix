{ pkgs, lib, config, inputs, ... }:

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
in {
  # https://devenv.sh/basics/
  env.GREET = "devenv";

  # https://devenv.sh/dotenv/
  dotenv.enable = true;

  # https://devenv.sh/packages/
  packages = [ pkgs.git ];

  # https://devenv.sh/languages/
  languages.python.enable = true;
  languages.python.venv.enable = true;
  languages.python.uv.enable = true;
  
  # languages.rust.enable = true;

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

  # Synchronize all skills from various sources (call when updating skills)
  tasks."skills:sync" = {
    exec = ''
      devenv tasks run skills:add:zap
    '';
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
    "mkhl.direnv"
    "github.copilot"
    "github.copilot-chat"
    "arrterian.nix-env-selector"
    "jraylan.seamless-agent"
  ];

  # See full reference at https://devenv.sh/reference/options/
}
