#; Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "roshar"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  services.xserver = {
   enable = true;
   videoDrivers = ["nvidia"];
   windowManager.qtile.enable = true;
   displayManager.sessionCommands = ''
    xwallpaper --zoom ~/Pictures/wallpaper/dan.png
    xset r rate 200 35 &
   ''; 
   libinput = {
    enable = true;
    mouse = {
     accelProfile = "flat";
     accelSpeed = "0";
    };
   };
  };

  services.picom = {
   enable = true;
   backend = "glx";
   fade = true;
  };

  # Enable OpenGL
  hardware = {
   graphics = {
    enable = true;
   };
   nvidia = {
   modesetting.enable = true;
   powerManagement.enable = true;
   powerManagement.finegrained = false;
   open = true;
   nvidiaSettings = true;
   package = config.boot.kernelPackages.nvidiaPackages.stable;
   };
  };
  
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kaladin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    alacritty
    btop
    gcc
    git
    neovim 
    nfs-utils
    nodejs
    nodePackages.npm
    pcmanfm
    wget
  ];

  fonts.packages = with pkgs; [
   jetbrains-mono
  ];

  programs.steam = {
   enable = true;
   remotePlay.openFirewall = false;
   dedicatedServer.openFirewall = false;
   localNetworkGameTransfers.openFirewall = false;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.stateVersion = "25.05"; # Did you read the comment?
  
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

