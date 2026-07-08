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

#include "0x026_item_subcontainer.h"

#include "entities/char_entity.h"
#include "item_container.h"
#include "items/item_equipment.h"

GP_SERV_COMMAND_ITEM_SUBCONTAINER::GP_SERV_COMMAND_ITEM_SUBCONTAINER(const CONTAINER_ID locationId, const uint8_t slotId)
{
    auto& packet = this->data();

    packet.container = locationId;
    packet.index     = slotId;
}

GP_SERV_COMMAND_ITEM_SUBCONTAINER::GP_SERV_COMMAND_ITEM_SUBCONTAINER(const CONTAINER_ID locationId, const uint8_t slotId, const uint16_t headId, const uint16_t bodyId, const uint16_t handsId, const uint16_t legId, const uint16_t feetId, const uint16_t mainId, const uint16_t subId, const uint16_t rangeId)
{
    auto& packet = this->data();

    packet.is_used   = 0x01;
    packet.container = locationId;
    packet.index     = slotId;

    packet.model_id_race_hair = 0x01; // TODO: This is wrong. Mannequins use the same race values as player entities. However, they use a custom face/hair model id of 31.
    packet.model_id_head      = headId + 0x1000;
    packet.model_id_body      = bodyId + 0x2000;
    packet.model_id_hands     = handsId + 0x3000;
    packet.model_id_legs      = legId + 0x4000;
    packet.model_id_feet      = feetId + 0x5000;
    packet.model_id_main      = mainId + 0x6000;
    packet.model_id_sub       = subId + 0x7000;
    packet.model_id_range     = rangeId + 0x8000;
}

GP_SERV_COMMAND_ITEM_SUBCONTAINER::GP_SERV_COMMAND_ITEM_SUBCONTAINER(CCharEntity* PChar, const CONTAINER_ID locationId, const uint8_t slotId, const Exdata::Mannequin& mannequin)
{
    const auto getModelId = [PChar](uint8 slot) -> uint16
    {
        if (slot == 0)
        {
            return 0;
        }

        auto* PItem = PChar->getStorage(LOC_STORAGE)->GetItem(slot);
        if (PItem == nullptr)
        {
            return 0;
        }

        if (const auto* PEquip = dynamic_cast<CItemEquipment*>(PItem))
        {
            return PEquip->getModelId();
        }

        return 0;
    };

    auto& packet = this->data();

    packet.is_used   = 0x01;
    packet.container = locationId;
    packet.index     = slotId;

    packet.model_id_race_hair = 0x01; // TODO: Verify correct format
    packet.model_id_head      = getModelId(mannequin.EquipHead) + 0x1000;
    packet.model_id_body      = getModelId(mannequin.EquipBody) + 0x2000;
    packet.model_id_hands     = getModelId(mannequin.EquipHands) + 0x3000;
    packet.model_id_legs      = getModelId(mannequin.EquipLegs) + 0x4000;
    packet.model_id_feet      = getModelId(mannequin.EquipFeet) + 0x5000;
    packet.model_id_main      = getModelId(mannequin.EquipMain) + 0x6000;
    packet.model_id_sub       = getModelId(mannequin.EquipSub) + 0x7000;
    packet.model_id_range     = getModelId(mannequin.EquipRanged) + 0x8000;
    packet.race               = mannequin.Race;
    packet.pose               = mannequin.Pose;
}
