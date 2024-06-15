# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./fonts-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Casablanca";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Enable the X11 windowing system.
  #services.xserver.enable = true;
  /*  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
    layout = "fr";
    xkbVariant = "azerty";
    };
  */
  #Enable the KDE Plasma Desktop Environment.
  # wayland with plasma 6
  services = {
    xserver = {
      enable = true;
      xkb.layout = "fr";
      xkb.variant = "azerty";
    };
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Allow experimental feature "flakes"
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nyxar = {
    isNormalUser = true;
    description = "Nyxar";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirt"];
    #packages = with pkgs; [
    #];
  };
  # Default shell
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # Install firefox.
  programs.firefox.enable = true;
  # Default code editor
  programs.neovim = {
    enable = true;
    #defaultEditor = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # enable bluetooth
  hardware.bluetooth.enable = true;
  # enable hotspot
  # services.create_ap.enable = true;
  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim
    fish
    #wineWowPackages.stable
    #grapejuice
    winetricks
    fastfetch
    keepassxc
    tree
    htop
    btop
    git
    alacritty
    # linux-wifi-hotspot
    # haveged for more entropy
    haveged
    #spotify
    ungoogled-chromium
    mysql80
    # ----aesthetics----
    pipes
    tty-clock
    cava
    # ------------------
    # wayland dependencies
    # styling with json and css
    # waybar
    # dunst
    # libnotify
    # swww
    # rofi-wayland
    # hyprpaper
    # ncmpcpp
    # ------ wayland dependencies end here------
    mpv
    jq
    lan-mouse
    qemu_kvm
    libvirt
    virt-manager
    # ----awesome CLI tools----
    fzf
    fd
    bat
    # delta
    eza
    # --------------------------  
    # ----- File manager ------
    ranger
    ueberzugpp
    kitty
  ];

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = false;
  #enable tmux  
  programs.tmux.enable = true;

  # enabling tilting window manager hyperland
  /*  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    }; */
  programs.xwayland.enable = true;
  #xdg.portal = {
  #     enable = true;
  #      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  #};

  # enable mysql
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };
  #services.longview.mysqlPasswordFile = "/run/keys/mysql.password";
  # enable rng (haveged)
  services.haveged.enable = true;

  # enable docker
  virtualisation.docker.enable = true;

  # use docker without Root access (Rootless docker)
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # nix-garbage-collect every 15 days
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh. enable = true;

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      { from = 2000; to = 4000; }
    ];
    allowedUDPPortRanges = [
      { from = 2000; to = 4000; }
    ];
  };

  networking.firewall.allowedTCPPorts = [ 4242 ];
  networking.firewall.allowedUDPPorts = [ 4242 ];

  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.051"; # Did you read the comment?

}
