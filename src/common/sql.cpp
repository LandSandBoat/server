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

#include "../common/showmsg.h"
#include "../common/timer.h"
#include "../common/taskmgr.h"

#include "sql.h"

#include <string.h>
#include <stdlib.h>
#include <cstdio>
#include <any>

/************************************************************************
*																		*
*  Column length receiver.												*
*  Takes care of the possible size missmatch between uint32 and			*
*  unsigned long.				  										*
*																		*
************************************************************************/

struct s_column_length
{
	uint32* out_length;
	uint32  length;
};

/************************************************************************
*																		*
*  Allocates and initializes a new Sql handle.							*
*																		*
************************************************************************/

Sql_t* Sql_Malloc(void)
{
	Sql_t* self;

    self = new Sql_t{};
	mysql_init(&self->handle);
	self->lengths = NULL;
	self->result  = NULL;
	self->keepalive = CTaskMgr::TASK_INVALID;
	return self;
}

/************************************************************************
*																		*
*  Establishes a connection.											*
*																		*
************************************************************************/

int32 Sql_Connect(Sql_t* self, const char* user, const char* passwd, const char* host, uint16 port, const char* db)
{
	if( self == NULL )
		return SQL_ERROR;

    self->buf.clear();
	if( !mysql_real_connect(&self->handle, host, user, passwd, db, (uint32)port, NULL/*unix_socket*/, 0/*clientflag*/) )
	{
		ShowSQL("%s\n", mysql_error(&self->handle));
		return SQL_ERROR;
	}

	return SQL_SUCCESS;
}

/************************************************************************
*																		*
*  Retrieves the timeout of the connection.								*
*																		*
************************************************************************/

int32 Sql_GetTimeout(Sql_t* self, uint32* out_timeout)
{
	if( self && out_timeout && SQL_SUCCESS == Sql_Query(self, "SHOW VARIABLES LIKE 'wait_timeout'") )
	{
		char* data;
		size_t len;
		if( SQL_SUCCESS == Sql_NextRow(self) &&
			SQL_SUCCESS == Sql_GetData(self, 1, &data, &len) )
		{
			*out_timeout = (uint32)strtoul(data, NULL, 10);
			Sql_FreeResult(self);
			return SQL_SUCCESS;
		}
		Sql_FreeResult(self);
	}
	return SQL_ERROR;
}

/************************************************************************
*																		*
*  Retrieves the name of the columns of a table into out_buf, with		*
*  the separator after each name.										*
*																		*
************************************************************************/

int32 Sql_GetColumnNames(Sql_t* self, const char* table, char* out_buf, size_t buf_len, char sep)
{
	char* data;
	size_t len;
	size_t off = 0;

	if( self == NULL || SQL_ERROR == Sql_Query(self, "EXPLAIN `%s`", table) )
		return SQL_ERROR;

	out_buf[off] = '\0';
	while( SQL_SUCCESS == Sql_NextRow(self) && SQL_SUCCESS == Sql_GetData(self, 0, &data, &len) )
	{
		len = strnlen(data, len);
		if( off + len + 2 > buf_len )
		{
			ShowDebug("Sql_GetColumns: output buffer is too small\n");
			*out_buf = '\0';
			return SQL_ERROR;
		}
		memcpy(out_buf+off, data, len);
		off += len;
		out_buf[off++] = sep;
	}
	out_buf[off] = '\0';
	Sql_FreeResult(self);
	return SQL_SUCCESS;
}

/************************************************************************
*																		*
*  Changes the encoding of the connection.								*
*																		*
************************************************************************/

int32 Sql_SetEncoding(Sql_t* self, const char* encoding)
{
	if( self && mysql_set_character_set(&self->handle, encoding) == 0 )
	{
		return SQL_SUCCESS;
	}
	return SQL_ERROR;
}

/************************************************************************
*																		*
*  Pings the connection.												*
*																		*
************************************************************************/

int32 Sql_Ping(Sql_t* self)
{
	if( self && mysql_ping(&self->handle) == 0 )
	{
		return SQL_SUCCESS;
	}
	return SQL_ERROR;
}

/************************************************************************
*																		*
*  Wrapper function for Sql_Ping.										*
*																		*
************************************************************************/

// @private

static int32 Sql_P_KeepaliveTimer(time_point tick,CTaskMgr::CTask* PTask)
{
	Sql_t* self = std::any_cast<Sql_t*>(PTask->m_data);
	ShowInfo("Pinging SQL server to keep connection alive...\n");
	Sql_Ping(self);
	return 0;
}

/************************************************************************
*																		*
*  Establishes keepalive (periodic ping) on the connection				*
*																		*
************************************************************************/

/// @return the keepalive timer id, or INVALID_TIMER

