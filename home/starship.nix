{
  config,
  lib,
  ...
}:
{
  programs.starship = {
    enable = true;

    settings = {
      add_newline = false;

      format = ''
        [󱄅 ](fg:bold blue)$username[@](fg:white)$hostname $directory$nix_shell$git_branch $character
      '';

      username = {
        show_always = true;
        style_user = "bold blue";
        style_root = "bold red";
        format = "[$user]($style)";
      };

      hostname = {
        ssh_only = false;
        format = "[$hostname]($style)";
        style = "blue";
      };

      directory = {
        style = "blue";
        format = "[\\[ ](fg:white)$path[ \\]](fg:white)";
        read_only = "  ";
      };

      git_branch = {
        format = " [\\[ ](fg:white)$symbol$branch(fg:bold yellow)[ \\]](fg:white)";
      };

      character = {
        success_symbol = "[󰘧](bold white)";
        error_symbol = "[?](bold red)";
      };

      cmd_duration = {
        format = "[$duration]($style)";
        style = "yellow";
      };

      nix_shell = {
        symbol = "";
        format = "[ $symbol ($name)](bold blue)";
      };

      golang = {
        symbol = "";
        format = "[ $symbol ($version_format) ](bold blue)";
      };

      python = {
        symbol = "";
        format = "[ $symbol ($version_format) ](bold green)";
      };

      nodejs = {
        symbol = "󰎙";
        format = "[ $symbol ($version_format) ](bold yellow)";
      };

      rust = {
        symbol = "";
        format = "[ $symbol ($version) ](bold red)";
      };
    };
  };
}
