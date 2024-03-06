{ config, pkgs, lib, currentSystem, currentSystemName, ... }:

{
  # Be careful updating this.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix = {
    # use unstable nix so we can access flakes
    package = pkgs.nixUnstable;
  };
  nix.settings.experimental-features = [ "flakes nix-command" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # VMware, Parallels both only support this being 0 otherwise you see
  # "error switching console mode" on boot.
  boot.loader.systemd-boot.consoleMode = "0";

  # Define your hostname.
  networking.hostName = "dev";

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  networking.networkmanager.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

  # Don't require password for sudo
  security.sudo.wheelNeedsPassword = false;

  # Virtualization settings
  # virtualisation.docker.enable = true;

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_IN.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_IN.UTF-8";
      LC_IDENTIFICATION = "en_IN.UTF-8";
      LC_MEASUREMENT = "en_IN.UTF-8";
      LC_MONETARY = "en_IN.UTF-8";
      LC_NAME = "en_IN.UTF-8";
      LC_NUMERIC = "en_IN.UTF-8";
      LC_PAPER = "en_IN.UTF-8";
      LC_TELEPHONE = "en_IN.UTF-8";
      LC_TIME = "en_IN.UTF-8";
    };
  };

  # setup windowing environment
  hardware = {
    opengl.enable = true;
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };
  environment = {
    variables = {
      NIXOS_OZONE_WL = "1";
      GDK_BACKEND = "wayland,x11";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      XDG_SESSION_TYPE = "wayland";
      XDG_CACHE_HOME = "/home/akash/.cache";
      EDITOR = "nvim";
    };
  };
  xdg.enable = true;

  programs.gpg.enable = true;
  programs.gpg.agent = {
    enable = true;
    pinentryFlavor = "tty";
    # cache the keys forever so we don't get asked for a password
    defaultCacheTtl = 31536000;
    maxCacheTtl = 31536000;
  };

  # Enable tailscale. We manually authenticate when we want with
  # "sudo tailscale up". If you don't use tailscale, you should comment
  # out or delete all of this.
  # services.tailscale.enable = true;

  programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.akash = {
    isNormalUser = true;
    description = "Akash";
    hashedPassword = "$y$j9T$rka7WMNIqs/u4KQopsGuB1$6YgkyrjVaCbPQYaspzIGK8mTIF9iWhNYV10nF4PWLs9";
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      fzf
      gh
      htop
      jq
      ripgrep
      tree
      watch
      gopls
      nodejs
      cachix
    ];
    shell = pkgs.fish;
  };

  services.getty.autologinUser = "akash";

  users.mutableUsers = false;


  # Manage fonts. We pull these from a secret directory since most of these
  # fonts require a purchase.
  fonts = {
    fontDir.enable = true;

    packages = with pkgs;[
      jetbrains-mono
      ibm-plex
      inter
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "IBM Plex Serif" ];
        sansSerif = [ "Inter Variable" ];
        # TODO: use Input Mono
        monospace = [ "JetBrains Mono" ];
      };
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    gcc
    gnumake
    killall
    xclip
    wayland
    alacritty
    kitty
    lf
    neovim
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;
  services.openssh.settings.PermitRootLogin = "yes";

  # Disable the firewall since we're in a VM and we want to make it
  # easy to visit stuff in here. We only use NAT networking anyways.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
