{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Tomek Bobrowicz";
      user.email = "129859305+TomekBobrowicz@users.noreply.github.com";
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
        fetch.prune = true;
        core.editor = "nvim";
      };
    };
  };
}
