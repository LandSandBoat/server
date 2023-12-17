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


#ifndef _RESULTSETMETADATA_H_
#define _RESULTSETMETADATA_H_

#include "SQLString.hpp"

namespace sql
{
class ResultSetMetaData
{
  void operator=(ResultSetMetaData &);
protected:
  ResultSetMetaData(const ResultSetMetaData&) {}
public:
  enum {
    columnNoNulls= 0,
    columnNullable,
    columnNullableUnknown
  };
  ResultSetMetaData() {}
  virtual ~ResultSetMetaData(){}

  virtual uint32_t getColumnCount()=0;
  virtual bool isAutoIncrement(uint32_t column)=0;
  virtual bool isCaseSensitive(uint32_t column)=0;
  virtual bool isSearchable(uint32_t column)=0;
  virtual bool isCurrency(uint32_t column)=0;
  virtual int32_t isNullable(uint32_t column)=0;
  virtual bool isSigned(uint32_t column)=0;
  virtual uint32_t getColumnDisplaySize(uint32_t column)=0;
  virtual SQLString getColumnLabel(uint32_t column)=0;
  virtual SQLString getColumnName(uint32_t column)=0;
  virtual SQLString getCatalogName(uint32_t column)=0;
  virtual uint32_t getPrecision(uint32_t column)=0;
  virtual uint32_t getScale(uint32_t column)=0;
  virtual SQLString getTableName(uint32_t column)=0;
  virtual SQLString getSchemaName(uint32_t column)=0;
  virtual int32_t getColumnType(uint32_t column)=0;
  virtual SQLString getColumnTypeName(uint32_t column)=0;
  virtual bool isReadOnly(uint32_t column)=0;
  virtual bool isWritable(uint32_t column)=0;
  virtual bool isDefinitelyWritable(uint32_t column)=0;
  virtual SQLString getColumnClassName(uint32_t column)=0;
  virtual bool isZerofill(uint32_t column)=0;
  virtual SQLString getColumnCollation(uint32_t column)=0;
};

}
#endif
