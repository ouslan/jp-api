{ pkgs ? import <nixpkgs> {}}:
let
  fhs = pkgs.buildFHSUserEnv {
    name = "my-fhs-environment";

    targetPkgs = _: [
      pkgs.micromamba
    ];

    profile = ''
      set -e
      eval "$(micromamba shell hook --shell=posix)"
      export MAMBA_ROOT_PREFIX=${builtins.getEnv "PWD"}/.mamba
      micromamba create -q -n my-mamba-environment
      micromamba activate my-mamba-environment
      micromamba install --yes -f requirements.txt -c conda-forge
      set +e
    '';
  };
in fhs.env