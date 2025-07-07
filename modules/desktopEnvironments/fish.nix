{ pkgsUnstable, userName, ... }:
{
  users.users."${userName}" = {
    shell = pkgsUnstable.fish;
    packages = with pkgsUnstable; [ starship ];
  };

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
