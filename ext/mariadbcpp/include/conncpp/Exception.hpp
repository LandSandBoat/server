/************************************************************************************
   Copyright (C) 2020,2021 MariaDB Corporation AB

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU Library General Public
   License along with this library; if not see <http://www.gnu.org/licenses>
   or write to the Free Software Foundation, Inc.,
   51 Franklin St., Fifth Floor, Boston, MA 02110, USA
*************************************************************************************/


#ifndef _EXCEPTION_H_
#define _EXCEPTION_H_

#include <memory>
#include <stdexcept>

#include "buildconf.hpp"
#include "SQLString.hpp"

namespace sql
{
class SQLException : public ::std::runtime_error
{
  SQLString SqlState;
  int32_t ErrorCode;
  std::shared_ptr<std::exception> Cause;

public:
  MARIADB_EXPORTED virtual ~SQLException();

  SQLException& operator=(const SQLException &) = default;
  
  MARIADB_EXPORTED SQLException();
  MARIADB_EXPORTED SQLException(const SQLException&);
  MARIADB_EXPORTED SQLException(const SQLString& msg);
  MARIADB_EXPORTED SQLException(const char* msg, const char* state, int32_t error=0, const std::exception *e= nullptr);

  MARIADB_EXPORTED SQLException* getNextException();
  MARIADB_EXPORTED void setNextException(sql::SQLException& nextException);
  SQLString getSQLState() { return SqlState.c_str(); }
  const char* getSQLStateCStr() { return SqlState.c_str(); }
  int32_t getErrorCode() { return ErrorCode; }
  MARIADB_EXPORTED SQLString getMessage();
  MARIADB_EXPORTED std::exception* getCause() const;
  MARIADB_EXPORTED char const* what() const noexcept override;
};


class SQLFeatureNotImplementedException: public SQLException
{
  SQLFeatureNotImplementedException& operator=(const SQLFeatureNotImplementedException&) = default;
  SQLFeatureNotImplementedException() = default;

public:
  MARIADB_EXPORTED virtual ~SQLFeatureNotImplementedException();

  MARIADB_EXPORTED SQLFeatureNotImplementedException(const SQLFeatureNotImplementedException&);
  MARIADB_EXPORTED SQLFeatureNotImplementedException(const SQLString& msg);
};

typedef SQLFeatureNotImplementedException MethodNotImplementedException;


class IllegalArgumentException : public SQLException
{
  IllegalArgumentException& operator=(const IllegalArgumentException&) = default;
  IllegalArgumentException() = default;

public:
  MARIADB_EXPORTED virtual ~IllegalArgumentException();

  MARIADB_EXPORTED IllegalArgumentException(const IllegalArgumentException&);
  MARIADB_EXPORTED IllegalArgumentException(const SQLString& msg, const char* sqlState = nullptr, int32_t error = 0);
};

typedef IllegalArgumentException InvalidArgumentException;


class SQLFeatureNotSupportedException : public SQLException
{
  SQLFeatureNotSupportedException& operator=(const SQLFeatureNotSupportedException&) = default;
  SQLFeatureNotSupportedException() = default;

public:
  MARIADB_EXPORTED virtual ~SQLFeatureNotSupportedException();

  MARIADB_EXPORTED SQLFeatureNotSupportedException(const SQLFeatureNotSupportedException&);
  MARIADB_EXPORTED SQLFeatureNotSupportedException(const SQLString& msg);
  MARIADB_EXPORTED SQLFeatureNotSupportedException(const SQLString& msg, const char* state, int32_t error = 0, const std::exception* e = nullptr);
};


class SQLTransientConnectionException : public SQLException
{
  SQLTransientConnectionException& operator=(const SQLTransientConnectionException&) = default;
  SQLTransientConnectionException() = default;

public:
  MARIADB_EXPORTED virtual ~SQLTransientConnectionException();

  MARIADB_EXPORTED SQLTransientConnectionException(const SQLTransientConnectionException&);
  MARIADB_EXPORTED SQLTransientConnectionException(const SQLString& msg);
  MARIADB_EXPORTED SQLTransientConnectionException(const SQLString& msg, const SQLString& state, int32_t error = 0, const std::exception* e = nullptr);
};


class SQLNonTransientConnectionException : public SQLException
{
  SQLNonTransientConnectionException& operator=(const SQLNonTransientConnectionException&) = default;
  SQLNonTransientConnectionException() = default;

public:
  MARIADB_EXPORTED virtual ~SQLNonTransientConnectionException();

  MARIADB_EXPORTED SQLNonTransientConnectionException(const SQLNonTransientConnectionException&);
  MARIADB_EXPORTED SQLNonTransientConnectionException(const SQLString& msg);
  MARIADB_EXPORTED SQLNonTransientConnectionException(const SQLString& msg, const SQLString& state, int32_t error = 0, const std::exception* e = nullptr);
};


class SQLTransientException : public SQLException
{
  SQLTransientException& operator=(const SQLTransientException&) = default;
  SQLTransientException() = default;

public:
  MARIADB_EXPORTED virtual ~SQLTransientException();

