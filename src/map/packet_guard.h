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
#include "packet_system.h"
#include "packets/basic.h"

class CCharEntity;

namespace PacketGuard
{

void Init();
bool PacketIsValidForPlayerState(CCharEntity* PChar, uint16 SmallPD_Type);
bool IsRateLimitedPacket(CCharEntity* PChar, uint16 SmallPD_Type);
bool PacketsArrivingInCorrectOrder(CCharEntity* PChar, uint16 SmallPD_Type);
void PrintPacketList(CCharEntity* PChar);

auto GetPacketAllowList() -> std::unordered_map<CHAR_SUBSTATE, std::unordered_map<uint16, bool>>&;

} // namespace PacketGuard
