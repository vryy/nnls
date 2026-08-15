# File: CMakeLists.txt
# Author: Hoang-Giang Bui <hgbk2008@gmail.com>

cmake_minimum_required(VERSION 3.18)

project(nnls CXX)
set(PROJECT_VERSION "0.52")

## create the library

set(NNLS_SOURCE
    ${CMAKE_CURRENT_SOURCE_DIR}/src/denseMatrix.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/src/sparseMatrix.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/src/nnls.cc
)

option(BUILD_SHARED_LIBS "Build using shared libraries" ON)
add_library(nnls ${NNLS_SOURCE})
target_include_directories(nnls PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
)
set_target_properties(nnls PROPERTIES
    PUBLIC_HEADER "src/nnls.h;src/denseMatrix.h;src/sparseMatrix.h;src/vector.h;src/matrix.h"
)

find_package(BLAS)
if (BLAS_FOUND)
    if (TARGET BLASS::BLAS)
        target_link_libraries(nnls PUBLIC BLAS::BLAS)
    else()
        target_link_libraries(nnls PUBLIC ${BLAS_LIBRARIES})
    endif()
endif()

## create the executable

set(nnls_exe_name nnls-${PROJECT_VERSION})
add_executable(${nnls_exe_name} ${CMAKE_CURRENT_SOURCE_DIR}/app/nnlsDriver.cc)
target_link_libraries(${nnls_exe_name} PRIVATE nnls)

## installation interface

include(cmake/install.cmake)
