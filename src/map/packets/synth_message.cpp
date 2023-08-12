/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "common/socket.h"

#include "entities/charentity.h"
#include "synth_message.h"
#include "trade_container.h"

CSynthMessagePacket::CSynthMessagePacket(CCharEntity* PChar, SYNTH_MESSAGE messageID, uint16 itemID, uint8 quantity)
{
    this->setType(0x6F);
    this->setSize(0x38);

    ref<uint8>(0x04) = messageID;

    if (itemID != 0)
    {
        ref<uint8>(0x06)  = quantity;
        ref<uint16>(0x08) = itemID;
    }

    for (uint8 i = 0; i < 4; i++)
    {
        uint8 skillValue = 0;
        for (uint8 skillID = 49; skillID < 57; skillID++)
        {
            if (skillID == ref<uint8>(0x1A) || skillID == ref<uint8>(0x1B) || skillID == ref<uint8>(0x1C) || skillID == ref<uint8>(0x1D))
            {
                continue;
            }
            if (PChar->CraftContainer->getQuantity(skillID - 40) > skillValue)
            {
                skillValue           = PChar->CraftContainer->getQuantity(skillID - 40);
                ref<uint8>(0x1A + i) = skillID;
            }
        }
    }

    ref<uint16>(0x22) = PChar->CraftContainer->getItemID(0); // crystal

    for (uint8 slotID = 1; slotID <= 8; ++slotID) // recipe materials
    {
        uint16 slotItemID                      = PChar->CraftContainer->getItemID(slotID);
        ref<uint16>(0x24 + ((slotID - 1) * 2)) = slotItemID;

        if (PChar->CraftContainer->getQuantity(slotID) == 0)
        {
            ref<uint16>(0x0A + ((slotID - 1) * 2)) = slotItemID;
        }
    }
}
