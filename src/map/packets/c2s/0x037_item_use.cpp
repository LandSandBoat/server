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

#include "0x037_item_use.h"

#include "ai/ai_container.h"
#include "entities/charentity.h"
#include "packets/s2c/0x029_battle_message.h"
#include "universal_container.h"

namespace
{

const std::set validContainers = {
    LOC_INVENTORY,
    LOC_TEMPITEMS,
    LOC_WARDROBE,
    LOC_WARDROBE2,
    LOC_WARDROBE3,
    LOC_WARDROBE4,
    LOC_WARDROBE5,
    LOC_WARDROBE6,
    LOC_WARDROBE7,
    LOC_WARDROBE8
};

}

auto GP_CLI_COMMAND_ITEM_USE::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .isNotMonstrosity(PChar)
        .mustEqual(PChar->inMogHouse(), false, "Player is in moghouse")
        .mustEqual(this->ItemNum, 0, "ItemNum not 0")
        .oneOf("Category", static_cast<CONTAINER_ID>(this->Category), validContainers);
}

void GP_CLI_COMMAND_ITEM_USE::process(MapSession* PSession, CCharEntity* PChar) const
{
    auto* PEntity = PChar->GetEntity(this->ActIndex);
    if (!PEntity)
    {
        return;
    }

    // 12 yalm is about the maximum distance for Soultrapper.
    // TODO: Test more items
    if (distance(PChar->loc.p, PEntity->loc.p) > 12.0f)
    {
        PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PEntity, 0, 0, MsgBasic::TOO_FAR_AWAY);
        return;
    }

    const auto* PItem = PChar->getStorage(this->Category)->GetItem(this->PropertyItemIndex);
    if (!PItem)
    {
        return;
    }

    // Equipment can be locked (equipped state) and still usable, but must actually be equipped
    // Non-equipment items should never be locked
    auto isEquipped = [&]() -> bool
    {
        for (uint8 slot = 0; slot < 18; ++slot)
        {
            if (PChar->equipLoc[slot] == this->Category && PChar->equip[slot] == this->PropertyItemIndex)
            {
                return true;
            }
        }

        return false;
    };

    const bool isEquipment = PItem->isType(ITEM_WEAPON) || PItem->isType(ITEM_EQUIPMENT);
    const bool isLocked    = PItem->isSubType(ITEM_LOCKED) && !(isEquipment && isEquipped());
    if (isLocked ||
        PItem->getReserve() > 0 ||
        PItem->getCharPrice() > 0)
    {
        ShowWarningFmt("GP_CLI_COMMAND_ITEM_USE: {} trying to use invalid item (locked/reserved/bazaared)", PChar->getName());
        return;
    }

    // TODO: Using a charged item on a non-eligible target (i.e. Soultrapper): Cannot use the <item> on <target>.
    if (PChar->UContainer->GetType() != UCONTAINER_USEITEM)
    {
        PChar->PAI->UseItem(this->ActIndex, this->Category, this->PropertyItemIndex);
    }
    else
    {
        PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MsgBasic::UNABLE_TO_USE_ITEM);
    }
}
