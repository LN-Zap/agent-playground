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
    pkgs.tree
    pkgs.actionlint
    pkgs.shellcheck
    pkgs.mdformat
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
    echo "hello from $GREET"
  '';

  enterShell = builtins.readFile ./scripts/devenv-enter.sh;

  treefmt = {
    enable = true;
    config.programs = {
      actionlint.enable = true;
      mdformat.enable = true;
      shellcheck.enable = true;
    };
    config.settings.formatter.mdformat.includes = [
      "README.md"
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
      "workspace/**/*.md"
    ];
    config.settings.formatter.shellcheck.excludes = [
      ".envrc"
      "workspace/**"
    ];
  };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  # https://devenv.sh/git-hooks/
  git-hooks.hooks.treefmt.enable = true;
  git-hooks.hooks.rulesync-regenerate = {
    enable = true;
    name = "rulesync regenerate on source changes";
    files = "^(\\.rulesync/|rulesync\\.jsonc$|rulesync\\.lock$)";
    pass_filenames = false;
    entry = "npm run postinstall";
  };

  # https://devenv.sh/integrations/codespaces-devcontainer/
  devcontainer.enable = true;
  devcontainer.settings.name = "Agent Playground Dev Container";
  devcontainer.settings.containerEnv.TREEFMT_NO_CACHE = "1";
  devcontainer.settings.postCreateCommand = "npm run prepare";
  # Warm once per workspace snapshot, then rely on .envrc auto-activation.
  devcontainer.settings.updateContentCommand = "mkdir -p .devenv && if [ ! -f .devenv/.warmup-done ]; then devenv shell -- echo 'devenv ready' && touch .devenv/.warmup-done; fi && direnv allow";
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
