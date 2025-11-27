{
  description = "Kalyan's Minimal Flake";

  inputs = {

    # Stable Channel
    nixpkgs.url = "github:NixOS/nixpkgs/release-25.11";
    nixpkgsStable.url = "github:NixOS/nixpkgs/release-25.11";
    nixpkgsUnstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Additonal Flake Config
    #
    # Home Manager
    # For Home Configurations
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgsStable";
    };
    # Chaotic Nyx
    # URL - https://www.nyx.chaotic.cx/
    # For CachyOS Kernel
    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    };

    #
    # Zen Browser Flake
    # URL - https://github.com/0xc000022070/zen-browser-flake
    # For Zen Browser
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input
      inputs.nixpkgs.follows = "nixpkgsUnstable";
      inputs.home-manager.follows = "home-manager";
    };

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

    #
    # NixVim
    nixvim = {
      url = "github:nix-community/nixvim";
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
      inputs.nixpkgs.follows = "nixpkgsUnstable";
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
      zen-browser,
      determinate,
      nixvim,
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
            userName = "kalyanm";
            hostName = "ThinkPadT16";
            hostMachine = "ThinkPadT16";
            inherit self;
            inherit pkgsUnstable;
            inherit chaotic;
            inherit zen-browser;
            inherit inputs;
          };
          modules = [
            ./hosts/ThinkPadT16/ThinkPadT16.nix
            nixvim.nixosModules.nixvim
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
            # Chaotic Nyx Stable Channel Modules
            chaotic.nixosModules.nyx-cache
            chaotic.nixosModules.nyx-overlay
            chaotic.nixosModules.nyx-registry
            chaotic.nixosModules.mesa-git

            # Chaotic Nyx unstable Channel Modules
            # chaotic.nixosModules.default

            # Load the Determinate module
            determinate.nixosModules.default
          ];
        };
        SER7 = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            userName = "kalyanm";
            hostName = "SER7";
            hostMachine = "SER7";
            inherit self;
            inherit pkgsUnstable;
            inherit chaotic;
            inherit zen-browser;
            inherit inputs;
          };
          modules = [
            ./hosts/SER7/SER7.nix
            nixvim.nixosModules.nixvim
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
            # Chaotic Nyx Stable Channel Modules
            chaotic.nixosModules.nyx-cache
            chaotic.nixosModules.nyx-overlay
            chaotic.nixosModules.nyx-registry
            chaotic.nixosModules.mesa-git

            # Chaotic Nyx unstable Channel Modules
            # chaotic.nixosModules.default

            # Load the Determinate module
            determinate.nixosModules.default
          ];
        };
      };

    };
}
