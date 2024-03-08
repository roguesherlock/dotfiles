{ config, pkgs, lib, ... }: {
  imports = [
    ../hardware-configuration.nix
    ../shared.nix
  ];

  # Qemu
  services.spice-vdagentd.enable = true;

  # For now, we need this since hardware acceleration does not work.
  # environment.variables.LIBGL_ALWAYS_SOFTWARE = "1";

  # Lots of stuff that uses aarch64 that claims doesn't work, but actually works.
  nixpkgs.config.allowUnsupportedSystem = true;

  # Share our host filesystem
  # fileSystems."/host" = {
  #   fsType = "fuse./run/current-system/sw/bin/vmhgfs-fuse";
  #   device = ".host:/";
  #   options = [
  #     "umask=22"
  #     "uid=1000"
  #     "gid=1000"
  #     "allow_other"
  #     "auto_unmount"
  #     "defaults"
  #   ];
  # };
}
