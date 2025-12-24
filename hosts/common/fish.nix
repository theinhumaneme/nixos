{ ... }:
{
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        starship init fish | source
      '';
    };
    starship = {
      enable = true;
    };
  };
}
