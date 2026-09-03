{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.mango = {
    enable = true;

    settings = ''
      # ==========================================================
      # MangoWC - ThinkPad T460
      # ==========================================================

      # ----------------------------------------------------------
      # Appearance
      # ----------------------------------------------------------

      border_width=2
      border_radius=6

      focused_opacity=1.0
      unfocused_opacity=1.0

      blur=0
      shadows=0

      # ----------------------------------------------------------
      # Layout
      # ----------------------------------------------------------

      gappih=8
      gappiv=8
      gappoh=8
      gappov=8

      mfact=0.55

      # ----------------------------------------------------------
      # Animation
      # ----------------------------------------------------------

      animations=1
      layer_animations=1

      animation_type_open=slide
      animation_type_close=slide

      animation_fade_in=1
      animation_fade_out=1

      animation_duration_move=250
      animation_duration_open=250
      animation_duration_tag=200
      animation_duration_close=250

      # ----------------------------------------------------------
      # Input
      # ----------------------------------------------------------

      focus_on_activate=1

      # ----------------------------------------------------------
      # Terminal
      # ----------------------------------------------------------

      bind=SUPER,Return,spawn,ghostty

      # ----------------------------------------------------------
      # Launcher
      # ----------------------------------------------------------

      bind=SUPER,d,spawn,fuzzel

      # ----------------------------------------------------------
      # Window management
      # ----------------------------------------------------------

      bind=SUPER,q,killclient

      bind=SUPER,Escape,quit

      # ----------------------------------------------------------
      # Focus
      # ----------------------------------------------------------

      bind=SUPER,h,focusdir,left
      bind=SUPER,j,focusdir,down
      bind=SUPER,k,focusdir,up
      bind=SUPER,l,focusdir,right

      # ----------------------------------------------------------
      # Move windows
      # ----------------------------------------------------------

      bind=SUPER+SHIFT,h,movedir,left
      bind=SUPER+SHIFT,j,movedir,down
      bind=SUPER+SHIFT,k,movedir,up
      bind=SUPER+SHIFT,l,movedir,right

      # ----------------------------------------------------------
      # Resize master
      # ----------------------------------------------------------

      bind=SUPER,i,incnmaster,1
      bind=SUPER,p,incnmaster,-1

      # ----------------------------------------------------------
      # Tags
      # ----------------------------------------------------------

      bind=SUPER,1,view,1
      bind=SUPER,2,view,2
      bind=SUPER,3,view,3
      bind=SUPER,4,view,4
      bind=SUPER,5,view,5
      bind=SUPER,6,view,6
      bind=SUPER,7,view,7
      bind=SUPER,8,view,8
      bind=SUPER,9,view,9

      bind=SUPER+SHIFT,1,tag,1
      bind=SUPER+SHIFT,2,tag,2
      bind=SUPER+SHIFT,3,tag,3
      bind=SUPER+SHIFT,4,tag,4
      bind=SUPER+SHIFT,5,tag,5
      bind=SUPER+SHIFT,6,tag,6
      bind=SUPER+SHIFT,7,tag,7
      bind=SUPER+SHIFT,8,tag,8
      bind=SUPER+SHIFT,9,tag,9

      # ----------------------------------------------------------
      # Fullscreen
      # ----------------------------------------------------------

      bind=SUPER,f,togglefullscreen

      # ----------------------------------------------------------
      # Floating
      # ----------------------------------------------------------

      bind=SUPER,v,togglefloating



      # ----------------------------------------------------------
      # Reload
      # ----------------------------------------------------------

      bind=SUPER+SHIFT,r,reload_config
    '';

    autostart_sh = ''
      #!/bin/sh


      # Polkit
      /run/current-system/sw/bin/xfce-polkit >/dev/null 2>&1 &

      # Clipboard persistence
      wl-clip-persist --clipboard regular --reconnect-tries 0 >/dev/null 2>&1 &

      # Noctalia
      noctalia >/dev/null 2>&1 &
    '';
  };
}
