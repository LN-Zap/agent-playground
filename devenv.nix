{ pkgs, lib, config, inputs, ... }:

let
  agents = [
    "claude-code"
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
  '';

  # https://devenv.sh/tasks/
  tasks."skills:sync:zap" = {
    exec = "npx skills add LN-Zap/zap-skills ${agentFlags} -y";
  };

  # Synchronize all skills from various sources
  tasks."skills:sync" = {
    exec = ''
      devenv tasks run skills:sync:zap
    '';
  };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  # https://devenv.sh/git-hooks/
  # git-hooks.hooks.shellcheck.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}
