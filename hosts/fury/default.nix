{ ... }:
{
  networking.hostName = "fury";

  hardware.bluetooth.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot.kernelModules = [
    "amdgpu"
    "kvm-amd"
  ];

  hardware.amdgpu.initrd.enable = true;

  powerManagement.cpuFreqGovernor = "performance";
}
