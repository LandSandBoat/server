/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "logging.h"
#include "taskmgr.h"
#include "timer.h"
#include "tracy.h"
#include "xirand.h"

#include "sql.h"

#include <any>
#include <cstdio>
#include <cstdlib>
#include <cstring>

namespace sql
{
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
    std::string    keepaliveTaskName;
};

// State
Sql_t*      self;
const char* gUser;
const char* gPasswd;
const char* gHost;
uint16      gPort;
const char* gDb;

/************************************************************************
 *                                                                        *
 *  Column length receiver.                                               *
 *  Takes care of the possible size missmatch between uint32 and          *
 *  unsigned long.                                                        *
 *                                                                        *
 ************************************************************************/

struct s_column_length
{
    uint32* out_length;
    uint32  length;
};

/************************************************************************
 *                                                                        *
 *  Establishes a connection.                                             *
 *                                                                        *
 ************************************************************************/

int32 Connect(const char* user, const char* passwd, const char* host, uint16 port, const char* db)
{
    mysql_init(&self->handle);
    if (self == nullptr)
    {
        ShowFatalError("mysql_init failed!");
        return SQL_ERROR;
    }

    self->lengths = nullptr;
    self->result  = nullptr;

    bool reconnect = true;
    mysql_options(&self->handle, MYSQL_OPT_RECONNECT, &reconnect);

    self->buf.clear();
    if (!mysql_real_connect(&self->handle, host, user, passwd, db, (uint32)port, nullptr /*unix_socket*/, 0 /*clientflag*/))
    {
        ShowFatalError("%s", mysql_error(&self->handle));
        return SQL_ERROR;
    }

    gUser = user;
    gPasswd = passwd;
    gHost = host;
    gPort = port;
    gDb = db;

    return SQL_SUCCESS;
}

/************************************************************************
 *                                                                        *
 *  Retrieves the timeout of the connection.                              *
 *                                                                        *
 ************************************************************************/

int32 GetTimeout(uint32* out_timeout)
{
    if (out_timeout && SQL_SUCCESS == Query("SHOW VARIABLES LIKE 'wait_timeout'"))
    {
        char*  data;
        size_t len;
        if (SQL_SUCCESS == NextRow() && SQL_SUCCESS == GetData(1, &data, &len))
        {
            *out_timeout = (uint32)strtoul(data, nullptr, 10);
            FreeResult();
            return SQL_SUCCESS;
        }
        FreeResult();
    }
    return SQL_ERROR;
}

/************************************************************************
 *                                                                        *
 *  Retrieves the name of the columns of a table into out_buf, with       *
 *  the separator after each name.                                        *
 *                                                                        *
 ************************************************************************/

int32 GetColumnNames(const char* table, char* out_buf, size_t buf_len, char sep)
{
    char*  data;
    size_t len;
    size_t off = 0;

    if (self == nullptr || SQL_ERROR == Query("EXPLAIN `%s`", table))
    {
        return SQL_ERROR;
    }

    out_buf[off] = '\0';
    while (SQL_SUCCESS == NextRow() && SQL_SUCCESS == GetData(0, &data, &len))
    {
        len = strnlen(data, len);
        if (off + len + 2 > buf_len)
        {
            ShowDebug("GetColumns: output buffer is too small");
            *out_buf = '\0';
            return SQL_ERROR;
        }
        memcpy(out_buf + off, data, len);
        off += len;
        out_buf[off++] = sep;
    }
    out_buf[off] = '\0';
    FreeResult();
    return SQL_SUCCESS;
}

/************************************************************************
 *                                                                        *
 *  Changes the encoding of the connection.                               *
 *                                                                        *
 ************************************************************************/

int32 SetEncoding(const char* encoding)
{
    if (mysql_set_character_set(&self->handle, encoding) == 0)
    {
        return SQL_SUCCESS;
    }
    return SQL_ERROR;
}

/************************************************************************
 *                                                                        *
 *  Pings the connection.                                                 *
 *                                                                        *
 ************************************************************************/

int32 Ping()
{
    auto startId = mysql_thread_id(&self->handle);
    try
    {
        if (mysql_ping(&self->handle) == 0)
        {
            auto endId = mysql_thread_id(&self->handle);
            if (startId != endId)
            {
                ShowWarning("DB thread ID has changed. You have been reconnected.");
            }
            return SQL_SUCCESS;
        }
    }
    catch (const std::exception& e)
    {
        ShowFatalError(fmt::format("mysql_ping failed: {}", e.what()));
    }
    catch (...)
    {
        ShowFatalError("mysql_ping failed with unhandled exception");
    }

    return SQL_ERROR;
}

/************************************************************************
 *                                                                        *
 *  Wrapper function for Sql_Ping.                                        *
 *                                                                        *
 ************************************************************************/

static int32 KeepaliveTimer(time_point tick, CTaskMgr::CTask* PTask)
{
    ShowInfo("(%s) Pinging SQL server to keep connection alive", self->keepaliveTaskName);
    Ping();

    return 0;
}

