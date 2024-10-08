/*
===========================================================================

  Copyright (c) 2024 LandSandBoat Dev Teams

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
#include "common/mmo.h"

class CBattleEntity;
class CCharEntity;
class CTrustEntity;

namespace trustutils
{
    void LoadTrustList();
    void FreeTrustList();

    CTrustEntity* SpawnTrust(CCharEntity* PMaster, uint32 TrustID);

    // Internal
    void          BuildTrust(uint32 TrustID);
    CTrustEntity* LoadTrust(CCharEntity* PMaster, uint32 TrustID);
    void          LoadTrustStatsAndSkills(CTrustEntity* PTrust);
}; // namespace trustutils
