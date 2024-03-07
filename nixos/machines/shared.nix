{ config, pkgs, lib, userSettings, systemSettings, ... }:

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
  networking.hostName = systemSettings.hostname;

  # Set your time zone.
  time.timeZone = systemSettings.timeZone;

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
  i18n.defaultLocale = systemSettings.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };

  # setup windowing environment

  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # gnome and others don't support proper fractional scaling
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  #
  # remove some default gnome packages
  # environment.gnome.excludePackages = (with pkgs; [
  #   gnome-photos
  #   gnome-tour
  # ]) ++ (with pkgs.gnome; [
  #   cheese # webcam tool
  #   gnome-music
  #   gnome-terminal
  #   gedit # text editor
  #   epiphany # web browser
  #   geary # email reader
  #   evince # document viewer
  #   gnome-characters
  #   totem # video player
  #   tali # poker game
  #   iagno # go game
  #   hitori # sudoku game
  #   atomix # puzzle game
  # ]);

  environment = {
    variables = {
      XDG_CACHE_HOME = "/home/${userSettings.username}/.cache";
      EDITOR = "nvim";
    };
  };

  # TODO: these are part of home manager.
  # xdg.enable = true;
  # programs.gpg.enable = true;
  # programs.gpg.agent = {
  #   enable = true;
  #   pinentryFlavor = "tty";
  #   # cache the keys forever so we don't get asked for a password
  #   defaultCacheTtl = 31536000;
  #   maxCacheTtl = 31536000;
  # };

  # Enable tailscale. We manually authenticate when we want with
  # "sudo tailscale up". If you don't use tailscale, you should comment
  # out or delete all of this.
  # services.tailscale.enable = true;

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
  programs.direnv.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    hashedPassword = userSettings.hashedPassword;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      fd
      fzf
      gh
      htop
      unzip
      jq
      ripgrep
      tree
      watch
      gopls
      nodejs
      cachix
      starship
      lazygit
      neofetch
      screenfetch
      sqlite
      go
      # mysql80
      # postgresql_16
    ];
    shell = pkgs.fish;
  };

  services.getty.autologinUser = userSettings.username;
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = userSettings.username;

  users.mutableUsers = false;


  # Manage fonts. We pull these from a secret directory since most of these
  # fonts require a purchase.
  fonts = {
    fontDir.enable = true;

    packages = with pkgs;[
      inter
      ibm-plex
      input-fonts
      commit-mono
      jetbrains-mono
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "IBM Plex Serif" ];
        sansSerif = [ "Inter Variable" ];
        monospace = [ "Input Mono" "JetBrains Mono" "IBM Plex Mono" ];
      };
    };
  };

  # for input mono
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.input-fonts.acceptLicense = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    gcc
    gnumake
    killall
    alacritty
    kitty
    lf
    neovim
    xclip
    xsel
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

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
