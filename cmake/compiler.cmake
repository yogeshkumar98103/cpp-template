# Supported compilers
if (CMAKE_CXX_COMPILER_ID MATCHES GNU)
  set(COMPILER gcc) 
endif()

# Recommended optimization flags
if(CMAKE_BUILD_TYPE MATCHES Debug)
  add_compile_definitions(DEBUG)
  add_compile_options(-O0 -ggdb)
else()
  add_compile_definitions(RELEASE)
  add_compile_options(-O3)
endif()

# Recommended warning flags
add_compile_options(
  -pedantic 
  -Wall 
  -Wextra 
  -Wcast-align 
  -Wcast-qual 
  -Wctor-dtor-privacy 
  -Wdisabled-optimization 
  -Wformat=2 
  -Winit-self 
  -Wlogical-op 
  -Wmissing-declarations 
  -Wmissing-include-dirs 
  -Wnoexcept 
  -Wold-style-cast 
  -Woverloaded-virtual 
  -Wredundant-decls 
  -Wshadow 
  -Wsign-conversion 
  -Wsign-promo 
  -Wstrict-null-sentinel 
  -Wstrict-overflow=5 
  -Wswitch-default 
  -Wundef 
  -Werror 
  -Wno-unused
  -Weffc++
  -Wzero-as-null-pointer-constant
)

# Other flags
add_compile_options(
  -march=native
  -pipe
  -fPIC 
  -fdiagnostics-color
)