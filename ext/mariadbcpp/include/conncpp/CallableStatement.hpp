/************************************************************************************
   Copyright (C) 2020 MariaDB Corporation AB

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


#ifndef _CALLABLESTATEMENT_H_
#define _CALLABLESTATEMENT_H_

#include "SQLString.hpp"
#include "jdbccompat.hpp"
#include "PreparedStatement.hpp"

namespace sql
{
class ParameterMetaData;

class CallableStatement : public PreparedStatement
{
  CallableStatement(const CallableStatement &);
  void operator=(const CallableStatement &);

public:
  CallableStatement() {}
  virtual ~CallableStatement() {}
  virtual bool wasNull()=0;
  virtual SQLString getString(int32_t parameterIndex)=0;
  virtual SQLString getString(const SQLString& parameterName)=0;
  virtual bool getBoolean(int32_t parameterIndex)=0;
  virtual bool getBoolean(const SQLString& parameterName)=0;
  virtual int8_t getByte(int32_t parameterIndex)=0;
  virtual int8_t getByte(const SQLString& parameterName)=0;
  virtual int16_t getShort(int32_t parameterIndex)=0;
  virtual int16_t getShort(const SQLString& parameterName)=0;
  virtual int32_t getInt(const SQLString& parameterName)=0;
  virtual int32_t getInt(int32_t parameterIndex)=0;
  virtual int64_t getLong(const SQLString& parameterName)=0;
  virtual int64_t getLong(int32_t parameterIndex)=0;
  virtual float getFloat(const SQLString& parameterName)=0;
  virtual float getFloat(int32_t parameterIndex)=0;
  virtual long double getDouble(int32_t parameterIndex)=0;
  virtual long double getDouble(const SQLString& parameterName)=0;

  virtual void registerOutParameter(int32_t parameterIndex, int32_t sqlType, const SQLString& typeName)=0;
  virtual void registerOutParameter(int32_t parameterIndex, int32_t sqlType)=0;
  virtual void registerOutParameter(int32_t parameterIndex, int32_t sqlType, int32_t scale)=0;
  virtual void registerOutParameter(const SQLString& parameterName, int32_t sqlType)=0;
  virtual void registerOutParameter(const SQLString& parameterName, int32_t sqlType, int32_t scale)=0;
  virtual void registerOutParameter(const SQLString& parameterName, int32_t sqlType, const SQLString& typeName)=0;

#ifdef MAYBE_IN_NEXTVERSION
  virtual Blob* getBlob(int32_t columnIndex)=0;
  virtual Blob* getBlob(const SQLString& columnLabel)=0;
  /*virtual std::istream* getBlob(int32_t columnIndex)=0;
  virtual std::istream* getBlob(SQLString& columnLabel)=0;*/
  virtual std::istringstream* getCharacterStream(int32_t parameterIndex)=0;
  virtual std::istringstream* getCharacterStream(const SQLString& parameterName)=0;
  virtual sql::bytes* getBytes(const SQLString& parameterName)=0;
  virtual Clob* getClob(const SQLString& parameterName)=0;
  virtual Clob* getClob(int32_t parameterIndex)=0;
  virtual SQLString getNString(int32_t parameterIndex)=0;
  virtual SQLString getNString(const SQLString& parameterName)=0;
  virtual RowId* getRowId(int32_t parameterIndex)=0;
  virtual RowId* getRowId(const SQLString& parameterName)=0;
  virtual NClob& getNClob(int32_t parameterIndex)=0;
  virtual NClob& getNClob(const SQLString& parameterName)=0;
  virtual std::istringstream* getNCharacterStream(int32_t parameterIndex)=0;
  virtual std::istringstream* getNCharacterStream(const SQLString& parameterName)=0;

  virtual Date* getDate(int32_t parameterIndex)=0;
  virtual Date* getDate(const SQLString& parameterName)=0;
  virtual Time* getTime(const SQLString& parameterName)=0;
  virtual Time* getTime(int32_t parameterIndex)=0;
  virtual Timestamp* getTimestamp(int32_t parameterIndex)=0;
  virtual Timestamp* getTimestamp(const SQLString& parameterName)=0;
#endif

#ifdef JDBC_SPECIFIC_TYPES_IMPLEMENTED
  virtual BigDecimal* getBigDecimal(int32_t parameterIndex,int32_t scale)=0;
  virtual BigDecimal* getBigDecimal(int32_t parameterIndex)=0;
  virtual BigDecimal* getBigDecimal(const SQLString& parameterName)=0;

  virtual sql::Object* getObject(int32_t parameterIndex)=0;
  virtual sql::Object* getObject(const SQLString& parameterName)=0;
  virtual sql::Object* getObject(const SQLString& parameterName,Map<String,Class<?>>map)=0;
  virtual Ref* getRef(int32_t parameterIndex)=0;
  virtual Ref* getRef(const SQLString& parameterName)=0;
  virtual sql::Array* getArray(const SQLString& parameterName)=0;
  virtual sql::Array* getArray(int32_t parameterIndex)=0;
  virtual URL* getURL(int32_t parameterIndex)=0;
  virtual URL* getURL(const SQLString& parameterName)=0;
  virtual SQLXML* getSQLXML(int32_t parameterIndex)=0;
  virtual SQLXML* getSQLXML(const SQLString& parameterName)=0;

  virtual void registerOutParameter(int32_t parameterIndex, SQLType* sqlType)=0;
  virtual void registerOutParameter(int32_t parameterIndex, SQLType* sqlType,int32_t scale)=0;
  virtual void registerOutParameter(int32_t parameterIndex, SQLType* sqlType, SQLString& typeName)=0;
  virtual void registerOutParameter(const SQLString& parameterName,SQLType* sqlType)=0;
  virtual void registerOutParameter(const SQLString& parameterName,SQLType* sqlType,int32_t scale)=0;
  virtual void registerOutParameter(const SQLString& parameterName,SQLType* sqlType, SQLString& typeName)=0;
 #endif

  };
}
#endif
