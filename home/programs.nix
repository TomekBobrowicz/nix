{pkgs, ...}: {
  home.packages = with pkgs; [
    bat
    eza
    fd
    fzf
    ripgrep
    tree
    wget
    curl
    jq
    unzip
    zip

    zoxide

    git
    neovim
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;

    historySize = 50000;
    historyFileSize = 100000;

    historyControl = [
      "ignoredups"
      "erasedups"
    ];

    shellOptions = [
      "histappend"
      "checkwinsize"
      "cdspell"
      "dirspell"
    ];

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
      eval "$(zoxide init bash)"
      eval "$(fzf --bash)"

      export HISTTIMEFORMAT="%F %T "

      shopt -s autocd
      shopt -s cdspell
      shopt -s dirspell

      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'
    '';
  };

  programs.zoxide.enable = true;
  programs.fzf.enable = true;
  programs.eza.enable = true;
  programs.bat.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