  MARIADB_EXPORTED SQLTransientException(const SQLTransientException&);
  MARIADB_EXPORTED SQLTransientException(const SQLString& msg);
  MARIADB_EXPORTED SQLTransientException(const SQLString& msg, const SQLString& state, int32_t error = 0, const std::exception* e = nullptr);
};


class SQLSyntaxErrorException : public SQLException
{
  SQLSyntaxErrorException& operator=(const SQLSyntaxErrorException&) = default;
  SQLSyntaxErrorException() = default;

public:
  MARIADB_EXPORTED virtual ~SQLSyntaxErrorException();

  MARIADB_EXPORTED SQLSyntaxErrorException(const SQLString& msg);
  MARIADB_EXPORTED SQLSyntaxErrorException(const SQLString& msg, const SQLString& state, int32_t error= 0, const std::exception* e= nullptr);
  MARIADB_EXPORTED SQLSyntaxErrorException(const SQLSyntaxErrorException&);
};


class SQLTimeoutException : public SQLException
{
  SQLTimeoutException& operator=(const SQLTimeoutException&) = default;
  SQLTimeoutException() = default;

public:
  MARIADB_EXPORTED virtual ~SQLTimeoutException();

  MARIADB_EXPORTED SQLTimeoutException(const SQLTimeoutException&);
  MARIADB_EXPORTED SQLTimeoutException(const SQLString& msg, const SQLString& state, int32_t error = 0, const std::exception* e = nullptr);
};


class BatchUpdateException : public SQLException
{
  BatchUpdateException& operator=(const BatchUpdateException&) = default;
  BatchUpdateException() = default;

public:
  MARIADB_EXPORTED virtual ~BatchUpdateException();

  MARIADB_EXPORTED BatchUpdateException(const BatchUpdateException&);
  MARIADB_EXPORTED BatchUpdateException(const SQLString& msg, const SQLString& state, int32_t error = 0, int64_t* updCts = nullptr, const std::exception* e = nullptr);
};


class SQLDataException : public SQLException
{
  SQLDataException& operator=(const SQLDataException&) = default;
  SQLDataException() = default;

public:
  MARIADB_EXPORTED virtual ~SQLDataException();

  MARIADB_EXPORTED SQLDataException(const SQLDataException&);
  MARIADB_EXPORTED SQLDataException(const SQLString& msg, const SQLString& state, int32_t error = 0, const std::exception* e = nullptr);
};


class SQLIntegrityConstraintViolationException : public SQLException
{
  SQLIntegrityConstraintViolationException& operator=(const SQLIntegrityConstraintViolationException&) = default;
  SQLIntegrityConstraintViolationException() = default;

public:
  MARIADB_EXPORTED virtual ~SQLIntegrityConstraintViolationException();

  MARIADB_EXPORTED SQLIntegrityConstraintViolationException(const SQLIntegrityConstraintViolationException&);
  MARIADB_EXPORTED SQLIntegrityConstraintViolationException(const SQLString& msg, const SQLString& state, int32_t error = 0, const std::exception* e = nullptr);
};


class SQLInvalidAuthorizationSpecException : public SQLException
{
  SQLInvalidAuthorizationSpecException& operator=(const SQLInvalidAuthorizationSpecException&) = default;
  SQLInvalidAuthorizationSpecException() = default;

public:
  MARIADB_EXPORTED virtual ~SQLInvalidAuthorizationSpecException();

  MARIADB_EXPORTED SQLInvalidAuthorizationSpecException(const SQLInvalidAuthorizationSpecException&);
  MARIADB_EXPORTED SQLInvalidAuthorizationSpecException(const SQLString& msg, const SQLString& state, int32_t error = 0, const std::exception* e = nullptr);
};


class SQLTransactionRollbackException : public SQLException
{
  SQLTransactionRollbackException& operator=(const SQLTransactionRollbackException&) = default;
  SQLTransactionRollbackException() = default;

public:
  MARIADB_EXPORTED virtual ~SQLTransactionRollbackException();

  MARIADB_EXPORTED SQLTransactionRollbackException(const SQLTransactionRollbackException&);
  MARIADB_EXPORTED SQLTransactionRollbackException(const SQLString& msg, const SQLString& state, int32_t error = 0, const std::exception* e = nullptr);
};


class ParseException : public SQLException
{
  ParseException& operator=(const ParseException&) = default;
  ParseException() : position(0) {}

public:
  std::size_t position;
  
  MARIADB_EXPORTED virtual ~ParseException();

  MARIADB_EXPORTED ParseException(const ParseException&);
  MARIADB_EXPORTED ParseException(const SQLString& str, std::size_t pos = 0);
};


class MaxAllowedPacketException : public std::runtime_error {

  bool mustReconnect;

public:
  MARIADB_EXPORTED virtual ~MaxAllowedPacketException();

  MARIADB_EXPORTED MaxAllowedPacketException(const MaxAllowedPacketException&);
  MARIADB_EXPORTED MaxAllowedPacketException(const char* message, bool _mustReconnect);

  bool isMustReconnect() {
    return mustReconnect;
  }
};

}
#endif
