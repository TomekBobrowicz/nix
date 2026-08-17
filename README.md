# Modular NixOS Multi-Host

A modular NixOS flake for two `x86_64-linux` hosts:

- `kinetix` — Lenovo ThinkPad T14 Gen 1 AMD
- `fury` — Gigabyte B550 + AMD Radeon RX 6700 XT

The configuration is managed as a single Git repository and can be built locally or directly from GitHub.

## Hosts

| Host | Hardware | Role |
|---|---|---|
| `kinetix` | Lenovo ThinkPad T14 Gen 1 AMD | Laptop |
| `fury` | Gigabyte B550 + AMD Radeon RX 6700 XT | Desktop |

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
- Steam / GameMode / MangoHud / Lutris / Heroic
- VS Code / Neovim
- GCC / CMake / Python / Node.js / Rust / Go
- common CLI utilities

## Architecture

The flake separates reusable configuration from host-specific hardware configuration.

```text
.
├── flake.nix
├── flake.lock
├── hosts/
│   ├── fury/
│   │   ├── default.nix
│   │   └── hardware-configuration.nix
│   └── kinetix/
│       ├── default.nix
│       └── hardware-configuration.nix
├── modules/
│   └── ...
└── home/
    └── ...
```

Common configuration is shared between hosts while hardware-specific configuration stays inside `hosts/`.

## Host-specific layer

Hardware and hardware policy are kept in `hosts/`:

- `kinetix` uses the upstream `nixos-hardware` T14 AMD Gen 1 profile and laptop power management.
- `fury` uses the upstream Gigabyte B550 profile plus AMDGPU support for the RX 6700 XT.

## Hardware configuration

The generated hardware configuration belongs to the physical machine and should be generated separately on each host.

From the checked-out repository on the target machine:

```bash
sudo nixos-generate-config --show-hardware-config \
  > hosts/<host>/hardware-configuration.nix
```

For `kinetix`:

```bash
sudo nixos-generate-config --show-hardware-config \
  > hosts/kinetix/hardware-configuration.nix
```

For `fury`:

```bash
sudo nixos-generate-config --show-hardware-config \
  > hosts/fury/hardware-configuration.nix
```

Review the generated configuration before committing it.

## Local development

Clone the repository:

```bash
git clone https://github.com/TomekBobrowicz/nix.git
cd nix
```

Validate the flake:

```bash
nix flake check --all-systems
```

Build the ThinkPad:

```bash
sudo nixos-rebuild switch --flake .#kinetix
```

Build the desktop:

```bash
sudo nixos-rebuild switch --flake .#fury
```

Test a configuration without making it the active generation:

```bash
sudo nixos-rebuild test --flake .#kinetix
sudo nixos-rebuild test --flake .#fury
```

Build without activating:

```bash
sudo nixos-rebuild build --flake .#kinetix
sudo nixos-rebuild build --flake .#fury
```

## Build directly from GitHub

The configurations can be deployed directly from the GitHub repository.

For `fury`:

```bash
sudo nixos-rebuild switch \
  --flake github:TomekBobrowicz/nix#fury
```

For `kinetix`:

```bash
sudo nixos-rebuild switch \
  --flake github:TomekBobrowicz/nix#kinetix
```

For normal development, a local checkout is recommended so changes can be tested before pushing.

## CI

The repository uses GitHub Actions for automated validation and NixOS builds.

The workflow:

- runs `nix flake check --all-systems`
- authenticates Nix against GitHub
- builds both NixOS configurations
- uses Cachix for binary caching
- runs full host builds every three days
- supports manual workflow execution
- runs flake validation on pushes to `main`
- runs flake validation on pull requests

### Flake validation

Every push to `main` and every pull request runs:

```bash
nix flake check --all-systems
```

This validates the flake outputs and evaluates the NixOS configurations.

### Scheduled builds

Full NixOS builds are automatically executed every three days.

The workflow builds:

```text
nixosConfigurations.fury.config.system.build.toplevel
nixosConfigurations.kinetix.config.system.build.toplevel
```

The workflow can also be started manually through GitHub Actions.

The scheduled builds provide an early warning if upstream changes break the configuration.

## GitHub authentication in CI

The flake uses several GitHub-hosted inputs, including:

