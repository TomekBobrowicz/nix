{pkgs, ...}: {
  home.packages = with pkgs; [
    # System
    btop
    fastfetch
    ncdu
    pciutils
    usbutils

    # File management
    yazi
    eza
    bat
    fd
    ripgrep

    # Search / navigation
    fzf
    zoxide

    # Git
    lazygit

    # Network
    curl
    wget
    aria2
    nmap

    # JSON / YAML
    jq
    yq

    # Editors
    neovim

    # Multiplexer
    tmux

    # Audio
    wiremix

    # General TUI
    impala
  ];

  programs.tmux = {
    enable = true;

    clock24 = true;

    mouse = true;

    terminal = "tmux-256color";

    historyLimit = 50000;

    extraConfig = ''
      set -g status-interval 5

      set -g base-index 1
      setw -g pane-base-index 1

      set -g renumber-windows on

      bind r source-file ~/.config/tmux/tmux.conf

      bind | split-window -h
      bind - split-window -v

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
    '';
  };
}
