{ pkgs, ... }: {
  home.packages = with pkgs.gnomeExtensions;[
    appindicator
    clipboard-indicator
    blur-my-shell
    docker
    cronomix
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "clipboard-indicator@tudmotu.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "blur-my-shell@aunetx"
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        "cronomix@zagortenay333"
        "docker@stickman_0x00.com"
      ];
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "brave-browser.desktop"
        "code.desktop"
        "org.gnome.Console.desktop"
        "discord.desktop"
        "org.gnome.Calendar.desktop"
        "com.obsproject.Studio.desktop"
        "org.telegram.desktop.desktop"
        "org.gnome.Settings.desktop"
        "org.gnome.TextEditor.desktop"
        "org.gnome.Calculator.desktop"
      ];
    };

    "org/gnome/shell/extensions/appindicator" = {
      icon-saturation = 2.7755575615628914;
      icon-size = 22;
      legacy-tray-enabled = true;
    };

    "org/gnome/shell/extensions/clipboard-indicator" = {
      history-size = 200;
      move-item-first = true;
    };
  };
}
