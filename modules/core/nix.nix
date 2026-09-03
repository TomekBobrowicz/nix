{inputs, ...}: {
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      trusted-users = [
        "root"
        "@wheel"
      ];
      substituters = ["https://cache.nixos.org/"];
      extra-substituters = [
        "https://tomekbobrowicz-nix.cachix.org"
        "https://noctalia.cachix.org"
      ];
      extra-trusted-public-keys = [
        "tomekbobrowicz-nix.cachix.org-1:Lu5pkgP6+yf6ShXEzKXzIwYVuLTNoI139g3aQT5rf6M=
          "
        noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=
        "
"
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  nixpkgs = {
    config.allowUnfree = true;

    overlays = [
      inputs.kineticwe.overlays.default
    ];
  };
}
