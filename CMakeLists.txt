cmake_minimum_required(VERSION 3.7)
project(qp)

set(CMAKE_C_STANDARD 11)

option(USE_QSPY "build QP with QSPY" OFF) # OFF is the default
option(BUILD_RELEASE "build release version" OFF) # OFF is the default

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
    list(APPEND QP_SRCS "include/qstamp.c")
endif(USE_QSPY)

set(QP_PORT_SRCS "${PORT_DIR}/qf_port.c")

file(GLOB QP_PRIV_HEADER "source/*.h")
list(SORT QP_PRIV_HEADER)

file(GLOB QP_PORT_HEADER "${PORT_DIR}/*.h")
list(SORT QP_PORT_HEADER)

file(GLOB QP_PUB_HEADER "include/*.h")
list(SORT QP_PUB_HEADER)

set(SOURCE_FILES ${QP_SRCS} ${QP_PORT_SRCS} )
set(HEADER_FILES ${QP_PORT_HEADER} ${QP_PUB_HEADER} ${QP_PRIV_HEADER})

set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)

add_library(${PROJECT_NAME} ${SOURCE_FILES} ${HEADER_FILES})

target_link_libraries(${PROJECT_NAME} Threads::Threads)

target_include_directories(${PROJECT_NAME}
                           PUBLIC ${PORT_DIR}
                                  include
                           PRIVATE source)

target_compile_options(${PROJECT_NAME} PUBLIC -ffunction-sections
                                              -fdata-sections
                                              -O -Wall -W
                                              -Werror)

if (USE_QSPY)
    message(STATUS "QSPY traceing is enabled")
    target_compile_definitions(${PROJECT_NAME} PUBLIC -DQ_SPY)
    add_library(qspy_host INTERFACE)
    target_sources(qspy_host INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/qtools/qspy/source/qspy.c)
    target_include_directories(qspy_host INTERFACE qtools/qspy/include)
endif ()

if (BUILD_RELEASE)
    message(STATUS "building release")
    target_compile_definitions(${PROJECT_NAME} PUBLIC -DNDEBUG)
endif ()

add_subdirectory(examples/posix/dpp)