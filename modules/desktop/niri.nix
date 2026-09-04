{pkgs, ...}: {
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    wl-clipboard
    wl-clip-persist
    wayland-utils
    wlr-randr
    brightnessctl
    playerctl
    grim
    slurp
    libnotify
    jq
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
  };

  xdg.portal = {
    enable = true;
  };
}
