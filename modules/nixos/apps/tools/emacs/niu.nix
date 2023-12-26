{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.flowstate; let
  cfg = config.flowstate.apps.tools.emacs;
in {
  options.flowstate.apps.tools.emacs = with types; {
    enable = mkBoolOpt false "Enable emacs";
  };

  config = mkIf cfg.enable {
    flowstate.apps.tools.python3 = enabled;

    flowstate.home.programs.emacs = {
      package = pkgs.emacs-gtk;
      enable = true;
      extraPackages = epkgs: with epkgs; [
        evil
        evil-collection
        evil-tutor
        #evil-maps
        general
        all-the-icons
        company
        company-box
        dashboard
        diminish
        flycheck
        fira-code-mode
        transient
        git-timemachine
        magit
        hl-todo
        counsel
        ivy
        all-the-icons-ivy-rich
        ivy-rich
        doom-modeline
        nix-mode
        #nix-drv-mode
        #nix-shell
        #nix-repl
        toc-org
        perspective
        projectile
        rainbow-delimiters
        rainbow-mode
        sudo-edit
        doom-themes
        tldr
        treemacs
        treemacs-evil
        treemacs-projectile
        which-key
      ];
      
    };

    #flowstate.home.configFile."emacs/" = {
    # source = ./emacs;
    # recursive = true;
    #};
  };
}
