{
  pkgs,
  inputs,
  ...
}:
{
  home.username = "buber";
  home.homeDirectory = "/home/buber";
  home.stateVersion = "26.05";

  home.file.".face.icon" = {
    source = ./profile_picture.png;
  };
  home.file.".face" = {
    source = ./profile_picture.png;
  };

  programs.home-manager.enable = true;

  xdg.configFile."mimeapps.list".force = true;

  home.file = {
    "Pictures/Wallpapers" = {
      source = ../assets/wallpapers;
      recursive = true;
    };
  };

  home.packages = with pkgs; [
    bat
    eza
    fzf
    zoxide
    direnv
    nix-direnv
    inputs.codex-desktop.packages.${pkgs.system}.default
  ];
}
