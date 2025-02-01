/*
===========================================================================

  Copyright (c) Athena Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#ifndef _COMMON_SQL_H
#define _COMMON_SQL_H

#include "cbasetypes.h"

#include <string>
#include <thread>
#include <unordered_map>

#include <mysql.h>

#ifdef WIN32
#include <winsock2.h>
#endif

#include "logging.h"

// NOTE: This is just a shim to allow easy adoption of database.h
#include "database.h"

// Return codes
#define SQL_ERROR   -1
#define SQL_SUCCESS 0
#define SQL_NO_DATA 100

struct Sql_t
{
    std::string buf;

    // NOTE: Access to any of the MySQL resources is NOT thread-safe.
    // You will encounter very difficult to debug crashes and failed
    // operations if you're not careful!
    MYSQL          handle;
    MYSQL_RES*     result;
    MYSQL_ROW      row;
    unsigned long* lengths;
};

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

class SqlConnection
{
public:
    /// Establishes a connection.
    ///
    /// @return SQL_SUCCESS or SQL_ERROR
    SqlConnection();
    SqlConnection(const char* user, const char* passwd, const char* host, uint16 port, const char* db);
    ~SqlConnection();

    std::string GetDatabaseName();
    std::string GetClientVersion();
    std::string GetServerVersion();

    /// Retrieves the timeout of the connection.
    ///
    /// @return SQL_SUCCESS or SQL_ERROR
    int32 GetTimeout(uint32* out_timeout);

    /// Retrieves the name of the columns of a table into out_buf, with the separator after each name.
    ///
    /// @return SQL_SUCCESS or SQL_ERROR
    int32 GetColumnNames(const char* table, char* out_buf, size_t buf_len, char sep);

    /// Changes the encoding of the connection.
    ///
    /// @return SQL_SUCCESS or SQL_ERROR
    int32 SetEncoding(const char* encoding);

    void SetupKeepalive();

    void CheckCharset();

    /// Pings the connection.
    ///
    /// @return SQL_SUCCESS or SQL_ERROR
    int32 TryPing();

    /// Escapes a string.
    auto EscapeStringLen(char* out_to, const char* from, size_t from_len) -> size_t;
    auto EscapeStringLen(char* out_to, std::string_view from) -> size_t;
    auto EscapeString(char* out_to, const char* from) -> size_t;
    auto EscapeString(std::string_view from) -> std::string;
    auto EscapeString(const std::string& from) -> std::string;

    /// Executes a query.
    /// Any previous result is freed.
    /// The query is used directly.
    ///
    /// @return SQL_SUCCESS or SQL_ERROR
    int32 QueryStr(const char* query);

    /// Executes a query.
    /// Any previous result is freed.
    /// The query is constructed as if it was sprintf.
    ///
    /// @return SQL_SUCCESS or SQL_ERROR
    template <typename... Args>
    int32 Query(const char* query, Args... args)
    {
        std::string query_v = fmt::sprintf(query, args...);
        return QueryStr(query_v.c_str());
    }

    /// Executes a query.
    /// Any previous result is freed.
    /// The query is constructed as if it was fmtlib.
    ///
    /// @return SQL_SUCCESS or SQL_ERROR
    template <typename... Args>
    int32 QueryFmt(const char* query, Args... args)
    {
        std::string query_v = fmt::format(query, args...);
        return QueryStr(query_v.c_str());
    }

    uint64 AffectedRows();

    /// Returns the number of the AUTO_INCREMENT column of the last INSERT/UPDATE query.
    ///
    /// @return Value of the auto-increment column
    uint64 LastInsertId();

    /// Returns the number of columns in each row of the result.
    ///
    /// @return Number of columns
    uint32 NumColumns();

    /// Returns the number of rows in the result.
    ///
    /// @return Number of rows
    uint64 NumRows();

    /// Fetches the next row.
    /// The data of the previous row is no longer valid.
    ///
    /// @return SQL_SUCCESS, SQL_ERROR or SQL_NO_DATA
    int32 NextRow();

    /// Establishes keepalive (periodic ping) on the connection
    ///
    /// @return the keepalive timer id, or INVALID_TIMER
    int32 Keepalive(std::string const& keepalive_name);

    /// Gets the data of a column.
    /// The data remains valid until the next row is fetched or the result is freed.
    ///
    /// @return SQL_SUCCESS or SQL_ERROR
    int32 GetData(size_t col, char** out_buf, size_t* out_len);

    int8*  GetData(size_t col);
    int32  GetIntData(size_t col);
    uint32 GetUIntData(size_t col);
    uint64 GetUInt64Data(size_t col);
    float  GetFloatData(size_t col);

    std::string GetStringData(size_t col);

    template <typename T>
    void GetBlobData(size_t col, T* destination)
    {
        size_t length = 0;
        char*  buffer = nullptr;
        GetData(col, &buffer, &length);
        std::memcpy(destination, buffer, (length > sizeof(T) ? sizeof(T) : length));
    }

    template <typename T>
    std::string ObjectToBlobString(T* destination)
    {
        char buffer[sizeof(T) * 2 + 1];
        {
            char dataBlob[sizeof(T)];
            std::memcpy(dataBlob, destination, sizeof(dataBlob));
            EscapeStringLen(buffer, dataBlob, sizeof(dataBlob));
        }
        return std::string(buffer);
    }

    /// Frees the result of the query.
    void FreeResult();

    bool GetAutoCommit();
    bool SetAutoCommit(bool value);

    bool TransactionStart();
    bool TransactionCommit();
    bool TransactionRollback();

    void StartProfiling();
    void FinishProfiling();

private:
    Sql_t* self;

    const char* m_User;
    const char* m_Passwd;
    const char* m_Host;
    uint16      m_Port;
    const char* m_Db;

    uint32 m_PingInterval;
    uint32 m_LastPing;

    std::thread::id m_ThreadId;
};

//
// Outside of SQL class/namespace
//

#endif // _COMMON_SQL_H
