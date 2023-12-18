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

#include "instance_loader.h"
#include "lua/luautils.h"

#include "instanceutils.h"
#include "zoneutils.h"

#include <queue>

namespace instanceutils
{
    std::unordered_map<uint16, InstanceData_t> InstanceData;
    std::queue<std::pair<uint32, uint16>>      LoadQueue; // player id, instance id

    void LoadInstanceList()
    {
        const char query[] =
            "SELECT "
            "instanceid,"                // 0
            "instance_name,"             // 1
            "instance_zone,"             // 2
            "entrance_zone,"             // 3
            "time_limit,"                // 4
            "start_x,"                   // 5
            "start_y,"                   // 6
            "start_z,"                   // 7
            "start_rot,"                 // 8
            "instance_list.music_day,"   // 9
            "instance_list.music_night," // 10
            "instance_list.battlesolo,"  // 11
            "instance_list.battlemulti," // 12
            "zone_settings.name "        // 13
            "FROM instance_list INNER JOIN zone_settings "
            "ON instance_zone = zone_settings.zoneid "
            "WHERE IF(%d <> 0, '%s' = zoneip AND %d = zoneport, TRUE);";

        char address[INET_ADDRSTRLEN];
        inet_ntop(AF_INET, &map_ip, address, INET_ADDRSTRLEN);
        int32 ret = _sql->Query(query, map_ip.s_addr, address, map_port);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                InstanceData_t data;

                // Main data
                data.id            = static_cast<uint16>(_sql->GetIntData(0));
                data.instance_name = reinterpret_cast<const char*>(_sql->GetData(1));
                data.instance_zone = static_cast<uint16>(_sql->GetIntData(2));
                data.entrance_zone = static_cast<uint16>(_sql->GetIntData(3));
                data.time_limit    = static_cast<uint16>(_sql->GetIntData(4));
                data.start_x       = _sql->GetFloatData(5);
                data.start_y       = _sql->GetFloatData(6);
                data.start_z       = _sql->GetFloatData(7);
                data.start_rot     = static_cast<uint16>(_sql->GetIntData(8));
                data.music_day     = static_cast<uint16>(_sql->GetIntData(9));
                data.music_night   = static_cast<uint16>(_sql->GetIntData(10));
                data.battlesolo    = static_cast<uint16>(_sql->GetIntData(11));
                data.battlemulti   = static_cast<uint16>(_sql->GetIntData(12));

                // Meta data
                data.instance_zone_name = zoneutils::GetZone(data.instance_zone)->getName();
                data.entrance_zone_name = _sql->GetStringData(13);
                data.filename           = fmt::format("./scripts/zones/{}/instances/{}.lua", data.instance_zone_name, data.instance_name);

                // Add to data cache
                InstanceData[data.id] = data;

                // Add to Lua cache
                luautils::CacheLuaObjectFromFile(data.filename);
            }
        }
    }

    // NOTE: This used to be multithreaded, but was starting to cause problems with repeated loading
    //       and loading in quick succession, so we've swapped it out for a queue which services a
    //       single request at the end of every tick.
    // TODO: Make this multithreaded and not blocking the main tick loop
    void CheckInstance()
    {
        if (!LoadQueue.empty())
        {
            auto requestPair = LoadQueue.front();
            LoadQueue.pop();

            auto* PRequester = zoneutils::GetChar(requestPair.first);
            if (!PRequester)
            {
                ShowError("Encountered invalid requester id when loading instance!");
                return;
            }
            auto instanceId = requestPair.second;

            auto loader = std::make_unique<CInstanceLoader>(instanceId, PRequester);
            loader->LoadInstance();
        }
    }

    void LoadInstance(uint16 instanceid, CCharEntity* PRequester)
    {
        LoadQueue.push({ PRequester->id, instanceid });
    }

    InstanceData_t GetInstanceData(uint16 instanceid)
    {
        return InstanceData[instanceid];
    }

    bool IsValidInstanceID(uint16 instanceid)
    {
        return InstanceData.find(instanceid) != InstanceData.end();
    }
}; // namespace instanceutils
