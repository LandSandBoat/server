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

#ifndef _INSTANCEUTILS_H
#define _INSTANCEUTILS_H

#include "../../common/cbasetypes.h"

class CInstanceLoader;
class CCharEntity;

struct InstanceData_t
{
    uint16      id;
    std::string instance_name;
    uint16      instance_zone;
    std::string instance_zone_name;
    uint16      entrance_zone;
    std::string entrance_zone_name;
    uint16      time_limit;
    float       start_x;
    float       start_y;
    float       start_z;
    uint16      start_rot;
    uint16      music_day;
    uint16      music_night;
    uint16      battlesolo;
    uint16      battlemulti;
    std::string filename;
};

namespace instanceutils
{
    void LoadInstanceList();
    void CheckInstance();
    void LoadInstance(uint16 instanceid, CCharEntity* PRequester);
    auto GetInstanceData(uint16 instanceid) -> InstanceData_t;
}; // namespace instanceutils

#endif
