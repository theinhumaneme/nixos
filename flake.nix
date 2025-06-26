{
  description = "Kalyan's Minimal Flake";

  inputs = {

    # should be same as stable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgsStable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgsUnstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
  };
  outputs =
    {
      self,
      nixpkgs,
      nixpkgsStable,
      nixpkgsUnstable,
      chaotic,
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
          ];
        };
      };
    };

}
