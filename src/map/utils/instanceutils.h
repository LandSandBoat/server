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

#pragma once

#include "common/cbasetypes.h"

#include "ipc_client.h"

class CCharEntity;

struct InstanceData
{
    uint32      instanceId{};
    std::string instanceName{};
    uint16      instanceZoneId{};
    std::string instanceZoneName{};
    uint16      entranceZoneId{};
    std::string entranceZoneName{};
    uint16      timeLimit{};
    float       startX{};
    float       startY{};
    float       startZ{};
    uint8       startRot{};
    int16       musicDay{};
    int16       musicNight{};
    int16       battleSolo{};
    int16       battleMulti{};
    std::string filename{};
};

namespace instanceutils
{
    void LoadInstanceList();

    // Called at the end of every tick by time_server
    void CheckInstanceLoading();

    void RequestInstance(CCharEntity* PRequester, uint32 instanceId);
    void TryLoadInstance(const ipc::InstanceLoadRequest& message);
    void TrySendToInstance(const ipc::InstanceLoadResponse& message);

    auto GetInstanceData(uint32 instanceId) -> InstanceData;
    auto GetEntraceZoneForInstanceZone(uint16 instanceZoneId) -> uint16;
    bool IsValidInstanceID(uint32 instanceId);
}; // namespace instanceutils
