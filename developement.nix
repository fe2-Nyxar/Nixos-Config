{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # ----aesthetics----
    pipes
    tty-clock
    cava
    # ------ developpement ------
    docker-compose
    nodejs_22
    libgcc
    luarocks
    lua5_1
    gcc
    mysql80
    go
    python311
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
  ];
}
