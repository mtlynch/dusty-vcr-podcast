{
  description = "Dev environment for dusty vcr";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    # 20.9.0 release
    nodejs-nixpkgs.url = "github:NixOS/nixpkgs/a71323f68d4377d12c04a5410e214495ec598d4c";

    # 0.109.0 release
    hugo-nixpkgs.url = "github:NixOS/nixpkgs/2d38b664b4400335086a713a0036aafaa002c003";

    # 7.1.2-5
    imagemagick-nixpkgs.url = "github:NixOS/nixpkgs/832e3b6db48508ae436c2c7bfc0cf914eac6938e";
  };

  outputs = {
    self,
    flake-utils,
    nodejs-nixpkgs,
    hugo-nixpkgs,
    imagemagick-nixpkgs,
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      hugo = hugo-nixpkgs.legacyPackages.${system}.hugo;
      nodejs = nodejs-nixpkgs.legacyPackages.${system}.nodejs_20;
      imagemagick = imagemagick-nixpkgs.legacyPackages.${system}.imagemagick;
      source-sans = imagemagick-nixpkgs.legacyPackages.${system}.source-sans;
      bc = imagemagick-nixpkgs.legacyPackages.${system}.bc;
    in {
      devShells.default = hugo-nixpkgs.legacyPackages.${system}.mkShell {
        packages = [
          hugo
          nodejs
          imagemagick
          source-sans
          bc
        ];

        shellHook = ''
          echo "node" "$(node --version)"
          hugo version
          magick --version | head -n 1
          bc --version | head -n 1
        '';
      };

      formatter = hugo-nixpkgs.legacyPackages.${system}.alejandra;
    });
}
