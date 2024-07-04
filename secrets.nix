let
  micaht = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBbLdfGXOztrlXoNb618Jw/fU+fRPPYTvWGqyc76I7nn";
  micahtronL = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOlSgPt/RSumIgsgf1AarIcNeOq6w/6/4HWsbZsF7+pP";
  micahtronserver = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPZYjCzHLffK8QOaQ8ep0QSevIEU++dsTfx/U8U6tnhd";
  micahtronserverRoot = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHGMd7vVGShkK2r57OIHfXyNKiU0ucxXtV1qpXdamjNr";
  users = [
    micaht
  ];
  hosts = [
    micahtronL
    micahtronserver
    micahtronserverRoot
  ];
in
{
  "secrets/matrix/turn_secret.age".publicKeys = [micaht micahtronserver];
  "secrets/coturn/coturn_turn_secret.age".publicKeys = [micaht micahtronserver];
  "secrets/postgresql/matrix-database.sql.age".publicKeys = [micaht micahtronserver];
  "secrets/waybar/weather.sh.age".publicKeys = [micaht micahtronL];
  "secrets/liveSync/livesync.env.age".publicKeys = [micaht micahtronserver];
  "secrets/liveSync/couchdb.ini.age".publicKeys = [micaht micahtronserver];
  "secrets/immich/immich.env.age".publicKeys = [micaht micahtronserver];
  "secrets/immich/immichdb.env.age".publicKeys = [micaht micahtronserver];
  "secrets/radicale/htpasswd.age".publicKeys = [micaht micahtronserver];
  "secrets/gluetun/gluetun.age".publicKeys = [micaht micahtronserver];
  # "secrets/nextcloud/nextcloud-pass.age".publicKeys = [micaht micahtronserver];
  # "secrets/nextcloud/nextcloud-database-pass.age".publicKeys = [micaht micahtronserver];
}