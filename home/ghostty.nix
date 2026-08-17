{
  pkgs,
  config,
  lib,
  ...
}:
let
  cursorShaders = pkgs.fetchFromGitHub {
    owner = "sahaj-b";
    repo = "ghostty-cursor-shaders";
    rev = "06d4e90fb5410e9c4d0b3131584060adddf89406";
    hash = "sha256-G/UIr1bKnxn1AcHl/4FL/jou6b7M2VeREslYVELxdmw=";
  };
in
{
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;

    settings = {
      theme = "noctalia";
      font-family = "Iosevka Semibold ";
      font-size = 12;
      background-opacity = 0.90;
      background-blur-radius = "35";
      window-padding-x = 10;
      window-padding-y = 10;
      cursor-style = "block";
      cursor-style-blink = true;
      confirm-close-surface = false;
      shell-integration = "detect";
      copy-on-select = true;
      custom-shader = "${cursorShaders}/cursor_warp.glsl";
      custom-shader-animation = "always";
      shell-integration-features = "cursor,sudo";
      bold-is-bright = "false";
    };
  };
}
