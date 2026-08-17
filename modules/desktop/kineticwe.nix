{ inputs, ... }:
{
  imports = [ inputs.kineticwe.nixosModules.default ];

  programs.kineticwe.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
}
