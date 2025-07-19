{ config, ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Fira Code:size=12";
      };
    };
  };
}
