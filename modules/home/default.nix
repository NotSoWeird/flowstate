{ options, config, pkgs, lib, inputs, ... }:

with lib;
let
  cfg = config.home;
in
{
  imports = with inputs; [
    home-manager.nixosModules.home-manager
  ];

  options.home = with types; {
    file = mkOpt attrs { } "A set of files to be managed by home-manager's 'home.file'";
    configFile = mkOpt attrs { } "A set of files to be managed by home-manager's 'xdg.configFile'";
    extraOptions = mkOpt attrs { } "Options to pass directly to home-manager";
  };

  config = {
    home.extraOptions = {
      home.stateVersion = config.system.stateVersion;
      home.file = mkAliasDefinitions options.home.file;
      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.home.configFile;
    };

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;

      users.${config.user.name} = mkAliasDefinitions options.home.extraOptions;
    };
  };
}