{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";

      monitor = [
        ",preferred,auto,1"
      ];

      exec-once = [
        "waybar"
        "mako"
      ];

      input = {
        kb_layout = "us";

        follow_mouse = 1;

        touchpad = {
          natural_scroll = true;
        };

        sensitivity = 0;
      };

      general = {
        gaps_in = 4;
        gaps_out = 6;

        border_size = 2;

        layout = "dwindle";
      };

      decoration = {
        rounding = 4;

        blur = {
          enabled = false;
        };
      };

      animations = {
        enabled = false;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      bind = [
        "$mod, RETURN, exec, foot"

        "$mod, D, exec, fuzzel"

        "$mod, Q, killactive"

        "$mod, M, exit"

        "$mod, F, fullscreen"

        "$mod, E, exec, yazi"

        "$mod, B, exec, firefox"

        "$mod, V, togglefloating"

        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };

  home.packages = with pkgs; [
    hyprpaper
    waybar
    fuzzel
    foot
    mako
  ];
}
