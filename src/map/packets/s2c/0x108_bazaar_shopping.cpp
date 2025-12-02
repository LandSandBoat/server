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

#include "0x108_bazaar_shopping.h"

#include "entities/charentity.h"

#include <cstring>

GP_SERV_COMMAND_BAZAAR_SHOPPING::GP_SERV_COMMAND_BAZAAR_SHOPPING(const CCharEntity* PChar, const GP_SERV_COMMAND_BAZAAR_SHOPPING_STATE state)
{
    auto& packet = this->data();

    packet.UniqueNo = PChar->id;
    packet.State    = state;
    packet.ActIndex = PChar->targid;

    std::memcpy(packet.sName, PChar->getName().c_str(), std::min<size_t>(PChar->getName().size(), sizeof(packet.sName)));
}
