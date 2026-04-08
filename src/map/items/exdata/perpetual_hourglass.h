/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include "base.h"

namespace Exdata
{
#pragma pack(push, 1)
struct PerpetualHourglass
{
    uint16_t padding00;
    uint8_t  Flags : 3;
    uint8_t  padding01 : 5;
    uint8_t  padding02[5];
    uint32_t EndTime;
    uint32_t StartTime;
    uint16_t ZoneId;
    uint8_t  padding03[6];

    void toTable(sol::table& table) const;
    void fromTable(const sol::table& data);
};
#pragma pack(pop)
} // namespace Exdata
