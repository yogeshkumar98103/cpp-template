add_library(${LIB_NAME} 
    lib/lib.cpp
    util/util.cpp
)
set_target_properties(${LIB_NAME} PROPERTIES CXX_STANDARD 20)
target_link_libraries(${LIB_NAME} PRIVATE fmt::fmt magic_enum)
target_include_directories(${LIB_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

# target_include_directories(
#   ${PROJECT_NAME} PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
#                          $<INSTALL_INTERFACE:include/${LIB_NAME}-${PROJECT_VERSION}>
# )

# string(TOLOWER ${PROJECT_NAME}/version.h VERSION_HEADER_LOCATION)

# packageProject(
#   NAME ${PROJECT_NAME}
#   VERSION ${PROJECT_VERSION}
#   NAMESPACE ${PROJECT_NAME}
#   BINARY_DIR ${PROJECT_BINARY_DIR}
#   INCLUDE_DIR ${PROJECT_SOURCE_DIR}/include
#   INCLUDE_DESTINATION include/${PROJECT_NAME}-${PROJECT_VERSION}
#   VERSION_HEADER "${VERSION_HEADER_LOCATION}"
#   COMPATIBILITY SameMajorVersion
#   DEPENDENCIES "fmt 8.1.1"
# )