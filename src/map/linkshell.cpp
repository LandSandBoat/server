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

#include "common/utils.h"

#include <cstring>

#include "packets/char_status.h"
#include "packets/chat_message.h"
#include "packets/message_standard.h"
#include "packets/message_system.h"
#include "packets/s2c/0x01d_item_same.h"
#include "packets/s2c/0x01f_item_list.h"
#include "packets/s2c/0x020_item_attr.h"
#include "packets/s2c/0x0e0_group_comlink.h"

#include "conquest_system.h"
#include "ipc_client.h"
#include "item_container.h"
#include "items/item_linkshell.h"
#include "linkshell.h"

#include "enums/item_lockflg.h"
#include "items.h"
#include "packets/c2s/0x0e2_set_lsmsg.h"
#include "packets/linkshell_message.h"
#include "utils/charutils.h"
#include "utils/itemutils.h"
#include "utils/jailutils.h"
#include "utils/zoneutils.h"

CLinkshell::CLinkshell(uint32 id)
: m_postRights(GP_CLI_COMMAND_SET_LSMSG_WRITELEVEL::Linkshell)
, m_id(id)
, m_color(0)
{
}

uint32 CLinkshell::getID() const
{
    return m_id;
}

uint16 CLinkshell::getColor() const
{
    return m_color;
}

void CLinkshell::setColor(uint16 color)
{
    m_color = color;
}

auto CLinkshell::getPostRights() const -> GP_CLI_COMMAND_SET_LSMSG_WRITELEVEL
{
    return m_postRights;
}

void CLinkshell::setPostRights(const GP_CLI_COMMAND_SET_LSMSG_WRITELEVEL writeLevel)
{
    m_postRights = writeLevel;
    db::preparedStmt("UPDATE linkshells SET postrights = ? WHERE linkshellid = ?", m_postRights, m_id);
}

const std::string& CLinkshell::getName()
{
    return m_name;
}

void CLinkshell::setName(const std::string& name)
{
    m_name = name;
}

void CLinkshell::setMessage(const std::string& message, const std::string& poster)
{
    const auto postTime = earth_time::timestamp();

    if (!db::preparedStmt("UPDATE linkshells SET poster = ?, message = ?, messagetime = ? WHERE linkshellid = ?", poster, message, postTime, m_id))
    {
        ShowError("Failed to update linkshell message for linkshell %u", m_id);
        return;
    }

    if (message.size() != 0)
    {
        message::send(ipc::LinkshellSetMessage{
            .linkshellId   = m_id,
            .linkshellName = m_name,
            .poster        = poster,
            .message       = message,
            .postTime      = 0, // Indicator to look up the LS message
        });
    }
}

// add a character to the list of online members
void CLinkshell::AddMember(CCharEntity* PChar, int8 type, uint8 lsNum)
{
    if (PChar == nullptr)
    {
        return;
    }

    if (std::find(members.begin(), members.end(), PChar) != members.end())
    {
        ShowWarning("CLinkshell::AddMember attempted to add member '%s' who is already in the online member list.", PChar->getName());
        return;
    }

    members.emplace_back(PChar);

    if (lsNum == 1)
    {
        db::preparedStmt("UPDATE accounts_sessions SET linkshellid1 = ?, linkshellrank1 = ? WHERE charid = ?", this->getID(), type, PChar->id);
        PChar->PLinkshell1 = this;
    }
    else
    {
        db::preparedStmt("UPDATE accounts_sessions SET linkshellid2 = ?, linkshellrank2 = ? WHERE charid = ?", this->getID(), type, PChar->id);
        PChar->PLinkshell2 = this;
    }
}

// delete a character to the list of online members
bool CLinkshell::DelMember(CCharEntity* PChar)
{
    for (uint32 i = 0; i < members.size(); ++i)
    {
        if (members.at(i) == PChar)
        {
            if (PChar->PLinkshell1 == this)
            {
                db::preparedStmt("UPDATE accounts_sessions SET linkshellid1 = 0, linkshellrank1 = 0 WHERE charid = ?", PChar->id);
                PChar->PLinkshell1 = nullptr;
            }
            else if (PChar->PLinkshell2 == this)
            {
                db::preparedStmt("UPDATE accounts_sessions SET linkshellid2 = 0, linkshellrank2 = 0 WHERE charid = ?", PChar->id);
                PChar->PLinkshell2 = nullptr;
            }
            members.erase(members.begin() + i);
            break;
        }
    }
    return !members.empty();
}

