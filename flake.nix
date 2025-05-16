{
  description = "Kalyan's Minimal Flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.11";
    };
    nixpkgsUnstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
  };
  outputs =
    {
      nixpkgs,
      nixpkgsUnstable,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
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
            inherit pkgs pkgsUnstable;
          };
          modules = [
            ./hosts/ThinkPadT16/ThinkPadT16.nix
          ];
        };
      };
    };

}
