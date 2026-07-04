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

struct Furniture
{
    uint8_t Header;
    uint8_t On2ndFloor : 1;
    uint8_t padding00 : 5;
    uint8_t Installed : 1;
    uint8_t padding01 : 1;
    uint8_t Order; // LSB-only: placement order for moghancement tiebreaking. Not present on retail.
    uint8_t padding02[3];
    uint8_t X;
    uint8_t Z;
    uint8_t Y;
    uint8_t Rotation;
    uint8_t Signature[12];
    uint8_t padding03[2];

    void toTable(sol::table& table) const;
    void fromTable(const sol::table& data);
};

#pragma pack(pop)

} // namespace Exdata
