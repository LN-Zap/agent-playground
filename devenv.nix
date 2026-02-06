{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

let
  # Read skills configuration from skillsync.json
  skillsConfig = builtins.fromJSON (builtins.readFile ./skillsync.json);
  agents = skillsConfig.agents;
  agentFlags = builtins.concatStringsSep " " (map (a: "--agent ${a}") agents);

  # Generate a task for each skill entry in the config
  generateSkillTask = skillEntry:
    let
      taskName = builtins.replaceStrings ["/"] ["-"] skillEntry.source;
      skillFlags = if builtins.hasAttr "skills" skillEntry
        then builtins.concatStringsSep " " (map (s: "--skill ${s}") skillEntry.skills)
        else "";
    in
    {
      name = "skills:add:${taskName}";
      value = {
        exec = "npx skills add ${skillEntry.source} ${skillFlags} ${agentFlags} -y";
      };
    };

  # Convert skill entries to task definitions
  skillTasks = builtins.listToAttrs (map generateSkillTask skillsConfig.skills);
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

  # Dynamically generated skill installation tasks from skillsync.json
  tasks = skillTasks // {
    # Aggregate task to install all skills
    "skills:generate" = {
      exec = "devenv tasks run skills:add";
      execIfModified = [
        "skillsync.json"
      ];
    };

    # Generate rules using rulesync
    "rulesync:generate" = {
      exec = "npx rulesync generate";
      execIfModified = [
        ".rulesync"
      ];
    };
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
