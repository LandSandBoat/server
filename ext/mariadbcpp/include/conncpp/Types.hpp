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


#ifndef _MARIADB_TYPES_H_
#define _MARIADB_TYPES_H_

namespace sql
{

  enum Types {
    ARRAY= 1,
    BIGINT,
    BINARY,
    BIT,
    BLOB,
    BOOLEAN,
    CHAR,
    CLOB,
    DATALINK,
    DATE, //10
    DECIMAL,
    DISTINCT,
    DOUBLE,
    FLOAT,
    INTEGER,
    JAVA_OBJECT,
    LONGNVARCHAR,
    LONGVARBINARY,
    LONGVARCHAR,
    NCHAR, //20
    NCLOB,
    _NULL,
    SQLNULL= _NULL,
    NUMERIC,
    NVARCHAR,
    OTHER,
    REAL,
    REF,
    REF_CURSOR,
    ROWID,
    SMALLINT, //30
    _SQLXML, // Clash with class name
    STRUCT,
    TIME,
    TIME_WITH_TIMEZONE,
    TIMESTAMP,
    TIMESTAMP_WITH_TIMEZONE,
    TINYINT,
    VARBINARY,
    VARCHAR
  };

  typedef enum Types DataType;
}
#endif
