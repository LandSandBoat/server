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

#define CONTAINER_SIZE          17
#define TRADE_CONTAINER_SIZE     8

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

enum CRAFT_TYPE
{
    CRAFT_SYNTHESIS = 0,
    CRAFT_DESYNTHESIS = 1,
};

class CItem;

class CTradeContainer
{
public:

    CTradeContainer();

    uint8   getType();
    uint8   getCraftType();
    uint8   getItemsCount();
    uint8   getSlotCount();                                 // количество занятых ячеек
    uint32  getTotalQuantity();                             // общее количество предметов (gil считаются за 1)
    uint8   getGuildID(uint8 slotID);
    uint16  getGuildRank(uint8 slotID);
    CItem*  getItem(uint8 slotID);
    uint16  getItemID(uint8 slotID);
    uint8   getInvSlotID(uint8 slotID);
    uint32  getQuantity(uint8 slotID);                      // количество предметов в ячейке
    uint8   getConfirmedStatus(uint8 slotID);
    uint32  getItemQuantity(uint16 itemID);                 // количество предметов одного типа
    uint8   getSize();

    void    setType(uint8 type);
    void    setCraftType(uint8 craftType);
    void    setItemsCount(uint8 count);
    void    setItem(uint8 slotID, CItem* item);
    void    setGuildID(uint8 slotID, uint8 guildID);
    void    setGuildRank(uint8 slotID, uint16 guildRank);
    void    setItemID(uint8 slotID, uint16 itemID);
    void    setInvSlotID(uint8 slotID, uint8 invSlotID);
    void    setQuantity(uint8 slotID, uint32 quantity);
    bool    setConfirmedStatus(uint8 slotID, uint32 amount);
    void    setItem(uint8 slotID, uint16 itemID, uint8 invSlotID, uint32 quantity, CItem* item = nullptr);
    void    setSize(uint8 size);

    void    Clean();                                        // отчищаем контейнер

private:

    uint8   m_type;                                         // тип контейнера (тип кристалла, нация магазина и т.д.)
    uint8   m_craftType;                                    // The craft synthesis type (CRAFT_TYPE)
    uint8   m_ItemsCount;                                   // количество предметов в контейнере (устанавливаем самостоятельно)

    std::vector<CItem*>     m_PItem;
    std::vector<uint8>      m_slotID;
    std::vector<uint16>     m_itemID;
    std::vector<uint32>     m_quantity;
    std::vector<uint32>     m_confirmed;
    std::vector<uint8>      m_guildID;
    std::vector<uint16>     m_guildRank;
};

#endif
