{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.flowstate;
let
  cfg = config.flowstate.stylix;
  theme = "uwunicorn";
  themePath = "../../../../themes"+("/"+theme+"/"+theme)+".yaml";                                                                                               
  themePolarity = lib.removeSuffix "\n" (builtins.readFile (./. + "../../../../themes"+("/"+theme)+"/polarity.txt"));                                           
  backgroundUrl = builtins.readFile (./. + "../../../../themes"+("/"+theme)+"/backgroundurl.txt");                                                              
  backgroundSha256 = builtins.readFile (./. + "../../../../themes/"+("/"+theme)+"/backgroundsha256.txt");
in
{
  options.flowstate.stylix = with types; {
    enable = mkBoolOpt false "Enable Stylix";
  };

  config = mkIf cfg.enable {
    flowstate.home.file.".currenttheme".text = theme;
    #stylix.polarity = themePolarity;
  };
}