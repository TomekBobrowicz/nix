{
  description = "Modular multi-host NixOS configuration";

  inputs = {
    # Main unstable system
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Stable channel for lightweight/legacy hosts
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
    };

    kineticwe = {
      url = "gitlab:theblackdon/kineticwe";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    codex-desktop = {
      url = "github:ilysenko/codex-desktop-linux";
    };
    mango = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-stable,
    nixos-hardware,
    home-manager,
    noctalia,
    kineticwe,
    sops-nix,
    codex-desktop,
    mango,
    ...
  }: let
    system = "x86_64-linux";

    lib = nixpkgs.lib;

    /*
    Common NixOS host constructor.

    Every host gets:
    - core system
    - programs
    - services
    - common Home Manager

    Desktop and Home Manager modules are host-selectable.
    */
    mkHost = {
      hostname,
      pkgsSource ? nixpkgs,
      hardwareProfile ? null,
      hardwareConfiguration,
      hostModule,
      desktopModules ? [],
      homeModules ? [],
      virtualization ? false,
    }:
      pkgsSource.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs hostname;
        };

        modules =
          [
            hardwareConfiguration

            ./modules/core
            ./modules/core/boot.nix
            ./modules/core/binary-compatibility.nix
            ./modules/core/networking.nix
            ./modules/core/nix.nix
            ./modules/core/secrets.nix
            ./modules/core/users.nix

            ./modules/programs/common.nix
            ./modules/printing
            ./modules/services

            hostModule

            home-manager.nixosModules.home-manager
            sops-nix.nixosModules.sops

            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;

                extraSpecialArgs = {
                  inherit inputs hostname;
                };

                users.buber = import ./home;

                sharedModules =
                  [
                    ./home/programs.nix
                    ./home/starship.nix
                    ./home/ghostty.nix
                    ./home/git.nix
                  ]
                  ++ homeModules;
              };
            }
          ]
          ++ lib.optional (hardwareProfile != null) hardwareProfile
          ++ desktopModules
          ++ lib.optional virtualization ./modules/virtualization;
      };
  in {
    formatter.${system} =
      nixpkgs.legacyPackages.${system}.nixfmt-tree;

    nixosConfigurations = {
      # ============================================================
      # FURY
      # Gigabyte B550 + AMD RX 6700 XT
      # Full KDE / Noctalia / KineticWE workstation
      # ============================================================

      fury = mkHost {
        hostname = "fury";

        hardwareProfile =
          nixos-hardware.nixosModules.gigabyte-b550;

        hardwareConfiguration =
          ./hosts/fury/hardware-configuration.nix;

        hostModule =
          ./hosts/fury/default.nix;

        desktopModules = [
          ./modules/desktop/kde.nix
          ./modules/desktop/audio.nix
          ./modules/desktop/fonts.nix
          ./modules/desktop/flatpak.nix
          ./modules/desktop/kineticwe.nix
          ./modules/desktop/noctalia.nix
        ];

        homeModules = [
          ./home/kde.nix
          ./home/multimedia.nix
          ./home/noctalia.nix
          kineticwe.homeModules.default
        ];

        virtualization = true;
      };

      # ============================================================
      # Callisto
      # ThinkPad T14 Gen 1 AMD
      # Full KDE workstation
      # ============================================================

      callisto = mkHost {
        hostname = "callisto";

        hardwareProfile =
          nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1;

        hardwareConfiguration =
          ./hosts/callisto/hardware-configuration.nix;

        hostModule =
          ./hosts/callisto/default.nix;

        desktopModules = [
          ./modules/desktop/kde.nix
          ./modules/desktop/audio.nix
          ./modules/desktop/fonts.nix
          ./modules/desktop/flatpak.nix
          ./modules/desktop/kineticwe.nix
          ./modules/desktop/noctalia.nix
        ];

        homeModules = [
          ./home/kde.nix
          ./home/multimedia.nix
          ./home/noctalia.nix
          kineticwe.homeModules.default
        ];

        virtualization = true;
      };

      # ============================================================
      # T460
      # Lightweight stable NixOS
      # Niri / Wayland / TUI oriented
      # ============================================================

      t460 = mkHost {
        hostname = "t460";

        # IMPORTANT:
        # T460 uses stable nixpkgs.
        pkgsSource = nixpkgs-stable;

        hardwareConfiguration =
          ./hosts/t460/hardware-configuration.nix;

        hostModule =
          ./hosts/t460/default.nix;

        desktopModules = [
          ./modules/desktop/kde.nix
          ./modules/desktop/audio.nix
          ./modules/desktop/fonts.nix
          ./modules/desktop/flatpak.nix
          ./modules/desktop/noctalia.nix
          ./modules/desktop/niri.nix
        ];

        homeModules = [
          ./home/kde.nix
          ./home/niri.nix
          ./home/multimedia.nix
          ./home/noctalia.nix
        ];

        virtualization = false;
      };
    };
  };
}
