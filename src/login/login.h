/*
===========================================================================

  Copyright (c) 2010-2016 Darkstar Dev Teams

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

#ifndef _LOGIN_H
#define _LOGIN_H

#include "common/cbasetypes.h"

#include <functional>
#include <list>

#include "common/kernel.h"
#include "common/mmo.h"
#include "common/socket.h"
#include "common/sql.h"

#include "login_session.h"

extern std::unique_ptr<SqlConnection> sql;

int32 do_init(int32 argc, char** argv);

#endif // _LOGIN_H
