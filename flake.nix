{
  description = "Dev shell for the project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      packages = with pkgs; [ libyaml postgresql ruby ];

      shellHook = ''
        echo "Welcome to `${pkgs.ruby}/bin/ruby --version`"
      '';
    };
  };
}
