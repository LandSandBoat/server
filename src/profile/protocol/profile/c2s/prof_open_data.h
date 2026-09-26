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

#include "common/cbasetypes.h"

namespace profile
{

#pragma pack(push, 1)

// Opens a profile connection
// Used by MakeOpenData()
struct ProfOpenData
{
    uint8  zero;
    uint8  noCrypt; // 1 when the session is not encrypted; the PC always sends 0
    uint16 padding02;
    uint16 version;     // 1
    uint16 addressHigh; // PS2: __sqPolGetMyIpAddr +2
    uint32 address;     // PS2: __sqPolGetMyIpAddr +4
    uint8  unused0C[28];
};

#pragma pack(pop)

} // namespace profile
