{ pkgs, username, ... }:
{

  imports = [ 
  # ../../desktop-env/gnome/system.nix 
  # ./nvidia.nix 
  ];

  boot = {
    plymouth.enable = true;
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "amdgpu" ];
    supportedFilesystems = [ "ntfs" ];
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
      };
    };
  };

  time.timeZone = "Asia/Kolkata";

  users.users.${username} = {
    isNormalUser = true;
    description = "Arunava Ghosh";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    shell = pkgs.zsh;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_IN";
      LC_IDENTIFICATION = "en_IN";
      LC_MEASUREMENT = "en_IN";
      LC_MONETARY = "en_IN";
      LC_NAME = "en_IN";
      LC_NUMERIC = "en_IN";
      LC_PAPER = "en_IN";
      LC_TELEPHONE = "en_IN";
      LC_TIME = "en_IN";
    };
  };

  sound.enable = true;
  hardware = {
    pulseaudio.enable = false;
    bluetooth.settings.General.Experimental = true;
  };
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo.extraConfig = "Defaults !tty_tickets, pwfeedback";
  };

  virtualisation.docker.enable = true;

  environment = {
    systemPackages = with pkgs; [
      curl
      wget
      speedtest-rs
      pciutils
      nil
      nixpkgs-fmt
      zip
      unzip
    ];
  };
  services = {
    syncthing = {
      enable = true;
      user = username;
      dataDir = "/home/${username}/Data/Sync";
      configDir = "/home/${username}/.config/syncthing";
    };
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      excludePackages = [ pkgs.xterm ];
    };

    printing.enable = false;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
    openssh.enable = true;
    pcscd.enable = true;
    gnome.gnome-browser-connector.enable = true;
  };


  fonts = {
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk
      jetbrains-mono
      (import
        ../sources/apple-font.nix
        {
          inherit lib;
          inherit (pkgs) stdenv p7zip;
          inherit (builtins) fetchurl;
        })
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
    fontconfig = {
      enable = true;
      defaultFonts.monospace = [ "JetBrainsMono Nerd Font" ];
    };
  };

  programs = {
    zsh.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    gnome-terminal.enable = true;
  };
  networking = {
    hostName = "nixos";
    firewall.enable = false;
    networkmanager = {
      enable = true;
      wifi.powersave = false;
      insertNameservers = [
        "1.1.1.1"
        "1.0.0.1"
        "2606:4700:4700::1111"
        "2606:4700:4700::1001"
      ];
    };
  };
  system.stateVersion = "23.05";
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };
}
