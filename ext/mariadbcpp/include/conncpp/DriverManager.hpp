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


#ifndef _DRIVERMANAGER_H_
#define _DRIVERMANAGER_H_

#include "buildconf.hpp"
#include "SQLString.hpp"
#include "Connection.hpp"
#include "Driver.hpp"

namespace sql
{

/*
 * Mimimalistic DriverManager manager as the more convenient way to obtain a connection.
 * There is no means of registsering etc drivers, as it's unlikely needed.
 */
class MARIADB_EXPORTED DriverManager
{
  DriverManager(const DriverManager &);
  void operator=(DriverManager&)= delete;
  DriverManager() {}
  virtual ~DriverManager(){}
public:

  static Connection* getConnection(const SQLString& url);
  static Connection* getConnection(const SQLString& url, Properties& props);
  static Connection* getConnection(const SQLString& url, const SQLString& user, const SQLString& pwd);
};

}


#endif
