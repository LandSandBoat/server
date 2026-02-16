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

#include "instanceutils.h"

#include "common/database.h"
#include "common/logging.h"

#include "lua/luautils.h"

#include "instance_loader.h"
#include "map_engine.h"
#include "zoneutils.h"

#include <queue>

namespace instanceutils
{

std::unordered_map<uint16, InstanceData_t> InstanceData;
std::queue<std::pair<uint32, uint16>>      LoadQueue; // player id, instance id

void LoadInstanceList(IPP mapIPP)
{
    // NOTE:
    // - With `--lazy`, not all zones are instantiated up-front, so we must NOT rely on zoneutils::GetZone()
    //   to resolve zone names here.
    // - We also avoid caching instance lua at startup; the loader and GetCachedInstanceScript handle it on-demand.
    const auto rset = db::preparedStmt("SELECT instanceid,instance_name,instance_zone,entrance_zone,"
                                       "time_limit,start_x,start_y,start_z,"
                                       "start_rot,instance_list.music_day,instance_list.music_night,instance_list.battlesolo,"
                                       "instance_list.battlemulti,"
                                       "instance_zone_settings.name AS instance_zone_name,"
                                       "entrance_zone_settings.name AS entrance_zone_name "
                                       "FROM instance_list "
                                       "INNER JOIN zone_settings AS instance_zone_settings "
                                       "ON instance_zone = instance_zone_settings.zoneid "
                                       "INNER JOIN zone_settings AS entrance_zone_settings "
                                       "ON entrance_zone = entrance_zone_settings.zoneid "
                                       "WHERE IF(? <> 0, ? = instance_zone_settings.zoneip AND ? = instance_zone_settings.zoneport, TRUE)",
                                       mapIPP.getIP(),
                                       mapIPP.getIPString(),
                                       mapIPP.getPort());
    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        InstanceData_t data;

        // Main data
        data.id            = rset->get<uint16>("instanceid");
        data.instance_name = rset->get<std::string>("instance_name");
        data.instance_zone = rset->get<uint16>("instance_zone");
        data.entrance_zone = rset->get<uint16>("entrance_zone");
        data.time_limit    = rset->get<uint16>("time_limit");
        data.start_x       = rset->get<float>("start_x");
        data.start_y       = rset->get<float>("start_y");
        data.start_z       = rset->get<float>("start_z");
        data.start_rot     = rset->get<uint16>("start_rot");
        if (!rset->isNull("music_day"))
        {
            data.music_day = rset->get<uint16>("music_day");
        }

        if (!rset->isNull("music_night"))
        {
            data.music_night = rset->get<uint16>("music_night");
        }

        if (!rset->isNull("battlesolo"))
        {
            data.battlesolo = rset->get<uint16>("battlesolo");
        }

        if (!rset->isNull("battlemulti"))
        {
            data.battlemulti = rset->get<uint16>("battlemulti");
        }

        // Meta data
        data.instance_zone_name = rset->get<std::string>("instance_zone_name");
        data.entrance_zone_name = rset->get<std::string>("entrance_zone_name");
        data.filename           = fmt::format("./scripts/zones/{}/instances/{}.lua", data.instance_zone_name, data.instance_name);

        // Add to data cache
        InstanceData[data.id] = data;
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

        auto* PRequester = zoneutils::GetChar(requestPair.first);
        if (!PRequester)
        {
            LoadQueue.pop();
            ShowError("Encountered invalid requester id when loading instance!");
            return;
        }
        auto instanceId = requestPair.second;

        if (!IsValidInstanceID(instanceId))
        {
            LoadQueue.pop();
            ShowError("Encountered invalid instance id when loading instance! (%u)", instanceId);
            return;
        }

        auto instanceData = GetInstanceData(instanceId);
        // Under --lazy, instance zones may not be loaded yet. Keep the request queued until ready.
        if (!zoneutils::IsZoneReady(instanceData.instance_zone))
        {
            return;
        }

        LoadQueue.pop();

        auto loader = std::make_unique<CInstanceLoader>(instanceId, PRequester);
        loader->LoadInstance();
    }
}

void LoadInstance(uint32 instanceid, CCharEntity* PRequester)
{
    LoadQueue.emplace(PRequester->id, instanceid);
}

InstanceData_t GetInstanceData(uint32 instanceid)
{
    return InstanceData[instanceid];
}

bool IsValidInstanceID(uint32 instanceid)
{
    return InstanceData.find(instanceid) != InstanceData.end();
}

}; // namespace instanceutils
