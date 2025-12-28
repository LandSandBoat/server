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

#include "0x0c4_group_comlink_active.h"

#include "entities/charentity.h"
#include "enums/item_lockflg.h"
#include "enums/msg_std.h"
#include "item_container.h"
#include "items.h"
#include "items/item_linkshell.h"
#include "linkshell.h"
#include "packets/char_status.h"
#include "packets/s2c/0x01d_item_same.h"
#include "packets/s2c/0x01f_item_list.h"
#include "packets/s2c/0x020_item_attr.h"
#include "packets/s2c/0x0e0_group_comlink.h"
#include "utils/charutils.h"
#include "utils/itemutils.h"

namespace
{

const auto createLinkshell = [](CCharEntity* PChar, CItemLinkshell* PItemLinkshell, const GP_CLI_COMMAND_GROUP_COMLINK_ACTIVE& data)
{
    uint32_t       linkshellId    = 0;
    const uint16_t linkshellColor = (data.a << 12) | (data.b << 8) | (data.g << 4) | data.r;

    char DecodedName[DecodeStringLength]    = {};
    char EncodedName[LinkshellStringLength] = {};

    const auto encodedRawName = asStringFromUntrustedSource(data.sComLinkName, sizeof(data.sComLinkName));

    DecodeStringLinkshell(encodedRawName, DecodedName);
    EncodeStringLinkshell(DecodedName, EncodedName);

    const auto safeName = db::escapeString(DecodedName);
    linkshellId         = linkshell::RegisterNewLinkshell(safeName, linkshellColor);

    if (linkshellId != 0)
    {
        destroy(PItemLinkshell);
        PItemLinkshell = static_cast<CItemLinkshell*>(itemutils::GetItem(ITEMID::LINKSHELL));
        if (PItemLinkshell == nullptr)
        {
            return;
        }

        PItemLinkshell->setQuantity(1);
        PChar->getStorage(data.Category)->InsertItem(PItemLinkshell, data.ItemIndex);
        PItemLinkshell->SetLSID(linkshellId);
        PItemLinkshell->SetLSType(LSTYPE_LINKSHELL);
        PItemLinkshell->setSignature(EncodedName); // because apparently the format from the packet isn't right, and is missing terminators
        PItemLinkshell->SetLSColor(linkshellColor);

        const auto rset = db::preparedStmt("UPDATE char_inventory SET signature = ?, extra = ?, itemId = 513 WHERE charid = ? AND location = ? AND slot = ? LIMIT 1",
                                           safeName,
                                           PItemLinkshell->m_extra,
                                           PChar->id,
                                           data.Category,
                                           data.ItemIndex);
        if (rset && rset->rowsAffected())
        {
            PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PItemLinkshell, static_cast<CONTAINER_ID>(data.Category), data.ItemIndex);
        }
    }
    else
    {
        PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(MsgStd::LinkshellUnavailable);
    }
};

const auto equipLinkshell = [](CCharEntity* PChar, CItemLinkshell* PItemLinkshell, const GP_CLI_COMMAND_GROUP_COMLINK_ACTIVE& data)
{
    // Capture existing LS so we can unequip it
    SLOTTYPE          slot         = SLOT_LINK1;
    const CLinkshell* oldLinkshell = PChar->PLinkshell1;
    if (data.LinkshellId == 2)
    {
        slot         = SLOT_LINK2;
        oldLinkshell = PChar->PLinkshell2;
    }

    // If the linkshell has been broken, break the item
    const auto rset = db::preparedStmt("SELECT broken FROM linkshells WHERE linkshellid = ? LIMIT 1", PItemLinkshell->GetLSID());
    if (rset && rset->rowsCount() && rset->next() && rset->get<uint8>("broken") == 1)
    {
        PItemLinkshell->SetLSType(LSTYPE_BROKEN);

        db::preparedStmt("UPDATE char_inventory SET extra = ? WHERE charid = ? AND location = ? AND slot = ? LIMIT 1",
                         PItemLinkshell->m_extra,
                         PChar->id,
                         PItemLinkshell->getLocationID(),
                         PItemLinkshell->getSlotID());

        PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PItemLinkshell, static_cast<CONTAINER_ID>(PItemLinkshell->getLocationID()), PItemLinkshell->getSlotID());
        PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>();
        PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(MsgStd::LinkshellNoLongerExists);

        return;
    }

    if (PItemLinkshell->GetLSID() == 0)
    {
        PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(MsgStd::LinkshellNoLongerExists);

        return;
    }

    // Unequip old linkshell
    if (oldLinkshell)
    {
        auto* POldItemLinkshell = reinterpret_cast<CItemLinkshell*>(PChar->getEquip(slot));

        if (POldItemLinkshell && POldItemLinkshell->isType(ITEM_LINKSHELL))
        {
            linkshell::DelOnlineMember(PChar, POldItemLinkshell);

            POldItemLinkshell->setSubType(ITEM_UNLOCKED);
            PChar->pushPacket<GP_SERV_COMMAND_ITEM_LIST>(POldItemLinkshell, ItemLockFlg::Normal);
        }
    }

    // Now equip the new linkshell
    linkshell::AddOnlineMember(PChar, PItemLinkshell, data.LinkshellId);
    PItemLinkshell->setSubType(ITEM_LOCKED);
    PChar->equip[SLOT_BACK + data.LinkshellId]    = data.ItemIndex;
    PChar->equipLoc[SLOT_BACK + data.LinkshellId] = data.Category;
    if (data.LinkshellId == 1)
    {
        PChar->updatemask |= UPDATE_HP;
    }

    PChar->pushPacket<GP_SERV_COMMAND_ITEM_LIST>(PItemLinkshell, ItemLockFlg::Linkshell);
    charutils::SaveCharStats(PChar);
    charutils::SaveCharEquip(PChar);

    PChar->pushPacket<GP_SERV_COMMAND_GROUP_COMLINK>(PChar, data.LinkshellId);
    PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PItemLinkshell, static_cast<CONTAINER_ID>(data.Category), data.ItemIndex);
};

