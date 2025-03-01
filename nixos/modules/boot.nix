{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # It is needed for my hard drive to work
  boot.supportedFilesystems = [ "ntfs" ];
}
