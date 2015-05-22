{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
    windowManager.default = "i3";
  };

  environment.systemPackages = [ pkgs.glxinfo ];

  services.xserver.videoDrivers = [ "virtualbox" ];
}
