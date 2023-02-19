{
  description = "Home Manager configuration for Auguste";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      arch = "x86_64-darwin";
    in
    {
      defaultPackage.${arch} = home-manager.defaultPackage.${arch};
      formatter.${arch} = nixpkgs.legacyPackages.${arch}.nixpkgs-fmt;

      homeConfigurations.Auguste = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${arch};
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
