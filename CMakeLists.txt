cmake_minimum_required(VERSION 3.7)
project(QP)

set(CMAKE_C_STANDARD 11)

option(USE_CLANG "build QP with clang" OFF) # OFF is the default
option(USE_QSPY "build QP with QSPY" OFF) # OFF is the default
option(BUILD_RELEASE "build release version" OFF) # OFF is the default

if (USE_CLANG)
    message(STATUS "building with clang-3.8")
    # set(CMAKE_TOOLCHAIN_FILE "toolchain_llvm.cmake")
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
endif ()

add_compile_options(-pthread)
add_compile_options(-ffunction-sections)
add_compile_options(-fdata-sections)
add_compile_options(-O -Wall -W)
add_compile_options(-Werror)

if (USE_QSPY)
    message(STATUS "QSPY traceing is enabled")
    add_definitions(-DQ_SPY)
endif ()



if (BUILD_RELEASE)
    message(STATUS "building release")
    add_definitions(-DNDEBUG)
endif ()

set(PORT_DIR "ports/posix")

set(QP_SRCS "source/qep_hsm.c")
list(APPEND QP_SRCS "source/qep_msm.c")
list(APPEND QP_SRCS "source/qf_act.c")
list(APPEND QP_SRCS "source/qf_actq.c")
list(APPEND QP_SRCS "source/qf_defer.c")
list(APPEND QP_SRCS "source/qf_dyn.c")
list(APPEND QP_SRCS "source/qf_mem.c")
list(APPEND QP_SRCS "source/qf_ps.c")
list(APPEND QP_SRCS "source/qf_qact.c")
list(APPEND QP_SRCS "source/qf_qeq.c")
list(APPEND QP_SRCS "source/qf_qmact.c")
list(APPEND QP_SRCS "source/qf_time.c")

if(USE_QSPY)
    list(APPEND QP_SRCS "source/qs.c")
    list(APPEND QP_SRCS "source/qs_rx.c")
    list(APPEND QP_SRCS "source/qs_fp.c")
    list(APPEND QP_SRCS "source/qs_64bit.c")
endif(USE_QSPY)

set(QP_PORT_SRCS "${PORT_DIR}/qf_port.c")

file(GLOB QP_PRIV_HEADER "source/*.h")
list(SORT QP_PRIV_HEADER)

file(GLOB QP_PORT_HEADER "${PORT_DIR}/*.h")
list(SORT QP_PORT_HEADER)

file(GLOB QP_PUB_HEADER "include/*.h")
list(SORT QP_PUB_HEADER)

include_directories(
        ${PORT_DIR}
        include
        source
)

set(SOURCE_FILES ${QP_SRCS} ${QP_PORT_SRC} )
set(HEADER_FILES ${QP_PORT_HEADER} ${QP_PUB_HEADER} ${QP_PRIV_HEADER})

add_library(${PROJECT_NAME} ${SOURCE_FILES} ${HEADER_FILES})
