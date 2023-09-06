/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

  This file is part of DarkStar-server source code.

===========================================================================
*/

#ifndef _SERVERUTILS_H
#define _SERVERUTILS_H

#include "common/cbasetypes.h"
#include "common/mmo.h"
#include "common/taskmgr.h"

namespace serverutils
{
    uint32 GetServerVar(std::string const& var);
    void   SetServerVar(std::string const& var, int32 value, uint32 expiry = 0);
    void   PersistServerVar(std::string const& var, int32 value, uint32 expiry = 0);

    int32 GetVolatileServerVar(std::string const& var);
    void  SetVolatileServerVar(std::string const& var, int32 value, uint32 expiry = 0);

    int32 PersistVolatileServerVars(time_point tick, CTaskMgr::CTask* PTask);
} // namespace serverutils

#endif // _SERVERUTILS_H
