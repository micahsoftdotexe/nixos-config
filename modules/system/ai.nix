{ ... }: {
  flake.nixosModules.ai = { pkgs, lib, ... }: {
    services.open-webui = {
      enable = true;
      port = 8080;
      environment = {
        OPENAI_API_BASE_URL = "http://127.0.0.1:8081/v1";
        OPENAI_API_KEY = "sk-no-key";
      };
    };

    systemd.services.llama-cpp = {
      description = "llama.cpp server (Qwen3.6-35B-A3B)";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      environment = {
        # Uncomment if your GPU isn't detected:
        # HSA_OVERRIDE_GFX_VERSION = "11.0.0";
      };
      serviceConfig = {
        ExecStart = lib.concatStringsSep " " [
          "${pkgs.llama-cpp-vulkan}/bin/llama-server"
          "-hf unsloth/Qwen3.6-35B-A3B-GGUF:UD-IQ4_NL"
          "--port 8081"
          "--host 127.0.0.1"
          "--n-gpu-layers 99"
          "--ctx-size 4096"
          "--parallel 1"
        ];
        Restart = "on-failure";
        User = "micaht";
      };
    };
  };
}
