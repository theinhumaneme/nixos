{
  lib,
  pkgsUnstable,
  userName,
  enableRustTooling,
  ...
}:
{
  users.users."${userName}".packages = (
    lib.optionals enableRustTooling [
      pkgsUnstable.rustc
      pkgsUnstable.cargo
      pkgsUnstable.rust-analyzer
      pkgsUnstable.clippy
      pkgsUnstable.rustfmt
      pkgsUnstable.cargo-bump
    ]
  );
}
