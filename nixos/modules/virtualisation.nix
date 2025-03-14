{
  virtualisation.docker = {
    enable = true;

    # Note: remove this line, if you have different FS
    storageDriver = "btrfs";

    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}