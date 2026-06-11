{...}: {
  flake.nixosModules.printing = { pkgs, ... }: {
    services.ipp-usb.enable = true;
    services.printing = {
      enable = true;
      drivers = with pkgs; [
        hplip
        gutenprint
        gutenprintBin
        canon-cups-ufr2
        # cnijfilter2
        # epson-inkjet-escpr
        # brother-brlaser
      ];
    };
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}