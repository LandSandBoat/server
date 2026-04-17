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

#include "0x0fb_myroom_bankin.h"

#include "entities/charentity.h"
#include "enums/item_lockflg.h"
#include "items/exdata/mannequin.h"
#include "items/item_furnishing.h"
#include "lua/luautils.h"
#include "packets/char_status.h"
#include "packets/s2c/0x01c_item_max.h"
#include "packets/s2c/0x01d_item_same.h"
#include "packets/s2c/0x01f_item_list.h"
#include "packets/s2c/0x020_item_attr.h"
#include "packets/s2c/0x026_item_subcontainer.h"
#include "utils/charutils.h"
namespace
{

const std::set<uint8_t> validContainers = { LOC_MOGSAFE, LOC_MOGSAFE2 };

}

auto GP_CLI_COMMAND_MYROOM_BANKIN::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator(PChar)
        .blockedBy({ BlockedState::InEvent })
        .mustNotEqual(this->MyroomItemNo, 0, "MyroomItemNo must not equal 0")
        .oneOf("MyroomCategory", this->MyroomCategory, validContainers);
}

void GP_CLI_COMMAND_MYROOM_BANKIN::process(MapSession* PSession, CCharEntity* PChar) const
{
    const CItemContainer* PItemContainer = PChar->getStorage(this->MyroomCategory);
    if (this->MyroomItemIndex > PItemContainer->GetSize())
    {
        ShowErrorFmt("Invalid slot requested: {}", PChar->getName());
        return;
    }

    CItem* PItem = PItemContainer->GetItem(this->MyroomItemIndex);
    if (PItem == nullptr || !PItem->isType(ITEM_FURNISHING))
    {
        return;
    }

    auto* PFurnishing = static_cast<CItemFurnishing*>(PItem);

    if (PFurnishing->getID() != this->MyroomItemNo)
    {
        ShowErrorFmt("Bankin item id mismatch: {}", PChar->getName());
        return;
    }

    if (!PFurnishing->isInstalled())
    {
        ShowErrorFmt("Bankin requested for an uninstalled item: {}", PChar->getName());
        return;
    }

    PItemContainer          = PChar->getStorage(LOC_STORAGE);
    const uint8 RemovedSize = PItemContainer->GetSize() - std::min<uint8>(PItemContainer->GetSize(), PItemContainer->GetBuff() - PFurnishing->getStorage());
    if (PItemContainer->GetFreeSlotsCount() < RemovedSize)
    {
        ShowError("GP_CLI_COMMAND_MYROOM_BANKIN: furnishing can't be removed");
        return;
    }

    PFurnishing->setInstalled(false);
    PFurnishing->setCol(0);
    PFurnishing->setRow(0);
    PFurnishing->setLevel(0);
    PFurnishing->setRotation(0);

    PFurnishing->setSubType(ITEM_UNLOCKED);

    // If this furniture is a mannequin, clear its appearance and unlock all items that were on it!
    if (PFurnishing->isMannequin())
    {
        PChar->pushPacket<GP_SERV_COMMAND_ITEM_SUBCONTAINER>(static_cast<CONTAINER_ID>(this->MyroomCategory), this->MyroomItemIndex, 0, 0, 0, 0, 0, 0, 0, 0);
        auto&    mannequin = PFurnishing->exdata<Exdata::Mannequin>();
        uint8_t* slots[]   = { &mannequin.EquipMain, &mannequin.EquipSub, &mannequin.EquipRanged, &mannequin.EquipHead, &mannequin.EquipBody, &mannequin.EquipHands, &mannequin.EquipLegs, &mannequin.EquipFeet };
        for (auto* slot : slots)
        {
            if (*slot > 0)
            {
                auto* PEquippedItem = PChar->getStorage(LOC_STORAGE)->GetItem(*slot);
                if (PEquippedItem != nullptr)
                {
                    PChar->pushPacket<GP_SERV_COMMAND_ITEM_LIST>(PEquippedItem, ItemLockFlg::Normal);
                }

                *slot = 0;
            }
        }
    }

    const auto rset = db::preparedStmt("UPDATE char_inventory "
                                       "SET "
                                       "extra = ? "
                                       "WHERE location = ? AND slot = ? AND charid = ? LIMIT 1",
                                       PFurnishing->m_extra,
                                       this->MyroomCategory,
                                       this->MyroomItemIndex,
                                       PChar->id);

    if (rset && rset->rowsAffected())
    {
        const uint8 NewSize = PItemContainer->GetSize() - RemovedSize;
        for (uint8 SlotID = PItemContainer->GetSize(); SlotID > NewSize; --SlotID)
        {
            if (PItemContainer->GetItem(SlotID) != nullptr)
            {
                charutils::MoveItem(PChar, LOC_STORAGE, SlotID, ERROR_SLOTID);
            }
        }

        // Storage mods only apply on the 1st floor
        if (!PFurnishing->getOn2ndFloor())
        {
            PChar->getStorage(LOC_STORAGE)->AddBuff(-(int8)PFurnishing->getStorage());
        }

        PChar->pushPacket<GP_SERV_COMMAND_ITEM_MAX>(PChar);

        luautils::OnFurnitureRemoved(PChar, PFurnishing);

        PChar->loc.zone->SpawnConditionalNPCs(PChar);
    }
    PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PFurnishing, static_cast<CONTAINER_ID>(this->MyroomCategory), PFurnishing->getSlotID());
    PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>(PChar);
}
