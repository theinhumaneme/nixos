{
  config,
  lib,
  pkgsUnstable,
  userName,
  enableDocker,
  ...
}:
{
  # Virtualization for Docker
  virtualisation.docker.enable = enableDocker;
  users.users."${userName}" = {
    extraGroups = lib.optionals enableDocker [ "docker" ];

    packages = (
      lib.optionals enableDocker [
        pkgsUnstable.docker-compose
        pkgsUnstable.docker-buildx
      ]
    );
  };
}
