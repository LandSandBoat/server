/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams
  Copyright (c) 2025 LandSandBoat Dev Teams

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

#ifndef _MAP_H
#define _MAP_H

#include "common/cbasetypes.h"

#include "common/blowfish.h"
#include "common/kernel.h"
#include "common/md52.h"
#include "common/mmo.h"
#include "common/socket.h"
#include "common/sql.h"
#include "common/taskmgr.h"
#include "common/xirand.h"

#include <list>
#include <map>

#include "command_handler.h"
#include "zone.h"

class MapState final
{
public:

private:
    // Legacy SQL connection
    // TODO: Remove me and use db::preparedStmt everywhere
    std::unique_ptr<SqlConnection> sql_;

    // std::map<uint64, std::unique_ptr<map_session_data_t>> mapSessions_;

    // ip/port information
    extern in_addr map_ip;
    extern uint16  map_port;

    // Garbage collection & other misc tasks
    int32 map_garbage_collect(time_point tick, CTaskMgr::CTask* PTask);
    int32 map_cleanup(time_point tick, CTaskMgr::CTask* PTask); // Clean up timed out players

    // Debug things like "gLoadAllLua"

    // Platform platform()
};
