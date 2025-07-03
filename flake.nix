{
  description = "Kalyan's Minimal Flake";

  inputs = {

    # Stable Channel
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgsStable = {
      follows = "nixpkgs";
    };
    nixpkgsUnstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Additonal Flake Config
    #
    # Home Manager
    # For Home Configurations
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Chaotic Nyx
    # URL - https://www.nyx.chaotic.cx/
    # For CachyOS Kernel
    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs.nixpkgs.follows = "nixpkgsUnstable";
      inputs.home-manager.follows = "home-manager";
    };
    #
    # Zen Browser Flake
    # URL - https://github.com/0xc000022070/zen-browser-flake
    # For Zen Browser
    # zen-browser = {
    #   url = "github:0xc000022070/zen-browser-flake";
    #   # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
    #   # to have it up-to-date or simply don't specify the nixpkgs input
    #   inputs.nixpkgs.follows = "nixpkgsUnstable";
    # };
    #
    # Determinate Nix Flake
    # URL - https://docs.determinate.systems/
    # For Determinate Nix
    # Faster Parallel Execution
    # Lazy Tree Evalution
    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
      # Follow the Stable Channel
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs =
    {
      self,
      nixpkgs,
      nixpkgsStable,
      nixpkgsUnstable,
      home-manager,
      chaotic,
      # zen-browser,
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
            # inherit zen-browser;
            inherit inputs;
          };
          modules = [
            ./hosts/ThinkPadT16/ThinkPadT16.nix
            home-manager.nixosModules.home-manager
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
