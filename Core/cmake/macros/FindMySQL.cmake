#
# Simplified FindMySQL.cmake for Windows + MySQL 5.7.x
# Custom version for MySQL installed at: C:/Core-trinity/mysql
#

set(MYSQL_ROOT "C:/Core-trinity/mysql")

set(MYSQL_INCLUDE_DIR "${MYSQL_ROOT}/include")
set(MYSQL_LIBRARY "${MYSQL_ROOT}/lib/libmysql.lib")
set(MYSQL_EXECUTABLE "${MYSQL_ROOT}/bin/mysql.exe")

# Check include directory
if(NOT EXISTS "${MYSQL_INCLUDE_DIR}/mysql.h")
    message(FATAL_ERROR
        "MySQL include directory not found!\n"
        "Expected: ${MYSQL_INCLUDE_DIR}\n"
        "Please verify that your MySQL installation contains 'include/mysql.h'"
    )
endif()

# Check library directory
if(NOT EXISTS "${MYSQL_LIBRARY}")
    message(FATAL_ERROR
        "MySQL library not found!\n"
        "Expected: ${MYSQL_LIBRARY}\n"
        "Please verify that your MySQL installation contains 'lib/libmysql.lib'"
    )
endif()

# Check executable
if(NOT EXISTS "${MYSQL_EXECUTABLE}")
    message(WARNING
        "MySQL executable not found (mysql.exe).\n"
        "Expected: ${MYSQL_EXECUTABLE}\n"
        "This is optional and not required for building the server."
    )
endif()

# MySQL found
set(MYSQL_FOUND 1)

message(STATUS "Using MySQL root directory: ${MYSQL_ROOT}")
message(STATUS "Found MySQL headers: ${MYSQL_INCLUDE_DIR}")
message(STATUS "Found MySQL library: ${MYSQL_LIBRARY}")
message(STATUS "Found MySQL executable: ${MYSQL_EXECUTABLE}")

mark_as_advanced(
    MYSQL_FOUND
    MYSQL_INCLUDE_DIR
    MYSQL_LIBRARY
    MYSQL_EXECUTABLE
)
