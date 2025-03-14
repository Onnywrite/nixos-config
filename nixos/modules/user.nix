{ pkgs, user, ... }: {
  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;
    users.${user} = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "docker" ];
      packages = with pkgs; [ nekoray ];
    };
  };

  services.getty.autologinUser = user;
}
