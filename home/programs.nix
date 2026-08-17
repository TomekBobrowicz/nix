{ ... }: {
  programs.bash = {
    enable = true;

    enableCompletion = true;

    shellAliases = {
      ls = "eza";
      ll = "eza -lah";
      la = "eza -a";
      cat = "bat";
      ".." = "cd ..";
      "..." = "cd ../..";
      vim = "nvim";
      vi = "nvim";
      v = "nvim";
      ff = "fastfetch";

      grep = "rg";
      find = "fd";

      fr = "nh os switch";
      fu = "nh os switch --update";
    };

    initExtra = ''
      # zoxide
      eval "$(zoxide init bash)"
      # fzf
      eval "$(fzf --bash)"

      shopt -s autocd
      shopt -s cdspell
      shopt -s dirspell

      # Ctrl+R → fuzzy history
      bind '"\C-r": reverse-search-history'

      # Up/down search through history based on typed prefix
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'
    '';
  };
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.fzf.enable = true;
  programs.zoxide.enable = true;

  programs.eza = {
    enable = true;
    git = true;
    icons = "auto";
  };

  programs.bat.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };
}
