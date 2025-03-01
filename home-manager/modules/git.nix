{
  programs.git = {
    enable = true;
    userName = "Onnywrite";
    userEmail = "vlad.mokeev.061611@gmail.com";

    aliases = {
      co = "checkout";
      s = "status";
      a = "add";
      c = "commit";
      p = "push";
      rb = "rebase";
      sp = "stash push";
      spop = "stash pop";
      sdrop = "stash drop";
    };

    extraConfig = {
      safe.directory = "*";
    };
  };
}
