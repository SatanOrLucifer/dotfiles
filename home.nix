{ config, pkgs, self, ... }:
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

    # Bat config
   ".config/bat/config".text = ''
    --theme="Nord"
    --style="numbers,changes,grid"
    --paging=auto
   '';

    # Nvim Config
   ".config/nvim".source = self + "/nvim";

    # Qtile Config
   ".config/qtile".source = ./qtile;

  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
  
  programs = {

   alacritty = {
    enable = true;
     settings = {
      window.opacity = 0.9;
      font.normal = {
       family = "JetBrains Mono";
      };
      font.size = 12;
     };
   };

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
