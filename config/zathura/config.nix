{
  enable = true;

  options = {
    selection-clipboard = "clipboard";

    # Use relative path of document in status bar
    statusbar-basename = true;

    # Font
    font = "Rec Mono Semicasual 15";

    # synctex = true;
    # synctex-editor-command = "gvim --remote-silent +%{line} %{input}";

    # In BW mode by default
    recolor = true;
    # # When in BW mode, images still have color (buggy)
    # recolor-reverse-video = true;
    # # When in BW mode, file keeps its hue
    # recolor-keephue = true;
  };

  mappings = {
    "=" = "adjust_window width";
    "|" = "adjust_window best-fit";

    "u" = "scroll half-up";
    "b" = "scroll full-up";
    "d" = "scroll half-down";
    "f" = "scroll full-down";

    "<C-s>" = "toggle_statusbar";
    "<C-i>" = "toggle_inputbar";
    "<C-d>" = "toggle_page_mode";

    "<C-f>" = "follow specific";
  };

  extraConfig = builtins.readFile ./zathurarc;
}
