{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      name = "myProject";
      linux = "x86_64-linux";
      pkgs = import nixpkgs {
        system = linux;
      };
    in
    {
      devShell.${linux} = pkgs.gcc12.stdenv.mkDerivation {
        inherit name;

        nativeBuildInputs = with pkgs; [ cmake ninja gcc12 gdb clang-tools_14 gcovr lcov ];
        hardeningDisable = [ "all" ];

        # Environment Variables
        PROJECT_NAME = name;
        COMPILER = "gcc";
        COMPILER_VERSION = pkgs.gcc12.version;
      };
    };
}
