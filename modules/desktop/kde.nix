{ pkgs, ... }:
let
  sddmAstronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "astronaut";

    themeConfig = {
      Background = "Backgrounds/my-wallpaper.jpg";
    };
  };

  sddmAstronautWithWallpaper = sddmAstronaut.overrideAttrs (oldAttrs: {
    installPhase = oldAttrs.installPhase + ''
      chmod -R u+w $out

      mkdir -p \
        $out/share/sddm/themes/sddm-astronaut-theme/Backgrounds

      cp ${./../../assets/sddm/wallpaper.jpg} \
        $out/share/sddm/themes/sddm-astronaut-theme/Backgrounds/my-wallpaper.jpg
    '';
  });
in
{
  services.desktopManager.plasma6.enable = true;

  services.displayManager.sddm = {
    enable = true;

    wayland.enable = true;

    theme = "sddm-astronaut-theme";

    extraPackages = [
      sddmAstronautWithWallpaper
      pkgs.kdePackages.qtmultimedia
      pkgs.kdePackages.qtsvg
      pkgs.kdePackages.qtvirtualkeyboard
    ];
  };

  environment.systemPackages = [
    sddmAstronautWithWallpaper
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
  };
}
