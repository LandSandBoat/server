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

#include "common/async.h"
#include "common/database.h"
#include "common/logging.h"
#include "common/synchronized.h"

#include "lua/luautils.h"

#include "ipc_client.h"
#include "zone_instance.h"

#include "instanceutils.h"
#include "zoneutils.h"

#include <queue>

namespace
{
    // Instance data loaded on startup
    std::unordered_map<uint32, InstanceData> instanceData_;

    struct LoadRequest
    {
        ipc::InstanceLoadRequest         message;
        std::unique_ptr<CInstanceLoader> loader;
    };

    std::deque<LoadRequest> loadRequestQueue_;
} // namespace

void instanceutils::LoadInstanceList()
{
    // We need to make sure all of the instance data is available on all processes,
    // since we can try and enter an instance from any process - or we might get
    // ejected from an instance onto any other process.

    const auto query =
        "SELECT "
        "instanceid,"
        "instance_name,"
        "instance_zone,"
        "entrance_zone,"
        "time_limit,"
        "start_x,"
        "start_y,"
        "start_z,"
        "start_rot,"
        "instance_list.music_day,"
        "instance_list.music_night,"
        "instance_list.battlesolo,"
        "instance_list.battlemulti "
        "FROM instance_list";

    const auto rset = db::preparedStmt(query);

    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        InstanceData data;

        // Main data
        data.instanceId     = rset->get<uint32>("instanceid");
        data.instanceName   = rset->get<std::string>("instance_name");
        data.instanceZoneId = rset->get<uint16>("instance_zone");
        data.entranceZoneId = rset->get<uint16>("entrance_zone");
        data.timeLimit      = rset->get<uint16>("time_limit");
        data.startX         = rset->get<float>("start_x");
        data.startY         = rset->get<float>("start_y");
        data.startZ         = rset->get<float>("start_z");
        data.startRot       = rset->get<uint8>("start_rot");
        data.musicDay       = rset->get<int16>("music_day");
        data.musicNight     = rset->get<int16>("music_night");
        data.battleSolo     = rset->get<int16>("battlesolo");
        data.battleMulti    = rset->get<int16>("battlemulti");

        // Metadata
        data.instanceZoneName = zoneutils::GetZoneName(data.instanceZoneId);
        data.entranceZoneName = zoneutils::GetZoneName(data.entranceZoneId);
        data.filename         = fmt::format("./scripts/zones/{}/instances/{}.lua", data.instanceZoneName, data.instanceName);

        // Add to data cache
        instanceData_[data.instanceId] = data;

        // Add to Lua cache
        luautils::CacheLuaObjectFromFile(data.filename);
    }
}

void instanceutils::CheckInstanceLoading()
{
    if (loadRequestQueue_.empty())
    {
        return;
    }

    LoadRequest& request = loadRequestQueue_.front();

    request.loader->update();

    if (request.loader->ready())
    {
        message::send(ipc::InstanceLoadResponse{
            .instanceId      = request.message.instanceId,
            .instanceZoneId  = request.message.instanceZoneId,
            .requesterId     = request.message.requesterId,
            .requesterZoneId = request.message.requesterZoneId,
            .status          = 0,
        });

        loadRequestQueue_.pop_front();
    }
}

void instanceutils::RequestInstance(CCharEntity* PRequester, uint32 instanceId)
{
    if (!IsValidInstanceID(instanceId))
    {
        ShowError("Instance ID %d is not valid", instanceId);
        return;
    }

    const auto data = GetInstanceData(instanceId);

    // Ensure the entrance zone and instance zone are both on the same process
    // TODO: Get rid of this requirement
    const auto zonesOnThisProcess        = zoneutils::GetZonesAssignedToThisProcess();
    const auto entranceZoneOnThisProcess = std::find(zonesOnThisProcess.begin(), zonesOnThisProcess.end(), data.entranceZoneId) != zonesOnThisProcess.end();
    const auto instanceZoneOnThisProcess = std::find(zonesOnThisProcess.begin(), zonesOnThisProcess.end(), data.instanceZoneId) != zonesOnThisProcess.end();
    if (!(entranceZoneOnThisProcess && instanceZoneOnThisProcess))
    {
        ShowError("Entrance zone and instance zone for instance ID %d are not on the same process. Aborting.", instanceId);
        return;
    }

    std::vector<uint32> memberIds;

    // clang-format off
    PRequester->ForParty([&](CBattleEntity* PChar)
    {
        memberIds.push_back(PChar->id);
    });
    // clang-format on

    message::send(ipc::InstanceLoadRequest{
        .instanceId      = data.instanceId,
        .instanceZoneId  = data.instanceZoneId,
        .requesterId     = PRequester->id,
        .requesterZoneId = PRequester->loc.zone->GetID(),
        .memberIds       = memberIds,
    });
}

void instanceutils::TryLoadInstance(const ipc::InstanceLoadRequest& message)
{
    loadRequestQueue_.push_back(LoadRequest{
        .message = message,
        .loader  = std::make_unique<CInstanceLoader>(message),
    });
}

void instanceutils::TrySendToInstance(const ipc::InstanceLoadResponse& message)
{
    // TODO: Check status

    auto PZone = zoneutils::GetZone(message.requesterZoneId);
    if (!PZone)
    {
        ShowError("Could not find zone for requester ID %d", message.requesterId);
        return;
    }

    auto PChar = PZone->GetCharByID(message.requesterId);
    if (!PChar)
    {
        ShowError("Could not find char for requester ID %d", message.requesterId);
        return;
    }

    // At this point, we know the requesting zone and instance zone are on the same process
    auto PZoneInstance = dynamic_cast<CZoneInstance*>(zoneutils::GetZone(message.instanceZoneId));
    if (!PZoneInstance)
    {
        ShowError("Could not find instance zone for instance ID %d", message.instanceId);
        return;
    }

    auto PInstance = PZoneInstance->GetInstance(message.requesterId);
    if (!PInstance)
    {
        ShowError("Could not find instance for requester ID %d", message.requesterId);
        return;
    }

    luautils::OnInstanceCreatedCallback(PChar, PInstance);
}

auto instanceutils::GetInstanceData(uint32 instanceId) -> InstanceData
{
    return instanceData_.at(instanceId);
}

auto instanceutils::GetEntraceZoneForInstanceZone(uint16 instanceZoneId) -> uint16
{
    for (const auto& [_, data] : instanceData_)
    {
        if (data.instanceZoneId == instanceZoneId)
        {
            return data.entranceZoneId;
        }
    }

    return 0;
}

bool instanceutils::IsValidInstanceID(uint32 instanceId)
{
    return instanceData_.find(instanceId) != instanceData_.end();
}
