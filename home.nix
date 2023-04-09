{ config, pkgs, lib, ... }:

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

  # For MacOS only!
  home.username = "Auguste";
  home.homeDirectory = /Users/Auguste;

  home.packages = with pkgs; [
    agedu
    cargo
    dura # Git tool for commiting unstaged code
    fd
    jq
    micromamba
    nixfmt
    ripgrep
    tealdeer # Rewrite of tldr
    tree
    # tectonic

    elan # Lean package manager
  ];

  programs = {
    bat = { enable = true; };
    broot = { enable = true; };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      stdlib = builtins.readFile ./config/direnv/direnvrc;
    };
    exa = { enable = true; };
    fzf = {
      enable = true;
      defaultOptions = [ "--extended" "--cycle" ];
    };
    git = import ./config/git/config.nix;
    helix = {
      enable = true;
      settings = import ./config/helix/config.nix;
      # languages = (builtins.fromTOML (builtins.readFile ./config/helix/languages.toml));
    };
    # Let Home Manager install and manage itself.
    home-manager = { enable = true; };
    neovim = { enable = true; };
    nnn = {
      enable = true;
      bookmarks = {
        d = "~/Desktop";
        c = "~/.config";
        n = "~/Documents/Nextcloud/Notes";
      };
      plugins = {
        src = ./config/nnn/plugins;
        mappings = {
          z = "jump";
          g = "rec";
          h = "fzopen";
        };
      };
    };
    starship = {
      enable = true;
      settings =
        (builtins.fromTOML (builtins.readFile ./config/starship/config.toml));
    };
    wezterm = {
      enable = true;
      extraConfig = builtins.readFile ./config/wezterm/wezterm.lua;
    };
    zathura = import ./config/zathura/config.nix;
    zoxide = { enable = true; };
    zsh = {
      enable = true;
      completionInit = ''
        autoload -U compinit
        zstyle ':completion:*' menu select
        zmodload zsh/complist
        compinit -C
        _comp_options+=(globdots) # Include hidden files in autocomplete:
      '';
      # Adding this to login so that it's run after zshrc, where the zoxide
      # init script is run
      loginExtra = ''
        # Use `zf` with `zoxide`
        if command -v zf &> /dev/null
        then
          function __zoxide_zi() {
            result="$(zoxide query -l -- "$@" | zf)" && cd "$result"
          }
        fi
      '';
      initExtra = builtins.readFile ./config/zsh/zshrc;
      dotDir = ".config/zsh";
    };
  };

  home.sessionVariables = rec {
    CONFIG = "${config.home.homeDirectory}/.config";
    XDG_CONFIG = "${CONFIG}";
    SHARE = "${config.home.homeDirectory}/.local/share";

    EDITOR = "hx";
    GIT_EDITOR = "$EDITOR";
    VISUAL = "$EDITOR";

    LESS = "-imJMWR";
    PAGER = "less ${LESS}";
    MANPAGER = "$PAGER";
    GIT_PAGER = "$PAGER";

    BROWSER = "qutebrowser";

    TERMINAL = "wezterm";

    LANG = "en_US.UTF-8";
    LC_ALL = "${LANG}";
    LC_COLLATE = "C";
    LSCOLORS = "gxfxcxdxbxegedabagacad";

    ## cargo
    CARGO_HOME = "${CONFIG}/cargo";

    ## doom-emacs
    DOOMDIR = "${CONFIG}/doom";

    ## flavours
    FLAVOURS_CONFIG_FILE = "${CONFIG}/flavours/config.toml";
    FLAVOURS_DATA_DIRECTORY = "${SHARE}/flavours";

    ## goku
    GOKU_EDN_CONFIG_FILE = "${CONFIG}/karabiner/karabiner.edn";

    ## grep
    GREP_OPTIONS = "--color=auto";

    ## IPython
    IPYTHONDIR = "${CONFIG}/ipython";

    ## nix
    NIX_PAGER = "cat";

    ## nnn
    NNN_OPTS = "He";
    # Use trash-cli instead of rm
    NNN_TRASH = "1";
    NNN_CONTEXT_COLORS = "4312";
    # Custom 'open' script
    NNN_OPENER = "${CONFIG}/nnn/plugins/nuke";

    ## nvim
    NVIM_CONFIG_DIR = "${CONFIG}/nvim";

    ## pass
    PASSWORD_STORE_DIR = "${SHARE}/pass/.password-store";
    PASSWORD_STORE_ENABLE_EXTENSIONS = "true";
    PASSWORD_STORE_EXTENSIONS_DIR = "${PASSWORD_STORE_DIR}/.extensions";

    ## poetry
    POETRY_VIRTUALENVS_IN_PROJECT = "1";

    ## qmk
    QMK_HOME = "${CONFIG}/qmk/qmk_firmware";
  };

  home.sessionPath = [
    # Ideally I would add Rust programs to this config
    # rather than getting them here
    "${config.home.sessionVariables.CARGO_HOME}/bin"
  ];

  home.shellAliases = with config.home.sessionVariables; {
    "..." = "../..";
    cf = "$EDITOR ${CONFIG}";
    cl = "clear";
    cm = "chezmoi";
    e = "$EDITOR";
    "e." = "$EDITOR .";
    emacs = "emacs -nw";
    gn = "nvim -c Neogit";
    hms =
      "home-manager switch --flake 'path:${CONFIG}/nixpkgs#${config.home.username}'";
    ipt = "ipython";
    k = "kak";
    l = "exa --all --long";
    ls = "ls -AFHG";
    m = "micromamba";
    ma = "micromamba activate";
    md = "micromamba deactivate";
    mi = "micromamba install";
    ne = "nix-env";
    nd = "mkdir";
    nf = "touch";
    p = "pijul";
    p3 = "python3";
    po = "poetry";
    pt = "pytest";
    t = "tldr";
    tec = "tectonic";
    tw = "taskwarrior-tui";
    v = "nvim";
    vi = "nvim";

    # Scripts
    n = "source ${toString ./config/scripts}/n";
    zat = "source ${toString ./config/scripts}/zat";
    di = "${toString ./config/scripts}/di";

    # Git
    ga = "git add";
    gaa = "git add --all";
    gc = "git commit --verbose";
    gca = "git commit --verbose --all";
    gcam = "git commit --verbose --amend";
    gd = "git diff";
    gl = "git log --oneline -n 10";
    grh = "git reset --hard";
    grl = "git reflog";
    grm = "git rm";
    gs = "git status --short";
    gch = "git checkout";
    gb = "git branch";
    gbd = "git branch --delete";
    gbl = "git branch --list";
    gp = "git pull";
    gpp = "git push";
    gpf = "git push --force";
  };
}
