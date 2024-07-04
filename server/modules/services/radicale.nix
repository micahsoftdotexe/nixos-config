{config, ...}:
{
  services.radicale = {
    enable = true;
    settings = {
      server.hosts = ["0.0.0.0:5232"];
      auth = {
        type = "htpasswd";
        htpasswd_filename = config.age.secrets.radicale.path;
        htpasswd_encryption = "bcrypt";
      };
    };
  };
}