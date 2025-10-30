{ pkgs, ... }:
{
  
  # enable = true;
  # package = pkgs.vscode.fhs;
  # extensions = with pkgs.vscode-extensions; [
  #   jnoortheen.nix-ide
  #   arrterian.nix-env-selector
  #   github.copilot
  #   github.copilot-chat
  #   ms-vscode.remote-explorer
  #   ms-vscode-remote.vscode-remote-extensionpack
  #   ms-vscode-remote.remote-ssh
  #   ms-vscode-remote.remote-ssh-edit

  # ];
  # profiles.default = {
  #   userSettings = {
  #     # "password-store" = "gnome-libsecret";
  #     "telemetry.enableTelemetry" = false;
  #   };
  # };
  environment = {
    systemPackages = with pkgs; [
      vscode
      vscode.fhs
    ];
  };
}