{
  enable = true;

  options = {
    selection-clipboard = "clipboard";

    # Use relative path of document in status bar
    statusbar-basename = true;

    # Font
    font = "Rec Mono Semicasual 15";

    # In BW mode by default
    recolor = true;
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

  extraConfig = ''
    # Flavours base16 color scheme
    include flavours

    unmap <C-n>
    unmap <C-m>
    unmap <C-u>
    unmap <C-b>
  '';
}
