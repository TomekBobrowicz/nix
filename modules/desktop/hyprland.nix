{pkgs, ...}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        user = "buber";

        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    tuigreet

    foot
    fuzzel
    mako

    wl-clipboard

    grim
    slurp

    brightnessctl
    playerctl
  ];

  xdg.portal = {
    enable = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  # Do not enable SDDM on T460.
  services.displayManager.sddm.enable = false;
}
