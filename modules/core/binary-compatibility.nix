{ ... }:

{
  # Run third-party dynamically linked programs and AppImages without repackaging.
  programs.nix-ld.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
