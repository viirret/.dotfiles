{
  description = "Valtteri's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {

      wm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./users/valtteri/default.nix
          ./hosts/wm/default.nix
          ./modules/wm.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.valtteri = import ./home/valtteri/default.nix;
            };
          }
        ];
      };

      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./users/valtteri/default.nix
          ./hosts/laptop/default.nix
          ./modules/laptop.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.valtteri = import ./home/valtteri/default.nix;
            };
          }
        ];
      };
    };
  };
}
