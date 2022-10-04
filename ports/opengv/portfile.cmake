include(vcpkg_common_functions)
set(opengv_VERSION 1.0)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/laurentkneip/opengv/archive/master.zip"
    FILENAME "opengv-master.zip"
    SHA512 06e38dafe31e35037695ca3ce0a07296b3adcb079b08115c113135788f0047de0bb10ee51adbd5595d17e934cacafa6498b954584e07b721b5da8c4decd2ab3b
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    NO_REMOVE_ONE_LEVEL
    ARCHIVE ${ARCHIVE}
    REF opengv
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION ${SOURCE_PATH})
file(WRITE ${CURRENT_PACKAGES_DIR}/share/opengv/copyright/copyright.txt "LICENSE CODE GOES HERE")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
)

vcpkg_install_cmake()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Install CMake package definitions
file(WRITE "${CURRENT_PACKAGES_DIR}/share/opengv/opengvConfig.cmake ")
# This script sets following variables:
# OPENGV_FOUND
# OPENGV_INCLUDE_DIR
# OPENGV_LIBRARIES_DIR
# OPENGV_LIBRARIES
set(opengv_FOUND TRUE)
set(opengv_INCLUDE_DIR \${CMAKE_INSTALL_PREFIX}/include)
set(opengv_LIBRARIES_DIR \${CMAKE_INSTALL_PREFIX}/lib)
# Search for libraries
find_library(opengv_LIBRARIES NAMES \"opengv\" \"opengv.lib\")
# Moves all .cmake files from /debug/share/cupoch/ to /share/cupoch/
# See /docs/maintainers/vcpkg_fixup_cmake_targets.md for more details
#vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake TARGET_PATH share/opengv)
# Handle copyright
#file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/opengv RENAME copyright)
