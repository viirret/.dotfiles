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
          ./configuration.nix
          ./hosts/wm/hardware-configuration.nix
	  ./hosts/wm/default.nix

	  ./modules/xserver/wm.nix
          ./modules/window-manager/i3/default.nix
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
          ./configuration.nix
	  ./hosts/laptop/hardware-configuration.nix
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
