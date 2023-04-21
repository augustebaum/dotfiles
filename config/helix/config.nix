{
  theme = "base16_terminal";
  editor = {
    auto-pairs = false;
    mouse = false;
    auto-save = true;
    bufferline = "multiple";
    whitespace.render.tab = "all";
    text-width = 80;
    soft-wrap = {
      enable = true;
      wrap-at-text-width = true;
      max-indent-retain = 60;
    };
  };

  keys = let
    normal_and_select = {
      # buffer_movement
      "A-[" = ":buffer-previous";
      "A-]" = ":buffer-next";

      # movement
      g.j = "goto_last_line";
      g.k = "goto_file_start";
      A-l = [ "select_mode" "goto_line_end" ];
      A-h = [ "select_mode" "goto_line_start" ];
      "{" = "goto_prev_paragraph";
      "}" = "goto_next_paragraph";

      # clipboard
      p = ":clipboard-paste-after";
      P = ":clipboard-paste-before";
      y = ":clipboard-yank-join";
      Y = ":clipboard-yank";
      R = ":clipboard-paste-replace";
      d = [ "yank_joined_to_clipboard" "delete_selection" ];
    };
  in {
    normal = {
      C-q = ":quit!";
      esc = ":write";
      ret = [ "open_below" "normal_mode" ];
    } // normal_and_select;

    select = { } // normal_and_select;
  };
}