/************************************************************************
 *                                                                        *
 *  Establishes keepalive (periodic ping) on the connection               *
 *                                                                        *
 ************************************************************************/

/// @return the keepalive timer id, or INVALID_TIMER

int32 Keepalive(std::string const& keepaliveTaskName)
{
    uint32 timeout;
    uint32 ping_interval;

    self->keepaliveTaskName = keepaliveTaskName;

    // set a default value first
    timeout = 7200; // 2 hours

    // request the timeout value from the mysql server
    GetTimeout(&timeout);

    if (timeout < 60)
    {
        timeout = 60;
    }

    // Every time we add a keepalive, add a small offset to make
    // sure they aren't all firing back-to-back
    static uint8 offset = 0;

    // 30-second reserve
    uint8 reserve = 30;

    // establish keepalive
    ping_interval = timeout + offset - reserve;
    ShowInfo("Adding Keepalive task (%s) for every %i minutes", keepaliveTaskName, ping_interval / 60);
    CTaskMgr::getInstance()->AddTask(keepaliveTaskName, server_clock::now() + std::chrono::seconds(ping_interval), self, CTaskMgr::TASK_INTERVAL,
                                     KeepaliveTimer, std::chrono::seconds(ping_interval));

    offset += 2;

    return 0;
}

/************************************************************************
 *                                                                        *
 *  Escapes a string.                                                     *
 *                                                                        *
 ************************************************************************/

size_t EscapeStringLen(char* out_to, const char* from, size_t from_len)
{
    if (self)
    {
        return (size_t)mysql_real_escape_string(&self->handle, out_to, from, (uint32)from_len);
    }
    return (size_t)mysql_escape_string(out_to, from, (uint32)from_len);
}

/************************************************************************
 *                                                                        *
 *  Escapes a string.                                                     *
 *                                                                        *
 ************************************************************************/

size_t EscapeString(char* out_to, const char* from)
{
    return EscapeStringLen(out_to, from, strlen(from));
}

/************************************************************************
 *                                                                        *
 *  Executes a query.                                                     *
 *                                                                        *
 ************************************************************************/

int32 QueryStr(const char* query)
{
    TracyZoneScoped;
    TracyZoneCString(query);

    if (self == nullptr)
    {
        return SQL_ERROR;
    }

    FreeResult();
    self->buf.clear();

    self->buf += query;
    if (mysql_real_query(&self->handle, self->buf.c_str(), (unsigned int)self->buf.length()))
    {
        ShowSQL("DB error - %sSQL: %s", mysql_error(&self->handle), query);
        return SQL_ERROR;
    }

    self->result = mysql_store_result(&self->handle);
    if (mysql_errno(&self->handle) != 0)
    {
        ShowSQL("DB error - %sSQL: %s", mysql_error(&self->handle), query);
        return SQL_ERROR;
    }

    return SQL_SUCCESS;
}

/************************************************************************
 *                                                                        *
 *                                                                        *
 *                                                                        *
 ************************************************************************/

uint64 AffectedRows()
{
    if (self)
    {
        return (uint64)mysql_affected_rows(&self->handle);
    }
    return 0;
}

/************************************************************************
 *                                                                        *
 *  Returns the number of the AUTO_INCREMENT column of the last           *
 *  INSERT/UPDATE query.                                                  *
 *                                                                        *
 ************************************************************************/

uint64 Sql_LastInsertId()
{
    if (self)
    {
        return (uint64)mysql_insert_id(&self->handle);
    }
    return 0;
}

/************************************************************************
 *                                                                        *
 *  Returns the number of columns in each row of the result.              *
 *                                                                        *
 ************************************************************************/

uint32 NumColumns()
{
    if (self && self->result)
    {
        return (uint32)mysql_num_fields(self->result);
    }
    return 0;
}

/************************************************************************
 *                                                                        *
 *  Returns the number of rows in the result.                             *
 *                                                                        *
 ************************************************************************/

uint64 NumRows()
{
    if (self && self->result)
    {
        return (uint64)mysql_num_rows(self->result);
    }
    return 0;
}

/************************************************************************
 *                                                                        *
 *  Fetches the next row.                                                 *
 *                                                                        *
 ************************************************************************/

int32 NextRow()
{
    if (self && self->result)
    {
        self->row = mysql_fetch_row(self->result);
        if (self->row)
        {
            self->lengths = mysql_fetch_lengths(self->result);
            return SQL_SUCCESS;
        }
        self->lengths = nullptr;
        if (mysql_errno(&self->handle) == 0)
        {
            return SQL_NO_DATA;
        }
    }
    ShowFatalError("NextRow: SQL_ERROR: %s", mysql_error(&self->handle));
    return SQL_ERROR;
}

/************************************************************************
 *                                                                        *
 *  Gets the data of a column.                                            *
 *                                                                        *
 ************************************************************************/

