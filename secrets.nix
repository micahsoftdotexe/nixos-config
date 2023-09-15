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
}