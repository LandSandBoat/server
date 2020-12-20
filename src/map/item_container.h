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

#include "../common/cbasetypes.h"

enum CONTAINER_ID
{
    LOC_INVENTORY  = 0,
    LOC_MOGSAFE    = 1,
    LOC_STORAGE    = 2,
    LOC_TEMPITEMS  = 3,
    LOC_MOGLOCKER  = 4,
    LOC_MOGSATCHEL = 5,
    LOC_MOGSACK    = 6,
    LOC_MOGCASE    = 7,
    LOC_WARDROBE   = 8,
    LOC_MOGSAFE2   = 9,
    LOC_WARDROBE2  = 10,
    LOC_WARDROBE3  = 11,
    LOC_WARDROBE4  = 12
};

#define MAX_CONTAINER_ID   13
#define MAX_CONTAINER_SIZE 120
#define ERROR_SLOTID       255

/************************************************************************
 *																		*
 *																		*
 *																		*
 ************************************************************************/

class CItem;

class CItemContainer
{
public:
    CItemContainer(uint16 LocationID);
    ~CItemContainer();

    uint16 GetID() const;
    uint16 GetBuff() const; // планируемый размер хранилища (размер без ограничений)
    uint8  GetSize() const;
    uint8  GetFreeSlotsCount() const; // количество свободных ячеек в хранилище
    uint8  AddBuff(int8 buff);        // планируемый размер хранилища (размер без ограничений)
    uint8  AddSize(int8 size);        // увеличиваем/уменьшаем размер контейнера
    uint8  SetSize(uint8 size);
    uint8  SearchItem(uint16 ItemID);                           // поиск предмета в хранилище
    uint8  SearchItemWithSpace(uint16 ItemID, uint32 quantity); // search for item that has space to accomodate x items added

    uint8 InsertItem(CItem* PItem);               // добавляем заранее созданный предмет в свободную ячейку
    uint8 InsertItem(CItem* PItem, uint8 slotID); // добавляем заранее созданный предмет в выбранную ячейку

    uint32 SortingPacket;   // количество запросов на сортировку за такт
    uint32 LastSortingTime; // время последней сортировки контейнера

    CItem* GetItem(uint8 slotID); // получаем указатель на предмет, находящийся в указанной ячейка.
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
    uint16 m_buff;
    uint8  m_size;
    uint8  m_count;

    CItem* m_ItemList[MAX_CONTAINER_SIZE + 1];
};

#endif