int32 Sql_Keepalive(Sql_t* self)
{
	uint32 timeout, ping_interval;

	// set a default value first
	timeout = 7200; // 2 hours

	// request the timeout value from the mysql server
	Sql_GetTimeout(self, &timeout);

	if( timeout < 60 )
	{
		timeout = 60;
	}
	// establish keepalive
	ping_interval = timeout - 30; // 30-second reserve
	CTaskMgr::getInstance()->AddTask("Sql_P_KeepAliveTimer",server_clock::now()+std::chrono::seconds(ping_interval),self,CTaskMgr::TASK_INTERVAL,Sql_P_KeepaliveTimer,std::chrono::seconds(ping_interval));
	return 0;
}

/************************************************************************
*																		*
*  Escapes a string.													*
*																		*
************************************************************************/

size_t Sql_EscapeStringLen(Sql_t* self, char *out_to, const char *from, size_t from_len)
{
	if( self )
		return (size_t)mysql_real_escape_string(&self->handle, out_to, from, (uint32)from_len);
	else
		return (size_t)mysql_escape_string(out_to, from, (uint32)from_len);
}

/************************************************************************
*																		*
*  Escapes a string.													*
*																		*
************************************************************************/

size_t Sql_EscapeString(Sql_t* self, char *out_to, const char *from)
{
	return Sql_EscapeStringLen(self,out_to,from,strlen(from));
}

/************************************************************************
*																		*
*  Executes a query.													*
*																		*
************************************************************************/

int32 Sql_QueryStr(Sql_t* self, const char* query)
{
	if( self == NULL )
		return SQL_ERROR;

	Sql_FreeResult(self);
    self->buf.clear();
	self->buf += query;
	if( mysql_real_query(&self->handle, self->buf.c_str(), (unsigned int)self->buf.length()) )
	{
        ShowSQL("DB error - %s\nSQL: %s\n", mysql_error(&self->handle), query);
		return SQL_ERROR;
	}
	self->result = mysql_store_result(&self->handle);
	if( mysql_errno(&self->handle) != 0 )
	{
        ShowSQL("DB error - %s\nSQL: %s\n", mysql_error(&self->handle), query);
		return SQL_ERROR;
	}
	return SQL_SUCCESS;
}

/************************************************************************
*																		*
*				  														*
*																		*
************************************************************************/

uint64 Sql_AffectedRows(Sql_t* self)
{
	if( self )
	{
		return (uint64)mysql_affected_rows(&self->handle);
	}
	return 0;
}

/************************************************************************
*																		*
*  Returns the number of the AUTO_INCREMENT column of the last			*
*  INSERT/UPDATE query.				  									*
*																		*
************************************************************************/

uint64 Sql_LastInsertId(Sql_t* self)
{
	if( self )
	{
		return (uint64)mysql_insert_id(&self->handle);
	}
	return 0;
}

/************************************************************************
*																		*
*  Returns the number of columns in each row of the result.				*
*																		*
************************************************************************/

uint32 Sql_NumColumns(Sql_t* self)
{
	if( self && self->result )
	{
		return (uint32)mysql_num_fields(self->result);
	}
	return 0;
}

/************************************************************************
*																		*
*  Returns the number of rows in the result.							*
*																		*
************************************************************************/

uint64 Sql_NumRows(Sql_t* self)
{
	if( self && self->result )
	{
		return (uint64)mysql_num_rows(self->result);
	}
	return 0;
}

/************************************************************************
*																		*
*  Fetches the next row.												*
*																		*
************************************************************************/

int32 Sql_NextRow(Sql_t* self)
{
	if( self && self->result )
	{
		self->row = mysql_fetch_row(self->result);
		if( self->row )
		{
			self->lengths = mysql_fetch_lengths(self->result);
			return SQL_SUCCESS;
		}
		self->lengths = NULL;
		if( mysql_errno(&self->handle) == 0 )
		{
			return SQL_NO_DATA;
		}
	}
	ShowFatalError("Sql_NextRow: SQL_ERROR\n");
	return SQL_ERROR;
}

/************************************************************************
*																		*
*  Gets the data of a column.											*
*																		*
************************************************************************/

int32 Sql_GetData(Sql_t* self, size_t col, char** out_buf, size_t* out_len)
{
	if( self && self->row )
	{
		if( col < Sql_NumColumns(self) )
		{
			if( out_buf ) *out_buf = self->row[col];
			if( out_len ) *out_len = (size_t)self->lengths[col];
		}
		else // out of range - ignore
		{
			if( out_buf ) *out_buf = NULL;
			if( out_len ) *out_len = 0;
		}
		return SQL_SUCCESS;
	}
	ShowFatalError("Sql_GetData: SQL_ERROR\n");
	return SQL_ERROR;
}

