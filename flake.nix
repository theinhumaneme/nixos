{
  description = "Kalyan's Minimal Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgsUnstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
  };
  outputs =
    {
      nixpkgs,
      nixpkgsUnstable,
      chaotic,
      ...
    }:
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
          specialArgs = {
            inherit pkgsUnstable chaotic;
          };
          modules = [
            ./hosts/ThinkPadT16/ThinkPadT16.nix
            {
              nixpkgs.pkgs = import nixpkgs {
                inherit system;
                config = {
                  allowUnfree = true;
                };
                overlays = [ chaotic.overlays.cache-friendly ]; # IMPORTANT
              };
              chaotic.nyx.overlay.enable = false; # IMPORTANT
            }
            chaotic.nixosModules.nyx-cache
            chaotic.nixosModules.nyx-overlay
            chaotic.nixosModules.nyx-registry

          ];
        };
      };
    };

}
