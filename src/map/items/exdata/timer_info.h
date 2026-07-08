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

struct ItemTimerInfo
{
    uint8_t  Header;
    uint8_t  RemainingCharges;
    uint16_t Flags; // TODO: decode flag bits. Retail observations (high byte only, low always 0x00):
                    //   0x80=idle, 0xC0=just used, 0x90=charge consumed/cooldown, 0xD0=cooldown expired
    uint32_t TimeValue1;
    uint32_t TimeValue2;
    uint8_t  Signature[12];

    void toTable(sol::table& table) const;
    void fromTable(const sol::table& data);
};

#pragma pack(pop)

} // namespace Exdata
