{ config, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases =
      let
        flakeDir = "~/nix";
      in {
        sw = "nh os switch";
        upd = "nh os switch --update";
        hms = "nh home switch";

        pkgs = "nvim ${flakeDir}/home-manager/home-packages.nix";

        r = "ranger";
        v = "nvim";
        se = "sudoedit";
        microfetch = "microfetch && echo";

        gs = "git status";
        ga = "git add";
        gc = "git commit";
        gp = "git push";

        ".." = "cd ..";
      };

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    initExtra = ''
      # Start Tmux automatically if not already running. No Tmux in TTY and non-Alacritty
      if [ -z "$TMUX" ] && [ -n "$DISPLAY" ] && [ -n "$ALACRITTY_WINDOW_ID" ]; then
        tmux attach-session -t default || tmux new-session -s default
      fi

      # Start UWSM
      if uwsm check may-start > /dev/null && uwsm select; then
        exec systemd-cat -t uwsm_start uwsm start default
      fi
    '';
  };
}
