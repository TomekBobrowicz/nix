{pkgs, ...}: {
  home.packages = with pkgs; [
    fuzzel
    swaybg
    xwayland-satellite
    wl-clipboard
    wl-clip-persist
    brightnessctl
    playerctl
    grim
    slurp
    libnotify
  ];

  xdg.configFile."niri/config.kdl".text = ''
    // ============================================================
    // Niri
    // ============================================================

    input {
        keyboard {
            xkb {
                layout "pl"
            }
        }

        touchpad {
            tap
            natural-scroll
        }

        mouse {
            accel-speed 0.0
        }

        focus-follows-mouse
    }

    // ------------------------------------------------------------
    // General
    // ------------------------------------------------------------

    prefer-no-csd

    hotkey-overlay {
        skip-at-startup
    }

    screenshot-path "~/Pictures/Screenshots/%Y-%m-%d_%H-%M-%S.png"

    // ------------------------------------------------------------
    // Layout
    // ------------------------------------------------------------

    layout {
        gaps 8

        center-focused-column "never"

        always-center-single-column

        default-column-width {
            proportion 0.5
        }

        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }

        focus-ring {
            width 2
            active-color "#7aa2f7"
            inactive-color "#414868"
        }

        border {
            off
        }

        shadow {
            on
        }
    }

    // ------------------------------------------------------------
    // Animations
    // ------------------------------------------------------------

    animations {
        slowdown 1.0
    }

    // ------------------------------------------------------------
    // Window rules
    // ------------------------------------------------------------

    window-rule {
        geometry-corner-radius 8
        clip-to-geometry true
    }

    window-rule {
        match app-id=r#"^(org\.wezterm\.WezTerm|com\.mitchellh\.ghostty)$"#

        default-column-width {
            proportion 0.75
        }
    }

    window-rule {
        match app-id=r#"^(steam_app_.*)$"#

        open-fullscreen true
    }

    // ------------------------------------------------------------
    // Outputs
    // ------------------------------------------------------------

    // Do not hard-code monitor names here.
    //
    // Niri automatically detects displays.
    //
    // Host-specific output configuration can be added later if
    // required.

    // ------------------------------------------------------------
    // Spawn
    // ------------------------------------------------------------

    spawn-at-startup "noctalia-shell"

    // ------------------------------------------------------------
    // Keybindings
    // ------------------------------------------------------------

    binds {
        // Applications

        Mod+Return {
            spawn "ghostty"
        }

        Mod+D {
            spawn "fuzzel"
        }

        Mod+B {
            spawn "google-chrome-stable"
        }

        // Niri

        Mod+Shift+Slash {
            show-hotkey-overlay
        }

        Mod+Shift+E {
            quit
        }

        Mod+Shift+R {
            spawn "niri" "msg" "action" "load-config-file"
        }

        // Focus

        Mod+H {
            focus-column-left
        }

        Mod+L {
            focus-column-right
        }

        Mod+K {
            focus-window-up
        }

        Mod+J {
            focus-window-down
        }

        // Move columns

        Mod+Shift+H {
            move-column-left
        }

        Mod+Shift+L {
            move-column-right
        }

        Mod+Shift+K {
            move-window-up
        }

        Mod+Shift+J {
            move-window-down
        }

        // Workspaces

        Mod+1 {
            focus-workspace 1
        }

        Mod+2 {
            focus-workspace 2
        }

        Mod+3 {
            focus-workspace 3
        }

        Mod+4 {
            focus-workspace 4
        }

        Mod+5 {
            focus-workspace 5
        }

        Mod+6 {
            focus-workspace 6
        }

        Mod+7 {
            focus-workspace 7
        }

        Mod+8 {
            focus-workspace 8
        }

        Mod+9 {
            focus-workspace 9
        }

        Mod+Shift+1 {
            move-column-to-workspace 1
        }

        Mod+Shift+2 {
            move-column-to-workspace 2
        }

        Mod+Shift+3 {
            move-column-to-workspace 3
        }

        Mod+Shift+4 {
            move-column-to-workspace 4
        }

        Mod+Shift+5 {
            move-column-to-workspace 5
        }

        Mod+Shift+6 {
            move-column-to-workspace 6
        }

        Mod+Shift+7 {
            move-column-to-workspace 7
        }

        Mod+Shift+8 {
            move-column-to-workspace 8
        }

        Mod+Shift+9 {
            move-column-to-workspace 9
        }

        // Column management

        Mod+Q {
            close-window
        }

        Mod+F {
            maximize-column
        }

        Mod+Shift+F {
            fullscreen-window
        }

        Mod+C {
            center-column
        }

        Mod+R {
            switch-preset-column-width
        }

        Mod+V {
            toggle-window-floating
        }

        Mod+Shift+V {
            switch-focus-between-floating-and-tiling
        }

        // Screenshots

        Print {
            screenshot
        }

        Mod+Print {
            screenshot-screen
        }

        Mod+Shift+Print {
            screenshot-window
        }

        // Audio

        XF86AudioRaiseVolume {
            spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"
        }

        XF86AudioLowerVolume {
            spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"
        }

        XF86AudioMute {
            spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"
        }

        // Brightness

        XF86MonBrightnessUp {
            spawn "brightnessctl" "set" "+10%"
        }

        XF86MonBrightnessDown {
            spawn "brightnessctl" "set" "10%-"
        }

        // Media

        XF86AudioPlay {
            spawn "playerctl" "play-pause"
        }

        XF86AudioNext {
            spawn "playerctl" "next"
        }

        XF86AudioPrev {
            spawn "playerctl" "previous"
        }
    }
  '';

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
  };
}
