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

#include "../common/utils.h"

#include <string.h>

#include "packets/char_update.h"
#include "packets/chat_message.h"
#include "packets/inventory_assign.h"
#include "packets/inventory_finish.h"
#include "packets/inventory_item.h"
#include "packets/linkshell_equip.h"
#include "packets/message_standard.h"
#include "packets/message_system.h"

#include "utils/zoneutils.h"
#include "utils/charutils.h"
#include "conquest_system.h"
#include "utils/itemutils.h"
#include "linkshell.h"
#include "message.h"
#include "items/item_linkshell.h"
#include "utils/jailutils.h"
#include "map.h"
#include "item_container.h"
#include "packets/linkshell_message.h"

/************************************************************************
*                                                                       *
*  Реализация класса CLinkshell                                         *
*                                                                       *
************************************************************************/

CLinkshell::CLinkshell(uint32 id) : m_id(id), m_color(0)
{
}

uint32 CLinkshell::getID()
{
    return m_id;
}

uint16 CLinkshell::getColor()
{
    return m_color;
}

void CLinkshell::setColor(uint16 color)
{
    m_color = color;
}

void CLinkshell::setPostRights(uint8 postrights)
{
    m_postRights = postrights;
    Sql_Query(SqlHandle, "UPDATE linkshells SET postrights = %u WHERE linkshellid = %d;",
        postrights, m_id);
}

const int8* CLinkshell::getName()
{
    return (const int8*)m_name.c_str();
}

void CLinkshell::setName(int8* name)
{
	m_name.clear();
	m_name.insert(0, (const char*)name);
}

void CLinkshell::setMessage(const int8* message, const int8* poster)
{
    char sqlMessage[256];
    Sql_EscapeString(SqlHandle, sqlMessage, (const char*)message);
    Sql_Query(SqlHandle, "UPDATE linkshells SET poster = '%s', message = '%s', messagetime = %u WHERE linkshellid = %d;",
        poster, sqlMessage , static_cast<uint32>(time(nullptr)), m_id);

    int8 packetData[8] {};
    ref<uint32>(packetData, 0) = m_id;
    ref<uint32>(packetData, 4) = 0;
    if (strlen((const char*)message) != 0)
    {
        message::send(MSG_CHAT_LINKSHELL, packetData, sizeof packetData, new CLinkshellMessagePacket(poster, message, (const int8*)m_name.c_str(), std::numeric_limits<uint32>::min(), true));
    }
}

/************************************************************************
*                                                                       *
*  Добавляем персонажа в список активных участников Linkshells          *
*                                                                       *
************************************************************************/

void CLinkshell::AddMember(CCharEntity* PChar, int8 type, uint8 lsNum)
{
    members.push_back(PChar);
    if (lsNum == 1)
    {
        Sql_Query(SqlHandle, "UPDATE accounts_sessions SET linkshellid1 = %u , linkshellrank1 = %u WHERE charid = %u", this->getID(), type, PChar->id);
        PChar->PLinkshell1 = this;
    }
    else
    {
        Sql_Query(SqlHandle, "UPDATE accounts_sessions SET linkshellid2 = %u , linkshellrank2 = %u WHERE charid = %u", this->getID(), type, PChar->id);
        PChar->PLinkshell2 = this;
    }
}

/************************************************************************
*                                                                       *
*  Удаляем персонажа из списка активных участников Linkshells           *
*                                                                       *
************************************************************************/

bool CLinkshell::DelMember(CCharEntity* PChar)
{
    for (uint32 i = 0; i < members.size(); ++i)
	{
        if (members.at(i) == PChar)
        {
            if (PChar->PLinkshell1 == this)
            {
                Sql_Query(SqlHandle, "UPDATE accounts_sessions SET linkshellid1 = 0 , linkshellrank1 = 0 WHERE charid = %u", PChar->id);
                PChar->PLinkshell1 = nullptr;
            }
            else if (PChar->PLinkshell2 == this)
            {
                Sql_Query(SqlHandle, "UPDATE accounts_sessions SET linkshellid2 = 0 , linkshellrank2 = 0 WHERE charid = %u", PChar->id);
                PChar->PLinkshell2 = nullptr;
            }
            members.erase(members.begin() + i);
            break;
        }
    }
    if (members.empty()) { return false; }
    return true;
}