/************************************************************************
*																		*
*				  														*
*																		*
************************************************************************/

int8* Sql_GetData(Sql_t* self, size_t col)
{
	if( self && self->row )
	{
		if( col < Sql_NumColumns(self) )
		{
			return (int8*)self->row[col];
		}
	}
	ShowFatalError("Sql_GetData: SQL_ERROR\n");
	return NULL;
}

/************************************************************************
*																		*
*				  														*
*																		*
************************************************************************/

int32 Sql_GetIntData(Sql_t *self, size_t col)
{
	if( self && self->row )
	{
		if( col < Sql_NumColumns(self) )
		{
			return (self->row[col] ? (int32)atoi(self->row[col]) : 0);
		}
	}
	ShowFatalError("Sql_GetIntData: SQL_ERROR\n");
	return 0;
}

/************************************************************************
*																		*
*				  														*
*																		*
************************************************************************/

uint32 Sql_GetUIntData(Sql_t *self, size_t col)
{
	if( self && self->row )
	{
		if( col < Sql_NumColumns(self) )
		{
			return (self->row[col] ? (uint32)strtoul(self->row[col],NULL,10) : 0);
		}
	}
	ShowFatalError("Sql_GetUIntData: SQL_ERROR\n");
	return 0;
}

/************************************************************************
*																		*
*				  														*
*																		*
************************************************************************/

float Sql_GetFloatData(Sql_t *self, size_t col)
{
	if( self && self->row )
	{
		if( col < Sql_NumColumns(self) )
		{
			return (self->row[col] ? (float)atof(self->row[col]) : 0.f);
		}
	}
	ShowFatalError("Sql_GetFloatData: SQL_ERROR\n");
	return 0;
}

/************************************************************************
*																		*
*  Frees the result of the query.										*
*																		*
************************************************************************/

void Sql_FreeResult(Sql_t* self)
{
	if( self && self->result )
	{
		mysql_free_result(self->result);
		self->result  = NULL;
		self->row     = NULL;
		self->lengths = NULL;
	}
}

/************************************************************************
*																		*
*  Shows debug information (last query).								*
*																		*
************************************************************************/

void Sql_ShowDebug_(Sql_t* self, const char* debug_file, const unsigned long debug_line)
{
	if( self->buf.length() > 0 )
	{
		ShowDebug("at %s:%lu - %s\n", debug_file, debug_line, self->buf.c_str());
	}
	else
	{
		ShowDebug("at %s:%lu\n", debug_file, debug_line);
	}
}

/************************************************************************
*																		*
*  Frees a Sql handle returned by Sql_Malloc.							*
*																		*
************************************************************************/

void Sql_Free(Sql_t* self)
{
	if( self )
	{
        mysql_close(&self->handle);
		Sql_FreeResult(self);
		if( self->keepalive != CTaskMgr::TASK_INVALID ) CTaskMgr::getInstance()->RemoveTask("Sql_P_KeepAliveTimer");
		delete self;
	}
}

bool Sql_SetAutoCommit(Sql_t* self, bool value)
{
    uint8 val = (value) ? 1 : 0;

    //if( self && mysql_autocommit(&self->handle, val) == 0)
    if( self && Sql_Query(self, "SET @@autocommit = %u", val) != SQL_ERROR)
    {
        return true;
    }

    ShowFatalError("Sql_SetAutoCommit: SQL_ERROR\n");
    return false;
}

bool Sql_GetAutoCommit(Sql_t* self)
{
    if( self )
    {
        int32 ret = Sql_Query(self, "SELECT @@autocommit;");

        if( ret != SQL_ERROR &&
           Sql_NumRows(self) > 0 &&
           Sql_NextRow(self) == SQL_SUCCESS )
        {
            return (Sql_GetUIntData(self, 0) == 1);
        }
    }

    ShowFatalError("Sql_GetAutoCommit: SQL_ERROR\n");
    return false;
}

bool Sql_TransactionStart(Sql_t* self)
{
    if( self && Sql_Query(self, "START TRANSACTION;") != SQL_ERROR)
    {
        return true;
    }

    ShowFatalError("Sql_TransactionStart: SQL_ERROR\n");
    return false;
}

bool Sql_TransactionCommit(Sql_t* self)
{
    if( self && mysql_commit(&self->handle) == 0)
    {
        return true;
    }

    ShowFatalError("Sql_TransactionCommit: SQL_ERROR\n");
    return false;
}

bool Sql_TransactionRollback(Sql_t* self)
{
    //if( self && mysql_rollback(&self->handle) == 0)
    if( self && Sql_Query(self, "ROLLBACK;") != SQL_ERROR)
    {
        return true;
    }

    ShowFatalError("Sql_TransactionRollback: SQL_ERROR\n");
    return false;
}
