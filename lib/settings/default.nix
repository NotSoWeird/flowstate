{lib, ...}:
with lib; rec {
  setting = {
    # ----- USER SETTINGS ----- #
    username = "notsoweird"; # username
    name = "NotSoWeird"; # name/identifier
    email = "wiktor@liew.se"; # email (used for certain configurations)
    dotfilesDir = "~/.dotfiles"; # absolute path of the local repo
    theme = "uwunicorn"; # selcted theme from my themes directory (./themes/)
    wm = "hyprland"; # Selected window manager or desktop environment; must select one in both ./user/wm/ and ./system/wm/
    wmType = "wayland"; # x11 or wayland
    browser = "firefox"; # Default browser; must select one from ./user/app/browser/
    editor = "emacsclient"; # Default editor;
    defaultRoamDir = "Personal.p"; # Default org roam directory relative to ~/Org
    term = "kitty"; # Default terminal command;
    font = "Intel One Mono"; # Selected font
    profile = "personal"; # select a profile defined from my profiles directory
    #fontPkg = pkgs.intel-one-mono; # Font package

    #spawnEditor = if (editor == "emacsclient") then "emacsclient -c -a 'emacs'"
    #              else (if ((editor == "vim") || (editor == "nvim") || (editor == "nano")) then "exec " + term + " -e " + editor else editor);
  };
}
