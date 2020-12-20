// Copyright (c) Athena Dev Teams - Licensed under GNU GPL
// For more information, see LICENCE in the main folder

#ifndef _COMMON_SQL_H
#define _COMMON_SQL_H

#ifndef _CBASETYPES_H_
#include "../common/cbasetypes.h"
#endif
//#include <stdarg.h>// va_list

#ifdef WIN32
#include <mysql/mysql.h>
#include <winsock2.h>
#else
#include <mysql/mysql.h>
#endif
//#endif

#include "fmt/printf.h"

// Return codes
#define SQL_ERROR   -1
#define SQL_SUCCESS 0
#define SQL_NO_DATA 100

/// Data type identifier.
/// String, enum and blob data types need the buffer length specified.
enum SqlDataType
{
    SQLDT_NULL,
    // fixed size
    SQLDT_INT8,
    SQLDT_INT16,
    SQLDT_INT32,
    SQLDT_INT64,
    SQLDT_UINT8,
    SQLDT_UINT16,
    SQLDT_UINT32,
    SQLDT_UINT64,
    // platform dependent size
    SQLDT_CHAR,
    SQLDT_SHORT,
    SQLDT_INT,
    SQLDT_LONG,
    SQLDT_LONGLONG,
    SQLDT_UCHAR,
    SQLDT_USHORT,
    SQLDT_UINT,
    SQLDT_ULONG,
    SQLDT_ULONGLONG,
    // floating point
    SQLDT_FLOAT,
    SQLDT_DOUBLE,
    // other
    SQLDT_STRING,
    SQLDT_ENUM,
    // Note: An ENUM is a string with restricted values. When an invalid value
    //       is inserted, it is saved as an empty string (numerical value 0).
    SQLDT_BLOB,
    SQLDT_LASTID
};

/*
 *
 *					SQL LEVEL
 *
 */

struct Sql_t
{
    std::string    buf;
    MYSQL          handle;
    MYSQL_RES*     result;
    MYSQL_ROW      row;
    unsigned long* lengths;
    int            keepalive;
};

/// Allocates and initializes a new Sql handle.
struct Sql_t* Sql_Malloc(void);

/// Establishes a connection.
///
/// @return SQL_SUCCESS or SQL_ERROR
int32 Sql_Connect(Sql_t* self, const char* user, const char* passwd, const char* host, uint16 port, const char* db);

/// Retrieves the timeout of the connection.
///
/// @return SQL_SUCCESS or SQL_ERROR
int32 Sql_GetTimeout(Sql_t* self, uint32* out_timeout);

/// Retrieves the name of the columns of a table into out_buf, with the separator after each name.
///
/// @return SQL_SUCCESS or SQL_ERROR
int32 Sql_GetColumnNames(Sql_t* self, const char* table, char* out_buf, size_t buf_len, char sep);

/// Changes the encoding of the connection.
///
/// @return SQL_SUCCESS or SQL_ERROR
int32 Sql_SetEncoding(Sql_t* self, const char* encoding);

/// Pings the connection.
///
/// @return SQL_SUCCESS or SQL_ERROR
int32 Sql_Ping(Sql_t* self);

/// Escapes a string.
/// The output buffer must be at least strlen(from)*2+1 in size.
///
/// @return The size of the escaped string
size_t Sql_EscapeString(Sql_t* self, char* out_to, const char* from);
size_t Sql_EscapeStringLen(Sql_t* self, char* out_to, const char* from, size_t from_len);

/// Executes a query.
/// Any previous result is freed.
/// The query is used directly.
///
/// @return SQL_SUCCESS or SQL_ERROR
int32 Sql_QueryStr(Sql_t* self, const char* query);

/// Executes a query.
/// Any previous result is freed.
/// The query is constructed as if it was sprintf.
///
/// @return SQL_SUCCESS or SQL_ERROR
template <typename... Args>
int32 Sql_Query(Sql_t* self, const char* query, Args... args)
{
    std::string query_v = fmt::sprintf(query, args...);
    return Sql_QueryStr(self, query_v.c_str());
}

uint64 Sql_AffectedRows(Sql_t* self);

/// Returns the number of the AUTO_INCREMENT column of the last INSERT/UPDATE query.
///
/// @return Value of the auto-increment column
uint64 Sql_LastInsertId(Sql_t* self);

/// Returns the number of columns in each row of the result.
///
/// @return Number of columns
uint32 Sql_NumColumns(Sql_t* self);

/// Returns the number of rows in the result.
///
/// @return Number of rows
uint64 Sql_NumRows(Sql_t* self);

/// Fetches the next row.
/// The data of the previous row is no longer valid.
///
/// @return SQL_SUCCESS, SQL_ERROR or SQL_NO_DATA
int32 Sql_NextRow(Sql_t* self);

/// Establishes keepalive (periodic ping) on the connection
///
/// @return the keepalive timer id, or INVALID_TIMER
int32 Sql_Keepalive(Sql_t* self);

/// Gets the data of a column.
/// The data remains valid until the next row is fetched or the result is freed.
///
/// @return SQL_SUCCESS or SQL_ERROR
int32 Sql_GetData(Sql_t* self, size_t col, char** out_buf, size_t* out_len);

int8*  Sql_GetData(Sql_t* self, size_t col);
int32  Sql_GetIntData(Sql_t* self, size_t col);
uint32 Sql_GetUIntData(Sql_t* self, size_t col);
float  Sql_GetFloatData(Sql_t* self, size_t col);

/// Frees the result of the query.
void Sql_FreeResult(Sql_t* self);

#if defined(SQL_REMOVE_SHOWDEBUG)
#define Sql_ShowDebug(self) (void)0
#else
#define Sql_ShowDebug(self) Sql_ShowDebug_(self, __FILE__, __LINE__)
#endif

/// Shows debug information (last query).
void Sql_ShowDebug_(Sql_t* self, const char* debug_file, const unsigned long debug_line);

/// Frees a Sql handle returned by Sql_Malloc.
void Sql_Free(Sql_t* self);

bool Sql_GetAutoCommit(Sql_t* self);
bool Sql_SetAutoCommit(Sql_t* self, bool value);

bool Sql_TransactionStart(Sql_t* self);
bool Sql_TransactionCommit(Sql_t* self);
bool Sql_TransactionRollback(Sql_t* self);

#endif

//											End level
////
//////////////////////////////////////////////////////////////////////////////////////////
