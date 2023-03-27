{
  description = "Home Manager configuration for Auguste";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # A nice utility for setting style globally
    stylix.url = "github:danth/stylix";
  };

  outputs = { nixpkgs, home-manager, stylix, ... }:
    let arch = "x86_64-darwin";
    in {
      defaultPackage.${arch} = home-manager.defaultPackage.${arch};
      formatter.${arch} = nixpkgs.legacyPackages.${arch}.nixpkgs-fmt;

      homeConfigurations.Auguste = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${arch};
        modules = [ stylix.darwinModules.stylix ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = { inherit stylix; };
      };
    };
}
