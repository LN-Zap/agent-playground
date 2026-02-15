{
  pkgs,
  config,
  inputs,
  ...
}: {
  # https://devenv.sh/basics/
  env.GREET = "devenv";

  # https://devenv.sh/dotenv/
  dotenv.enable = true;

  # https://devenv.sh/packages/
  packages = [
    pkgs.git
    pkgs.jq
    pkgs.yq-go
    pkgs.yamlfmt
    pkgs.actionlint
    pkgs.shellcheck
    pkgs.mdformat
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

  tasks = {
    "rulesync:generate" = {
      exec = "npx rulesync generate";
      execIfModified = [
        ".rulesync"
        "rulesync.jsonc"
      ];
    };
  };

  treefmt = {
    enable = true;
    config.programs = {
      actionlint.enable = true;
      mdformat.enable = true;
    };
    config.settings.formatter.mdformat.includes = [
      "README.md"
      "CLAUDE.md"
      "GEMINI.md"
      "docs/**/*.md"
    ];
    config.settings.formatter.mdformat.excludes = [
      ".rulesync/**/*.md"
      ".github/instructions/**/*.md"
      ".github/skills/**/SKILL.md"
      ".claude/**/*.md"
      ".agents/**/*.md"
      ".codex/**/*.md"
      ".gemini/**/*.md"
      ".opencode/**/*.md"
    ];
  };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  # https://devenv.sh/git-hooks/
  git-hooks.hooks.treefmt.enable = true;

  # https://devenv.sh/integrations/codespaces-devcontainer/
  devcontainer.enable = true;
  devcontainer.settings.name = "Agent Playground Dev Container";
  devcontainer.settings.postCreateCommand = "true"; # No-op - setup runs in updateContentCommand
  # Build shell with persistent state during prebuild, then trust .envrc for auto-activation
  devcontainer.settings.updateContentCommand = "devenv shell -- echo 'devenv ready' && direnv allow";
  devcontainer.settings.customizations.vscode.extensions = [
    "github.copilot-chat"
    "arrterian.nix-env-selector"
    "jraylan.seamless-agent"
    "Rubymaniac.vscode-direnv"
  ];
  devcontainer.settings.customizations.codespaces.openFiles = [
    "README.md"
  ];
  # See full reference at https://devenv.sh/reference/options/
}