// Promotes or demotes the target member (pearlsack/linkpearl)
void CLinkshell::ChangeMemberRank(const std::string& MemberName, const uint8 requesterRank, const uint8 newRank)
{
    // 2 = Pearl to sack
    // 3 = Sack to pearl
    if (newRank < 2 || newRank > 3)
    {
        ShowErrorFmt("CLinkshell::ChangeMemberRank: Invalid rank change request for member '{}' in linkshell {}.", MemberName, m_id);
        return;
    }

    if (requesterRank != LSTYPE_LINKSHELL)
    {
        ShowErrorFmt("CLinkshell::ChangeMemberRank: Invalid rank change request for member '{}' in linkshell {}.", MemberName, m_id);
        return;
    }

    const int newId = (ITEMID::LINKSHELL + newRank) - 1;

    if (newId == ITEMID::PEARLSACK || newId == ITEMID::LINKPEARL)
    {
        for (auto& member : members)
        {
            if (strcmpi(MemberName.c_str(), member->getName().c_str()) == 0)
            {
                CCharEntity* PMember = member;

                SLOTTYPE slot = SLOT_LINK1;
                int      lsID = 1;
                if (PMember->PLinkshell2 == this)
                {
                    lsID = 2;
                    slot = SLOT_LINK2;
                }

                CItemLinkshell* PItemLinkshell = (CItemLinkshell*)PMember->getEquip(slot);

                if (PItemLinkshell != nullptr && PItemLinkshell->isType(ITEM_LINKSHELL) && PItemLinkshell->GetLSID() == m_id)
                {
                    CItemLinkshell* newShellItem = (CItemLinkshell*)itemutils::GetItem(newId);
                    if (newShellItem == nullptr)
                    {
                        return;
                    }
                    newShellItem->setQuantity(1);
                    std::memcpy(newShellItem->m_extra, PItemLinkshell->m_extra, 24);
                    newShellItem->SetLSType(newId == ITEMID::PEARLSACK ? LSTYPE_PEARLSACK : LSTYPE_LINKPEARL);
                    newShellItem->setSubType(ITEM_LOCKED);
                    uint8 LocationID = PItemLinkshell->getLocationID();
                    uint8 SlotID     = PItemLinkshell->getSlotID();
                    destroy(PItemLinkshell);

                    PItemLinkshell = newShellItem;
                    PMember->getStorage(LocationID)->InsertItem(PItemLinkshell, SlotID);
                    db::preparedStmt("UPDATE char_inventory SET itemid = ?, extra = ? WHERE charid = ? AND location = ? AND slot = ? LIMIT 1",
                                     PItemLinkshell->getID(), PItemLinkshell->m_extra, PMember->id, LocationID, SlotID);
                    if (lsID == 1)
                    {
                        db::preparedStmt("UPDATE accounts_sessions SET linkshellid1 = ?, linkshellrank1 = ? WHERE charid = ? LIMIT 1",
                                         m_id, static_cast<uint8>(PItemLinkshell->GetLSType()), PMember->id);
                    }
                    else if (lsID == 2)
                    {
                        db::preparedStmt("UPDATE accounts_sessions SET linkshellid2 = ?, linkshellrank2 = ? WHERE charid = ?",
                                         m_id, static_cast<uint8>(PItemLinkshell->GetLSType()), PMember->id);
                    }

                    PMember->pushPacket<GP_SERV_COMMAND_ITEM_LIST>(PItemLinkshell, ItemLockFlg::Normal);
                    PMember->pushPacket<GP_SERV_COMMAND_GROUP_COMLINK>(PMember, lsID);
                    PMember->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PItemLinkshell, static_cast<CONTAINER_ID>(LocationID), SlotID);
                }

                charutils::SaveCharStats(PMember);
                charutils::SaveCharEquip(PMember);

                PMember->pushPacket<GP_SERV_COMMAND_ITEM_SAME>();
                PMember->pushPacket<CCharStatusPacket>(PMember);
                return;
            }
        }
    }
}

