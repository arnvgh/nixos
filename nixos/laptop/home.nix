{ pkgs, username, ... }:

{
  imports = [
    # ../../desktop-env/gnome/home.nix
  ]
  ++ map (program: ../../home-manager/${program}.nix)
    [ "zsh" "git" "direnv" "discord"];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    packages = with pkgs; [
      brave
      vscode
      rustup
      celluloid
      nodePackages_latest.pnpm
      telegram-desktop
      obs-studio
      neofetch
      nodejs
      python3
      tree
      blanket
      python310Packages.pip
      protonvpn-gui
    ];
    stateVersion = "23.05";
  };

  programs = {
    neovim.enable = true;
    exa = {
      enable = true;
      enableAliases = true;
    };
  };
  services.gpg-agent.enable = true;
}
