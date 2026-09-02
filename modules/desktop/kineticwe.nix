{inputs, ...}: {
  imports = [inputs.kineticwe.nixosModules.default];

  programs.kineticwe.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.isInGroup("wheel"))
        return polkit.Result.YES;
    });
  '';
}
