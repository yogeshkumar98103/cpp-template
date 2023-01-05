cmake_minimum_required(VERSION 3.24)
project(myProject_test VERSION 1.0 LANGUAGES CXX)

if (PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  message(FATAL_ERROR "In-source builds not allowed")
endif()

option(ENABLE_COVERAGE "Enable test coverage" OFF)
option(TEST_INSTALLED_VERSION "Test the version found by find_package" OFF)

# ---- Dependencies ----
add_subdirectory(../external/doctest)

set(LIB_NAME myProject)
if (TEST_INSTALLED_VERSION)
  find_package(${LIB_NAME} REQUIRED)
else()
  add_subdirectory(../src)
endif()

# ---- Add Tests -----
enable_testing()

# Create Test Binary 
file(GLOB sources CONFIGURE_DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp)
add_executable(${PROJECT_NAME} main.cpp ${sources})
target_link_libraries(${PROJECT_NAME} doctest ${LIB_NAME})
set_target_properties(${PROJECT_NAME} PROPERTIES CXX_STANDARD 20)

# Enable Compiler Warnings
if (NOT TEST_INSTALLED_VERSION)
  if (CMAKE_CXX_COMPILER_ID MATCHES "Clang" OR CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    target_compile_options(${LIB_NAME} PUBLIC -Wall -Wpedantic -Wextra -Werror)
  elseif (MSVC)
    target_compile_options(${LIB_NAME} PUBLIC /W4 /WX)
    target_compile_definitions(${PROJECT_NAME} PUBLIC DOCTEST_CONFIG_USE_STD_HEADERS)
  endif()
endif()

# Add CTests
include(../external/doctest/scripts/cmake/doctest.cmake)
doctest_discover_tests(${PROJECT_NAME})

# Code Coverage
if (ENABLE_COVERAGE)
  include(../cmake/CodeCoverage.cmake)
  append_coverage_compiler_flags()
  setup_target_for_coverage_gcovr_html(
    NAME coverage 
    EXECUTABLE ${PROJECT_NAME}
    DEPENDENCIES ${PROJECT_NAME} ${LIB_NAME}
  )

  # target_link_libraries(${PROJECT_NAME} gcov)
  # target_compile_options(${LIB_NAME} PUBLIC -O0 -ggdb3 -fprofile-arcs -ftest-coverage)
  # target_link_options(${LIB_NAME} PUBLIC -fprofile-arcs -ftest-coverage)
endif()