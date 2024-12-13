{ config, pkgs, inputs, ... }:
{
  virtualisation.oci-containers.containers.go2rtc = {
    image = "alexxit/go2rtc:1.9.7";
    volumes = [ "/disk1/homeassistant/config:/config" ];
    extraOptions = [
      "--privileged"
      "--network=host"
    ];
    environment.TZ = "America/New_York";
  };
}