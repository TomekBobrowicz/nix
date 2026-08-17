{ lib, ... }:
let
  githubTokenFile = ../../secrets/github.yaml;
in
{
  # Each host keeps this private age identity outside the repository.
  sops.age.keyFile = "/home/buber/.config/sops/age/keys.txt";

  # The declaration activates automatically when the encrypted file is tracked.
  sops.secrets = lib.optionalAttrs (builtins.pathExists githubTokenFile) {
    github-token = {
      sopsFile = githubTokenFile;
      key = "github_token";
      owner = "buber";
      group = "users";
      mode = "0400";
    };
  };
}
