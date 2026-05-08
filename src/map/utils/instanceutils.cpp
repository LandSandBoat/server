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

#include <coroutine>
#include <queue>

namespace instanceutils
{

std::unordered_map<uint16, InstanceData_t> InstanceData;
std::queue<std::pair<uint32, uint16>>      LoadQueue; // player id, instance id
detail::LazyLoadState                      lazyLoad;

namespace
{

auto GetInstancesAssignedToThisProcess(IPP mapIPP) -> std::vector<uint16>
{
    std::vector<uint16> result;

    const auto rset = db::preparedStmt("SELECT instanceid FROM instance_list INNER JOIN zone_settings "
                                       "ON instance_zone = zone_settings.zoneid "
                                       "WHERE IF(? <> 0, ? = zoneip AND ? = zoneport, TRUE)",
                                       mapIPP.getIP(),
                                       mapIPP.getIPString(),
                                       mapIPP.getPort());
    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        result.emplace_back(rset->get<uint16>("instanceid"));
    }

    return result;
}

auto LoadInstances(const std::vector<uint16>& instanceIds) -> void
{
    if (instanceIds.empty())
    {
        return;
    }

    const auto query = fmt::format("SELECT instanceid,instance_name,instance_zone,entrance_zone,"
                                   "time_limit,start_x,start_y,start_z,"
                                   "start_rot,instance_list.music_day,instance_list.music_night,instance_list.battlesolo,"
                                   "instance_list.battlemulti,zone_settings.name AS zone_name "
                                   "FROM instance_list INNER JOIN zone_settings "
                                   "ON instance_zone = zone_settings.zoneid "
                                   "WHERE instanceid IN ({})",
                                   fmt::join(instanceIds, ","));
    const auto rset  = db::preparedStmt(query);

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
        data.instance_zone_name = rset->get<std::string>("zone_name");
        data.entrance_zone_name = rset->get<std::string>("zone_name");
        data.filename           = fmt::format("./scripts/zones/{}/instances/{}.lua", data.instance_zone_name, data.instance_name);

        // Add to data cache
        InstanceData[data.id] = data;

        // Add to Lua cache
        luautils::CacheLuaObjectFromFile(data.filename);
    }
}

} // namespace

// Initialize instance loading: immediate (load all now) or lazy (load on first access)
auto Initialize(MapConfig config) -> void
{
    const auto instanceIds = GetInstancesAssignedToThisProcess(config.ipp);

    if (!config.lazyZones)
    {
        LoadInstances(instanceIds);
        return;
    }

    lazyLoad.enabled          = true;
    lazyLoad.managedInstances = std::set(instanceIds.begin(), instanceIds.end());
}

// NOTE: This used to be multithreaded, but was starting to cause problems with repeated loading
//       and loading in quick succession, so we've swapped it out for a queue which services a
//       single request at the end of every tick.
// TODO: Make this multithreaded and not blocking the main tick loop
auto CheckInstance(Scheduler& scheduler, MapConfig config) -> Task<void>
{
    if (LoadQueue.empty())
    {
        co_return;
    }

    const auto requestPair = LoadQueue.front();
    auto*      PRequester  = zoneutils::GetChar(requestPair.first);
    if (!PRequester)
    {
        ShowError("Encountered invalid requester id when loading instance!");
        LoadQueue.pop();
        co_return;
    }

    const auto instanceId = requestPair.second;
    const auto data       = GetInstanceData(instanceId);

    // CInstanceLoader requires the instance template zone to be loaded.
    const bool zoneReady = co_await zoneutils::IsZoneReady(scheduler, config, data.instance_zone);
    if (!zoneReady)
    {
        co_return;
    }

    LoadQueue.pop();

    auto loader = std::make_unique<CInstanceLoader>(instanceId, PRequester);
    loader->LoadInstance();
}

auto LoadInstance(uint32 instanceid, CCharEntity* PRequester) -> void
{
    LoadQueue.emplace(PRequester->id, instanceid);
}

auto GetInstanceData(uint32 instanceid) -> InstanceData_t
{
    const auto key = static_cast<uint16>(instanceid);

    if (auto it = InstanceData.find(key); it != InstanceData.end())
    {
        return it->second;
    }

    if (lazyLoad.enabled && lazyLoad.managedInstances.contains(key))
    {
        LoadInstances({ key });

        if (auto it = InstanceData.find(key); it != InstanceData.end())
        {
            return it->second;
        }

        ShowWarning("instanceutils::GetInstanceData: managed instanceid %u has no row in instance_list", instanceid);
    }

    return {};
}

auto IsValidInstanceID(uint32 instanceid) -> bool
{
    const auto key = static_cast<uint16>(instanceid);

    if (InstanceData.contains(key))
    {
        return true;
    }

    return lazyLoad.enabled && lazyLoad.managedInstances.contains(key);
}

}; // namespace instanceutils
