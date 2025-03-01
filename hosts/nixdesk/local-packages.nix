{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    go
    git
    vim
  ];
}
