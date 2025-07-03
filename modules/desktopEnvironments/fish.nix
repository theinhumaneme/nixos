{
  pkgsUnstable,
  userName,
  ...
}:
{
  programs.fish = {
    enable = true;
  };
  users.users."${userName}" = {
    shell = pkgsUnstable.fish;
    packages = with pkgsUnstable; [
    ];
  };
}
