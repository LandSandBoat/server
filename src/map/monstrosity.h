/*
===========================================================================

  Copyright (c) 2023 LandSandBoat Dev Teams

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

#include <array>

class CCharEntity;

namespace monstrosity
{
    struct MonstrosityData_t
    {
    public:
        MonstrosityData_t(uint8 face, uint8 race);

        // TODO: Should these be a single uint16?
        uint8 Face;
        uint8 Race;

        // TODO: Extend this to be large enough to hold Slime and Spriggan levels
        //     : but don't use sizeof() with this structure.
        std::array<uint8, 128> levels{ 0 };
        std::array<uint8, 64>  instincts{ 0 };
        std::array<uint8, 32>  variants{ 0 };
    };

    void   HandleZoneIn(CCharEntity* PChar);
    uint32 GetPackedMonstrosityName(CCharEntity* PChar);
    void   SendFullMonstrosityUpdate(CCharEntity* PChar);
} // namespace monstrosity
