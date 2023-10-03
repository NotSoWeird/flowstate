{ options
, config
, pkgs
, lib
, inputs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.apps.helix;
in
{
  options.flowstate.apps.helix = with types; {
    enable = mkBoolOpt false "Enable or disable helix";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      EDITOR = "hx";
    };
    environment.systemPackages = with pkgs; [
      helix
    ];

    # flowstate.home.extraOptions = {
    #   helix = {
    #     defaultEditor = true;

    #     settings = {
    #       theme = "base16_transparent";
        
    #       editor = {
    #         line-number = "relative";
    #         lsp.display-messages = true;
    #         cursor-shape = {
    #           insert = "bar";
    #           normal = "block";
    #           select = "underline";
    #         };
    #       };

    #       keys.normal = {
    #         space = {
    #           space = "file_picker";
    #           s = ":w";
    #           q = ":q";
    #         };
    #         esc = [ "collapse_selection" "keep_primary_selection" ];
    #       };
    #     };
    #   };
    # };
  };
}
