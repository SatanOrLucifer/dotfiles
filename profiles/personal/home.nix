{ config, pkgs, userSettings, ...}:

{
 home.username = userSettings.username;
 home.homeDirectory = "/home/"+userSettings.username;

 programs.home-manager.enable = true;

 imports =
 [
  ../work/home.nix;
  ../../user/app/games/games.nix
 ];

 home.packages = with pkgs; [
  alacritty
  git
  librewolf
  zsh
 ];

 xdg.enable = true;
 xdg.userDirs = {
  extraConfig = {
   XDG_GAME_DIR = "${config.home.homeDirectory}/Media/Games";
   XDG_GAME_SAVE_DIR = "${config.home.homeDirectory}/Media/ Game Saves";
  };
 };

}
