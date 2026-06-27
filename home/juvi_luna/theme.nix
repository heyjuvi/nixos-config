

{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  home.pointerCursor =
    let
      chooseCursor = name: {
        gtk.enable = true;
        x11.enable = true;
        name = name;
        package = pkgs.runCommand "cursorTheme" {} ''
          mkdir -p $out/share/icons
          cp -r ${./assets/cursors}/${name} $out/share/icons/${name}
        '';
      };
    in
      chooseCursor "plan9";
}
