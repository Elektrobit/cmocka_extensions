# SPDX-License-Identifier: MIT
cmake_minimum_required(VERSION 3.21)
include(cmake/project.cmake)
project(cmocka_extensions LANGUAGES C VERSION ${CMOCKA_EXTENSIONS_VERSION})

list(APPEND CMAKE_PREFIX_PATH "${INSTALL_DIR}/usr/local/lib/cmake")

project_set_environment()
project_set_version_variables()
project_add_documentation_target(
  TITLE
    "BaseOS Cmocka_extensions Documentation"
  MARKDOWN
    ${CMAKE_SOURCE_DIR}/documentation/documentation.md
)

add_subdirectory(src)
add_subdirectory(examples)
add_subdirectory(test)

if(PACKAGING)
  include(cmake/Packing.cmake)
endif(PACKAGING)
