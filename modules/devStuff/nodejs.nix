{ lib, pkgs, userName, enableNodeJsTooling, ... }: {
  users.users."${userName}".packages =
    (lib.optionals enableNodeJsTooling [ pkgs.nodejs_22 ]);
}
