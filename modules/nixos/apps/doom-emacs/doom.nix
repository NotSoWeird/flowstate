{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.flowstate.apps.doom-emacs;
  themePolarity = lib.removeSuffix "\n" (builtins.readFile (./. + "../../../../themes" + ("/" + theme) + "/polarity.txt"));
  dashboardLogo = ./. + "/nix-" + themePolarity + ".png";

in {
  options.flowstate.apps.doom-emacs = with types; {
    enable = mkBoolOpt false "Enable or disable Emacs";
  };

  config = mkIf cfg.enable {
    lib.programs.doom-emacs = {
      enable = true;
      emacsPackage = pkgs.emacs29-pgtk;
      doomPrivateDir = ./.;
      # This block from https://github.com/znewman01/dotfiles/blob/be9f3a24c517a4ff345f213bf1cf7633713c9278/emacs/default.nix#L12-L34
      # Only init/packages so we only rebuild when those change.
      doomPackageDir = let
        filteredPath = builtins.path {
          path = ./.;
          name = "doom-private-dir-filtered";
          filter = path: type: builtins.elem (baseNameOf path) [ "init.el" "packages.el" ];
        };
      in pkgs.linkFarm "doom-packages-dir" [
        {
          name = "init.el";
          path = "${filteredPath}/init.el";
        }
        {
          name = "packages.el";
          path = "${filteredPath}/packages.el";
        }
        {
          name = "config.el";
          path = pkgs.emptyFile;
        }
      ];
      # End block
  };

  home = {
    file.".emacs.d/themes/doom-stylix-theme.el".source = config.lib.stylix.colors {
      template = builtins.readFile ./themes/doom-stylix-theme.el.mustache;
      extension = ".el";
    };

    packages = with pkgs; [
      nil
      nixfmt
      git
      file
      nodejs
      wmctrl
      jshon
      aria
      hledger
      hunspell
      hunspellDicts.en_US-large
      hunspellDicts.sv_SE
      pandoc
      nodePackages.mermaid-cli
      (python3.withPackages (p: with p; [ pandas requests pyqt6 sip qtpy qt6.qtwebengine epc lxml pyqt6-webengine pysocks pymupdf markdown ]))
    ];

    sessionVariables = { EDITOR = "emacsclient"; };

    file.".emacs.d/eaf" = {
      source = "${lib.eaf}";
      recursive = true;
    };

    file.".emacs.d/org-yaap" = {
      source = "${lib.org-yaap}";
      recursive = true;
    };

    file.".emacs.d/org-side-tree" = {
      source = "${lib.org-side-tree}";
      recursive = true;
    };

    file.".emacs.d/org-timeblock" = {
      source = "${lib.org-timeblock}";
      recursive = true;
    };

    file.".emacs.d/eaf/app/browser" = {
      source = "${lib.eaf-browser}";
      recursive = true;
      onChange =
        "
        pushd ~/.emacs.d/eaf/app/browser;
        rm package*.json;
        npm install darkreader @mozilla/readability && rm package*.json;
        popd;
        ";
    };

    file.".emacs.d/org-nursery" = { source = "${lib.org-nursery}"; };

    file.".emacs.d/dashboard-logo.png".source = dashboardLogo;
    file.".emacs.d/scripts/copy-link-or-file/copy-link-or-file-to-clipboard.sh" = {
      source = ./scripts/copy-link-or-file/copy-link-or-file-to-clipboard.sh;
      executable = true;
    };

    file.".emacs.d/phscroll" = { source = "${lib.phscroll}"; };

    file.".emacs.d/system-vars.el".text = ''
      ;;; ~/.emacs.d/config.el -*- lexical-binding: t; -*-

      ;; Import relevant variables from flake into emacs

      (setq user-full-name "'' + name + ''") ; name
      (setq user-username "'' + username + ''") ; username
      (setq user-mail-address "'' + email + ''") ; email
      (setq user-home-directory "/home/'' + username + ''") ; absolute path to home directory as string
      (setq user-default-roam-dir "'' + defaultRoamDir + ''") ; absolute path to home directory as string
      (setq system-nix-profile "'' + profile + ''") ; what profile am I using?
      (setq system-wm-type "'' + wmType + ''") ; wayland or x11?
      (setq doom-font (font-spec :family "'' + font + ''" :size 20)) ; import font
      (setq dotfiles-dir "'' + dotfilesDir + ''") ; import location of dotfiles directory
      '';
    };
  };
}
