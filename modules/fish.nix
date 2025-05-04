{
  config,
  pkgsUnstable,
  userName,
  ...
}:
{
  programs.fish = {
    enable = true;
    promptInit = "fastfetch";
  };
  users.users."${userName}" = {
    shell = pkgsUnstable.fish;
    packages = with pkgsUnstable; [
      fastfetch
    ];
  };
}
