{
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
      pushall = "!git remote | xargs -L1 git push --all";
    };
  };
}
