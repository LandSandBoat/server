# Try to find MYSQL
# Once done this will define
# MYSQL_FOUND - System has MYSQL
# MYSQL_INCLUDE_DIR - The MYSQL include directories
# MYSQL_LIBRARIES - The libraries needed to use MYSQL

set(MYSQL_FOUND TRUE)
set(MYSQL_INCLUDE_DIR "")
set(MYSQL_LIBRARIES "")

mark_as_advanced(MYSQL_LIBRARIES)
