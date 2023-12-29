{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.misc;
in {
  options.flowstate.apps.misc = with types; {
    enable = mkBoolOpt false "Enable or disable misc apps";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Development
      git
      bat
      eza
      fzf
      fd

      # Util
      unzip
      sshfs
      bottom
      ffmpeg
      wget
      wl-clipboard
    ];
  };
}
