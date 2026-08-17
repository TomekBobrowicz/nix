{ ... }:

{
  # Private mesh networking. Authenticate each host once with `tailscale up`.
  services.tailscale.enable = true;

  # Peer-to-peer file sync. It starts empty and is configured in the local web UI.
  services.syncthing = {
    enable = true;
    user = "buber";
    dataDir = "/home/buber";
    configDir = "/home/buber/.config/syncthing";
    openDefaultPorts = true;
  };

  programs.kdeconnect.enable = true;
}
