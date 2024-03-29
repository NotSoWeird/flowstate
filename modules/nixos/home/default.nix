{
  options,
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.home;
in {
  imports = with inputs; [home-manager.nixosModules.home-manager];

  options.flowstate.home = with types; {
    file = mkOpt attrs {} "A set of files to be managed by home-manager's <option>home.file</option>.";
    configFile = mkOpt attrs {} "A set of files to be managed by home-manager's <option>xdg.configFile</option>.";
    programs = mkOpt attrs {} "Programs to be managed by home-manager.";
    extraOptions = mkOpt attrs {} "Options to pass directly to home-manager.";
  };

  config = {
    flowstate.home.extraOptions = {
      home.stateVersion = config.system.stateVersion;
      home.file = mkAliasDefinitions options.flowstate.home.file;
      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.flowstate.home.configFile;
      programs = mkAliasDefinitions options.flowstate.home.programs;
    };

    home-manager = {
      useUserPackages = true;

      users.${config.flowstate.user.name} = mkAliasDefinitions options.flowstate.home.extraOptions;
    };
  };
}
