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

#ifndef _CTRADECONTAINER_H
#define _CTRADECONTAINER_H

#include "../common/cbasetypes.h"
#include <vector>

#define CONTAINER_SIZE       17
#define TRADE_CONTAINER_SIZE 8

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

enum CRAFT_TYPE
{
    CRAFT_SYNTHESIS   = 0,
    CRAFT_DESYNTHESIS = 1,
};

class CItem;

class CTradeContainer
{
public:
    CTradeContainer();

    uint8  getType() const;
    uint8  getCraftType() const;
    uint8  getItemsCount() const;
    uint8  getSlotCount();     // Number of occupied cells
    uint32 getTotalQuantity(); // Total number of items (gil counts as 1)
    uint8  getGuildID(uint8 slotID);
    uint16 getGuildRank(uint8 slotID);
    CItem* getItem(uint8 slotID);
    uint16 getItemID(uint8 slotID);
    uint8  getInvSlotID(uint8 slotID);
    uint32 getQuantity(uint8 slotID); // Number of items in the slot
    uint32 getConfirmedStatus(uint8 slotID);
    uint32 getItemQuantity(uint16 itemID); // Number of items of one type
    uint8  getSize();
    uint8  getExSize() const;

    void setType(uint8 type);
    void setCraftType(uint8 craftType);
    void setItemsCount(uint8 count);
    void setItem(uint8 slotID, CItem* item);
    void setGuildID(uint8 slotID, uint8 guildID);
    void setGuildRank(uint8 slotID, uint16 guildRank);
    void setItemID(uint8 slotID, uint16 itemID);
    void setInvSlotID(uint8 slotID, uint8 invSlotID);
    void setQuantity(uint8 slotID, uint32 quantity);
    bool setConfirmedStatus(uint8 slotID, uint32 amount);
    void setItem(uint8 slotID, uint16 itemID, uint8 invSlotID, uint32 quantity, CItem* item = nullptr);
    void setSize(uint8 size);
    void setExSize(uint8 size); // Set "extra" size information; purpose changes depending on container's goal
    void unreserveUnconfirmed();

    void Clean(); // we clean the container

private:
    uint8 m_type;       // Container type (crystal type, store nation, etc.)
    uint8 m_craftType;  // The craft synthesis type (CRAFT_TYPE)
    uint8 m_ItemsCount; // The number of items in the container (set by yourself)
    uint8 m_exSize;     // Can be used as a custom delineation point inside a container

    std::vector<CItem*> m_PItem;
    std::vector<uint8>  m_slotID;
    std::vector<uint16> m_itemID;
    std::vector<uint32> m_quantity;
    std::vector<uint32> m_confirmed;
    std::vector<uint8>  m_guildID;
    std::vector<uint16> m_guildRank;
};

#endif
