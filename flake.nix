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
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgsStable";
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

    #
    # Nix Darwin
    # URL - https://github.com/LnL7/nix-darwin
    # For MacOS Configuration
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
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
      zen-browser,
      determinate,
      nixvim,
      nix-darwin,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib;
      pkgsUnstableFor = system: import nixpkgsUnstable {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations = {
        ThinkPadT16 = lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            userName = "kalyanm";
            hostName = "ThinkPadT16";
            hostMachine = "ThinkPadT16";
            pkgsUnstable = pkgsUnstableFor "x86_64-linux";
            inherit self;
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
                nixpkgs.config.allowUnfree = true;
              }
            )
            # Load the Determinate module
            determinate.nixosModules.default
          ];
        };
        SER7 = lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            userName = "kalyanm";
            hostName = "SER7";
            hostMachine = "SER7";
            pkgsUnstable = pkgsUnstableFor "x86_64-linux";
            inherit self;
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
                nixpkgs.config.allowUnfree = true;
              }
            )
            # Load the Determinate module
            determinate.nixosModules.default
          ];
        };
      };

      darwinConfigurations = {
        MacBookPro14 = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            userName = "kalyanmudumby";
            hostName = "MacBookPro14";
            hostMachine = "MacBookPro14";
            pkgsUnstable = pkgsUnstableFor "aarch64-darwin";
            inherit self;
            inherit zen-browser;
            inherit inputs;
          };
          modules = [
            ({ ... }: {
        # Let Determinate Nix handle Nix configuration
        nix.enable = false;
      })
            ./hosts/MacBookPro14/MacBookPro14.nix
            home-manager.darwinModules.home-manager
          ];
        };
      };
    };
}
