{ inputs, config, pkgs, ... }: {

  imports = [
    inputs.stylix.homeModules.stylix
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    polarity = "dark";
    fonts.sizes.applications = 10;
    targets = {
      firefox = {
        colorTheme.enable = true;
      };
    };
  };
}

