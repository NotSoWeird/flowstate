{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.apps.tools.fish;
in
{
  options.flowstate.apps.tools.fish = with types; {
    enable = mkBoolOpt false "Enable fish";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      fish
      eza
      bat
      lazygit
      git
      niche
    ];

    flowstate.home.programs.fish = {
      enable = true;
      shellAliases = {
        ls = "eza -la --icons --no-user --no-time --git -s type";
        cat = "bat";
        ".." = "cd ..";

        # Git aliases
        ga = "git add .";
        gc = "git commit -m ";
        gp = "git push -u origin";

        g = "lazygit";
        neofetch = "niche";
      };

      plugins = [
        {
          name = "z";
          src = pkgs.fetchFromGitHub {
            owner = "jethrokuan";
            repo = "z";
            rev = "85f863f20f24faf675827fb00f3a4e15c7838d76";
            sha256 = "sha256-+FUBM7CodtZrYKqU542fQD+ZDGrd2438trKM0tIESs0=";
          };
        }
      ];
      shellInit = ''
        set -x DIRENV_LOG_FORMAT ""
        direnv hook fish | source

        function , --description 'add software to shell session'
              nix shell nixpkgs#$argv[1..-1]
        end
      '';
    };
  };
}