// Remove a character from Linkshell by name.
// Breaks all pearls/sacks if, kicked by shell holder, otherwise equipped pearl only.
void CLinkshell::RemoveMemberByName(const std::string& MemberName, uint8 requesterRank, bool breakLinkshell)
{
    uint32 lsid = m_id;
    for (auto& member : members)
    {
        if (strcmpi(MemberName.c_str(), member->getName().c_str()) == 0)
        {
            CCharEntity* PMember = member;

            CItemLinkshell* PItemLinkshell = (CItemLinkshell*)PMember->getEquip(SLOT_LINK1);
            SLOTTYPE        slot           = SLOT_LINK1;
            int             lsNum          = 1;

            if (!PItemLinkshell || (PItemLinkshell->GetLSID() != lsid))
            {
                PItemLinkshell = (CItemLinkshell*)PMember->getEquip(SLOT_LINK2);
                slot           = SLOT_LINK2;
                lsNum          = 2;
            }

            if (PItemLinkshell != nullptr && PItemLinkshell->isType(ITEM_LINKSHELL))
            {
                linkshell::DelOnlineMember(PMember, PItemLinkshell);

                PItemLinkshell->setSubType(ITEM_UNLOCKED);

                PMember->equip[slot] = 0;
                if (slot == SLOT_LINK1)
                {
                    PMember->updatemask |= UPDATE_HP;
                }

                PMember->pushPacket<GP_SERV_COMMAND_ITEM_LIST>(PItemLinkshell, ItemLockFlg::Normal);
                PMember->pushPacket<GP_SERV_COMMAND_GROUP_COMLINK>(PMember, lsNum);
            }

            for (uint8 LocationID = 0; LocationID < CONTAINER_ID::MAX_CONTAINER_ID; ++LocationID)
            {
                CItemContainer* Inventory = PMember->getStorage(LocationID);
                for (uint8 SlotID = 0; SlotID < Inventory->GetSize(); ++SlotID)
                {
                    CItemLinkshell* newPItemLinkshell = (CItemLinkshell*)Inventory->GetItem(SlotID);
                    if (newPItemLinkshell != nullptr && newPItemLinkshell->isType(ITEM_LINKSHELL) && newPItemLinkshell->GetLSID() == lsid)
                    {
                        if (requesterRank == LSTYPE_LINKSHELL || newPItemLinkshell == PItemLinkshell)
                        {
                            if (newPItemLinkshell->GetLSType() != LSTYPE_LINKSHELL)
                            {
                                newPItemLinkshell->SetLSType(LSTYPE_BROKEN);

                                db::preparedStmt("UPDATE char_inventory SET extra = ? WHERE charid = ? AND location = ? AND slot = ? LIMIT 1",
                                                 newPItemLinkshell->m_extra, PMember->id, LocationID, SlotID);

                                PMember->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(newPItemLinkshell, static_cast<CONTAINER_ID>(LocationID), SlotID);
                            }
                        }
                    }
                }
            }

            charutils::SaveCharStats(PMember);
            charutils::SaveCharEquip(PMember);

            PMember->pushPacket<GP_SERV_COMMAND_ITEM_SAME>();
            PMember->pushPacket<CCharStatusPacket>(PMember);
            if (breakLinkshell)
            {
                PMember->pushPacket<CMessageStandardPacket>(MsgStd::LinkshellNoLongerExists);
            }
            else
            {
                PMember->pushPacket<CMessageStandardPacket>(MsgStd::LinkshellKicked);
            }

            return;
        }
    }
}

// Break and unequip all affiliated pearlsacks and linkpearls
void CLinkshell::BreakLinkshell()
{
    uint32 lsid = m_id;

    // break logged in and equipped members
    while (!members.empty())
    {
        RemoveMemberByName(members.at(0)->getName(), LSTYPE_LINKSHELL, true);
    }
    // set the linkshell as broken
    db::preparedStmt("UPDATE linkshells SET broken = 1 WHERE linkshellid = ? LIMIT 1", lsid);
}

// send linkshell message to all online members
void CLinkshell::PushPacket(uint32 senderID, const std::unique_ptr<CBasicPacket>& packet)
{
    for (auto& member : members)
    {
        if (member->id != senderID && member->status != STATUS_TYPE::DISAPPEAR && !jailutils::InPrison(member))
        {
            auto newPacket = packet->copy();
            if (member->PLinkshell2 == this)
            {
                if (newPacket->getType() == CChatMessagePacket::id)
                {
                    newPacket->ref<uint8>(0x04) = MESSAGE_LINKSHELL2;
                }
                else if (newPacket->getType() == CLinkshellMessagePacket::id)
                {
                    newPacket->ref<uint8>(0x05) |= 0x40;
                }
            }
            member->pushPacket(std::move(newPacket));
        }
    }
}

void CLinkshell::PushLinkshellMessage(CCharEntity* PChar, LinkshellSlot slot)
{
    const auto rset = db::preparedStmt("SELECT poster, message, messagetime FROM linkshells WHERE linkshellid = ?", m_id);
    if (rset && rset->rowsCount() && rset->next())
    {
        const auto poster      = rset->getOrDefault<std::string>("poster", "");
        const auto message     = rset->getOrDefault<std::string>("message", "");
        const auto messageTime = rset->getOrDefault<uint32>("messagetime", 0);
        if (!message.empty())
        {
            PChar->pushPacket<CLinkshellMessagePacket>(poster, message, m_name, messageTime, slot);
        }
        // TODO: No message sends a 0xCC packet that prints "No linkshell message set."
    }
}

