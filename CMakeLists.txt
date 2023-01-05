cmake_minimum_required(VERSION 3.16)
project(myproject VERSION 1.0 LANGUAGES CXX)

# ---- Options ----

option(ENABLE_TESTING "Enable test coverage" ON)
option(ENABLE_COVERAGE "Enable test coverage" ON)
# option(TEST_INSTALLED_VERSION "Test the version found by find_package" OFF)


# ---- Dependencies ----

include(cmake/CPM.cmake)

# PackageProject
CPMAddPackage(
  NAME PackageProject
  GITHUB_REPOSITORY TheLartians/PackageProject.cmake
  VERSION 1.8.0
)

# fmt
CPMAddPackage(
  NAME fmt
  GITHUB_REPOSITORY fmtlib/fmt
  GITTAG 9.1.0
  OPTIONS "FMT_INSTALL YES"
)

# magic_enum
CPMAddPackage(
  NAME magic_enum
  GITHUB_REPOSITORY Neargye/magic_enum
  VERSION 0.8.2
)

# nlohman_json
CPMAddPackage(
  NAME nlohmann_json
  GITHUB_REPOSITORY nlohmann/json
  VERSION 3.6.1
  OPTIONS "JSON_BuildTests OFF"
)

# ---- Project ----

set(LIB_NAME lib)
set(BIN_NAME bin)
set(TEST_BIN_NAME test)

add_subdirectory(src)
add_subdirectory(tools)

if (ENABLE_TESTING)
  add_subdirectory(tests)
endif()
