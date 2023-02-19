{ config, pkgs, ... }:

{
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  home.username = "Auguste";
  home.homeDirectory = "/Users/Auguste";

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "Auguste Baum";
      userEmail = "auguste.apple@gmail.com";
      delta.enable = true;
      includes = [{path = "~/.config/nixpkgs/git/config"; }];
    };
    fzf = { enable = true; };
    zoxide = { enable = true; };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  home.packages = [
    pkgs.ripgrep
  ];
  
  home.sessionVariables = {
    CONFIG = "${config.home.homeDirectory}/.config";
    XDG_CONFIG = "${config.home.sessionVariables.CONFIG}";
    SHARE = "${config.home.homeDirectory}/.local/share";

    EDITOR = "hx";
    VISUAL = "${config.home.sessionVariables.EDITOR}";
    GIT_EDITOR = "${config.home.sessionVariables.EDITOR}";
    LESS = "-imJMWR";
    PAGER = "less ${config.home.sessionVariables.LESS}";
    MANPAGER = "${config.home.sessionVariables.PAGER}";
    GIT_PAGER = "${config.home.sessionVariables.PAGER}";
    BROWSER = "qutebrowser";

    LANG = "en_US.UTF-8";
    LC_ALL = "${config.home.sessionVariables.LANG}";
    LC_COLLATE = "C";
    LSCOLORS = "gxfxcxdxbxegedabagacad";

    ## cargo
    CARGO_HOME = "${config.home.sessionVariables.CONFIG}/cargo";

    ## doom-emacs
    DOOMDIR = "${config.home.sessionVariables.CONFIG}/doom";

    ## flavours
    FLAVOURS_DATA_DIRECTORY = "${config.home.sessionVariables.SHARE}/flavours";
    FLAVOURS_CONFIG_FILE = "${config.home.sessionVariables.CONFIG}/flavours/config.toml";

    ## fzf
    FZF_DEFAULT_OPTS = "--extended --cycle";

    ## goku
    GOKU_EDN_CONFIG_FILE = "${config.home.sessionVariables.CONFIG}/karabiner/karabiner.edn";

    ## grep
    GREP_OPTIONS = "--color=auto";

    ## IPython
    IPYTHONDIR = "${config.home.sessionVariables.CONFIG}/ipython";

    ## nix
    NIX_PAGER = "cat";

    ## nnn
    NNN_OPTS = "He";
    # Use trash-cli instead of rm
    NNN_TRASH = "1";
    NNN_CONTEXT_COLORS = "4312";
    # Plugin shortcuts
    NNN_PLUG = "g:rec;h:fzopen";
    # Custom 'open' script
    NNN_OPENER = "${config.home.sessionVariables.CONFIG}/nnn/plugins/nuke";

    ## nvim
    NVIM_CONFIG_DIR = "${config.home.sessionVariables.CONFIG}/nvim/";

    ## pass
    PASSWORD_STORE_DIR = "${config.home.sessionVariables.SHARE}/pass/.password-store";
    PASSWORD_STORE_ENABLE_EXTENSIONS = "true";
    PASSWORD_STORE_EXTENSIONS_DIR = "${config.home.sessionVariables.PASSWORD_STORE_DIR}/.extensions";

    ## poetry
    POETRY_VIRTUALENVS_IN_PROJECT = "1";

    ## qmk
    QMK_HOME = "${config.home.sessionVariables.CONFIG}/qmk/qmk_firmware";

    ## starship
    STARSHIP_CONFIG = "${config.home.sessionVariables.CONFIG}/starship/config.toml";
  };

  home.shellAliases = {
    "..." = "" ../.. "";
    "cl" = "clear";
    "cm" = "chezmoi";
    "e" = "${config.home.sessionVariables.EDITOR}";
    "e." = "e .";
    "emacs=" = "emacs -nw";
    "gn" = "nvim -c Neogit";
    "hms" = "home-manager switch --flake 'path:${config.home.sessionVariables.CONFIG}/nixpkgs#${config.home.username}'";
    "ipt" = "ipython";
    "k" = "kak";
    "l" = "exa --all --long";
    "ls" = "ls -AFHG";
    "m" = "mamba";
    "ne" = "nix-env";
    "n" = "source ${config.home.sessionVariables.CONFIG}/scripts/n";
    "nd" = "mkdir";
    "nf" = "touch";
    "p" = "pijul";
    "p3" = "python3";
    "po" = "poetry";
    "pt" = "pytest";
    "t" = "tldr";
    "tec" = "tectonic";
    "tw" = "taskwarrior-tui";
    "v" = "nvim";
    "vi" = "nvim";

    # Git
    "ga" = "git add";
    "gaa" = "git add --all";
    "gc" = "git commit --verbose";
    "gca" = "git commit --verbose --all";
    "gcam" = "git commit --verbose --amend";
    "gd" = "git diff";
    "gl" = "git log --oneline -n 10";
    "grh" = "git reset --hard";
    "grl" = "git reflog";
    "grm" = "git rm";
    "gs" = "git status --short";
    "gch" = "git checkout";
    "gb" = "git branch";
    "gbd" = "git branch --delete";
    "gbl" = "git branch --list";
    "gp" = "git pull";
    "gpp" = "git push";
    "gpf" = "git push --force";
  };
}
