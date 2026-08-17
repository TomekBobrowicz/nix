{ ... }:
{
  networking.hostName = "kinetix";

  hardware.bluetooth.enable = true;

  boot.kernelModules = [ "kvm-amd" ];

  services.thermald.enable = true;

  services.power-profiles-daemon.enable = true;

  services.tlp = {
    enable = false;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      USB_AUTOSUSPEND = 1;
    };
  };
}
