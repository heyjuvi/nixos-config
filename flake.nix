{
  description = "System nix flake";

  inputs = {
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }@inputs: {
    nixosConfigurations = {
      luna = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
	modules =
	  [
	    ./hosts/luna
	    home-manager.nixosModules.home-manager {
	      home-manager.useGlobalPkgs = true;
	      home-manager.useUserPackages = true;
	      home-manager.extraSpecialArgs = inputs;
	      home-manager.users.juvi = { ... }: {
	        imports =
	          [
	            ./home
	          ];
	      };
	    }
	  ];
      };
    };
  };
}
