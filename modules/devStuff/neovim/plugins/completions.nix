{ ... }:
{
  programs.nixvim = {
    plugins.blink-cmp = {
      enable = true;
      settings = {
        appearance = {
          nerd_font_variant = "mono";
        };
      };
    };
  };

}
