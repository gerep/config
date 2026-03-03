{
  description = "gerep's NixOS configuration";

  inputs = {
    # This pins nixpkgs to the unstable branch.
    # You can also use "nixos-25.05" for the stable branch.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
      ];
    };
  };
}
