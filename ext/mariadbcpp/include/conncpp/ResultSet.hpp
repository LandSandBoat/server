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


#ifndef _RESULTSET_H_
#define _RESULTSET_H_

#include <istream>

#include "buildconf.hpp"
#include "SQLString.hpp"
#include "Warning.hpp"
#include "jdbccompat.hpp"

namespace sql
{
class ResultSetMetaData;
class Statement;

class MARIADB_EXPORTED ResultSet {

  ResultSet(const ResultSet &);
  void operator=(ResultSet &);

public:
  enum {
    HOLD_CURSORS_OVER_COMMIT= 1,
    CLOSE_CURSORS_AT_COMMIT= 2
  };
  enum {
    CONCUR_READ_ONLY= 1007,
    CONCUR_UPDATABLE= 1008
  };

  enum {
    FETCH_FORWARD= 1000,
    FETCH_REVERSE,
    FETCH_UNKNOWN
  };
  enum enum_type {
    TYPE_FORWARD_ONLY= 1003,
    TYPE_SCROLL_INSENSITIVE,
    TYPE_SCROLL_SENSITIVE
  };

  ResultSet() {}
  virtual ~ResultSet(){}

  virtual void close()=0;
  virtual bool next()=0;
  virtual SQLWarning* getWarnings()=0;
  virtual void clearWarnings()=0;
  virtual bool isBeforeFirst()=0;
  virtual bool isAfterLast()=0;
  virtual bool isFirst()=0;
  virtual bool isLast()=0;
  virtual void beforeFirst()=0;
  virtual void afterLast()=0;
  virtual bool first()=0;
  virtual bool last()=0;
  virtual int32_t getRow()=0;
  virtual bool absolute(int32_t row)=0;
  virtual bool relative(int32_t rows)=0;
  virtual bool previous()=0;
  virtual int32_t getFetchDirection()=0;
  virtual void setFetchDirection(int32_t direction)=0;
  virtual int32_t getFetchSize()=0;
  virtual void setFetchSize(int32_t fetchSize)=0;
  virtual int32_t getType()=0;
  virtual int32_t getConcurrency()=0;
  virtual bool isClosed() const=0;
  virtual Statement* getStatement()=0;
  virtual bool wasNull()=0;

  virtual bool isNull(int32_t columnIndex)=0;
  virtual bool isNull(const SQLString& columnLabel)=0;
  virtual SQLString getString(int32_t columnIndex)=0;
  virtual SQLString getString(const SQLString& columnLabel)=0;
  virtual int32_t getInt(int32_t columnIndex)=0;
  virtual int32_t getInt(const SQLString& columnLabel)=0;
  virtual uint32_t getUInt(int32_t columnIndex)=0;
  virtual uint32_t getUInt(const SQLString& columnLabel)=0;
  virtual int64_t getLong(const SQLString& columnLabel)=0;
  virtual int64_t getLong(int32_t columnIndex)=0;
  /* getInt64 are aliases for getLong */
  virtual int64_t getInt64(const SQLString& columnLabel)=0;
  virtual int64_t getInt64(int32_t columnIndex)=0;
  virtual uint64_t getUInt64(const SQLString& columnLabel)=0;
  virtual uint64_t getUInt64(int32_t columnIndex)=0;
  virtual float getFloat(const SQLString& columnLabel)=0;
  virtual float getFloat(int32_t columnIndex)=0;
  virtual long double getDouble(const SQLString& columnLabel)=0;
  virtual long double getDouble(int32_t columnIndex)=0;
  virtual bool getBoolean(int32_t index)=0;
  virtual bool getBoolean(const SQLString& columnLabel)=0;
  virtual int8_t getByte(int32_t index)=0;
  virtual int8_t getByte(const SQLString& columnLabel)=0;
  virtual int16_t getShort(int32_t index)=0;
  virtual int16_t getShort(const SQLString& columnLabel)=0;