/************************************************************************
*                                                                       *
*  Promotes or demotes the target member		(linkshell)				*
*                                                                       *
************************************************************************/

void CLinkshell::ChangeMemberRank(int8* MemberName, uint8 toSack)
{
	//topearl = 3
	//tosack = 2
	int newId = 512 + toSack;

    if (newId == 514 || newId == 515)
    {
	    for (uint32 i = 0; i < members.size(); ++i)
	    {
		    if (strcmp((const char*)MemberName, (const char*)members.at(i)->GetName()) == 0)
		    {
                CCharEntity* PMember = (CCharEntity*)members.at(i);

                SLOTTYPE slot = SLOT_LINK1;
                int lsID = 1;
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
                        return;
                    newShellItem->setQuantity(1);
                    memcpy(newShellItem->m_extra, PItemLinkshell->m_extra, 24);
                    newShellItem->SetLSType(newId == 514 ? LSTYPE_PEARLSACK : LSTYPE_LINKPEARL);
                    newShellItem->setSubType(ITEM_LOCKED);
                    uint8 LocationID = PItemLinkshell->getLocationID();
                    uint8 SlotID = PItemLinkshell->getSlotID();
                    delete PItemLinkshell;
                    PItemLinkshell = newShellItem;
                    char extra[sizeof(PItemLinkshell->m_extra) * 2 + 1];
                    Sql_EscapeStringLen(SqlHandle, extra, (const char*)PItemLinkshell->m_extra, sizeof(PItemLinkshell->m_extra));

                    PMember->getStorage(LocationID)->InsertItem(PItemLinkshell, SlotID);
                    const char* Query = "UPDATE char_inventory SET itemid = %u, extra = '%s' WHERE charid = %u AND location = %u AND slot = %u LIMIT 1";
                    Sql_Query(SqlHandle, Query, PItemLinkshell->getID(), extra, PMember->id, LocationID, SlotID);
                    if (lsID == 1)
                    {
                        Sql_Query(SqlHandle, "UPDATE accounts_sessions SET linkshellid1 = %u , linkshellrank1 = %u WHERE charid = %u",
                            m_id, static_cast<uint8>(PItemLinkshell->GetLSType()), PMember->id);
                    }
                    else if (lsID == 2)
                    {
                        Sql_Query(SqlHandle, "UPDATE accounts_sessions SET linkshellid2 = %u , linkshellrank2 = %u WHERE charid = %u",
                            m_id, static_cast<uint8>(PItemLinkshell->GetLSType()), PMember->id);
                    }

                    PMember->pushPacket(new CInventoryAssignPacket(PItemLinkshell, INV_NORMAL));
                    PMember->pushPacket(new CLinkshellEquipPacket(PMember, lsID));
                    PMember->pushPacket(new CInventoryItemPacket(PItemLinkshell, LocationID, SlotID));
                }

                charutils::SaveCharStats(PMember);
                charutils::SaveCharEquip(PMember);

                PMember->pushPacket(new CInventoryFinishPacket());
                PMember->pushPacket(new CCharUpdatePacket(PMember));
			    return;
		    }
	    }
    }
}

/************************************************************************
*                                                                       *
* Remove a character from Linkshell by name. Breaks all pearls/sacks if *
* kicked by shell holder, otherwise equipped pearl only.                *
*                                                                       *
************************************************************************/

