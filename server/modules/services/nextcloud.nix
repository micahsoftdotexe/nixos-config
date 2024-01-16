{ config, pkgs, inputs, ... }:
{
    services.nextcloud = {
        enable = true;
        package = pkgs.nextcloud28;
        hostName = "nextcloud.micahsoft.net";
        https = true;
        datadir = "/disk0/nextcloud";
        configureRedis = true;
        config = {
            adminpassFile = "${config.age.secrets.nextcloud_pass.path}";
            dbtype = "pgsql";
            dbname = "nextcloud";
            dbpassFile = "${config.age.secrets.nextcloud_database_pass.path}";
        };
        extraApps = {
            deck = config.services.nextcloud.package.packages.apps.deck;
            notes = config.services.nextcloud.package.packages.apps.notes;
        };
        extraAppsEnable = true;
        appstoreEnable = true;
    };

    services.nginx.virtualHosts.${config.services.nextcloud.hostName} = {
        forceSSL = true;
        useACMEHost = "micahsoft.net";
    };
}