{
  lib,
  ...
}:
let
  enableChrome = false;
  enableFirefox = false;
  enableBrave = true;
  enableZenBrowser = false;
in
{
  imports =
    lib.optionals enableChrome [
      ./browsers/google-chrome.nix

    ]
    ++ lib.optionals enableFirefox [
      ./browsers/firefox.nix
    ]
    ++ lib.optionals enableBrave [
      ./browsers/brave.nix

    ]
    ++ lib.optionals enableZenBrowser [
      ./browsers/zen-browser.nix

    ];

}
