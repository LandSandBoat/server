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

#ifndef _CITEMCONTAINER_H
#define _CITEMCONTAINER_H

#include "common/cbasetypes.h"
#include "common/logging.h"
#include "common/timer.h"

#include <array>
#include <memory>
#include <optional>

// TODO: Enum class
enum CONTAINER_ID : uint8
{
    LOC_INVENTORY    = 0,
    LOC_MOGSAFE      = 1,
    LOC_STORAGE      = 2,
    LOC_TEMPITEMS    = 3,
    LOC_MOGLOCKER    = 4,
    LOC_MOGSATCHEL   = 5,
    LOC_MOGSACK      = 6,
    LOC_MOGCASE      = 7,
    LOC_WARDROBE     = 8,
    LOC_MOGSAFE2     = 9,
    LOC_WARDROBE2    = 10,
    LOC_WARDROBE3    = 11,
    LOC_WARDROBE4    = 12,
    LOC_WARDROBE5    = 13,
    LOC_WARDROBE6    = 14,
    LOC_WARDROBE7    = 15,
    LOC_WARDROBE8    = 16,
    LOC_RECYCLEBIN   = 17,
    MAX_CONTAINER_ID = 18,
};
#define MAX_CONTAINER_SIZE 120
#define ERROR_SLOTID       255
DECLARE_FORMAT_AS_UNDERLYING(CONTAINER_ID);

class CItem;

class CItemContainer
{
public:
    CItemContainer(uint16 LocationID);
    ~CItemContainer();

    uint16 GetID() const;
    uint16 GetBuff() const; // get storage size (unlimited size)
    uint8  GetSize() const; // get container size
    uint8  GetFreeSlotsCount() const;
    uint8  AddBuff(int8 buff); // increase/decrease storage size
    uint8  AddSize(int8 size); // increase/decrease container size
    uint8  SetSize(uint8 size);
    auto   SearchItem(uint16 itemId) const -> uint8;
    auto   SearchItems(uint16 itemId) const -> std::vector<uint8>;
    uint8  SearchItemWithSpace(uint16 ItemID, uint32 quantity); // search for item that has space to accomodate x items added

    auto InsertItem(std::unique_ptr<CItem> PItem) -> uint8;
    auto InsertItem(std::unique_ptr<CItem> PItem, uint8 slotID) -> uint8;
    auto RemoveItem(uint8 slotID) -> std::unique_ptr<CItem>;
    auto MoveItemTo(uint8 fromSlot, CItemContainer& dst, std::optional<uint8> dstSlot = std::nullopt) -> uint8;

    uint32            SortingPacket; // number of sort requests per clock
    timer::time_point LastSortingTime;

    auto GetItem(uint8 slotID) const -> CItem*;
    void Clear();

    template <typename F, typename... Args>
    void ForEachItem(F func, Args&&... args)
    {
        for (uint8 SlotID = 0; SlotID <= m_size; ++SlotID)
        {
            if (m_ItemList[SlotID])
            {
                func(m_ItemList[SlotID].get(), std::forward<Args>(args)...);
            }
        }
    }

private:
    uint16 m_id;
    uint16 m_buff; // This appears to be the "usable" amount of your storage. You can have a locker size of 30, but a "buff" of 0 when it is out of use.
    uint8  m_size;
    uint8  m_count;

    std::array<std::unique_ptr<CItem>, MAX_CONTAINER_SIZE + 1> m_ItemList{};
};

#endif
