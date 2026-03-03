{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # --- BOOT & KERNEL ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = ["nvidia-drm.modeset=1"];
  boot.kernelModules = ["samsung-galaxybook"];
  boot.kernelPackages = pkgs.linuxPackages_6_18;

  # --- NETWORKING ---
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  # --- LOCALE & INPUT ---
  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };
  console.keyMap = "br-abnt2";
  services.xserver.xkb = {
    layout = "br";
    variant = "abnt2";
  };

  # --- NVIDIA DRIVERS ---
  services.xserver.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # --- USERS ---
  users.users.gerep = {
    isNormalUser = true;
    description = "gerep";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "zoxide" ];
      theme = "robbyrussell";
    };
  };

  programs.light.enable = true;

  # --- SYSTEM PACKAGES ---
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # Desktop / WM Tools
    swaybg swayidle swaylock waybar fuzzel ghostty yazi
    playerctl brightnessctl xdg-utils
    wl-clipboard

    # Dev Tools
    neovim wget git unzip gcc python3 zoxide brave
    godotPackages_4_6.godot
    go_1_26
    jetbrains.datagrip
    starship
  ];

  # --- PROGRAMS & SERVICES ---
  programs.niri.enable = true;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    zlib zstd stdenv.cc.cc curl openssl attr libssh bzip2
    libxml2 acl libsodium util-linux xz systemd glibc
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  security.pam.services.swaylock = {};

  services.openssh.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  zramSwap.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = { automatic = true; dates = "weekly"; options = "--delete-older-than 14d"; };

  system.stateVersion = "25.11";
}
