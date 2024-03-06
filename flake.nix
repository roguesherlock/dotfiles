{
  description = "NixOS systems and tools by akash";

  inputs = {
    # Pin our primary nixpkgs repository. This is the main nixpkgs repository
    # we'll use for our configurations. Be very careful changing this because
    # it'll impact your entire system.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    # We use the unstable nixpkgs repo for some packages.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      systemSettings = {
        system = "aarch64-linux";
        hostname = "dev";
        locale = "en_US.UTF-8";
        timeZone = "Asia/Kolkata";
      };
      userSettings = {
        username = "akash";
        name = "Akash";
        email = "aakash@hey.com";
        hashedPassword = "$y$j9T$rka7WMNIqs/u4KQopsGuB1$6YgkyrjVaCbPQYaspzIGK8mTIF9iWhNYV10nF4PWLs9";
      };
      inherit (self) outputs;
    in
    {
      nixosConfigurations.system = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs systemSettings userSettings; };
        system = systemSettings.system;
        # > Our main nixos configuration file <
        modules = [ ./nixos/machines/vmware/configuration.nix ];
      };
    };
}
