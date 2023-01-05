cmake_minimum_required(VERSION 3.24)
project(myProject VERSION 1.0 LANGUAGES CXX)

if (PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  message(FATAL_ERROR "In-source builds not allowed")
endif()

# ---- Dependencies ----
add_subdirectory(../external/fmt)
add_subdirectory(../external/magic_enum)

# ---- Library ----
set (
  SOURCES 
    lib/lib.cpp
    util/util.cpp
)

add_library(${PROJECT_NAME} ${SOURCES})
set_target_properties(${PROJECT_NAME} PROPERTIES CXX_STANDARD 20)
target_link_libraries(${PROJECT_NAME} PRIVATE fmt magic_enum)
target_include_directories(
  ${PROJECT_NAME} PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
                     $<INSTALL_INTERFACE:include/${PROJECT_NAME}>
)

packageProject(
  NAME ${PROJECT_NAME}
  VERSION ${PROJECT_VERSION}
  NAMESPACE ${PROJECT_NAME}
  BINARY_DIR ${PROJECT_BINARY_DIR}
  INCLUDE_DIR ${PROJECT_SOURCE_DIR}
  INCLUDE_DESTINATION include/${PROJECT_NAME}
  INCLUDE_HEADER_PATTERN "*.hpp"
  COMPATIBILITY SameMajorVersion
)