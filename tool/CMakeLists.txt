add_executable(${TARGET_BIN} main.cpp)
target_link_libraries(${TARGET_BIN} ${TARGET_LIB})
set_target_properties(${TARGET_BIN} PROPERTIES OUTPUT_NAME ${TARGET_LIB})