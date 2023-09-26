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

class CCharEntity;

namespace monstrosity
{
    struct MonstrosityData_t
    {
    public:
        uint8 Face;
        uint8 Race;

        MonstrosityData_t(uint8 face, uint8 race)
        : Face(face)
        , Race(race)
        {
            //
        }
    };

    void   HandleZoneIn(CCharEntity* PChar);
    uint32 GetPackedMonstrosityName(CCharEntity* PChar);
} // namespace monstrosity
