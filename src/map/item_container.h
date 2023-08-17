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

enum CONTAINER_ID
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

/************************************************************************
 *                                                                        *
 *                                                                        *
 *                                                                        *
 ************************************************************************/

class CItem;

class CItemContainer
{
public:
    CItemContainer(uint16 LocationID);
    ~CItemContainer();

    uint16 GetID() const;
    uint16 GetBuff() const; // Planned amount of storage (size without restrictions)
    uint8  GetSize() const;
    uint8  GetFreeSlotsCount() const; // The number of free cells in the storage
    uint8  AddBuff(int8 buff);        // Planned amount of storage (size without restrictions)
    uint8  AddSize(int8 size);        // Increase/decrease the size of the container
    uint8  SetSize(uint8 size);
    uint8  SearchItem(uint16 ItemID);                           // Search for the subject in the storage
    uint8  SearchItemWithSpace(uint16 ItemID, uint32 quantity); // search for item that has space to accomodate x items added

    uint8 InsertItem(CItem* PItem);               // Add a pre -created object to a free cell
    uint8 InsertItem(CItem* PItem, uint8 slotID); // Add a pre -created item to the selected cell

    uint32 SortingPacket;   // The number of requests for the tact
    uint32 LastSortingTime; // The time of the last sorting of the container

    CItem* GetItem(uint8 slotID); // We get a pointer for the subject in the specified cell.
    void   Clear();               // Remove all items from container

    template <typename F, typename... Args>
    void ForEachItem(F func, Args&&... args)
    {
        for (uint8 SlotID = 0; SlotID <= m_size; ++SlotID)
        {
            if (m_ItemList[SlotID])
            {
                func(m_ItemList[SlotID], std::forward<Args>(args)...);
            }
        }
    }

private:
    uint16 m_id;
    uint16 m_buff; // This appears to be the "usable" amount of your storage. You can have a locker size of 30, but a "buff" of 0 when it is out of use.
    uint8  m_size;
    uint8  m_count;

    CItem* m_ItemList[MAX_CONTAINER_SIZE + 1]{};
};

#endif
