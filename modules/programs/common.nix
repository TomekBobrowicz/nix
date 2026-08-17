{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Browsers / communication
    google-chrome
    discord

    # Terminal
    ghostty

    # KDE
    kdePackages.kate
    kdePackages.dolphin
    kdePackages.gwenview
    kdePackages.spectacle
    kdePackages.ark
    kdePackages.kcalc
    kdePackages.filelight
    kdePackages.kdeconnect-kde
    kdePackages.sddm-kcm
    kdePackages.qtmultimedia

    # Video
    mpv
    vlc
    ffmpeg
    handbrake
    mediainfo
    yt-dlp

    # Music / audio
    spotify
    strawberry
    audacity
    easyeffects
    pavucontrol

    # Video editing / graphics
    kdePackages.kdenlive
    gimp
    imagemagick

    # Gaming
    mangohud
    lutris
    heroic
    protonup-qt
    gamescope
    protontricks
    bottles

    # Development
    git
    gcc
    gnumake
    cmake
    pkg-config
    python3
    nodejs
    rustc
    cargo
    go
    neovim
    vscode
    lua5_1
    luarocks
    codex

    # Apps
    zathura
    equibop
    obsidian
    libreoffice-fresh
    thunderbird
    keepassxc
    hunspell
    hunspellDicts.en_US
    hunspellDicts.pl_PL
    simple-scan

    # Creative work and streaming
    obs-studio
    krita
    inkscape
    blender

    # Files, disks, and hardware diagnostics
    ntfs3g
    p7zip
    unrar
    libarchive
    smartmontools
    nvme-cli
    virt-viewer
    podman-compose

    # CLI / utilities
    curl
    wget
    ripgrep
    fd
    jq
    tree
    file
    unzip
    zip
    btop
    htop
    fastfetch
    wl-clipboard
    brightnessctl
    alejandra
    nixd
    nix-output-monitor
    nix-init
    nix-prefetch-scripts
    nixfmt
    nvd
    nurl
    age
    sops
    just
    statix
    deadnix
    go
    comma
    bubblewrap

    # Just cool
    peaclock
    cbonsai
    pipes
    cmatrix
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  programs.gamemode.enable = true;

  programs.nh = {
    enable = true;
    clean = {
      enable = false;
      extraArgs = "--keep-since 7d --keep 5";
    };
    flake = "/$HOME/.config/nixos";
  };
}
