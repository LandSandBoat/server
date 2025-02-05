/*
===========================================================================

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

#include "map_session.h"

map_session_data_t* mapsession_getbyipp(uint64 ipp)
{
    TracyZoneScoped;
    map_session_list_t::iterator i = map_session_list.begin();
    while (i != map_session_list.end())
    {
        if ((*i).first == ipp)
        {
            return (*i).second;
        }
        ++i;
    }
    return nullptr;
}

map_session_data_t* mapsession_createsession(uint32 ip, uint16 port)
{
    TracyZoneScoped;

    const auto ipstr = ip2str(ip);

    const auto rset = db::preparedStmt("SELECT charid FROM accounts_sessions WHERE inet_ntoa(client_addr) = ? LIMIT 1", ipstr);

    if (rset == nullptr)
    {
        ShowError("SQL query failed in mapsession_createsession!");
        return nullptr;
    }

    if (rset->rowsCount() == 0)
    {
        // This is noisy and not really necessary
        DebugSockets(fmt::format("recv_parse: Invalid login attempt from {}", ipstr));
        return nullptr;
    }

    map_session_data_t* map_session_data = new map_session_data_t();

    map_session_data->server_packet_data = new int8[MAX_BUFFER_SIZE + 20];

    map_session_data->last_update = time(nullptr);
    map_session_data->client_addr = ip;
    map_session_data->client_port = port;

    uint64 port64 = port;
    uint64 ipp    = ip;
    ipp |= port64 << 32;
    map_session_list[ipp] = map_session_data;

    return map_session_data;
}
