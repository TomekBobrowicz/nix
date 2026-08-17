{...}: {
  programs.git = {
    enable = true;

    settings = {
      user.name = "TomekBobrowicz";
      user.email = "129859305+TomekBobrowicz@users.noreply.github.com";

      init.defaultBranch = "main";
      pull.rebase = false;
      push.autoSetupRemote = true;
      fetch.prune = true;
      core.editor = "nvim";

      credential.helper = "!gh auth git-credential";
    };
  };
}
