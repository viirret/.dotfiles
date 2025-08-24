{ config, lib, pkgs, ... }:

{
  options.unfree.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable unfree packages globally.";
  };

  config = lib.mkIf config.unfree.enable {
    nixpkgs.config.allowUnfree = true;
  };

}
