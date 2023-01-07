PROJECT_NAME := `echo $PROJECT_NAME`

# BUILD DIR
BUILD_DIR_DEBUG := `realpath build/debug-$COMPILER-$COMPILER_VERSION`
BUILD_DIR_STAGING := `realpath build/staging-$COMPILER-$COMPILER_VERSION`
BUILD_DIR_RELEASE := `realpath build/release-$COMPILER-$COMPILER_VERSION`

# INSTALL DIR
INSTALL_DIR_DEBUG := `realpath install/debug-$COMPILER-$COMPILER_VERSION`
INSTALL_DIR_STAGING := `realpath install/staging-$COMPILER-$COMPILER_VERSION`
INSTALL_DIR_RELEASE := `realpath install/release-$COMPILER-$COMPILER_VERSION`

default:
  @just --list --unsorted

init:
  # git submodule add https://github.com/fmtlib/fmt external/fmt
  # git submodule add https://github.com/Neargye/magic_enum external/magic_enum
  git submodule add https://github.com/doctest/doctest external/doctest

clean-debug:
  rm -rf {{BUILD_DIR_DEBUG}}

clean-staging:
  rm -rf {{BUILD_DIR_STAGING}}

clean-release:
  rm -rf {{BUILD_DIR_RELEASE}}

cmake-debug:
  mkdir -p {{BUILD_DIR_DEBUG}}
  cmake -S . -B {{BUILD_DIR_DEBUG}} -DCMAKE_BUILD_TYPE=Debug -GNinja -D{{PROJECT_NAME}}_ENABLE_TESTING=1 -D{{PROJECT_NAME}}_ENABLE_COVERAGE=1
  ln -sf {{BUILD_DIR_DEBUG}}/compile_commands.json compile_commands.json

cmake-staging:
  mkdir -p {{BUILD_DIR_STAGING}}
  cmake -S . -B {{BUILD_DIR_STAGING}} -DCMAKE_BUILD_TYPE=Release -GNinja -D{{PROJECT_NAME}}_ENABLE_TESTING=1 -D{{PROJECT_NAME}}_ENABLE_INSTALL=1

cmake-release:
  mkdir -p {{BUILD_DIR_RELEASE}}
  cmake -S . -B {{BUILD_DIR_RELEASE}} -DCMAKE_BUILD_TYPE=Release -GNinja -DDOCTEST_CONFIG_DISABLE=1 -D{{PROJECT_NAME}}_ENABLE_INSTALL=1

_build TARGET BUILD_DIR: 
  cmake --build {{BUILD_DIR}} --target {{TARGET}}

build-debug TARGET="all": cmake-debug (_build TARGET BUILD_DIR_DEBUG)
build-staging TARGET="all": cmake-staging (_build TARGET BUILD_DIR_STAGING)
build-release TARGET="all": cmake-release (_build TARGET BUILD_DIR_RELEASE)

_install BUILD_DIR INSTALL_DIR:
  rm -rf {{INSTALL_DIR}}
  mkdir -p {{INSTALL_DIR}}
  cmake --install {{BUILD_DIR}} --prefix {{INSTALL_DIR}}
  tree {{INSTALL_DIR}}

install-debug: build-debug (_install BUILD_DIR_DEBUG INSTALL_DIR_DEBUG)
install-staging: build-staging (_install BUILD_DIR_STAGING INSTALL_DIR_STAGING)
install-release: build-release (_install BUILD_DIR_RELEASE INSTALL_DIR_RELEASE)

test-debug: build-debug
  CTEST_OUTPUT_ON_FAILURE=1 cmake --build {{BUILD_DIR_DEBUG}} --target {{PROJECT_NAME}}_test
  {{BUILD_DIR_DEBUG}}/test/{{PROJECT_NAME}}_test

test-staging: install-staging
  cmake -S . -B {{BUILD_DIR_STAGING}} -DCMAKE_BUILD_TYPE=Release -GNinja -D{{PROJECT_NAME}}_ENABLE_TESTING=1 -D{{PROJECT_NAME}}_ENABLE_TESTING_INSTALLED=1 -D{{PROJECT_NAME}}_INSTALL_PATH={{INSTALL_DIR_STAGING}}
  CTEST_OUTPUT_ON_FAILURE=1 cmake --build {{BUILD_DIR_STAGING}} --target {{PROJECT_NAME}}_test
  {{BUILD_DIR_STAGING}}/test/{{PROJECT_NAME}}_test

coverage-debug: build-debug
  CTEST_OUTPUT_ON_FAILURE=1 cmake --build {{BUILD_DIR_DEBUG}} --target {{PROJECT_NAME}}_coverage

run-debug: build-debug
  {{BUILD_DIR_DEBUG}}/tool/{{PROJECT_NAME}}

run-release: build-release
  {{BUILD_DIR_RELEASE}}/tool/{{PROJECT_NAME}}

cmake: cmake-debug
build: build-debug
install: install-debug
test: test-debug
coverage: coverage-debug
clean: clean-debug
run: run-debug