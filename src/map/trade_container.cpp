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

#include <string.h>

#include "utils/itemutils.h"
#include "trade_container.h"


CTradeContainer::CTradeContainer()
{
    Clean();
}

CItem* CTradeContainer::getItem(uint8 slotID)
{
    if (slotID < m_PItem.size())
    {
        return m_PItem[slotID];
    }
    return 0;
}

uint16 CTradeContainer::getItemID(uint8 slotID)
{
    if (slotID < m_PItem.size())
    {
        return m_itemID[slotID];
    }
    return 0;
}

uint8 CTradeContainer::getInvSlotID(uint8 slotID)
{
    if (slotID < m_PItem.size())
    {
        return m_slotID[slotID];
    }
    return 0xFF;
}

uint32 CTradeContainer::getQuantity(uint8 slotID)
{
    if (slotID < m_PItem.size())
    {
        return m_quantity[slotID];
    }
    return 0;
}

uint8 CTradeContainer::getConfirmedStatus(uint8 slotID)
{
    if (slotID < m_PItem.size())
    {
        return m_confirmed[slotID];
    }
    return false;
}

uint32 CTradeContainer::getItemQuantity(uint16 itemID)
{
    uint32 quantity = 0;
    for (uint8 slotID = 0; slotID < m_PItem.size(); ++slotID)
    {
        if( m_itemID[slotID] == itemID)
        {
            quantity += m_quantity[slotID];
        }
    }
    return quantity;
}

uint32 CTradeContainer::getTotalQuantity()
{
    uint32 quantity = 0;
    for (uint8 slotID = 0; slotID < m_PItem.size(); ++slotID)
    {
        quantity += (m_itemID[slotID] == 0xFFFF ? 1 : m_quantity[slotID]);
    }
    return quantity;
}

uint8 CTradeContainer::getSlotCount()
{
    uint8 count = 0;
    for (uint8 slotID = 0; slotID < m_PItem.size(); ++slotID)
    {
        if (m_itemID[slotID] != 0)
        {
            count += 1;
        }
    }
    return count;
}

uint8 CTradeContainer::getGuildID(uint8 slotID)
{
    if (slotID < m_PItem.size())
    {
        return m_guildID[slotID];
    }
    return 0;
}

uint16 CTradeContainer::getGuildRank(uint8 slotID)
{
    if (slotID < m_PItem.size())
    {
        return m_guildRank[slotID];
    }
    return 0;
}

void CTradeContainer::setItem(uint8 slotID, CItem* item)
{
    if (slotID < m_PItem.size())
    {
        m_PItem[slotID] = item;
    }
    return;
}

void CTradeContainer::setItemID(uint8 slotID, uint16 itemID)
{
    if (slotID < m_PItem.size())
    {
        m_itemID[slotID] = itemID;
    }
    return;
}

void CTradeContainer::setInvSlotID(uint8 slotID, uint8 invSlotID)
{
    if (slotID < m_PItem.size())
    {
        m_slotID[slotID] = invSlotID;
    }
    return;
}

void CTradeContainer::setQuantity(uint8 slotID, uint32 quantity)
{
    if (slotID < m_PItem.size())
    {
        m_quantity[slotID] = quantity;
    }
    return;
}

bool CTradeContainer::setConfirmedStatus(uint8 slotID, uint32 amount)
{
    if (slotID < m_PItem.size() && m_PItem[slotID] && m_PItem[slotID]->getQuantity() >= amount)
    {
        m_confirmed[slotID] = std::min<uint32>(amount, m_PItem[slotID]->getQuantity());
        return true;
    }
    return false;
}

void CTradeContainer::setItem(uint8 slotID, uint16 itemID, uint8 invSlotID, uint32 quantity, CItem* item)
{
    if (slotID < m_PItem.size())
    {
        m_ItemsCount += 1;

        m_PItem[slotID] = item;
        m_itemID[slotID] = itemID;
        m_slotID[slotID] = invSlotID;
        m_quantity[slotID] = quantity;
    }
    return;
}

void CTradeContainer::setGuildID(uint8 slotID, uint8 guildID)
{
    if (slotID < m_PItem.size())
    {
        m_guildID[slotID] = guildID;
    }
    return;
}

void CTradeContainer::setGuildRank(uint8 slotID, uint16 guildRank)
{
    if (slotID < m_PItem.size())
    {
        m_guildRank[slotID] = guildRank;
    }
    return;
}

uint8 CTradeContainer::getSize()
{
    return (uint8)m_PItem.size();
}

void CTradeContainer::setSize(uint8 size)
{
    m_PItem.resize(size, nullptr);
    m_itemID.resize(size, 0);
    m_slotID.resize(size, 0xFF);
    m_quantity.resize(size, 0);
    m_confirmed.resize(size, 0);
    m_guildID.resize(size, 0);
    m_guildRank.resize(size, 0);
}

uint8 CTradeContainer::getItemsCount()
{
    return m_ItemsCount;
}

void CTradeContainer::setItemsCount(uint8 count)
{
    m_ItemsCount = count;
}

uint8 CTradeContainer::getType()
{
    return m_type;
}

void CTradeContainer::setType(uint8 type)
{
    m_type = type;
}

uint8 CTradeContainer::getCraftType()
{
    return m_craftType;
}

void CTradeContainer::setCraftType(uint8 craftType)
{
    m_craftType = craftType;
}

void CTradeContainer::Clean()
{
    for (auto PItem : m_PItem)
    {
        if (PItem)
        {
            PItem->setReserve(0);
        }
    }
    m_type = 0;
    m_craftType = 0;
    m_ItemsCount = 0;

    m_PItem.clear();
    m_PItem.resize(CONTAINER_SIZE, nullptr);
    m_itemID.clear();
    m_itemID.resize(CONTAINER_SIZE, 0);
    m_slotID.clear();
    m_slotID.resize(CONTAINER_SIZE, 0xFF);
    m_quantity.clear();
    m_quantity.resize(CONTAINER_SIZE, 0);
    m_confirmed.clear();
    m_confirmed.resize(CONTAINER_SIZE, 0);
    m_guildID.clear();
    m_guildID.resize(CONTAINER_SIZE, 0);
    m_guildRank.clear();
    m_guildRank.resize(CONTAINER_SIZE, 0);
}
