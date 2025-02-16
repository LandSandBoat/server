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

#include "common/logging.h"
#include "items/item.h"

#include "lua_item.h"
#include "lua_trade_container.h"
#include "trade_container.h"

//======================================================//

CLuaTradeContainer::CLuaTradeContainer(CTradeContainer* pTrade)
: m_pMyTradeContainer(pTrade)
{
    if (pTrade == nullptr)
    {
        ShowError("CLuaTradeContainer created with nullptr instead of valid CTradeContainer*!");
    }
}

//======================================================//

uint32 CLuaTradeContainer::getGil()
{
    uint16 itemID = m_pMyTradeContainer->getItemID(0);
    return itemID == 0xFFFF ? m_pMyTradeContainer->getQuantity(0) : 0;
}

auto CLuaTradeContainer::getItem(sol::object const& SlotIDObj) -> CItem*
{
    uint8 SlotID = 0;
    if (SlotIDObj.is<uint8>())
    {
        SlotID = SlotIDObj.as<uint8>();
    }

    return m_pMyTradeContainer->getItem(SlotID);
}

//======================================================//

uint16 CLuaTradeContainer::getItemId(sol::object const& SlotIDObj)
{
    uint8 SlotID = 0;
    if (SlotIDObj.is<uint8>())
    {
        SlotID = SlotIDObj.as<uint8>();
    }

    uint16 id    = 0;
    CItem* PItem = m_pMyTradeContainer->getItem(SlotID);
    if (PItem)
    {
        id = PItem->getID();
    }

    return id;
}

//======================================================//

uint16 CLuaTradeContainer::getItemSubId(sol::object const& SlotIDObj)
{
    uint8 SlotID = 0;
    if (SlotIDObj.is<uint8>())
    {
        SlotID = SlotIDObj.as<uint8>();
    }

    uint16 subID = 0;
    CItem* PItem = m_pMyTradeContainer->getItem(SlotID);
    if (PItem)
    {
        subID = PItem->getSubID();
    }

    return subID;
}

//======================================================//

uint32 CLuaTradeContainer::getItemCount()
{
    return m_pMyTradeContainer->getTotalQuantity();
}

//======================================================//

uint8 CLuaTradeContainer::getSlotCount()
{
    return m_pMyTradeContainer->getSlotCount();
}

//======================================================//

uint32 CLuaTradeContainer::getItemQty(uint16 itemID)
{
    return m_pMyTradeContainer->getItemQuantity(itemID);
}

//======================================================//

uint32 CLuaTradeContainer::getSlotQty(uint8 slotID)
{
    return m_pMyTradeContainer->getQuantity(slotID);
}

//======================================================//

bool CLuaTradeContainer::hasItemQty(uint16 itemID, uint32 quantity)
{
    uint32 tradeQuantity = m_pMyTradeContainer->getItemQuantity(itemID);
    return quantity == tradeQuantity;
}

//======================================================//

bool CLuaTradeContainer::confirmItem(uint16 itemID, sol::object const& amountObj)
{
    uint32 amount = amountObj.is<uint32>() ? amountObj.as<uint32>() : 1;

    for (uint8 slotID = 0; slotID < TRADE_CONTAINER_SIZE; ++slotID)
    {
        if (m_pMyTradeContainer->getItemID(slotID) == itemID)
        {
            if (m_pMyTradeContainer->getQuantity(slotID) < amount)
            {
                m_pMyTradeContainer->setConfirmedStatus(slotID, m_pMyTradeContainer->getQuantity(slotID));
                amount -= m_pMyTradeContainer->getQuantity(slotID);
            }
            else
            {
                m_pMyTradeContainer->setConfirmedStatus(slotID, amount);
                return true;
            }
        }
    }
    return false;
}

//======================================================//

bool CLuaTradeContainer::confirmSlot(uint8 slotID, sol::object const& amountObj)
{
    uint32 amount = amountObj.is<uint32>() ? amountObj.as<uint32>() : 1;
    return m_pMyTradeContainer->setConfirmedStatus(slotID, amount);
}

//======================================================//

void CLuaTradeContainer::clean()
{
    m_pMyTradeContainer->Clean();
}

//======================================================//

void CLuaTradeContainer::Register()
{
    SOL_USERTYPE("CTradeContainer", CLuaTradeContainer);
    SOL_REGISTER("getGil", CLuaTradeContainer::getGil);
    SOL_REGISTER("getItem", CLuaTradeContainer::getItem);
    SOL_REGISTER("getItemId", CLuaTradeContainer::getItemId);
    SOL_REGISTER("getItemSubId", CLuaTradeContainer::getItemSubId);
    SOL_REGISTER("getItemCount", CLuaTradeContainer::getItemCount);
    SOL_REGISTER("getSlotCount", CLuaTradeContainer::getSlotCount);
    SOL_REGISTER("getItemQty", CLuaTradeContainer::getItemQty);
    SOL_REGISTER("getSlotQty", CLuaTradeContainer::getSlotQty);
    SOL_REGISTER("hasItemQty", CLuaTradeContainer::hasItemQty);
    SOL_REGISTER("confirmItem", CLuaTradeContainer::confirmItem);
    SOL_REGISTER("confirmSlot", CLuaTradeContainer::confirmSlot);
    SOL_REGISTER("clean", CLuaTradeContainer::clean);
}

std::ostream& operator<<(std::ostream& os, const CLuaTradeContainer& trade)
{
    // TODO: Print out contents of container
    return os << "CLuaTradeContainer";
}

//======================================================//
