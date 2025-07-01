{ config, pkgs, ... }:
let
 myAliases = {
  nrs = "sudo nixos-rebuild switch";
  nrsf = "sudo nixos-rebuild switch --flake";
  nfu = "nix flake update";
  hmsf = "home-manager switch --flake";
 };
in
{
 nixpkgs = {
  config = {
   allowUnfree = true;
   allowUnfreePredicate = (_: true);
  };
 };

  home.username = "kaladin";
  home.homeDirectory = "/home/kaladin";
  home.stateVersion = "25.05"; 

  home.packages = with pkgs; [
  bat
  davinci-resolve-studio
  discord
  obs-studio
  rofi
  xwallpaper
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
  
  programs = {
   bash = {
    enable = true;
    shellAliases = myAliases;
   };
   zsh = {
    enable = true;
    shellAliases = myAliases;
   };
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