int32 GetData(size_t col, char** out_buf, size_t* out_len)
{
    if (self && self->row)
    {
        if (col < NumColumns())
        {
            if (out_buf)
            {
                *out_buf = self->row[col];
            }
            if (out_len)
            {
                *out_len = (size_t)self->lengths[col];
            }
        }
        else // out of range - ignore
        {
            if (out_buf)
            {
                *out_buf = nullptr;
            }
            if (out_len)
            {
                *out_len = 0;
            }
        }
        return SQL_SUCCESS;
    }
    ShowFatalError("GetData: SQL_ERROR: %s", mysql_error(&self->handle));
    return SQL_ERROR;
}

/************************************************************************
 *                                                                        *
 *                                                                        *
 *                                                                        *
 ************************************************************************/

int8* GetData(size_t col)
{
    if (self && self->row)
    {
        if (col < NumColumns())
        {
            return (int8*)self->row[col];
        }
    }
    ShowFatalError("GetData: SQL_ERROR: %s", mysql_error(&self->handle));
    return nullptr;
}

/************************************************************************
 *                                                                        *
 *                                                                        *
 *                                                                        *
 ************************************************************************/

int32 GetIntData(size_t col)
{
    if (self && self->row)
    {
        if (col < NumColumns())
        {
            return (self->row[col] ? (int32)atoi(self->row[col]) : 0);
        }
    }
    ShowFatalError("GetIntData: SQL_ERROR: %s", mysql_error(&self->handle));
    return 0;
}

/************************************************************************
 *                                                                        *
 *                                                                        *
 *                                                                        *
 ************************************************************************/

uint32 GetUIntData(size_t col)
{
    if (self && self->row)
    {
        if (col < NumColumns())
        {
            return (self->row[col] ? (uint32)strtoul(self->row[col], nullptr, 10) : 0);
        }
    }
    ShowFatalError("GetUIntData: SQL_ERROR: %s", mysql_error(&self->handle));
    return 0;
}

/************************************************************************
 *                                                                        *
 *                                                                        *
 *                                                                        *
 ************************************************************************/

float GetFloatData(size_t col)
{
    if (self && self->row)
    {
        if (col < NumColumns())
        {
            return (self->row[col] ? (float)atof(self->row[col]) : 0.f);
        }
    }
    ShowFatalError("GetFloatData: SQL_ERROR: %s", mysql_error(&self->handle));
    return 0;
}

/************************************************************************
 *                                                                        *
 *  Frees the result of the query.                                        *
 *                                                                        *
 ************************************************************************/

void FreeResult()
{
    if (self && self->result)
    {
        mysql_free_result(self->result);
        self->result  = nullptr;
        self->row     = nullptr;
        self->lengths = nullptr;
    }
}

/************************************************************************
 *                                                                        *
 *                                                                        *
 *                                                                        *
 ************************************************************************/

void Disconnect()
{
    if (self)
    {
        mysql_close(&self->handle);
        FreeResult();
        if (!self->keepaliveTaskName.empty())
        {
            CTaskMgr::getInstance()->RemoveTask(self->keepaliveTaskName);
        }
        delete self;
    }
}

/************************************************************************
 *                                                                        *
 *                                                                        *
 *                                                                        *
 ************************************************************************/

bool SetAutoCommit(bool value)
{
    uint8 val = (value) ? 1 : 0;

    // if( self && mysql_autocommit(&self->handle, val) == 0)
    if (self && Query("SET @@autocommit = %u", val) != SQL_ERROR)
    {
        return true;
    }

    ShowFatalError("SetAutoCommit: SQL_ERROR: %s", mysql_error(&self->handle));
    return false;
}

/************************************************************************
 *                                                                        *
 *                                                                        *
 *                                                                        *
 ************************************************************************/

bool GetAutoCommit()
{
    if (self)
    {
        int32 ret = Query("SELECT @@autocommit;");

        if (ret != SQL_ERROR && NumRows() > 0 && NextRow() == SQL_SUCCESS)
        {
            return (GetUIntData(0) == 1);
        }
    }

    ShowFatalError("GetAutoCommit: SQL_ERROR: %s", mysql_error(&self->handle));
    return false;
}

/************************************************************************
 *                                                                        *
 *                                                                        *
 *                                                                        *
 ************************************************************************/

bool TransactionStart()
{
    if (self && Query("START TRANSACTION;") != SQL_ERROR)
    {
        return true;
    }

    ShowFatalError("TransactionStart: SQL_ERROR: %s", mysql_error(&self->handle));
    return false;
}

/************************************************************************
 *                                                                        *
 *                                                                        *
 *                                                                        *
 ************************************************************************/

bool TransactionCommit()
{
    if (self && mysql_commit(&self->handle) == 0)
    {
        return true;
    }

    ShowFatalError("TransactionCommit: SQL_ERROR: %s", mysql_error(&self->handle));
    return false;
}

/************************************************************************
 *                                                                        *
 *                                                                        *
 *                                                                        *
 ************************************************************************/

bool TransactionRollback()
{
    if (self && Query("ROLLBACK;") != SQL_ERROR)
    {
        return true;
    }

    ShowFatalError("TransactionRollback: SQL_ERROR: %s", mysql_error(&self->handle));
    return false;
}
} // namespace sql
