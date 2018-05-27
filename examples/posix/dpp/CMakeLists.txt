cmake_minimum_required(VERSION 3.7)
project(dpp)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 14)

set(C_SRCS bsp.c
           main.c
           philo.c
           table.c)

add_executable(${PROJECT_NAME} ${C_SRCS})

target_link_libraries(${PROJECT_NAME} qp qspy_host)
