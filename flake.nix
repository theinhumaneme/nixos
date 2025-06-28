{
  description = "Kalyan's Minimal Flake";

  inputs = {

    # should be same as stable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgsStable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
      follows = "nixpkgs";
    };
    nixpkgsUnstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs.nixpkgs.follows = "nixpkgsUnstable";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input
      inputs.nixpkgs.follows = "nixpkgs";
    };
    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs =
    {
      self,
      nixpkgs,
      nixpkgsStable,
      nixpkgsUnstable,
      chaotic,
      zen-browser,
      determinate,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgsUnstable = import nixpkgsUnstable {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations = {
        ThinkPadT16 = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit pkgsUnstable;
            inherit chaotic;
            inherit zen-browser;
            inherit inputs;
          };
          modules = [
            ./hosts/ThinkPadT16/ThinkPadT16.nix
            (
              { ... }:
              {
                nixpkgs = {
                  inherit system;
                  # This configures the `pkgs` argument passed to all modules.
                  config.allowUnfree = true;
                };
              }
            )
            chaotic.nixosModules.default
            # Load the Determinate module
            determinate.nixosModules.default
          ];
        };
      };
    };

}
