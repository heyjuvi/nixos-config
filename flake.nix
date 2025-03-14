{
  description = "System nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixvim,
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
		    nixvim.homeManagerModules.nixvim
		  ];
	      };
	    }
	  ];
      };
    };
  };
}
