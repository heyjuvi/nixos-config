{
  description = "System nix flake";

  inputs = {
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    flake-utils.url = "github:numtide/flake-utils";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      #url = "github:nix-community/home-manager/master";
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      #url = "github:sodiboo/niri-flake/very-refactor";
      url = "github:epireyn/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    stylix,
    nix-index-database,
    ...
  }@inputs: let
    inherit (self) outputs;
  in {
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
	      home-manager.extraSpecialArgs = { inherit inputs outputs; };
	      home-manager.users.juvi = { ... }: {
	        imports =
	          [
	            ./home/juvi_luna
	            nix-index-database.homeModules.default
	          ];
	      };
	    }
	  ];
      };
    };

    #homeConfigurations = {
    #  "juvi_luna" = home-manager.lib.homeManagerConfiguration {
    #    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    #    extraSpecialArgs = {inherit inputs outputs;};
    #    modules = [
    #      ./home/juvi_luna
    #    ];
    #  };
    #};
  };
}