const auto unequipLinkshell = [](CCharEntity* PChar, CItemLinkshell* PItemLinkshell, const GP_CLI_COMMAND_GROUP_COMLINK_ACTIVE& data)
{
    linkshell::DelOnlineMember(PChar, PItemLinkshell);
    PItemLinkshell->setSubType(ITEM_UNLOCKED);
    PChar->equip[SLOT_BACK + data.LinkshellId]    = 0;
    PChar->equipLoc[SLOT_BACK + data.LinkshellId] = 0;
    if (data.LinkshellId == 1)
    {
        PChar->updatemask |= UPDATE_HP;
    }

    PChar->pushPacket<GP_SERV_COMMAND_ITEM_LIST>(PItemLinkshell, ItemLockFlg::Linkshell);
    charutils::SaveCharStats(PChar);
    charutils::SaveCharEquip(PChar);

    PChar->pushPacket<GP_SERV_COMMAND_GROUP_COMLINK>(PChar, data.LinkshellId);
    PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PItemLinkshell, static_cast<CONTAINER_ID>(data.Category), data.ItemIndex);
};

} // namespace

auto GP_CLI_COMMAND_GROUP_COMLINK_ACTIVE::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .range("r", r, 0, 15)
        .range("g", g, 0, 15)
        .range("b", b, 0, 15)
        .mustEqual(a, 15, "a not 15")
        .oneOf<GP_CLI_COMMAND_GROUP_COMLINK_ACTIVE_ACTIVEFLG>(ActiveFlg)
        .oneOf<GP_CLI_COMMAND_GROUP_COMLINK_ACTIVE_LINKSHELLID>(LinkshellId);
}

void GP_CLI_COMMAND_GROUP_COMLINK_ACTIVE::process(MapSession* PSession, CCharEntity* PChar) const
{
    auto* PItemLinkshell = static_cast<CItemLinkshell*>(PChar->getStorage(Category)->GetItem(ItemIndex));

    if (!PItemLinkshell || !PItemLinkshell->isType(ITEM_LINKSHELL))
    {
        return;
    }

    switch (static_cast<GP_CLI_COMMAND_GROUP_COMLINK_ACTIVE_ACTIVEFLG>(ActiveFlg))
    {
        case GP_CLI_COMMAND_GROUP_COMLINK_ACTIVE_ACTIVEFLG::EquipOrCreate:
        {
            if (PItemLinkshell->getID() == ITEMID::NEW_LINKSHELL)
            {
                // Case 1. New Linkshell, create it.
                createLinkshell(PChar, PItemLinkshell, *this);
            }
            else
            {
                // Case 2. Existing LS, equip it.
                equipLinkshell(PChar, PItemLinkshell, *this);
            }
        }
        break;
        case GP_CLI_COMMAND_GROUP_COMLINK_ACTIVE_ACTIVEFLG::Unequip:
        {
            unequipLinkshell(PChar, PItemLinkshell, *this);
        }
        break;
    }

    PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>();
    PChar->pushPacket<CCharStatusPacket>(PChar);
}