  /*virtual std::istream* getBlob(int32_t columnIndex)=0;
  virtual std::istream* getBlob(SQLString& columnLabel)=0;*/
  virtual std::istream* getBinaryStream(int32_t columnIndex)=0;
  virtual std::istream* getBinaryStream(const SQLString& columnLabel)=0;

  virtual int32_t findColumn(const SQLString& columnLabel)=0;
  virtual SQLString getCursorName()=0;
  virtual int32_t getHoldability()=0;
  virtual ResultSetMetaData* getMetaData()=0;
  virtual Blob* getBlob(int32_t columnIndex)=0;
  virtual Blob* getBlob(const SQLString& columnLabel)=0;

#ifdef MAYBE_IN_NEXTVERSION
  virtual Blob* getBlob(int32_t columnIndex)=0;
  virtual Blob* getBlob(const SQLString& columnLabel)=0;
  virtual sql::bytes* getBytes(const SQLString& columnLabel)=0;
  virtual sql::bytes* getBytes(int32_t columnIndex)=0;
  virtual SQLString getNString(int32_t columnIndex)=0;
  virtual SQLString getNString(SQLString& columnLabel)=0;
  virtual Date* getDate(int32_t columnIndex)=0;
  virtual Date* getDate(SQLString& columnLabel)=0;
  virtual Time* getTime(int32_t columnIndex)=0;
  virtual Time* getTime(SQLString& columnLabel)=0;

  virtual std::istream* getAsciiStream(SQLString& columnLabel)=0;
  virtual std::istream* getAsciiStream(int32_t columnIndex)=0;
  virtual std::istringstream* getCharacterStream(SQLString& columnLabel)=0;
  virtual std::istringstream* getCharacterStream(int32_t columnIndex)=0;
  virtual std::istringstream& getNCharacterStream(int32_t columnIndex)=0;
  virtual std::istringstream& getNCharacterStream(SQLString& columnLabel)=0;
  virtual NClob* getNClob(int32_t columnIndex)=0;
  virtual NClob* getNClob(SQLString& columnLabel)=0;
  virtual Clob* getClob(int32_t columnIndex)=0;
  virtual Clob* getClob(SQLString& columnLabel)=0;
  virtual Timestamp* getTimestamp(int32_t columnIndex)=0;
  virtual Timestamp* getTimestamp(SQLString& columnLabel)=0;
#endif

  virtual RowId* getRowId(int32_t columnIndex)=0;
  virtual RowId* getRowId(const SQLString& columnLabel)=0;

#ifdef JDBC_SPECIFIC_TYPES_IMPLEMENTED
  virtual BigDecimal* getBigDecimal(SQLString& columnLabel,int32_t scale)=0;
  virtual BigDecimal* getBigDecimal(int32_t columnIndex,int32_t scale)=0;
  virtual BigDecimal* getBigDecimal(int32_t columnIndex)=0;
  virtual BigDecimal* getBigDecimal(SQLString& columnLabel)=0;
  virtual Date* getDate(int32_t columnIndex,Calendar& cal)=0;
  virtual Date* getDate(SQLString& columnLabel,Calendar& cal)=0;
  virtual Time* getTime(int32_t columnIndex,Calendar& cal)=0;
  virtual Time* getTime(SQLString& columnLabel,Calendar& cal)=0;
  virtual Timestamp* getTimestamp(int32_t columnIndex,Calendar& cal)=0;
  virtual Timestamp* getTimestamp(SQLString& columnLabel,Calendar& cal)=0;

  virtual sql::Object* getObject(int32_t columnIndex)=0;
  virtual sql::Object* getObject(SQLString& columnLabel)=0;
  /*virtual sql::Object* getObject(SQLString& columnLabel, map<SQLString,Class<?>>map)=0;*/

  virtual Ref* getRef(int32_t columnIndex)=0;
  virtual Ref* getRef(SQLString& columnLabel)=0;

  virtual sql::Array* getArray(int32_t columnIndex)=0;
  virtual sql::Array* getArray(SQLString& columnLabel)=0;
  virtual URL* getURL(int32_t columnIndex)=0;
  virtual URL* getURL(SQLString& columnLabel)=0;

