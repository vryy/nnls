# File: install.cmake
# Author: Hoang-Giang Bui <hgbk2008@gmail.com>

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

set(CMAKE_SKIP_BUILD_RPATH FALSE)
set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}")
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

# add include directories
target_include_directories(nnls
    INTERFACE $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

# install the targets
install(
    TARGETS nnls nnls-${PROJECT_VERSION}
    EXPORT nnlsTargets
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
    RUNTIME DESTINATION bin
    PUBLIC_HEADER DESTINATION include/nnls
)

# export the nnls targets
install(
  EXPORT nnlsTargets
  NAMESPACE SS::
  DESTINATION ${CMAKE_INSTALL_DATADIR}/cmake/nnls
)

# create and install the config file
configure_package_config_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake/nnlsConfig.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/nnlsConfig.cmake"
    INSTALL_DESTINATION ${CMAKE_INSTALL_DATADIR}/cmake/nnls
)

write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/nnlsConfigVersion.cmake"
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY AnyNewerVersion
)

install(
    FILES ${PROJECT_BINARY_DIR}/nnlsConfig.cmake
          ${PROJECT_BINARY_DIR}/nnlsConfigVersion.cmake
    DESTINATION ${CMAKE_INSTALL_DATADIR}/cmake/nnls
)
