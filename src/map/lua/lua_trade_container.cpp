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

#include "../../common/showmsg.h"
#include "../items/item.h"

#include "../trade_container.h"
#include "lua_item.h"
#include "lua_trade_container.h"

//======================================================//

CLuaTradeContainer::CLuaTradeContainer(CTradeContainer* pTrade)
{
    m_pMyTradeContainer = pTrade;
}

//======================================================//

inline int32 CLuaTradeContainer::getGil(lua_State* L)
{
    if (m_pMyTradeContainer != nullptr)
    {
        uint16 itemID = m_pMyTradeContainer->getItemID(0);
        lua_pushinteger(L, (itemID == 0xFFFF ? m_pMyTradeContainer->getQuantity(0) : 0));
        return 1;
    }
    lua_pushnil(L);
    return 1;
}

inline int32 CLuaTradeContainer::getItem(lua_State* L)
{
    if (m_pMyTradeContainer != nullptr)
    {
        uint8 SlotID = 0;

        if (!lua_isnil(L, 1) && lua_isnumber(L, 1))
        {
            SlotID = (uint8)lua_tonumber(L, 1);
        }
        lua_getglobal(L, "CTradeContainer");
        lua_pushstring(L, "new");
        lua_gettable(L, -2);
        lua_insert(L, -2);
        lua_pushlightuserdata(L, (void*)m_pMyTradeContainer->getItem(SlotID));

        if (lua_pcall(L, 2, 1, 0))
        {
            return 0;
        }
        return 1;
    }
    lua_pushnil(L);
    return 1;
}

//======================================================//

inline int32 CLuaTradeContainer::getItemId(lua_State* L)
{
    if (m_pMyTradeContainer != nullptr)
    {
        uint8 SlotID = 0;

        if (!lua_isnil(L, 1) && lua_isnumber(L, 1))
        {
            SlotID = (uint8)lua_tonumber(L, 1);
        }
        lua_pushinteger(L, m_pMyTradeContainer->getItemID(SlotID));
        return 1;
    }
    lua_pushnil(L);
    return 1;
}

//======================================================//

inline int32 CLuaTradeContainer::getItemSubId(lua_State* L)
{
    if (m_pMyTradeContainer != nullptr)
    {
        uint8 SlotID = 0;

        if (!lua_isnil(L, 1) && lua_isnumber(L, 1))
        {
            SlotID = (uint8)lua_tonumber(L, 1);
        }
        CItem* PItem = m_pMyTradeContainer->getItem(SlotID);
        if (PItem)
        {
            lua_pushinteger(L, PItem->getSubID());
            return 1;
        }
    }
    lua_pushinteger(L, 0);
    return 1;
}

//======================================================//

inline int32 CLuaTradeContainer::getItemCount(lua_State* L)
{
    if (m_pMyTradeContainer != nullptr)
    {
        lua_pushinteger(L, m_pMyTradeContainer->getTotalQuantity());
        return 1;
    }
    lua_pushnil(L);
    return 1;
}

//======================================================//

inline int32 CLuaTradeContainer::getSlotCount(lua_State* L)
{
    if (m_pMyTradeContainer != nullptr)
    {
        lua_pushinteger(L, m_pMyTradeContainer->getSlotCount());
        return 1;
    }
    lua_pushnil(L);
    return 1;
}

//======================================================//

inline int32 CLuaTradeContainer::getItemQty(lua_State* L)
{
    if (m_pMyTradeContainer != nullptr)
    {
        if (!lua_isnil(L, 1) && lua_isnumber(L, 1))
        {
            uint16 itemID = (uint16)lua_tonumber(L, 1);
            lua_pushinteger(L, m_pMyTradeContainer->getItemQuantity(itemID));
        }
        else
        {
            lua_pushnil(L);
        }
        return 1;
    }
    lua_pushnil(L);
    return 1;
}

//======================================================//

inline int32 CLuaTradeContainer::getSlotQty(lua_State* L)
{
    if (m_pMyTradeContainer != nullptr)
    {
        if (!lua_isnil(L, 1) && lua_isnumber(L, 1))
        {
            uint8 slotID = (uint8)lua_tonumber(L, 1);
            lua_pushinteger(L, m_pMyTradeContainer->getQuantity(slotID));
        }
        else
        {
            lua_pushnil(L);
        }
        return 1;
    }
    lua_pushnil(L);
    return 1;
}

//======================================================//

inline int32 CLuaTradeContainer::hasItemQty(lua_State* L)
{
    if (m_pMyTradeContainer != nullptr)
    {
        if (!lua_isnil(L, -1) && lua_isnumber(L, -1) && !lua_isnil(L, -2) && lua_isnumber(L, -2))
        {
            uint32 quantity = (uint32)lua_tonumber(L, -1);
            uint16 itemID   = (uint16)lua_tonumber(L, -2);

            uint32 tradeQuantity = m_pMyTradeContainer->getItemQuantity(itemID);

            lua_pushboolean(L, (quantity == tradeQuantity));
        }
        else
        {
            lua_pushnil(L);
        }
        return 1;
    }
    lua_pushnil(L);
    return 1;
}

//======================================================//

inline int32 CLuaTradeContainer::confirmItem(lua_State* L)
{
    if (m_pMyTradeContainer != nullptr)
    {
        if (!lua_isnil(L, 1) && lua_isnumber(L, 1))
        {
            uint16 itemID = (uint16)lua_tonumber(L, 1);
            uint32 amount = 1;
            if (lua_isnumber(L, 2))
            {
                amount = (uint32)lua_tonumber(L, 2);
            }
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
                        lua_pushboolean(L, true);
                        return 1;
                    }
                }
            }
            lua_pushboolean(L, false);
            return 1;
        }
    }
    lua_pushnil(L);
    return 1;
}

//======================================================//

inline int32 CLuaTradeContainer::confirmSlot(lua_State* L)
{
    if (m_pMyTradeContainer != nullptr)
    {
        if (!lua_isnil(L, 1) && lua_isnumber(L, 1))
        {
            uint8  slotID = (uint8)lua_tonumber(L, 1);
            uint32 amount = 1;
            if (lua_isnumber(L, 2))
            {
                amount = (uint32)lua_tonumber(L, 2);
            }
            lua_pushboolean(L, m_pMyTradeContainer->setConfirmedStatus(slotID, amount));
            return 1;
        }
    }
    lua_pushnil(L);
    return 1;
}

//======================================================//

void CLuaTradeContainer::Register(sol::state& lua)
{
    SOL_START(CTradeContainer, CLuaTradeContainer)
    SOL_REGISTER(getGil)
    SOL_REGISTER(getItem)
    SOL_REGISTER(getItemId)
    SOL_REGISTER(getItemSubId)
    SOL_REGISTER(getItemCount)
    SOL_REGISTER(getSlotCount)
    SOL_REGISTER(getItemQty)
    SOL_REGISTER(getSlotQty)
    SOL_REGISTER(hasItemQty)
    SOL_REGISTER(confirmItem)
    SOL_REGISTER(confirmSlot)
    SOL_END()
}

//======================================================//
