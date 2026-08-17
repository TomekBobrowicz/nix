# Modular NixOS Multi-Host

A modular NixOS flake for two x86_64 hosts:

- `kinetix` — Lenovo ThinkPad T14 Gen 1 AMD
- `fury` — Gigabyte B550 + AMD Radeon RX 6700 XT

## Common software

Both hosts receive the same application stack:

- KDE Plasma 6 + SDDM + Wayland
- KineticWE
- Noctalia
- PipeWire / WirePlumber
- Flatpak
- Google Chrome
- Discord
- Ghostty
- Spotify
- Strawberry
- VLC / MPV / FFmpeg
- Kdenlive / HandBrake
- Audacity / EasyEffects
- GIMP / ImageMagick
- Steam / Gamemode / MangoHud / Lutris / Heroic
- VS Code / Neovim
- GCC / CMake / Python / Node.js / Rust / Go
- common CLI utilities

## Host-specific layer

Hardware and hardware policy are kept in `hosts/`:

- ThinkPad uses the upstream `nixos-hardware` T14 AMD Gen 1 profile and laptop power management.
- Desktop uses the upstream Gigabyte B550 profile plus AMDGPU support for the RX 6700 XT.

## Before first build

Replace both placeholder hardware configurations with the generated hardware files from each physical machine.

On each machine, from the checked-out repository:

```bash
sudo nixos-generate-config --show-hardware-config \
  > hosts/<host>/hardware-configuration.nix
```

For example:

```bash
sudo nixos-generate-config --show-hardware-config \
  > hosts/kinetix/hardware-configuration.nix
```

and:

```bash
sudo nixos-generate-config --show-hardware-config \
  > hosts/fury/hardware-configuration.nix
```

## Build

Validate:

```bash
nix flake check
```

Build the ThinkPad:

```bash
sudo nixos-rebuild switch --flake .#kinetix
```

Build the desktop:

```bash
sudo nixos-rebuild switch --flake .#fury
```

Test without making it the active generation:

```bash
sudo nixos-rebuild test --flake .#kinetix
sudo nixos-rebuild test --flake .#fury
```

## Sessions

SDDM keeps Plasma as the default session. KineticWE is installed as an additional Wayland session, so Plasma remains available as a fallback while KineticWE is being tested.

## Notes

This repository intentionally uses `nixos-unstable` because KineticWE tracks current NixOS packages and its upstream documentation recommends unstable.

The Git identity in `home/git.nix` is a placeholder and should be changed.
