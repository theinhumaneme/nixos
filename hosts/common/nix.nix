{ ... }: {
  nix = {
    settings = {
      substituters = [
        "https://cache.nixos.org/"
        "https://install.determinate.systems"
      ];
      trusted-public-keys = [
        "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
        "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
      ];
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
        "parallel-eval"
      ];
      lazy-trees = true;
      eval-cores = 0;
    };

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };
}
