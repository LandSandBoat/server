/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include "basic.h"

class CCharEntity;
class CTrustEntity;
class CAlliance;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x00E2
class CPartyMemberDefinePacket : public CBasicPacket
{
public:
    CPartyMemberDefinePacket(CCharEntity* PChar, uint8 MemberNumber, uint16 memberflags, uint16 zoneid);
    CPartyMemberDefinePacket(CTrustEntity* PTrust, uint8 MemberNumber);
    CPartyMemberDefinePacket(uint32 id, const std::string& name, uint16 memberFlags, uint8 MemberNumber, uint16 ZoneID);
};
