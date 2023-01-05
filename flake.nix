{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      linux = "x86_64-linux";
      pkgs = import nixpkgs {
        system = linux;
      };
    in
    {
      devShell.${linux} = pkgs.gcc12.stdenv.mkDerivation {
        name = "myProject";

        nativeBuildInputs = with pkgs; [ cmake ninja gcc12 gdb clang-tools_14 ];
        hardeningDisable = [ "all" ];
        COMPILER = "gcc";
        COMPILER_VERSION = pkgs.gcc12.version;
      };
    };
}
