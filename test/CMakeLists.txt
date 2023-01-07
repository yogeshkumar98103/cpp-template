if (${PROJECT_NAME}_ENABLE_TESTING_INSTALLED)
  find_package(${PROJECT_NAME} REQUIRED PATHS ${${PROJECT_NAME}_INSTALL_PATH}/lib64/cmake/${PROJECT_NAME})
  set(TARGET_LIB ${PROJECT_NAME}::${TARGET_LIB})
endif()

# Create Test Binary 
file(GLOB TESTS CONFIGURE_DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp)
add_executable(${TARGET_TEST} EXCLUDE_FROM_ALL main.cpp ${TESTS})
target_link_libraries(${TARGET_TEST} doctest ${TARGET_LIB})

if (CMAKE_BUILD_TYPE MATCHES Release)
  set(TARGET ${TARGET_TEST} PROPERTY INTERPROCEDURAL_OPTIMIZATION TRUE)
endif()

# Add CTests
include(../external/doctest/scripts/cmake/doctest.cmake)
doctest_discover_tests(${TARGET_TEST})

# Code Coverage
if (${PROJECT_NAME}_ENABLE_COVERAGE)
  include(../cmake/CodeCoverage.cmake)
  append_coverage_compiler_flags()
  set(Coverage_LCOV_ARGS --no-external)
  setup_target_for_coverage_lcov(
    NAME ${TARGET_COVERAGE} 
    EXECUTABLE ${TARGET_TEST}
    DEPENDENCIES ${TARGET_TEST} ${TARGET_LIB}
    BASE_DIRECTORY "${PROJECT_SOURCE_DIR}/src"
    EXCLUDE "${PROJECT_SOURCE_DIR}/external/**" "/nix/store/**" "/usr/**"
  )
endif()