#include using cmake -DCMAKE_TOOLCHAIN_FILE=toolchain.cmake
INCLUDE(CMakeForceCompiler) #Disables checks
SET(CMAKE_SYSTEM_NAME Generic)
#Generic removes -rdynamic from linker, which llvm-ld doesn't support

CMAKE_FORCE_C_COMPILER( /usr/lib/llvm-3.8/bin/clang CLang )
CMAKE_FORCE_CXX_COMPILER ( /usr/lib/llvm-3.8/bin/clang++ CLang )
SET(CMAKE_RANLIB "/usr/lib/llvm-3.8/bin/llvm-ranlib" CACHE INTERNAL STRING FORCE)
SET(CMAKE_AR "/usr/lib/llvm-3.8/bin/llvm-ar" CACHE INTERNAL STRING FORCE)

SET(CMAKE_LINKER "/usr/lib/llvm-3.8/bin/llvm-ld" CACHE INTERNAL STRING FORCE)
#SET(CMAKE_C_LINKER "/usr/bin/llvm-ld")
#SET(CMAKE_CXX_LINKER "/usr/bin/llvm-ld")

SET (CMAKE_C_COMPILER             "/usr/lib/llvm-3.8/bin/clang")
SET (CMAKE_C_FLAGS                "-Wall -std=c11")
SET (CMAKE_C_FLAGS_DEBUG          "-g")
SET (CMAKE_C_FLAGS_MINSIZEREL     "-Os -DNDEBUG")
SET (CMAKE_C_FLAGS_RELEASE        "-O4 -DNDEBUG")
SET (CMAKE_C_FLAGS_RELWITHDEBINFO "-O2 -g")

SET (CMAKE_CXX_COMPILER             "/usr/lib/llvm-3.8/bin/clang++")
SET (CMAKE_CXX_FLAGS                "-Wall")
SET (CMAKE_CXX_FLAGS_DEBUG          "-g")
SET (CMAKE_CXX_FLAGS_MINSIZEREL     "-Os -DNDEBUG")
SET (CMAKE_CXX_FLAGS_RELEASE        "-O4 -DNDEBUG")
SET (CMAKE_CXX_FLAGS_RELWITHDEBINFO "-O2 -g")

SET (CMAKE_AR      "/usr/lib/llvm-3.8/bin/llvm-ar")
SET (CMAKE_LINKER  "/usr/lib/llvm-3.8/bin/llvm-ld")
SET (CMAKE_NM      "/usr/lib/llvm-3.8/bin/llvm-nm")
SET (CMAKE_OBJDUMP "/usr/lib/llvm-3.8/bin/llvm-objdump")
SET (CMAKE_RANLIB  "/usr/lib/llvm-3.8/bin/llvm-ranlib")

SET(CMAKE_C_LINK_EXECUTABLE "/usr/lib/llvm-3.8/bin/llvm-ld <OBJECTS> -o  <TARGET> <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> <LINK_LIBRARIES>")
SET(CMAKE_CXX_LINK_EXECUTABLE "/usr/lib/llvm-3.8/bin/llvm-ld <OBJECTS> -o  <TARGET> <CMAKE_CXX_LINK_FLAGS> <LINK_FLAGS> <LINK_LIBRARIES>")

SET(CMAKE_FIND_ROOT_PATH /usr/lib/llvm-3.8/bin)
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)