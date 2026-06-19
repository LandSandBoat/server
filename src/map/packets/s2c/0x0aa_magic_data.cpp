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

#include "0x0aa_magic_data.h"

#include <cstring>

#include "entities/charentity.h"
#include "items/item_equipment.h"

GP_SERV_COMMAND_MAGIC_DATA::GP_SERV_COMMAND_MAGIC_DATA(const CCharEntity* PChar)
{
    auto& packet = this->data();

    xi::bitset<1024> spellList = PChar->m_SpellList;

    // Include spells granted by equipped items (ADDS_SPELL modifier)
    for (int i = 0; i < 16; ++i)
    {
        if (auto* PItem = static_cast<CItemEquipment*>(PChar->getEquip(static_cast<SLOTTYPE>(i))))
        {
            auto spellId = static_cast<uint16>(PItem->getModifier(Mod::ADDS_SPELL));
            if (spellId > 0 && spellId < 1024)
            {
                spellList.set(spellId);
            }
        }
    }

    std::memcpy(packet.MagicDataTbl, &spellList, sizeof(packet.MagicDataTbl));
}
