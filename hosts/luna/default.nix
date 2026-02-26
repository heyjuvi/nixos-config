# Edit this configuration file to define what should be installed on

# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, inputs, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t420
      ./hardware-configuration.nix
      inputs.niri.nixosModules.niri
    ];

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  nix.settings.experimental-features =
    [
      "nix-command"
      "flakes"
    ];

  nix.settings.trusted-users =
    [
      "root"
      "juvi"
    ];

  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/d53e920b-98ba-450d-9596-cc1e0910a95b";
      preLVM = true;
    };
  };

  boot.plymouth = {
    enable = true;
    themePackages = [ pkgs.plymouth-blahaj-theme ];
    theme = "blahaj";
  };

  networking.hostName = "luna"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  services.avahi = {
    enable = true;

    nssmdns4 = true;
    nssmdns6 = true;

    ipv4 = true;
    ipv6 = true;

    openFirewall = true;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = false;
    # Configure keymap in X11
    xkb.layout = "de";
    xkb.variant = "neo";
    # xkb.options = "eurosign:e,caps:escape";
  };

  services.displayManager.defaultSession = "niri";

  # Printing
  services.printing = {
    enable = true;
    drivers = [ pkgs.gutenprint ];
  };

  hardware.sane.enable = true; # enables support for SANE scanners

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        ControllerMode = "bredr";
	Experimental = true;
      };
    };
  };

  services.blueman.enable = true;

  security = {
    polkit.enable = true;
    rtkit.enable = true;
    pam.services.swaylock = {
      text = "auth include login";
    };
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.juvi = {
    isNormalUser = true;
    hashedPassword = "$y$j9T$9waBeNWPf/JqV4kt6n1az/$zHjX5ic/gTIJfSwMKLvByUKDKel00vhyObSl0219bS6";
    extraGroups = [ "wheel" "networkmanager" "docker" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
      neovim
      tree
    ];
    shell = pkgs.zsh;
  };

  #virtualisation.virtualbox.host.enable = true;
  #virtualisation.virtualbox.host.enableExtensionPack = true;
  #virtualisation.virtualbox.guest.enable = true;
  #virtualisation.virtualbox.guest.dragAndDrop = true;

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  virtualisation.docker.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    uwufetch
    wget
    sshfs
    wl-clipboard
    ntfs3g
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.dconf.enable = true;

  # Activate zsh
  programs.zsh.enable = true;

  # Nix ld
  programs.nix-ld.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}

