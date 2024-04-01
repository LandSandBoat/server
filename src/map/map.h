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

===========================================================================
*/

#ifndef _MAP_H
#define _MAP_H

#include "common/cbasetypes.h"

#include "common/blowfish.h"
#include "common/kernel.h"
#include "common/mmo.h"
#include "common/socket.h"
#include "common/sql.h"
#include "common/taskmgr.h"
#include "common/xirand.h"

#include <list>
#include <map>

#include "command_handler.h"
#include "zone.h"

/************************************************************************
 *                                                                       *
 *  Map's working session                                                *
 *                                                                       *
 ************************************************************************/

struct map_session_data_t
{
    uint32       client_addr        = 0;
    uint16       client_port        = 0;
    uint16       client_packet_id   = 0;       // id of the last packet that came from the client
    uint16       server_packet_id   = 0;       // id of the last packet sent by the server
    int8*        server_packet_data = nullptr; // a pointer to the packet, which was previously sent to the client
    size_t       server_packet_size = 0;       // the size of the packet that was previously sent to the client
    time_t       last_update        = 0;       // time of last packet recv
    blowfish_t   blowfish           = {};      // unique decypher keys
    CCharEntity* PChar              = nullptr; // game char
    uint8        shuttingDown       = 0;       // prevents double session closing
};

extern uint32 map_amntplayers;
extern int32  map_fd;

// 2.5 updates per second
static constexpr float server_tick_rate = 2.5f;

// Update every 400ms
static constexpr float server_tick_interval = 1000.0f / server_tick_rate;

// Check Trigger Areas every 200ms
static constexpr float server_trigger_area_interval = server_tick_interval / 2.0f;

typedef std::map<uint64, map_session_data_t*> map_session_list_t;
extern map_session_list_t                     map_session_list;

extern in_addr map_ip;
extern uint16  map_port;

extern inline map_session_data_t* mapsession_getbyipp(uint64 ipp);
extern inline map_session_data_t* mapsession_createsession(uint32 ip, uint16 port);

extern std::unique_ptr<SqlConnection> _sql;

extern bool gLoadAllLua;

//=======================================================================

int32 recv_parse(int8* buff, size_t* buffsize, sockaddr_in* from, map_session_data_t*); // main function to parse recv packets
int32 parse(int8* buff, size_t* buffsize, sockaddr_in* from, map_session_data_t*);      // main function parsing the packets
int32 send_parse(int8* buff, size_t* buffsize, sockaddr_in* from, map_session_data_t*); // main function is building big packet

void map_helpscreen(int32 flag);

int32 map_cleanup(time_point tick, CTaskMgr::CTask* PTask); // Clean up timed out players
int32 map_close_session(time_point tick, map_session_data_t* map_session_data);

int32 map_garbage_collect(time_point tick, CTaskMgr::CTask* PTask);

#endif //_MAP_H
