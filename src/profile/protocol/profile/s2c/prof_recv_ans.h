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

#include "enums/prof_error.h"

#include "common/cbasetypes.h"

namespace profile
{

#pragma pack(push, 1)

// Answer header
// Used by __sqProfRecvAns()
struct ProfRecvAns
{
    uint8     code; // retail sends 0x83
    ProfError error;
    uint16    padding02;
    uint32    size;   // bytes that follow (ReadFile: data length + 4)
    uint32    realIp; // redirects every later session to this address when non-zero
    uint8     unused0C[12];
};

#pragma pack(pop)

} // namespace profile
