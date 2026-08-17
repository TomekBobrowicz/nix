{
  description = "Modular multi-host NixOS - KDE Plasma, KineticWE, Noctalia, multimedia and gaming";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
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
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixos-hardware,
      home-manager,
      noctalia,
      kineticwe,
      sops-nix,
      codex-desktop,
      ...
    }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;

      mkHost =
        {
          hostname,
          hardwareProfile,
          hardwareConfiguration,
          hostModule,
        }:
        lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit inputs hostname;
          };

          modules = [
            hardwareProfile
            hardwareConfiguration

            ./modules/core
            ./modules/core/boot.nix
            ./modules/core/binary-compatibility.nix
            ./modules/core/networking.nix
            ./modules/core/nix.nix
            ./modules/core/secrets.nix
            ./modules/core/users.nix

            ./modules/desktop/kde.nix
            ./modules/desktop/audio.nix
            ./modules/desktop/fonts.nix
            ./modules/desktop/flatpak.nix
            ./modules/desktop/kineticwe.nix
            ./modules/desktop/noctalia.nix

            ./modules/programs/common.nix
            ./modules/printing
            ./modules/services
            ./modules/virtualization

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

                sharedModules = [
                  ./home/programs.nix
                  ./home/starship.nix
                  ./home/ghostty.nix
                  ./home/git.nix
                  ./home/kde.nix
                  ./home/multimedia.nix
                  ./home/noctalia.nix
                  kineticwe.homeModules.default
                ];
              };
            }
          ];
        };
    in
    {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-tree;

      nixosConfigurations = {
        kinetix = mkHost {
          hostname = "kinetix";
          hardwareProfile = nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1;
          hardwareConfiguration = ./hosts/kinetix/hardware-configuration.nix;
          hostModule = ./hosts/kinetix/default.nix;
        };

        fury = mkHost {
          hostname = "fury";
          hardwareProfile = nixos-hardware.nixosModules.gigabyte-b550;
          hardwareConfiguration = ./hosts/fury/hardware-configuration.nix;
          hostModule = ./hosts/fury/default.nix;
        };
      };
    };
}