- `NixOS/nixos-hardware`
- `nix-community/home-manager`
- `numtide/flake-utils`
- other GitHub-hosted dependencies

Anonymous GitHub API requests can hit rate limits during Nix flake evaluation.

GitHub Actions therefore provides its built-in token to Nix:

```text
github.com=${{ github.token }}
```

This allows Nix to authenticate GitHub API requests during CI.

The GitHub token is supplied by GitHub Actions and is not stored in the repository.

## Cachix

CI uses the following Cachix binary cache:

```text
https://tomekbobrowicz-nix.cachix.org
```

The cache is used to store build artifacts produced by GitHub Actions.

The CI build uses:

```bash
cachix watch-exec
```

around the Nix build so newly produced Nix store paths can be uploaded to Cachix.

The cache is configured on the physical machines as a Nix substituter:

```text
https://tomekbobrowicz-nix.cachix.org
```

with the corresponding trusted public key.

This means that builds performed by GitHub Actions can be reused by `fury` and `kinetix` instead of being rebuilt locally.

For example:

```bash
sudo nixos-rebuild switch \
  --flake github:TomekBobrowicz/nix#fury
```

can obtain matching store paths from the Cachix cache.

### CI authentication

The GitHub repository contains the following Actions secret:

```text
CACHIX_AUTH_TOKEN
```

The token is used by CI to push build results to:

```text
tomekbobrowicz-nix
```

The token is never committed to the repository.

## Deployment workflow

The intended workflow is:

```text
                  GitHub
                    │
                    │ push / PR
                    ▼
             ┌───────────────┐
             │ Flake Check   │
             └───────┬───────┘
                     │
                     │ every 3 days
                     ▼
             ┌───────────────┐
             │ NixOS Builds  │
             └───────┬───────┘
                     │
             ┌───────┴───────┐
             ▼               ▼
           fury           kinetix
             │               │
             └───────┬───────┘
                     ▼
                  Cachix
                     │
                     ▼
             Physical machines
```

Typical development:

```bash
# Edit configuration
$EDITOR .

# Validate
nix flake check --all-systems

# Build locally
sudo nixos-rebuild build --flake .#fury

# Commit
git add .
git commit -m "Update NixOS configuration"

# Push
git push
```

GitHub Actions then validates the pushed configuration.

## Git configuration

Git is managed through Home Manager.

The configuration includes:

- Git identity
- `main` as the default branch
- automatic remote tracking for new branches
- fetch pruning
- non-rebase pulls
- Neovim as the Git editor
- GitHub CLI credential integration

GitHub authentication is handled through `gh`.

Authenticate GitHub CLI:

```bash
gh auth login
```

Configure Git to use GitHub CLI credentials:

```bash
gh auth setup-git
```

The Git credential helper is managed declaratively through Home Manager:

```nix
credential.helper = "!gh auth git-credential";
```

This keeps GitHub credentials out of the Nix configuration itself.

Check authentication:

```bash
gh auth status
```

Check Git's credential configuration:

```bash
git config --show-origin --get-all credential.helper
```

## NixOS generations

Before activating a new configuration, it is recommended to build it first:

```bash
sudo nixos-rebuild build --flake .#fury
```

If the build succeeds, activate it:

```bash
sudo nixos-rebuild switch --flake .#fury
```

The same applies to `kinetix`:

```bash
sudo nixos-rebuild build --flake .#kinetix
sudo nixos-rebuild switch --flake .#kinetix
```

If a configuration causes problems, previous NixOS generations remain available through the bootloader.

## Flake updates

All flake inputs are locked in:

```text
flake.lock
```

To update inputs:

```bash
nix flake update
```

Then validate:

```bash
nix flake check --all-systems
```

It is recommended to review the resulting `flake.lock` changes before committing them.

## NixOS channel

The configuration intentionally uses:

```text
nixos-unstable
```

KineticWE tracks current NixOS packages and its upstream documentation recommends using unstable.

Using a flake with a committed `flake.lock` keeps the actual dependency revisions reproducible even while following `nixos-unstable`.

## Sessions

SDDM provides the graphical login manager.

KDE Plasma remains the default Wayland desktop session.

KineticWE is installed as an additional Wayland session, allowing Plasma to remain available as a fallback while KineticWE is being tested.

## Repository

GitHub:

https://github.com/TomekBobrowicz/nix