void CLinkshell::RemoveMemberByName(int8* MemberName, uint8 kickerRank, bool breakLinkshell)
{
    uint32 lsid = m_id;
	for (uint32 i = 0; i < members.size(); ++i)
	{
		if (strcmp((const char*)MemberName, (const char*)members.at(i)->GetName()) == 0)
		{
            CCharEntity* PMember = (CCharEntity*)members.at(i);

            CItemLinkshell* PItemLinkshell = (CItemLinkshell*)PMember->getEquip(SLOT_LINK1);
            SLOTTYPE slot = SLOT_LINK1;
            int lsNum = 1;

            if (!PItemLinkshell || (PItemLinkshell->GetLSID() != lsid))
            {
                PItemLinkshell = (CItemLinkshell*)PMember->getEquip(SLOT_LINK2);
                slot = SLOT_LINK2;
                lsNum = 2;
            }

            if (PItemLinkshell != nullptr && PItemLinkshell->isType(ITEM_LINKSHELL))
            {
                linkshell::DelOnlineMember(PMember, PItemLinkshell);

                PItemLinkshell->setSubType(ITEM_UNLOCKED);

                PMember->equip[slot] = 0;
                if (slot == SLOT_LINK1)
                {
                    PMember->nameflags.flags &= ~FLAG_LINKSHELL;
                    PMember->updatemask |= UPDATE_HP;
                }

                PMember->pushPacket(new CInventoryAssignPacket(PItemLinkshell, INV_NORMAL));
                PMember->pushPacket(new CLinkshellEquipPacket(PMember,lsNum));
            }

            for (uint8 LocationID = 0; LocationID < MAX_CONTAINER_ID; ++LocationID)
            {
                CItemContainer* Inventory = PMember->getStorage(LocationID);
                for (uint8 SlotID = 0; SlotID < Inventory->GetSize(); ++SlotID)
                {
                    CItemLinkshell* newPItemLinkshell = (CItemLinkshell*)Inventory->GetItem(SlotID);
                    if (newPItemLinkshell != nullptr && newPItemLinkshell->isType(ITEM_LINKSHELL) && newPItemLinkshell->GetLSID() == lsid)
                    {
                        if (kickerRank == LSTYPE_LINKSHELL || newPItemLinkshell == PItemLinkshell)
                        {
                            if (newPItemLinkshell->GetLSType() != LSTYPE_LINKSHELL)
                            {
                                newPItemLinkshell->SetLSType(LSTYPE_BROKEN);
                                char extra[sizeof(newPItemLinkshell->m_extra) * 2 + 1];
                                Sql_EscapeStringLen(SqlHandle, extra, (const char*)newPItemLinkshell->m_extra, sizeof(newPItemLinkshell->m_extra));
                                const char* Query = "UPDATE char_inventory SET extra = '%s' WHERE charid = %u AND location = %u AND slot = %u LIMIT 1";
                                Sql_Query(SqlHandle, Query, extra, PMember->id, LocationID, SlotID);
                                PMember->pushPacket(new CInventoryItemPacket(newPItemLinkshell, LocationID, SlotID));
                            }
                        }
                    }
                }
            }

            charutils::SaveCharStats(PMember);
            charutils::SaveCharEquip(PMember);

            PMember->pushPacket(new CInventoryFinishPacket());
            PMember->pushPacket(new CCharUpdatePacket(PMember));
            if (breakLinkshell)
            {
                PMember->pushPacket(new CMessageStandardPacket(MsgStd::LinkshellNoLongerExists));
            }
            else
            {
                PMember->pushPacket(new CMessageStandardPacket(MsgStd::LinkshellKicked));
            }
            
			return;
		}
	}
}

/************************************************************************
*                                                                       *
*  Break and unequip all affiliated pearlsacks and linkpearls           *
*                                                                       *
************************************************************************/

void CLinkshell::BreakLinkshell(int8* lsname, bool gm)
{
    uint32 lsid = m_id;
    int8 signature[21];
    DecodeStringLinkshell(lsname, signature);

    // break logged in and equipped members
	while (members.size() > 0)
	{
        RemoveMemberByName((int8*)members.at(0)->GetName(), LSTYPE_LINKSHELL, true);
    }
    // set the linkshell as broken
    Sql_Query(SqlHandle, "UPDATE linkshells SET broken = 1 WHERE linkshellid = %u LIMIT 1", lsid);
}

/************************************************************************
*                                                                       *
*  Отправляем пакет всем членам Linkshells, за исключением PChar        *
*                                                                       *
************************************************************************/

void CLinkshell::PushPacket(uint32 senderID, CBasicPacket* packet)
{
    for (uint32 i = 0; i < members.size(); ++i)
	{
        if (members.at(i)->id != senderID &&
            members.at(i)->status != STATUS_DISAPPEAR &&
            !jailutils::InPrison(members.at(i)))
		{
            CBasicPacket* newPacket = new CBasicPacket(*packet);
            if (members.at(i)->PLinkshell2 == this)
            {
                if (newPacket->id() == CChatMessagePacket::id)
                {
                    newPacket->ref<uint8>(0x04) = MESSAGE_LINKSHELL2;
                }
                else if (newPacket->id() == CLinkshellMessagePacket::id)
                {
                    newPacket->ref<uint8>(0x05) |= 0x40;
                }
            }
            members.at(i)->pushPacket(newPacket);
		}
	}
    delete packet;
}

