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


#ifndef _PREPARESTATEMENT_H_
#define _PREPARESTATEMENT_H_

#include "buildconf.hpp"
#include "SQLString.hpp"
#include "ParameterMetaData.hpp"

#include "Statement.hpp"

namespace sql
{

class MARIADB_EXPORTED PreparedStatement: virtual public Statement {
  PreparedStatement(const PreparedStatement &);
  void operator=(PreparedStatement &);
public:
  PreparedStatement() {}
  virtual ~PreparedStatement(){}

  virtual bool execute()=0;
  virtual bool execute(const SQLString& sql)=0;
  virtual ParameterMetaData* getParameterMetaData()=0;
  virtual int32_t executeUpdate()=0;
  virtual int64_t executeLargeUpdate()=0;
  virtual ResultSet* executeQuery()=0;
  virtual void addBatch()=0;
  virtual void clearParameters()=0;
  virtual void setNull(int32_t parameterIndex,int32_t sqlType)=0;
  virtual void setNull(int32_t parameterIndex,int32_t sqlType,const SQLString& typeName)=0;

  virtual void setBoolean(int32_t parameterIndex, bool value)=0;
  virtual void setByte(int32_t parameterIndex, int8_t bit)=0;
  virtual void setShort(int32_t parameterIndex, int16_t value)=0;
  virtual void setString(int32_t parameterIndex, const SQLString& str)=0;
  /* We need either array length passed along with pointer, or make it a vector. Passing vector doesn't feel good */
  virtual void setBytes(int32_t parameterIndex, sql::bytes* bytes)=0;
  virtual void setInt(int32_t column, int32_t value)=0;
  virtual void setLong(int32_t parameterIndex, int64_t value)=0;
  virtual void setInt64(int32_t parameterIndex, int64_t value)=0;
  virtual void setUInt64(int32_t parameterIndex, uint64_t value)=0;
  virtual void setUInt(int32_t parameterIndex, uint32_t value)=0;
  virtual void setFloat(int32_t parameterIndex, float value)=0;
  virtual void setDouble(int32_t parameterIndex, double value)=0;
  virtual void setBigInt(int32_t column, const SQLString& value)=0;

  virtual void setBlob(int32_t parameterIndex, std::istream* inputStream,const int64_t length)=0;
  virtual void setBlob(int32_t parameterIndex, std::istream* inputStream)=0;
  virtual void setDateTime(int32_t parameterIndex, const SQLString& dt)=0;

#ifdef MAKES_SENSE_TO_ADD_TO_EASE_SETTING_NULL_AND_COPY_JDBC_BEHAVIOR
  virtual void setBoolean(int32_t parameterIndex, bool *value)=0;
  virtual void setByte(int32_t parameterIndex, int8_t* bit)=0;
  virtual void setShort(int32_t parameterIndex, const int16_t* value)=0;
  virtual void setString(int32_t parameterIndex, const SQLString* str)=0;
  /* We need either array length passed along with pointer, or make it a vector. Passing vector doesn't feel good */
  virtual void setInt(int32_t column, int32_t* value)=0;
  virtual void setLong(int32_t parameterIndex, int64_t* value)=0;
  virtual void setFloat(int32_t parameterIndex, float* value)=0;
  virtual void setDouble(int32_t parameterIndex, double* value)=0;
#endif

#ifdef MAYBE_IN_NEXT_VERSION
  virtual void setRowId(int32_t parameterIndex, const RowId* rowid)=0;
  /* Pass refs or pointers? */
  virtual void setCharacterStream(int32_t parameterIndex, const std::istringstream& reader, int32_t length)=0;
  virtual void setCharacterStream(int32_t parameterIndex, const std::istringstream& reader, int64_t length)=0;
  virtual void setCharacterStream(int32_t parameterIndex, const std::istringstream& reader)=0;
  virtual void setBinaryStream(int32_t parameterIndex, std::istream& stream, int64_t length)=0;
  virtual void setBinaryStream(int32_t parameterIndex, std::istream& stream)=0;
  virtual void setBinaryStream(int32_t parameterIndex, std::istream& stream, int32_t length)=0;

  virtual void setBlob(int32_t parameterIndex,const Blob& blob)=0;
  virtual void setClob(int32_t parameterIndex,const Clob& clob)=0;
  virtual void setClob(int32_t parameterIndex,const std::istringstream& reader,const int64_t length)=0;
  virtual void setClob(int32_t parameterIndex,const std::istringstream& reader)=0;
  virtual void setNString(int32_t parameterIndex,const SQLString& value)=0;
  virtual void setAsciiStream(int32_t parameterIndex, std::istream& stream,const int64_t length)=0;
  virtual void setAsciiStream(int32_t parameterIndex, std::istream& stream)=0;
  virtual void setAsciiStream(int32_t parameterIndex, std::istream& stream, int32_t length)=0;

  virtual void setDate(int32_t parameterIndex,const Date& date)=0;
  virtual void setTime(int32_t parameterIndex,const Time time)=0;
  virtual void setTimestamp(int32_t parameterIndex,const Timestamp timestamp)=0;

  virtual void setNCharacterStream(int32_t parameterIndex,const std::istringstream& value,const int64_t length)=0;
  virtual void setNCharacterStream(int32_t parameterIndex,const std::istringstream& value)=0;#endif
  virtual void setNClob(int32_t parameterIndex, const NClob& value)=0;
  virtual void setNClob(int32_t parameterIndex, const std::istringstream& reader, const int64_t length)=0;
  virtual void setNClob(int32_t parameterIndex, const std::istringstream& reader)=0;
#endif

#ifdef JDBC_SPECIFIC_TYPES_IMPLEMENTED
  virtual void setBigDecimal(int32_t parameterIndex, const BigDecimal& bigDecimal)=0;
  virtual void setRef(int32_t parameterIndex, const Ref& ref)=0;
  virtual void setArray(int32_t parameterIndex,const sql::Array& array)=0;
  virtual void setDate(int32_t parameterIndex,const Date date,const Calendar& cal)=0;
  virtual void setTime(int32_t parameterIndex,const Time time,const Calendar& cal)=0;
  virtual void setTimestamp(int32_t parameterIndex, const Timestamp timestamp, const Calendar& cal)=0;
  virtual void setURL(int32_t parameterIndex, const URL& url)=0;


  virtual void setSQLXML(int32_t parameterIndex, const SQLXML& xmlObject)=0;
  virtual void setObject(int32_t parameterIndex, const sql::Object* obj, int32_t targetSqlType, int32_t scaleOrLength)=0;
  virtual void setObject(int32_t parameterIndex, const sql::Object* obj, int32_t targetSqlType)=0;
  virtual void setObject(int32_t parameterIndex, const sql::Object* obj)=0;
  virtual void setObject(int32_t parameterIndex, sql::Object* obj, SQLType* targetSqlType, int32_t scaleOrLength)=0;
  virtual void setObject(int32_t parameterIndex, sql::Object* obj, SQLType* targetSqlType)=0;

#endif

  };
}
#endif
