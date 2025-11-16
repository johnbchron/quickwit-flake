{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { nixpkgs, flake-utils, ... }: 
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs { inherit system; };

      quickwit = pkgs.callPackage ./packages/quickwit { };
    in {
      packages = {
        inherit quickwit;
        default = quickwit;
      };
    });
}

