{...}: {
  networking.hostName = "t460";

  # Lightweight laptop power management.
  services.tlp.enable = true;

  # Do not run power-profiles-daemon alongside TLP.
  services.power-profiles-daemon.enable = false;

  # Bluetooth only if you actually need it.
  hardware.bluetooth.enable = true;
}
