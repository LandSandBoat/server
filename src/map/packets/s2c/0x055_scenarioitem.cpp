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

#include "0x055_scenarioitem.h"
#include "entities/charentity.h"

GP_SERV_COMMAND_SCENARIOITEM::GP_SERV_COMMAND_SCENARIOITEM(const CCharEntity* PChar, const uint8_t keyTable)
{
    auto& packet = this->data();
    if (keyTable >= PChar->keys.tables.size())
    {
        ShowErrorFmt("Index {} exceeds key items table capacity.", keyTable);
        return;
    }

    std::memcpy(packet.GetItemFlag, &PChar->keys.tables[keyTable].keyList, sizeof(packet.GetItemFlag));
    std::memcpy(packet.LookItemFlag, &PChar->keys.tables[keyTable].seenList, sizeof(packet.LookItemFlag));

    packet.TableIndex = keyTable;
}
