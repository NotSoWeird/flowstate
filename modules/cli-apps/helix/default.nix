{ options, config, lib, pkgs, ... }:

with lib;
let 
  cfg = config.cli-apps.helix;
in
{
  options.cli-apps.helix = with types; {
    enable = mkBoolOpt false "Whether or not to enable helix";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      helix
    ];


    home = {
      helix = {
        defaultEditor = true;

        settings = {
          editor = {
            line-number = "relative";
            lsp.display-messages = true;
            cursor-shape = {
              insert = "bar";
              normal = "block";
              select = "underline";
            };
          };
          
          keys.normal = {
            space = {
              space = "file_picker";
              s = ":w";
              q = ":q";
            };
            esc = [ "collapse_selection" "keep_primary_selection" ];
          };
        };
      };
    };
  };
}