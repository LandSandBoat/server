# Try to find LUAJIT
# LUAJIT_FOUND - System has LUAJIT
# LUAJIT_LIBRARY - The libraries needed to use LUAJIT
# LUAJIT_INCLUDE_DIR - The LUAJIT include directories

find_library(LUAJIT_LIBRARY NAMES luajit)
find_path(LUAJIT_INCLUDE_DIR luajit.h)

include (FindPackageHandleStandardArgs)
find_package_handle_standard_args(LUAJIT DEFAULT_MSG LUAJIT_LIBRARY LUAJIT_INCLUDE_DIR)
