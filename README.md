# cpp-template

## Folder Structure

```txt
├── cmake
│   ├── CodeCoverage.cmake
│   └── compiler.cmake
├── external
│   ├── fmt
│   └── magic_enum
│   └── ...
├── src
│   ├── module1
│   │   └── ...
│   ├── module2
│   │   └──  ...
│   ├── CMakeLists.txt
│   └── lib.hpp
├── test
│   ├── CMakeLists.txt
│   ├── main.cpp
│   ├── module1.cpp
│   └── module2.cpp
├── tool
│   ├── CMakeLists.txt
│   └──  main.cpp
├── .clang-format
├── .clang-tidy
├── .clangd
├── .cmake-format
├── .gitignore
├── .gitmodules
├── CMakeLists.txt
├── compile_commands.json
├── flake.lock
├── flake.nix
├── justfile
├── LICENSE
└── README.md
```

## Steps to setup

1. Open flake.nix and change project name
2. Open justfile add dependencies in init recipe
3. Open CMakeLists.txt
   3.1 add dependencies
   3.2 set target names

## Commands

1. Download dependencies

   ```sh
   just init
   ```

2. Configure project

   ```sh
   just cmake
   just cmake-release
   ```

3. Build

   ```sh
   just build
   just build-release

   # Optionally we can build specific target
   just build <target>
   just build-release <targeeet>
   ```

4. Test Project

   ```sh
   just test
   just test-staging

   # Optionally we can run specific tests
   just test module1
   just test-staging module1
   ```

5. Coverage Report

   ```sh
   just coverage
   ```
