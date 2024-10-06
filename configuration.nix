# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./vm.nix
    ./hardware-configuration.nix
    ./fonts-configuration.nix
    ./hyprland-dependencies.nix
    ./Terminal.nix
  ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  boot.initrd.kernelModules = [ "amdgpu" ];
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
  /*
    services.xserver = {
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
      xkb.layout = "fr,ara";
      xkb.variant = "azerty";
      videoDrivers = [ "amdgpu" ];
    };
    displayManager.sddm = {
      enable = true;
      autoNumlock = true;
    };
    desktopManager.plasma6.enable = true;
  };
  programs.xwayland.enable = true;

  # Configure console keymap
  console.keyMap = "fr";

  # Enable CUPS to print documents.
  services = {
    printing.enable = true;
    udev.enable = true;
  };
  # enable bluetooth
  hardware.bluetooth.enable = true;
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable fingerprint.
  /*
      services.fprintd = {
        enable = true;
        tod.enable = true;
        tod.driver = pkgs.libfprint-2-tod1-vfs0090;
    }
      systemd.services.fprintd = {
        wantedBy = [ "multi-user.target" ];
      	serviceConfig.Type = "simple";
      };
  */
  /*
    services.fprintd = {
      enable = true;
      tod.enable = true;
      tod.driver = pkgs.libfprint-2-tod1-vfs0090;
    };
  */
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Allow experimental feature "flakes"
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    # Default shell
    defaultUserShell = pkgs.fish;
    users.nyxar = {
      isNormalUser = true;
      description = "Nyxar";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
        "libvirt"
      ];
      # packages = with pkgs; [];
    };
  };

  programs = {
    firefox.enable = true;
    steam.enable = true;
    nix-ld.enable = true;
    neovim.enable = true;
    fish.enable = true;
  };

  #NOTE: automount/umount
  services.gvfs.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # enable hotspot
  # services.create_ap.enable = true;
  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    kitty
    #---- disk / partition related packages ----
    disko # format and changing fs in a declarative way
    ntfs3g
    gparted
    parted
    gnome.gnome-disk-utility
    testdisk
    usbutils
    ventoy-full
    #--- password manager ---
    keepassxc
    syncthing
    # entropy daemon
    haveged
    #-------------------
    mpv
    git
    ranger
    obs-studio
    linuxKernel.packages.linux_zen.v4l2loopback # virtual camera
    # linux-wifi-hotspot
    ungoogled-chromium
    # ----aesthetics----
    pipes
    tty-clock
    cava
    # ------------------
    lan-mouse

    # ------ developpement ------
    docker-compose
    nodejs_22
    libgcc
    gcc
    mysql80
    lua
    php83Packages.composer
    nixfmt-rfc-style # format for the nix language
    nixd # lsp for nix
    mongosh
    rustc
    cargo
    nix-tree
    brightnessctl
    fprintd
    zip
    unzip
    appimage-run
    steam-run
    gtk3
    libdbusmenu-gtk3
    xdg-utils
    /*
      gtk-layer-shell
      pango
      rubyPackages_3_3.gdk_pixbuf2
      cairo
      rubyPackages_3_3.glib2
      glibc
    */
    # ------------------------
    winetricks
    wineWowPackages.waylandFull
    blender-hip
    vesktop
    discover-overlay # overlay for audio
    spotify
    obsidian
    libreoffice # alternative for microsoft office
    hunspell # spellchecker
    hunspellDicts.en_US # english_usa
    hunspellDicts.fr-any # french - any variant
    mangohud
    goverlay
    (prismlauncher.override {
      jdks = [
        jdk8
        jdk17
        jdk19
        jdk21_headless
      ];
    })
    torrential
  ];

  # enable mysql
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };
  #services.longview.mysqlPasswordFile = "/run/keys/mysql.password";
  # enable rng (haveged) #NOTE: this is for entropy (generate randomness) 
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
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      {
        from = 2000;
        to = 4000;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 2000;
        to = 4000;
      }
    ];
  };

  networking.firewall.allowedTCPPorts = [ 4242 ];
  networking.firewall.allowedUDPPorts = [ 4242 ];

  system.stateVersion = "24.051"; # Did you read the comments? no :(
}
