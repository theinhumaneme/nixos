{
  config,
  pkgs,
  lib,
  pkgsUnstable,
  ...
}: {
  imports = [ ../common/nix.nix ];

  environment.systemPackages = with pkgs; [ ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.kalyanmudumby = {
    home = "/Users/kalyanmudumby";
  };

  # Setup home-manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit pkgsUnstable; };
    users.kalyanmudumby = {
      imports = [
        ./devConfig.nix
        ../common/fish.nix
      ];
      home.packages = [ pkgs.nerd-fonts.caskaydia-mono ];
      home.username = "kalyanmudumby";
      home.homeDirectory = "/Users/kalyanmudumby";
      home.stateVersion = "25.11";
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
