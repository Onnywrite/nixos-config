{ pkgs, unstable, ... }: {
  environment.systemPackages = with pkgs; [
    git
    vim
  ];
}
