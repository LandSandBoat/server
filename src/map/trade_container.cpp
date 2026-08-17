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

#include <cstring>

#include "trade_container.h"
#include "utils/itemutils.h"

CTradeContainer::CTradeContainer()
{
    Clean();
}

uint16 CTradeContainer::getItemID(uint8 slotID)
{
    if (slotID < m_itemID.size())
    {
        return m_itemID[slotID];
    }
    return 0;
}

uint8 CTradeContainer::getInvSlotID(uint8 slotID)
{
    if (slotID < m_itemID.size())
    {
        return m_slotID[slotID];
    }
    return 0xFF;
}

uint32 CTradeContainer::getQuantity(uint8 slotID)
{
    if (slotID < m_itemID.size())
    {
        return m_quantity[slotID];
    }
    return 0;
}

uint32 CTradeContainer::getItemQuantity(uint16 itemID)
{
    uint32 quantity = 0;
    for (std::size_t slotID = 0; slotID < m_itemID.size(); ++slotID)
    {
        if (m_itemID[slotID] == itemID)
        {
            quantity += m_quantity[slotID];
        }
    }
    return quantity;
}

uint32 CTradeContainer::getTotalQuantity()
{
    uint32 quantity = 0;
    for (std::size_t slotID = 0; slotID < m_itemID.size(); ++slotID)
    {
        quantity += (m_itemID[slotID] == 0xFFFF ? 1 : m_quantity[slotID]);
    }
    return quantity;
}

uint8 CTradeContainer::getSlotCount()
{
    uint8 count = 0;
    for (std::size_t slotID = 0; slotID < m_itemID.size(); ++slotID)
    {
        if (m_itemID[slotID] != 0)
        {
            count += 1;
        }
    }
    return count;
}

auto CTradeContainer::getRestriction(uint8 slotID) const -> SlotRestriction
{
    if (slotID < m_itemID.size())
    {
        return restrictions_[slotID];
    }

    return std::monostate{};
}

void CTradeContainer::setItemID(uint8 slotID, uint16 itemID)
{
    if (slotID < m_itemID.size())
    {
        m_itemID[slotID] = itemID;
    }
}

void CTradeContainer::setInvSlotID(uint8 slotID, uint8 invSlotID)
{
    if (slotID < m_itemID.size())
    {
        m_slotID[slotID] = invSlotID;
    }
}

void CTradeContainer::setQuantity(uint8 slotID, uint32 quantity)
{
    if (slotID < m_itemID.size())
    {
        m_quantity[slotID] = quantity;
    }
}

void CTradeContainer::setItem(const uint8 slotId, const uint16 itemId, const uint8 invSlotId, const uint32 quantity)
{
    if (slotId < m_itemID.size())
    {
        m_ItemsCount += 1;

        m_itemID[slotId]   = itemId;
        m_slotID[slotId]   = invSlotId;
        m_quantity[slotId] = quantity;
    }
}

void CTradeContainer::setRestriction(uint8 slotID, SlotRestriction restriction)
{
    if (slotID < m_itemID.size())
    {
        restrictions_[slotID] = restriction;
    }
}

uint8 CTradeContainer::getSize()
{
    return (uint8)m_itemID.size();
}

void CTradeContainer::setSize(uint8 size)
{
    m_itemID.resize(size, 0);
    m_slotID.resize(size, 0xFF);
    m_quantity.resize(size, 0);
    restrictions_.resize(size);
}

uint8 CTradeContainer::getExSize() const
{
    return m_exSize;
}

void CTradeContainer::setExSize(uint8 size)
{
    m_exSize = size;
}

uint8 CTradeContainer::getItemsCount() const
{
    return m_ItemsCount;
}

void CTradeContainer::setItemsCount(uint8 count)
{
    m_ItemsCount = count;
}

uint8 CTradeContainer::getType() const
{
    return m_type;
}

void CTradeContainer::setType(uint8 type)
{
    m_type = type;
}

uint8 CTradeContainer::getShopFameArea() const
{
    return m_shopFameArea;
}

void CTradeContainer::setShopFameArea(uint8 fameArea)
{
    m_shopFameArea = fameArea;
}

uint32 CTradeContainer::getShopVendorId() const
{
    return m_shopVendorId;
}

void CTradeContainer::setShopVendorId(uint32 vendorId)
{
    m_shopVendorId = vendorId;
}

void CTradeContainer::Clean()
{
    m_type         = 0;
    m_shopFameArea = 0xFF; // match the lua side default value
    m_shopVendorId = 0;
    m_ItemsCount   = 0;
    m_exSize       = 0;

    m_itemID.clear();
    m_itemID.resize(CONTAINER_SIZE, 0);
    m_slotID.clear();
    m_slotID.resize(CONTAINER_SIZE, 0xFF);
    m_quantity.clear();
    m_quantity.resize(CONTAINER_SIZE, 0);
    restrictions_.clear();
    restrictions_.resize(CONTAINER_SIZE);
}
