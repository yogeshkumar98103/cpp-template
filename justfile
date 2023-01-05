PROJECT_NAME := myproject
THREADS := 8

# BUILD DIR
BUILD_DIR_DEBUG := `echo build/debug-$COMPILER-$COMPILER_VERSION`
BUILD_DIR_STAGING := `echo build/staging-$COMPILER-$COMPILER_VERSION`
BUILD_DIR_RELEASE := `echo build/release-$COMPILER-$COMPILER_VERSION`

default:
  @just --list --unsorted

cmake-debug:
  mkdir -p {{BUILD_DIR_DEBUG}}
  cmake -S src -B {{BUILD_DIR_DEBUG}}/src -DCMAKE_BUILD_TYPE=Debug -GNinja -DDEBUG=1
  cmake -S test -B {{BUILD_DIR_DEBUG}}/test -DCMAKE_BUILD_TYPE=Debug -GNinja -DDEBUG=1 -DENABLE_COVERAGE=1
  ln -sf {{BUILD_DIR_DEBUG}}/compile_commands.json compile_commands.json

cmake-release:
  mkdir -p {{BUILD_DIR_RELEASE}}
  cmake -S src -B {{BUILD_DIR_RELEASE}} -DCMAKE_BUILD_TYPE=Release -GNinja -DRELEASE=1 -DDOCTEST_CONFIG_DISABLE=1

build-debug TARGET="all":
  ninja -C {{BUILD_DIR_DEBUG}}/src -j{{THREADS}} {{TARGET}}

build-release TARGET="all": 
  ninja -C {{BUILD_DIR_RELEASE}}/src -j{{THREADS}} {{TARGET}}

test-debug:
  CTEST_OUTPUT_ON_FAILURE=1 cmake --build {{BUILD_DIR_DEBUG}}/test --target {{PROJECT_NAME}}_test
  {{BUILD_DIR_DEBUG}}/{{PROJECT_NAME}}_test

test-staging:
  mkdir -p {{BUILD_DIR_STAGING}}

  cmake -S src -B {{BUILD_DIR_STAGING}}/src -DCMAKE_BUILD_TYPE=Release -GNinja -DSTAGING=1
  cmake --build {{BUILD_DIR_STAGING}}/src --target all

  cmake -S test -B {{BUILD_DIR_STAGING}}/test -DCMAKE_BUILD_TYPE=Release -GNinja -DTEST_INSTALLED_VERSION=1
  CTEST_OUTPUT_ON_FAILURE=1 cmake --build {{BUILD_DIR_STAGING}}/test --target {{PROJECT_NAME}}_test
  
  {{BUILD_DIR_STAGING}}/{{PROJECT_NAME}}_test

cmake: cmake-debug
build: build-debug
test: test-debug