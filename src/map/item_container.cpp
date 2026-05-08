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

#include "item_container.h"
#include "utils/itemutils.h"

CItemContainer::CItemContainer(uint16 LocationID)
: SortingPacket(0)
, LastSortingTime(timer::time_point::min())
, m_id(LocationID)
, m_buff(0)
, m_size(0)
, m_count(0)
{
}

CItemContainer::~CItemContainer() = default;

uint16 CItemContainer::GetID() const
{
    return m_id;
}

uint8 CItemContainer::GetSize() const
{
    return m_size;
}

uint8 CItemContainer::GetFreeSlotsCount() const
{
    return m_size - m_count;
}

/************************************************************************
 *                                                                       *
 *  Setting the size of the container                                    *
 *                                                                       *
 ************************************************************************/

uint16 CItemContainer::GetBuff() const
{
    return m_buff;
}

uint8 CItemContainer::AddBuff(int8 buff)
{
    m_buff += buff;
    return SetSize(std::clamp<int>(m_buff, 0, 80)); // Limit in 0-80 cells for character
}

/************************************************************************
 *                                                                       *
 *  Setting the size of the container                                    *
 *                                                                       *
 ************************************************************************/

// The container is not responsible for the fact that items can remain outside the size.

uint8 CItemContainer::SetSize(uint8 size)
{
    if (size <= MAX_CONTAINER_SIZE)
    {
        if (size >= m_count)
        {
            m_size = size;
            return m_size;
        }
    }
    ShowDebug("ItemContainer <%u>: Bad new container size %u", m_id, size);
    return -1;
}

/************************************************************************
 *                                                                       *
 *  Increase/decrease container size                                     *
 *                                                                       *
 ************************************************************************/

uint8 CItemContainer::AddSize(int8 size)
{
    uint8 newsize = m_size + size;

    if (newsize <= MAX_CONTAINER_SIZE)
    {
        if (newsize >= m_count)
        {
            m_size = newsize;
            return m_size;
        }
    }
    ShowDebug("ItemContainer <%u>: Bad new container size %u", m_id, newsize);
    return -1;
}

auto CItemContainer::InsertItem(std::unique_ptr<CItem> PItem) -> uint8
{
    if (PItem == nullptr)
    {
        ShowWarning("Null item passed into function.");
        return ERROR_SLOTID;
    }

    for (uint8 SlotID = 1; SlotID <= m_size; ++SlotID)
    {
        if (m_ItemList[SlotID] == nullptr)
        {
            m_count++;

            PItem->setSlotID(SlotID);
            PItem->setLocationID((uint8)m_id);

            m_ItemList[SlotID] = std::move(PItem);
            return SlotID;
        }
    }
    ShowDebug("ItemContainer: Container is full");
    return ERROR_SLOTID;
}

/************************************************************************
 *                                                                       *
 *  Add an item to the specified cell.                                   *
 *                                                                       *
 ************************************************************************/

auto CItemContainer::InsertItem(std::unique_ptr<CItem> PItem, uint8 SlotID) -> uint8
{
    if (SlotID > m_size)
    {
        ShowDebug("ItemContainer: SlotID %i is out of range", SlotID);
        return ERROR_SLOTID;
    }

    PItem->setSlotID(SlotID);
    PItem->setLocationID((uint8)m_id);

    if (m_ItemList[SlotID] == nullptr && SlotID != 0)
    {
        m_count++;
    }

    m_ItemList[SlotID] = std::move(PItem);
    return SlotID;
}

auto CItemContainer::RemoveItem(uint8 SlotID) -> std::unique_ptr<CItem>
{
    if (SlotID > m_size)
    {
        return nullptr;
    }

    if (m_ItemList[SlotID] != nullptr && SlotID != 0)
    {
        m_count--;
    }

    return std::move(m_ItemList[SlotID]);
}

auto CItemContainer::MoveItemTo(uint8 fromSlot, CItemContainer& dst, std::optional<uint8> dstSlot) -> uint8
{
    if (dstSlot.has_value())
    {
        if (*dstSlot > dst.m_size || dst.m_ItemList[*dstSlot] != nullptr)
        {
            return ERROR_SLOTID;
        }
    }
    else if (dst.GetFreeSlotsCount() == 0)
    {
        return ERROR_SLOTID;
    }

    auto PItem = RemoveItem(fromSlot);
    if (PItem == nullptr)
    {
        return ERROR_SLOTID;
    }

    return dstSlot.has_value()
               ? dst.InsertItem(std::move(PItem), *dstSlot)
               : dst.InsertItem(std::move(PItem));
}

auto CItemContainer::GetItem(uint8 slotID) const -> CItem*
{
    if (slotID <= m_size)
    {
        return m_ItemList[slotID].get();
    }

    return nullptr;
}

auto CItemContainer::SearchItem(const uint16 itemId) const -> uint8
{
    for (uint8 slotId = 0; slotId <= m_size; ++slotId)
    {
        if ((m_ItemList[slotId] != nullptr) && (m_ItemList[slotId]->getID() == itemId))
        {
            return slotId;
        }
    }

    return ERROR_SLOTID;
}

auto CItemContainer::SearchItems(const uint16 itemId) const -> std::vector<uint8>
{
    std::vector<uint8> slotIds;

    for (uint8 slotId = 0; slotId <= m_size; ++slotId)
    {
        if ((m_ItemList[slotId] != nullptr) && (m_ItemList[slotId]->getID() == itemId))
        {
            slotIds.push_back(slotId);
        }
    }

    return slotIds;
}

uint8 CItemContainer::SearchItemWithSpace(uint16 ItemID, uint32 quantity)
{
    for (uint8 SlotID = 0; SlotID <= m_size; ++SlotID)
    {
        if ((m_ItemList[SlotID] != nullptr) && (m_ItemList[SlotID]->getID() == ItemID) &&
            (m_ItemList[SlotID]->getQuantity() <= m_ItemList[SlotID]->getStackSize() - quantity))
        {
            return SlotID;
        }
    }
    return ERROR_SLOTID;
}

void CItemContainer::Clear()
{
    for (uint8 SlotID = 0; SlotID <= m_size; ++SlotID)
    {
        m_ItemList[SlotID].reset();
    }
}
