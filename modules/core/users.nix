{...}: {
  users.users.buber = {
    isNormalUser = true;
    description = "Tomek Bobrowicz";
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "input"
      "render"
    ];
    shell = "/run/current-system/sw/bin/bash";
  };
}
