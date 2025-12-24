{
  lib,
  pkgsUnstable,
  enableRustTooling,
  ...
}:
{
  home.packages = (
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