namespace linkshell
{
    std::map<uint32, std::unique_ptr<CLinkshell>> LinkshellList;

    auto LoadLinkshell(uint32 id) -> CLinkshell*
    {
        const auto rset = db::preparedStmt("SELECT linkshellid, color, name, postrights FROM linkshells WHERE linkshellid = ? LIMIT 1", id);
        if (rset && rset->rowsCount() && rset->next())
        {
            const auto linkshellid = rset->get<uint32>("linkshellid");
            const auto color       = rset->get<uint16>("color");
            const auto name        = rset->get<std::string>("name");
            const auto postrights  = rset->get<GP_CLI_COMMAND_SET_LSMSG_WRITELEVEL>("postrights");

            auto PLinkshell = std::make_unique<CLinkshell>(linkshellid);

            PLinkshell->setColor(color);
            char EncodedName[LinkshellStringLength] = {};

            EncodeStringLinkshell(name.c_str(), EncodedName);
            PLinkshell->setName(EncodedName);
            PLinkshell->setPostRights(postrights);

            LinkshellList[id] = std::move(PLinkshell);
            return LinkshellList[id].get();
        }
        return nullptr;
    }

    // Unloads a loaded linkshell, only used after all members are removed
    void UnloadLinkshell(uint32 id)
    {
        if (auto PLinkshell = LinkshellList.find(id); PLinkshell != LinkshellList.end())
        {
            LinkshellList.erase(id);
        }
    }

    // add character to online linkshell list, used to send messages
    bool AddOnlineMember(CCharEntity* PChar, CItemLinkshell* PItemLinkshell, uint8 lsNum)
    {
        if (PChar == nullptr)
        {
            ShowWarning("PChar is null.");
            return false;
        }

        if (PItemLinkshell != nullptr && PItemLinkshell->isType(ITEM_LINKSHELL))
        {
            CLinkshell* PLinkshell = nullptr;
            if (auto LinkshellListShell = LinkshellList.find(PItemLinkshell->GetLSID()); LinkshellListShell != LinkshellList.end())
            {
                PLinkshell = LinkshellListShell->second.get();
            }
            else
            {
                PLinkshell = LoadLinkshell(PItemLinkshell->GetLSID());
            }
            if (PLinkshell)
            {
                PLinkshell->AddMember(PChar, PItemLinkshell->GetLSType(), lsNum);
            }
        }
        return false;
    }

    // remove online member so we don't try to send messages to them
    bool DelOnlineMember(CCharEntity* PChar, CItemLinkshell* PItemLinkshell)
    {
        if (PChar == nullptr)
        {
            ShowWarning("PChar is null.");
            return false;
        }

        if (PItemLinkshell != nullptr && PItemLinkshell->isType(ITEM_LINKSHELL))
        {
            try
            {
                CLinkshell* Linkshell = LinkshellList.at(PItemLinkshell->GetLSID()).get();
                if (!Linkshell->DelMember(PChar))
                {
                    LinkshellList.erase(PItemLinkshell->GetLSID());
                }
            }
            catch (std::out_of_range& exception)
            {
                ShowError("linkshell::DelOnlineMember caught exception: %s", exception.what());
            }
        }
        return false;
    }

    bool IsValidLinkshellName(const std::string& name)
    {
        const auto rset = db::preparedStmt("SELECT linkshellid FROM linkshells WHERE name = ? AND broken != 1", name);
        return !rset || rset->rowsCount() == 0;
    }

    uint32 RegisterNewLinkshell(const std::string& name, uint16 color)
    {
        if (IsValidLinkshellName(name))
        {
            if (db::preparedStmt("INSERT INTO linkshells (name, color, postrights) VALUES (?, ?, ?)",
                                 name, color, static_cast<uint8>(LSTYPE_PEARLSACK)))
            {
                const auto rset = db::preparedStmt("SELECT linkshellid FROM linkshells WHERE name = ? AND broken != 1", name);
                if (rset && rset->rowsCount() && rset->next())
                {
                    const auto id = rset->get<uint32>("linkshellid");
                    return LoadLinkshell(id)->getID();
                }
            }
        }
        return 0;
    }

    CLinkshell* GetLinkshell(uint32 id)
    {
        if (auto PLinkshell = LinkshellList.find(id); PLinkshell != LinkshellList.end())
        {
            return PLinkshell->second.get();
        }
        else
        {
            return nullptr;
        }
    }
}; // namespace linkshell
