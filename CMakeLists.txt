cmake_minimum_required(VERSION 3.24)
project($ENV{PROJECT_NAME} LANGUAGES CXX)

if (PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  message(FATAL_ERROR "In-source builds not allowed")
endif()

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_EXTENSIONS OFF)

# required in nixOS
set(CMAKE_NO_SYSTEM_FROM_IMPORTED ON)
set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES ${CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES})

# this generates compile_commands.json
# required for clangd 
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include(cmake/compiler.cmake)

# ---- Dependencies

# add_subdirectory(external/fmt EXCLUDE_FROM_ALL)
# add_subdirectory(external/magic_enum EXCLUDE_FROM_ALL)
add_subdirectory(external/doctest EXCLUDE_FROM_ALL)

# ---- Options ----

option(${PROJECT_NAME}_ENABLE_TESTING "Enable testing" OFF)
option(${PROJECT_NAME}_ENABLE_TESTING_INSTALLED "Enable testing installed version" OFF)
option(${PROJECT_NAME}_ENABLE_COVERAGE "Enable test coverage" OFF)
option(${PROJECT_NAME}_ENABLE_INSTALL "Enable generation of install target" OFF)

# ---- Project ----

# Name all your targets here
set(TARGET_LIB ${PROJECT_NAME})
set(TARGET_BIN ${PROJECT_NAME}_bin)
set(TARGET_TEST ${PROJECT_NAME}_test)
set(TARGET_COVERAGE ${PROJECT_NAME}_coverage)

add_subdirectory(src)
add_subdirectory(tool)

if (${PROJECT_NAME}_ENABLE_TESTING)
  enable_testing()
  add_subdirectory(test)
endif()