void CLinkshell::PushLinkshellMessage(CCharEntity* PChar, bool ls1)
{
    auto ret = Sql_Query(SqlHandle, "SELECT poster, message, messagetime FROM linkshells WHERE linkshellid = %u", m_id);

    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        PChar->pushPacket(new CLinkshellMessagePacket(Sql_GetData(SqlHandle, 0), Sql_GetData(SqlHandle, 1),
            (const int8*)m_name.c_str(), Sql_GetUIntData(SqlHandle, 2), ls1));
    }
}

/************************************************************************
*                                                                       *
*  Реализация namespase для работы с Linkshells                         *
*                                                                       *
************************************************************************/

namespace linkshell
{
    std::map<uint32, std::unique_ptr<CLinkshell>> LinkshellList;

    /************************************************************************
    *                                                                       *
    *  Загружаем список зарегистрированных Linkshells                       *
    *                                                                       *
    ************************************************************************/

    CLinkshell* LoadLinkshell(uint32 id)
    {
	    int32 ret = Sql_Query(SqlHandle, "SELECT linkshellid, color, name, postrights FROM linkshells WHERE linkshellid = %d", id);

	    if( ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
	    {
            auto PLinkshell = std::make_unique<CLinkshell>(Sql_GetUIntData(SqlHandle,0));

            PLinkshell->setColor(Sql_GetIntData(SqlHandle,1));
            int8 EncodedName[16];
            EncodeStringLinkshell(Sql_GetData(SqlHandle,2), EncodedName);
            PLinkshell->setName(EncodedName);
            if (Sql_GetUIntData(SqlHandle,3) < LSTYPE_LINKSHELL || Sql_GetUIntData(SqlHandle,3) > LSTYPE_LINKPEARL)
            {
                PLinkshell->setPostRights(LSTYPE_PEARLSACK);
            }
            else
            {
                PLinkshell->m_postRights = Sql_GetUIntData(SqlHandle,3);
            }
            LinkshellList[id] = std::move(PLinkshell);
            return LinkshellList[id].get();
	    }
        return nullptr;
    }

    /************************************************************************
    *                                                                       *
    *  Unloads a loaded linkshell, only used after all members are removed  *
    *                                                                       *
    ************************************************************************/

    void UnloadLinkshell(uint32 id)
    {
        if (auto PLinkshell = LinkshellList.find(id); PLinkshell != LinkshellList.end())
        {
            LinkshellList.erase(id);
        }
    }

    /************************************************************************
    *                                                                       *
    *  Добавляем персонажа в список Linkshell                               *
    *                                                                       *
    ************************************************************************/

    bool AddOnlineMember(CCharEntity* PChar, CItemLinkshell* PItemLinkshell, uint8 lsNum)
    {
        TPZ_DEBUG_BREAK_IF(PChar == nullptr);
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

    /************************************************************************
    *                                                                       *
    *  Удаляем персонажа из списка Lilkshell                                *
    *                                                                       *
    ************************************************************************/

    bool DelOnlineMember(CCharEntity* PChar, CItemLinkshell* PItemLinkshell)
    {
        TPZ_DEBUG_BREAK_IF(PChar == nullptr);
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
            catch (std::out_of_range&)
            {
            }
        }
        return false;
    }

    /************************************************************************
    *                                                                       *
    *  Проверяем строку на возможность использования в качестве имени LS    *
    *                                                                       *
    ************************************************************************/

    bool IsValidLinkshellName(const int8* name)
    {
        auto ret = Sql_Query(SqlHandle, "SELECT linkshellid FROM linkshells WHERE name = '%s' AND broken != 1;", name);
        return ret == SQL_ERROR || Sql_NumRows(SqlHandle) == 0;
    }

    /************************************************************************
    *                                                                       *
    *  Регистрируем новую linkshell                                         *
    *                                                                       *
    ************************************************************************/

    uint32 RegisterNewLinkshell(const int8* name, uint16 color)
    {
        if (IsValidLinkshellName(name))
        {
		    if (Sql_Query(SqlHandle, "INSERT INTO linkshells (name, color, postrights) VALUES ('%s', %u, %u)", name, color, static_cast<uint8>(LSTYPE_PEARLSACK)) != SQL_ERROR)
            {
                return LoadLinkshell((uint32)Sql_LastInsertId(SqlHandle))->getID();
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
};
