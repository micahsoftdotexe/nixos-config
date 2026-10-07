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
      description = "llama.cpp server (Qwen3.6-27B)";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      environment = {
        # Uncomment if your GPU isn't detected:
        # HSA_OVERRIDE_GFX_VERSION = "11.0.0";
      };
      serviceConfig = {
        ExecStart = lib.concatStringsSep " " [
          "${pkgs.llama-cpp-vulkan}/bin/llama-server"
          # Q6_K is ~22.5 GB; leaves room for a large KV cache in 32 GB VRAM
          "-hf unsloth/Qwen3.6-27B-GGUF:Q6_K"
          "--port 8081"
          "--host 127.0.0.1"
          "--n-gpu-layers 99"
          "--ctx-size 65536"
          "--cache-type-k q8_0"
          "--cache-type-v q8_0"
          "--flash-attn on"
          "--parallel 1"
          # Qwen's recommended sampling for coding
          "--temp 0.6"
          "--top-p 0.95"
          "--top-k 20"
          "--min-p 0"
        ];
        Restart = "on-failure";
        User = "micaht";
      };
    };
  };
}
