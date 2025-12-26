{
  self,
  config,
  lib,
  hostMachine,
  userName,
  ...
}:
{
  specialisation = {
    "gnome-work" = {
      configuration = {
        imports = [
          ../../modules/desktopEnvironments/gnome.nix
          (self + "/hosts/${hostMachine}/devConfig-nixos.nix")
        ];
        home-manager.users."${userName}" = {
          imports = [
            (self + "/hosts/${hostMachine}/devConfig-hm.nix")
          ];
        };
      };
    };
    "gnome-gaming" = {
      configuration = {
        imports = [
          ../../modules/desktopEnvironments/gnome.nix
          ../common/steam.nix
        ];

      };
    };
    "niri-work" = {
      configuration = {
        imports = [
          (self + "/hosts/${hostMachine}/${hostMachine}-mods/niri.nix")
          (self + "/hosts/${hostMachine}/devConfig-nixos.nix")
        ];
        home-manager.users."${userName}" = {
          imports = [
            (self + "/hosts/${hostMachine}/devConfig-hm.nix")
          ];
        };
      };
    };
    "niri-gaming" = {
      configuration = {
        imports = [
          (self + "/hosts/${hostMachine}/${hostMachine}-mods/niri.nix")
          ../common/steam.nix
        ];
      };
    };
    "kde-work" = {
      configuration = {
        imports = [
          ../../modules/desktopEnvironments/plasma.nix
          (self + "/hosts/${hostMachine}/devConfig-nixos.nix")
        ];
        home-manager.users."${userName}" = {
          imports = [
            (self + "/hosts/${hostMachine}/devConfig-hm.nix")
          ];
        };
      };
    };
    "kde-gaming" = {
      configuration = {
        imports = [
          ../../modules/desktopEnvironments/plasma.nix
          ../common/steam.nix
        ];
      };
    };
  };
}
