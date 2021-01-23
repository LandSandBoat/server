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

#include "../instance_loader.h"

#include "instanceutils.h"
#include "zoneutils.h"

#include "../lua/luautils.h"

std::unique_ptr<CInstanceLoader> Loader;

namespace instanceutils
{
    std::unordered_map<uint16, InstanceData_t> InstanceData;

    void LoadInstanceList()
    {
        const char query[] =
            "SELECT "
            "instanceid,"    // 0
            "instance_name," // 1
            "instance_zone," // 2
            "entrance_zone," // 3
            "time_limit,"    // 4
            "start_x,"       // 5
            "start_y,"       // 6
            "start_z,"       // 7
            "start_rot,"     // 8
            "music_day,"     // 9
            "music_night,"   // 10
            "battlesolo,"    // 11
            "battlemulti "   // 12
            "FROM instance_list;";

        int32 ret = Sql_Query(SqlHandle, query);

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                InstanceData_t data;

                // Main data
                data.id            = static_cast<uint16>(Sql_GetIntData(SqlHandle, 0));
                data.instance_name = reinterpret_cast<const char*>(Sql_GetData(SqlHandle, 1));
                data.instance_zone = static_cast<uint16>(Sql_GetIntData(SqlHandle, 2));
                data.entrance_zone = static_cast<uint16>(Sql_GetIntData(SqlHandle, 3));
                data.time_limit    = static_cast<uint16>(Sql_GetIntData(SqlHandle, 4));
                data.start_x       = static_cast<float>(Sql_GetFloatData(SqlHandle, 5));
                data.start_y       = static_cast<float>(Sql_GetFloatData(SqlHandle, 6));
                data.start_z       = static_cast<float>(Sql_GetFloatData(SqlHandle, 7));
                data.start_rot     = static_cast<uint16>(Sql_GetIntData(SqlHandle, 8));
                data.music_day     = static_cast<uint16>(Sql_GetIntData(SqlHandle, 9));
                data.music_night   = static_cast<uint16>(Sql_GetIntData(SqlHandle, 10));
                data.battlesolo    = static_cast<uint16>(Sql_GetIntData(SqlHandle, 11));
                data.battlemulti   = static_cast<uint16>(Sql_GetIntData(SqlHandle, 12));

                // Meta data
                data.instance_zone_name = reinterpret_cast<const char*>(zoneutils::GetZone(data.instance_zone)->GetName());
                data.entrance_zone_name = reinterpret_cast<const char*>(zoneutils::GetZone(data.entrance_zone)->GetName());
                data.filename           = fmt::format("./scripts/zones/{}/instances/{}.lua", data.instance_zone, data.instance_name);

                // Add to data cache
                InstanceData[data.id] = data;

                // Add to Lua cache
                luautils::CacheLuaObjectFromFile(data.filename);
            }
        }
    }

    void CheckInstance()
    {
        if (Loader)
        {
            if (Loader->Check())
            {
                // instance load finished
                Loader.reset();
            }
        }
    }

    void LoadInstance(uint8 instanceid, uint16 zoneid, CCharEntity* PRequester)
    {
        CZone* PZone = zoneutils::GetZone(zoneid);
        if (!Loader && PZone)
        {
            Loader = std::make_unique<CInstanceLoader>(instanceid, PZone, PRequester);
        }
        else
        {
            luautils::OnInstanceCreated(PRequester, nullptr);
        }
    }

    InstanceData_t GetInstanceData(uint8 instanceid)
    {
        return InstanceData[instanceid];
    }
}; // namespace instanceutils
