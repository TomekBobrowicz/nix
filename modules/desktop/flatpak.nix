{ pkgs, ... }: {
  services.flatpak.enable = true;

  # The current NixOS Flatpak module has no declarative `remotes` option.
  systemd.services.flatpak-flathub = {
    description = "Configure the Flathub Flatpak remote";
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
    path = [ pkgs.flatpak ];

    serviceConfig.Type = "oneshot";

    script = ''
      flatpak remote-add --if-not-exists --system flathub \
        https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };

  xdg.portal.enable = true;
}
