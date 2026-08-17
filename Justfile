default:
    @just --list

check:
    nix flake check --no-build "path:."

format:
    nix fmt

lint:
    nixfmt --check $(find . -type f -name '*.nix' -not -path './.git/*')
    deadnix .

build host:
    nix build "path:.#nixosConfigurations.{{host}}.config.system.build.toplevel"

switch host:
    sudo nixos-rebuild switch --flake "path:.#{{host}}"

update:
    nix flake update
