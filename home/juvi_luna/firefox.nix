{ inputs, config, pkgs, ... }: {

  home.sessionVariables.DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";

  programs.firefox = {
    enable = true;
    profiles.juvi = {
      isDefault = true;
      extensions.force = true;
      extensions.packages = with pkgs.firefox-addons; [
        darkreader
        new-tab-override
        noscript
        old-reddit-redirect
        reddit-enhancement-suite
        sidebery
        skip-redirect
        ublock-origin
      ];
      search = {
        default = "ddg";
        force = true;
        engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "NixOS Wiki" = {
            urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
            icon = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@nw" ];
          };
          "bing".metaData.hidden = true;
          "google".metaData.hidden = true;
          "ddg".metaData.alias = "@ddg";
        };
      };
      settings = {
        "app.normandy.first_run" = false;
        "app.shield.optoutstudies.enabled" = false;
        "privacy.donotttrackheader.enabled" = true;
        "browser.startup.homepage" = "https://duckduckgo.com";
        "browser.search.region" = "DE";
        "browser.search.isUS" = false;
        "browser.theme.content-theme" = "0";
        "browser.theme.toolbar-theme" = "0";
        "browser.sessionstore.resume_from_crash" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.ml.chat.enabled" = false;
        "browser.tabs.groups.smart.enabled" = false;
        "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsored" = false;
        "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "general.useragent.locale" = "de-DE";
        "distribution.searchplugins.defaultLocale" = "de-DE";
        "signon.rememberSignons" = false;
      };
    };
  };

  # to adopt new default with NixOS 26.05
  # Move folder from ~/.mozilla !!
  programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";
}

