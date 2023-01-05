# doctest
CPMAddPackage(
  NAME doctest
  GITHUB_REPOSITORY onqtam/doctest
  VERSION 2.4.8
)

# if (TEST_INSTALLED_VERSION)
#   find_package(${LIB_NAME} REQUIRED)
# endif()

# ---- Add Tests -----

enable_testing()

# Create Test Binary 
file(GLOB sources CONFIGURE_DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/**/*.cpp)
add_executable(${TEST_BIN_NAME} main.cpp ${sources})
target_link_libraries(${TEST_BIN_NAME} doctest::doctest ${LIB_NAME})
set_target_properties(${TEST_BIN_NAME} PROPERTIES CXX_STANDARD 20)

# Enable Compiler Warnings
if(NOT TEST_INSTALLED_VERSION)
  if(CMAKE_CXX_COMPILER_ID MATCHES "Clang" OR CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    target_compile_options(${LIB_NAME} PUBLIC -Wall -Wpedantic -Wextra -Werror)
  elseif(MSVC)
    target_compile_options(${LIB_NAME} PUBLIC /W4 /WX)
    target_compile_definitions(${TEST_BIN_NAME} PUBLIC DOCTEST_CONFIG_USE_STD_HEADERS)
  endif()
endif()

# Add CTests
include(${doctest_SOURCE_DIR}/scripts/cmake/doctest.cmake)
doctest_discover_tests(${TEST_BIN_NAME})

# Code Coverage
if (ENABLE_COVERAGE)
  include(../cmake/CodeCoverage.cmake)
  append_coverage_compiler_flags()
  setup_target_for_coverage_gcovr_html(
    NAME coverage 
    EXECUTABLE ${TEST_BIN_NAME}
    DEPENDENCIES ${TEST_BIN_NAME} ${LIB_NAME}
  )
  # target_link_libraries(${TEST_BIN_NAME} gcov)

  # target_compile_options(${LIB_NAME} PUBLIC -O0 -ggdb3 -fprofile-arcs -ftest-coverage)
  # target_link_options(${LIB_NAME} PUBLIC -fprofile-arcs -ftest-coverage)
endif()