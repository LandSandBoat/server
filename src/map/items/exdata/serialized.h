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

#include "enums/exdata.h"

namespace Exdata
{

// Serializes any item without conflicting exdata but the only known retail usage is LuShang +1 and Ebisu +1
#pragma pack(push, 1)

struct Serialized
{
    AugmentKindFlags    AugmentKind;
    AugmentSubKindFlags AugmentSubKind;
    uint16_t            padding00;
    uint8_t             ServerIndex;
    uint8_t             padding01;
    uint16_t            SerialNumber;
    uint8_t             padding02[4];
    uint8_t             Signature[12];

    void toTable(sol::table& table) const;
    void fromTable(const sol::table& data);
};

#pragma pack(pop)

} // namespace Exdata
