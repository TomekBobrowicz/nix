{ ... }:

{
  # Firmware updates through LVFS when supported by the device manufacturer.
  services.fwupd.enable = true;
  services.smartd.enable = true;

  # Desktop integration for removable drives, MTP devices, network shares, and scanners.
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  hardware.sane.enable = true;
}
