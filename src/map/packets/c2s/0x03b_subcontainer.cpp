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

#include "0x03b_subcontainer.h"

#include "entities/charentity.h"
#include "enums/item_lockflg.h"
#include "items/item_equipment.h"
#include "packets/s2c/0x01d_item_same.h"
#include "packets/s2c/0x01f_item_list.h"
#include "packets/s2c/0x020_item_attr.h"
#include "packets/s2c/0x026_item_subcontainer.h"

namespace
{

const auto setStatusOfStorageItemAtSlot = [](CCharEntity* PChar, const uint8 slot, ItemLockFlg status) -> void
{
    if (PChar == nullptr || slot == 0)
    {
        return;
    }

    auto* PItem = PChar->getStorage(LOC_STORAGE)->GetItem(slot);
    if (PItem == nullptr)
    {
        return;
    }

    PChar->pushPacket<GP_SERV_COMMAND_ITEM_LIST>(PItem, status);
};

// Build Mannequin model id list
const auto getModelIdFromStorageSlot = [](const CCharEntity* PChar, const uint8 slot) -> uint16
{
    uint16 modelId = 0x0000;

    if (slot == 0)
    {
        return modelId;
    }

    auto* PItem = PChar->getStorage(LOC_STORAGE)->GetItem(slot);
    if (PItem == nullptr)
    {
        return modelId;
    }

    if (const auto* PItemEquipment = dynamic_cast<CItemEquipment*>(PItem))
    {
        modelId = PItemEquipment->getModelId();
    }

    return modelId;
};

const auto validContainers = [](const CCharEntity* PChar) -> std::set<CONTAINER_ID>
{
    std::set allowedContainers = {
        LOC_MOGSAFE
    };

    // Bitflag indicating if Mog 2F is unlocked
    if (PChar->profile.mhflag & 0x20)
    {
        allowedContainers.insert(LOC_MOGSAFE2);
    }

    return allowedContainers;
};

} // namespace

auto GP_CLI_COMMAND_SUBCONTAINER::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .mustEqual(PChar->m_moghouseID, PChar->id, "Character not in their mog house")
        .oneOf<GP_CLI_COMMAND_SUBCONTAINER_KIND>(Kind)
        .oneOf<GP_CLI_COMMAND_SUBCONTAINER_CONTAINERINDEX>(ContainerIndex)
        .oneOf("Category1", static_cast<CONTAINER_ID>(Category1), validContainers(PChar));
}

void GP_CLI_COMMAND_SUBCONTAINER::process(MapSession* PSession, CCharEntity* PChar) const
{
    auto* PMannequin = PChar->getStorage(Category1)->GetItem(ItemIndex1);
    if (PMannequin == nullptr)
    {
        ShowWarning("GP_CLI_COMMAND_SUBCONTAINER: Unable to load mannequin from slot %u in location %u by %s", ItemIndex1, Category1, PChar->getName());
        return;
    }

    switch (static_cast<GP_CLI_COMMAND_SUBCONTAINER_KIND>(Kind))
    {
        case GP_CLI_COMMAND_SUBCONTAINER_KIND::Equip:
        {
            if (Category2 != LOC_STORAGE) // Only valid for direct equip/unequip
            {
                ShowWarning("GP_CLI_COMMAND_SUBCONTAINER: Invalid item location passed to Mannequin Equip packet %u by %s", Category2, PChar->getName());
                return;
            }

            // Action 1 Unequip Hack: Does this need to exist?
            if (PMannequin->m_extra[10 + ContainerIndex] == ItemIndex2)
            {
                setStatusOfStorageItemAtSlot(PChar, ItemIndex2, ItemLockFlg::Normal);
                PMannequin->m_extra[10 + ContainerIndex] = 0;
            }
            else // Regular Logic
            {
                setStatusOfStorageItemAtSlot(PChar, ItemIndex2, ItemLockFlg::Mannequin);
                PMannequin->m_extra[10 + ContainerIndex] = ItemIndex2;
            }
        }
        break;
        case GP_CLI_COMMAND_SUBCONTAINER_KIND::Unequip:
        {
            setStatusOfStorageItemAtSlot(PChar, ItemIndex2, ItemLockFlg::Normal);
            PMannequin->m_extra[10 + ContainerIndex] = 0;
        }
        break;
        case GP_CLI_COMMAND_SUBCONTAINER_KIND::UnequipAll:
        {
            for (uint8 i = 0; i < 8; ++i)
            {
                if (PMannequin->m_extra[10 + i] > 0)
                {
                    setStatusOfStorageItemAtSlot(PChar, PMannequin->m_extra[10 + i], ItemLockFlg::Normal);
                }
                PMannequin->m_extra[10 + i] = 0;
            }
        }
        break;
    }

    uint16 mainId  = getModelIdFromStorageSlot(PChar, PMannequin->m_extra[10 + 0]);
    uint16 subId   = getModelIdFromStorageSlot(PChar, PMannequin->m_extra[10 + 1]);
    uint16 rangeId = getModelIdFromStorageSlot(PChar, PMannequin->m_extra[10 + 2]);
    uint16 headId  = getModelIdFromStorageSlot(PChar, PMannequin->m_extra[10 + 3]);
    uint16 bodyId  = getModelIdFromStorageSlot(PChar, PMannequin->m_extra[10 + 4]);
    uint16 handsId = getModelIdFromStorageSlot(PChar, PMannequin->m_extra[10 + 5]);
    uint16 legId   = getModelIdFromStorageSlot(PChar, PMannequin->m_extra[10 + 6]);
    uint16 feetId  = getModelIdFromStorageSlot(PChar, PMannequin->m_extra[10 + 7]);

    // TODO: (?)
    // 10 + 8 = Race
    // 10 + 9 = Pose

    const auto rset = db::preparedStmt("UPDATE char_inventory "
                                       "SET "
                                       "extra = ? "
                                       "WHERE location = ? AND slot = ? AND charid = ?",
                                       PMannequin->m_extra,
                                       Category1,
                                       ItemIndex1,
                                       PChar->id);
    if (rset)
    {
        PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PMannequin, static_cast<CONTAINER_ID>(Category1), ItemIndex1);
        PChar->pushPacket<GP_SERV_COMMAND_ITEM_SUBCONTAINER>(static_cast<CONTAINER_ID>(Category1), ItemIndex1, headId, bodyId, handsId, legId, feetId, mainId, subId, rangeId);
        PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>();
    }
    else
    {
        ShowError("GP_CLI_COMMAND_SUBCONTAINER: Problem writing Mannequin to database!");
    }
}
