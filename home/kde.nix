{ ... }:
{
  xdg.enable = true;

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "text/html" = [ "google-chrome.desktop" ];
      "x-scheme-handler/http" = [ "google-chrome.desktop" ];
      "x-scheme-handler/https" = [ "google-chrome.desktop" ];
      "video/mp4" = [ "mpv.desktop" ];
      "video/mkv" = [ "mpv.desktop" ];
      "audio/mpeg" = [ "mpv.desktop" ];
    };
  };
}
