{
  self,
  config,
  lib,
  hostMachine,
  userName,
  ...
}:
let
  cfg = config.hostSpec;
in
{
  imports = [
    ../../modules/desktopEnvironments/gnome.nix
    ../../modules/desktopEnvironments/plasma.nix
    ../../modules/desktopEnvironments/niri.nix
  ];

  options.hostSpec = {
    useSpecializations = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to use specializations for this host.";
    };

    defaultDesktop = lib.mkOption {
      type = lib.types.enum [
        "gnome"
        "plasma"
        "niri"
        "none"
      ];
      default = "none";
      description = "Default desktop environment to use if specializations are disabled.";
    };
  };

  config = lib.mkMerge [
    # Default Desktop Logic (Only if specializations are disabled)
    (lib.mkIf (!cfg.useSpecializations) {
      desktop.gnome.enable = cfg.defaultDesktop == "gnome";
      desktop.plasma.enable = cfg.defaultDesktop == "plasma";
      desktop.niri.enable = cfg.defaultDesktop == "niri";
    })

    # Specializations Logic
    (lib.mkIf cfg.useSpecializations {
      specialisation = {
        "gnome-work" = {
          configuration = {
            imports = [
              ../../modules/desktopEnvironments/gnome.nix
              (self + "/hosts/${hostMachine}/devConfig-nixos.nix")
            ];
            desktop.gnome.enable = true;
            home-manager.users."${userName}" = {
              imports = [
                (self + "/hosts/${hostMachine}/devConfig-hm.nix")
              ];
            };
          };
        };
        "niri-work" = {
          configuration = {
            imports = [
              (self + "/hosts/${hostMachine}/${hostMachine}-mods/niri.nix")
              (self + "/hosts/${hostMachine}/devConfig-nixos.nix")
            ];
            desktop.niri.enable = true;
            home-manager.users."${userName}" = {
              imports = [
                (self + "/hosts/${hostMachine}/devConfig-hm.nix")
              ];
            };
          };
        };
        "kde-work" = {
          configuration = {
            imports = [
              ../../modules/desktopEnvironments/plasma.nix
              (self + "/hosts/${hostMachine}/devConfig-nixos.nix")
            ];
            desktop.plasma.enable = true;
            home-manager.users."${userName}" = {
              imports = [
                (self + "/hosts/${hostMachine}/devConfig-hm.nix")
              ];
            };
          };
        };
      };
    })
  ];
}
