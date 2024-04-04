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


#ifndef _DRIVER_H_
#define _DRIVER_H_

#include "buildconf.hpp"
#include "SQLString.hpp"
#include "Connection.hpp"
#include "jdbccompat.hpp"

namespace sql
{
typedef Properties ConnectOptionsMap;

class MARIADB_EXPORTED Driver {
  Driver(const Driver &);
  void operator=(Driver &);
public:
  Driver() {}
  virtual ~Driver(){}

  virtual Connection* connect(const SQLString& url, Properties& props)=0;
  virtual Connection* connect(const SQLString& host, const SQLString& user, const SQLString& pwd)=0;
  virtual Connection* connect(const Properties& props)=0;
  virtual bool acceptsURL(const SQLString& url)=0;
  virtual uint32_t getMajorVersion()=0;
  virtual uint32_t getMinorVersion()=0;
  virtual bool jdbcCompliant()=0;
  //Not in the classic API
  virtual const SQLString& getName()=0;
#ifdef JDBC_SPECIFIC_TYPES_IMPLEMENTED
  virtual Logger* getParentLogger()= 0;
#endif
  };

namespace mariadb
{
  MARIADB_EXPORTED Driver* get_driver_instance();
}
}


#endif
