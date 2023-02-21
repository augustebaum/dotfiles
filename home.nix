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

  home.username = "Auguste";
  home.homeDirectory = "/Users/Auguste";

  programs = {
    bat = { enable = true; };
    broot = {
      enable = true;
      enableZshIntegration = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      stdlib = builtins.readFile ./config/direnv/direnvrc;
      enableZshIntegration = true;
    };
    exa = { enable = true; };
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultOptions = [ "--extended" "--cycle" ];
    };
    git = {
      enable = true;
      userName = "Auguste Baum";
      userEmail = "auguste.apple@gmail.com";
      delta = {
        enable = true;
        options = {
          navigate = true;
          light = true;
        };
      };
      extraConfig = {
        credential = { helper = "cache"; };
        advice = { addIgnoredFile = false; };
        filter = {
          "lfs" = {
            clean = "git-lfs clean -- %f";
            smudge = "git-lfs smudge -- %f";
            process = "git-lfs filter-process";
            required = "true";
          };
        };
        init = { defaultBranch = "main"; };
        diff = {
          colorMoved = "default";
          tool = "opendiff";
        };
        merge = {
          tool = "nvimdiff";
          conflictstyle = "diff3";
        };
        mergetool = {
          keepBackup = false;
          "nvimdiff" = {
            cmd = "nvim -d $LOCAL $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'";
          };
        };
        pager = {
          branch = false;
          log = false;
        };
        push = { autoSetupRemote = true; };
        alias = {
          revert-unstaged =
            "!sh -c '{ git commit -m=tmp --no-verify && git reset --hard HEAD && git reset --soft HEAD^ || git reset --hard HEAD; } > /dev/null 2>&1; git status'";
        };
      };
    };
    helix = {
      enable = true;
      settings =
        (builtins.fromTOML (builtins.readFile ./config/helix/config.toml));
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
          g = "rec";
          h = "fzopen";
        };
      };
    };
    zoxide = { enable = true; };
    zsh = {
      enable = true;
      initExtra = builtins.readFile ./config/zsh/zshrc;
    };
  };

  home.packages = [
    pkgs.cargo
    pkgs.dura
    pkgs.fd
    pkgs.micromamba
    pkgs.nixfmt
    pkgs.ripgrep
    pkgs.starship
  ];

  home.sessionVariables = rec {
    CONFIG = "${config.home.homeDirectory}/.config";
    XDG_CONFIG = "${CONFIG}";
    SHARE = "${config.home.homeDirectory}/.local/share";

    EDITOR = "hx";
    VISUAL = "${EDITOR}";
    GIT_EDITOR = "${EDITOR}";
    LESS = "-imJMWR";
    PAGER = "less ${LESS}";
    MANPAGER = "${PAGER}";
    GIT_PAGER = "${PAGER}";
    BROWSER = "qutebrowser";

    LANG = "en_US.UTF-8";
    LC_ALL = "${LANG}";
    LC_COLLATE = "C";
    LSCOLORS = "gxfxcxdxbxegedabagacad";

    ## cargo
    CARGO_HOME = "${CONFIG}/cargo";

    ## doom-emacs
    DOOMDIR = "${CONFIG}/doom";

    ## flavours
    FLAVOURS_DATA_DIRECTORY = "${SHARE}/flavours";
    FLAVOURS_CONFIG_FILE = "${CONFIG}/flavours/config.toml";

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
    # Plugin shortcuts
    # NNN_PLUG = "g:rec;h:fzopen";
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

    ## starship
    STARSHIP_CONFIG = builtins.toString ./config/starship/config.toml;
  };

  home.shellAliases = with config.home.sessionVariables; {
    "..." = "../..";
    "cl" = "clear";
    "cm" = "chezmoi";
    "e" = "${EDITOR}";
    "e." = "e .";
    "emacs" = "emacs -nw";
    "gn" = "nvim -c Neogit";
    "hms" =
      "home-manager switch --flake 'path:${CONFIG}/nixpkgs#${config.home.username}'";
    "ipt" = "ipython";
    "k" = "kak";
    "l" = "exa --all --long";
    "ls" = "ls -AFHG";
    "m" = "micromamba";
    "ma" = "micromamba activate";
    "mi" = "micromamba install";
    "ne" = "nix-env";
    "n" = "source ${CONFIG}/scripts/n";
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
