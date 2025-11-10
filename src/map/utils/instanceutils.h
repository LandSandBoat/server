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
#include "common/database.h"
#include "common/ipp.h"

class CInstanceLoader;
class CCharEntity;

struct InstanceData_t
{
    uint16                id;
    std::string           instance_name;
    uint16                instance_zone;
    std::string           instance_zone_name;
    uint16                entrance_zone;
    std::string           entrance_zone_name;
    uint16                time_limit;
    float                 start_x;
    float                 start_y;
    float                 start_z;
    uint16                start_rot;
    std::optional<uint16> music_day{ std::nullopt };
    std::optional<uint16> music_night{ std::nullopt };
    std::optional<uint16> battlesolo{ std::nullopt };
    std::optional<uint16> battlemulti{ std::nullopt };
    std::string           filename;

    InstanceData_t()
    : id(0)
    , instance_zone(0)
    , entrance_zone(0)
    , time_limit(0)
    , start_x(0.f)
    , start_y(0.f)
    , start_z(0.f)
    , start_rot(0)
    , music_day(0)
    , music_night(0)
    , battlesolo(0)
    , battlemulti(0)
    {
    }
};

namespace instanceutils
{

void LoadInstanceList(IPP mapIPP);
void CheckInstance(); // Called at the end of every tick by time_server
void LoadInstance(uint32 instanceid, CCharEntity* PRequester);
auto GetInstanceData(uint32 instanceid) -> InstanceData_t;
bool IsValidInstanceID(uint32 instanceid);

}; // namespace instanceutils
