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


#ifndef _SAVEPOINT_H_
#define _SAVEPOINT_H_

#include "SQLString.hpp"

namespace sql
{

class Savepoint
{
  Savepoint(const Savepoint &);
  void operator=(Savepoint &);

public:
  Savepoint() {}
  virtual ~Savepoint(){}

  virtual int32_t getSavepointId() const=0;
  virtual const SQLString& getSavepointName() const=0;
  virtual SQLString toString() const=0;
};

}
#endif
