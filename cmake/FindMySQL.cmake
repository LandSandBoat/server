# Try to find MYSQL
# MYSQL_FOUND - System has MYSQL
# MYSQL_LIBRARY - The libraries needed to use MYSQL
# MYSQL_INCLUDE_DIR - The MYSQL include directories

find_library(MYSQL_LIBRARY NAMES mysql)
find_path(MYSQL_INCLUDE_DIR mysql.h)

include (FindPackageHandleStandardArgs)
find_package_handle_standard_args(MYSQL DEFAULT_MSG MYSQL_LIBRARY MYSQL_INCLUDE_DIR)