  virtual SQLXML* getSQLXML(int32_t columnIndex)=0;
  virtual SQLXML* getSQLXML(SQLString& columnLabel)=0;
#endif

  virtual bool rowUpdated()=0;
  virtual bool rowInserted()=0;
  virtual bool rowDeleted()=0;
  virtual void moveToInsertRow()=0;
  virtual void moveToCurrentRow()=0;
  virtual void cancelRowUpdates()=0;
  virtual void insertRow()=0;
  virtual void refreshRow()=0;

  virtual std::size_t rowsCount()=0;

#ifdef RS_UPDATE_FUNCTIONALITY_IMPLEMENTED

  virtual void deleteRow()=0;
  virtual void updateNull(int32_t columnIndex)=0;
  virtual void updateNull(SQLString& columnLabel)=0;
  virtual void updateBoolean(int32_t columnIndex,bool boolean)=0;
  virtual void updateBoolean(SQLString& columnLabel,bool value)=0;
  virtual void updateByte(int32_t columnIndex,char value)=0;
  virtual void updateByte(SQLString& columnLabel,char value)=0;
  virtual void updateShort(int32_t columnIndex,short value)=0;
  virtual void updateShort(SQLString& columnLabel,short value)=0;
  virtual void updateInt(int32_t columnIndex,int32_t value)=0;
  virtual void updateInt(SQLString& columnLabel,int32_t value)=0;
  virtual void updateFloat(int32_t columnIndex,float value)=0;
  virtual void updateFloat(SQLString& columnLabel,float value)=0;
  virtual void updateDouble(int32_t columnIndex,double value)=0;
  virtual void updateDouble(SQLString& columnLabel,double value)=0;
  virtual void updateBigDecimal(int32_t columnIndex,BigDecimal value)=0;
  virtual void updateBigDecimal(SQLString& columnLabel,BigDecimal value)=0;
  virtual void updateString(int32_t columnIndex, SQLString& value)=0;
  virtual void updateString(SQLString& columnLabel, SQLString& value)=0;
  virtual void updateBytes(int32_t columnIndex,char* value)=0;
  virtual void updateBytes(SQLString& columnLabel,char* value)=0;
  virtual void updateDate(int32_t columnIndex,Date date)=0;
  virtual void updateDate(SQLString& columnLabel,Date value)=0;
  virtual void updateTime(int32_t columnIndex,Time time)=0;
  virtual void updateTime(SQLString& columnLabel,Time value)=0;
  virtual void updateTimestamp(int32_t columnIndex,Timestamp timeStamp)=0;
  virtual void updateTimestamp(SQLString& columnLabel,Timestamp value)=0;
  virtual void updateAsciiStream(int32_t columnIndex,std::istream* inputStream,int32_t length)=0;
  virtual void updateAsciiStream(SQLString& columnLabel,std::istream* inputStream)=0;
  virtual void updateAsciiStream(SQLString& columnLabel,std::istream* value,int32_t length)=0;
  virtual void updateAsciiStream(int32_t columnIndex,std::istream* inputStream,int64_t length)=0;
  virtual void updateAsciiStream(SQLString& columnLabel,std::istream* inputStream,int64_t length)=0;
  virtual void updateAsciiStream(int32_t columnIndex,std::istream* inputStream)=0;
  virtual void updateBinaryStream(int32_t columnIndex,std::istream* inputStream,int32_t length)=0;
  virtual void updateBinaryStream(int32_t columnIndex,std::istream* inputStream,int64_t length)=0;
  virtual void updateBinaryStream(SQLString& columnLabel,std::istream* value,int32_t length)=0;
  virtual void updateBinaryStream(SQLString& columnLabel,std::istream* inputStream,int64_t length)=0;
  virtual void updateBinaryStream(int32_t columnIndex,std::istream* inputStream)=0;
  virtual void updateBinaryStream(SQLString& columnLabel,std::istream* inputStream)=0;
  virtual void updateCharacterStream(int32_t columnIndex,std::istringstream& value,int32_t length)=0;
  virtual void updateCharacterStream(int32_t columnIndex,std::istringstream& value)=0;
  virtual void updateCharacterStream(SQLString& columnLabel,std::istringstream& std::istringstream&,int32_t length)=0;
  virtual void updateCharacterStream(int32_t columnIndex,std::istringstream& value,int64_t length)=0;
  virtual void updateCharacterStream(SQLString& columnLabel,std::istringstream& std::istringstream&,int64_t length)=0;
  virtual void updateCharacterStream(SQLString& columnLabel,std::istringstream& reader)=0;
  virtual void updateObject(int32_t columnIndex,sql::Object* value,int32_t scaleOrLength)=0;
  virtual void updateObject(int32_t columnIndex,sql::Object* value)=0;
  virtual void updateObject(SQLString& columnLabel,sql::Object* value,int32_t scaleOrLength)=0;
  virtual void updateObject(SQLString& columnLabel,sql::Object* value)=0;
  virtual void updateLong(SQLString& columnLabel,int64_t value)=0;
  virtual void updateLong(int32_t columnIndex,int64_t value)=0;
  virtual void updateRow()=0;
  virtual void updateRef(int32_t columnIndex,Ref ref)=0;
  virtual void updateRef(SQLString& columnLabel,Ref ref)=0;
  virtual void updateBlob(int32_t columnIndex,Blob& blob)=0;
  virtual void updateBlob(SQLString& columnLabel,Blob& blob)=0;
  virtual void updateBlob(int32_t columnIndex,std::istream* inputStream)=0;
  virtual void updateBlob(SQLString& columnLabel,std::istream* inputStream)=0;
  virtual void updateBlob(int32_t columnIndex,std::istream* inputStream,int64_t length)=0;
  virtual void updateBlob(SQLString& columnLabel,std::istream* inputStream,int64_t length)=0;
  virtual void updateClob(int32_t columnIndex,Clob& clob)=0;
  virtual void updateClob(SQLString& columnLabel,Clob& clob)=0;
  virtual void updateClob(int32_t columnIndex,std::istringstream& reader,int64_t length)=0;
  virtual void updateClob(SQLString& columnLabel,std::istringstream& reader,int64_t length)=0;
  virtual void updateClob(int32_t columnIndex,std::istringstream& reader)=0;
  virtual void updateClob(SQLString& columnLabel,std::istringstream& reader)=0;
  virtual void updateArray(int32_t columnIndex,sql::Array& array)=0;
  virtual void updateArray(SQLString& columnLabel,sql::Array& array)=0;
  virtual void updateRowId(int32_t columnIndex,RowId rowId)=0;
  virtual void updateRowId(SQLString& columnLabel,RowId rowId)=0;
  virtual void updateNString(int32_t columnIndex, SQLString& nstring)=0;
  virtual void updateNString(SQLString& columnLabel, SQLString& nstring)=0;
  virtual void updateNClob(int32_t columnIndex,NClob& nclob)=0;
  virtual void updateNClob(SQLString& columnLabel,NClob& nclob)=0;
  virtual void updateNClob(int32_t columnIndex,std::istringstream& reader)=0;
  virtual void updateNClob(SQLString& columnLabel,std::istringstream& reader)=0;
  virtual void updateNClob(int32_t columnIndex,std::istringstream& reader,int64_t length)=0;
  virtual void updateNClob(SQLString& columnLabel,std::istringstream& reader,int64_t length)=0;
  virtual void updateSQLXML(int32_t columnIndex,SQLXML& xmlObject)=0;
  virtual void updateSQLXML(SQLString& columnLabel,SQLXML& xmlObject)=0;
  virtual void updateNCharacterStream(int32_t columnIndex,std::istringstream& value,int64_t length)=0;
  virtual void updateNCharacterStream(SQLString& columnLabel,std::istringstream& reader,int64_t length)=0;
  virtual void updateNCharacterStream(int32_t columnIndex,std::istringstream& reader)=0;
  virtual void updateNCharacterStream(SQLString& columnLabel,std::istringstream& reader)=0;
#endif
};

}
#endif
