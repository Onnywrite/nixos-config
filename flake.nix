{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, zen-browser, ... }@inputs: let
    system = "x86_64-linux";
    homeStateVersion = "24.11";
    user = "onnywrite";
    hosts = [
      { hostname = "nixdesk"; stateVersion = "24.11"; }
    ];

    unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };

    makeSystem = { hostname, stateVersion }: nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {
        inherit inputs stateVersion hostname user unstable;
      };

      modules = [
        ./hosts/${hostname}/configuration.nix
      ];
    };

  in {
    nixosConfigurations = nixpkgs.lib.foldl' (configs: host:
      configs // {
        "${host.hostname}" = makeSystem {
          inherit (host) hostname stateVersion;
        };
      }) {} hosts;

    homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {
        inherit inputs homeStateVersion user zen-browser unstable;
      };

      modules = [
        ./home-manager/home.nix
      ];
    };
  };
}