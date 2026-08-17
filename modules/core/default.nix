{ pkgs, ... }:
{
  system.stateVersion = "26.05";
  time.timeZone = "Europe/Warsaw";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "pl_PL.UTF-8";
      LC_IDENTIFICATION = "pl_PL.UTF-8";
      LC_MEASUREMENT = "pl_PL.UTF-8";
      LC_MONETARY = "pl_PL.UTF-8";
      LC_NAME = "pl_PL.UTF-8";
      LC_NUMERIC = "pl_PL.UTF-8";
      LC_PAPER = "pl_PL.UTF-8";
      LC_TELEPHONE = "pl_PL.UTF-8";
      LC_TIME = "pl_PL.UTF-8";
    };
  };

  console.keyMap = "pl";

  environment.systemPackages = with pkgs; [
    curl
    wget
    git
    vim
    nano
    pciutils
    usbutils
    htop
    btop
    tree
    unzip
    zip
    file
    ripgrep
    fd
    jq
    fastfetch
  ];
}
