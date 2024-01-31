{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let cfg = config.flowstate.apps.media.termusic;
in {
  options.flowstate.apps.media.termusic = with types; {
    enable = mkBoolOpt false "Enable or disable Termusic";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ termusic yt-dlp ];
  };
}
