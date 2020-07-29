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

#ifndef _ITEMUTILS_H
#define _ITEMUTILS_H

#include <vector>

#include "../items/item.h"
#include "../items/item_equipment.h"
#include "../items/item_currency.h"
#include "../items/item_fish.h"
#include "../items/item_furnishing.h"
#include "../items/item_general.h"
#include "../items/item_linkshell.h"
#include "../items/item_puppet.h"
#include "../items/item_usable.h"
#include "../items/item_weapon.h"

#define MAX_ITEMID  32768
#define MAX_DROPID  5000
#define MAX_LOOTID  1300
#define MAX_DROP_GROUP_ID  255

enum DROP_TYPE
{
    DROP_NORMAL  = 0x00,
    DROP_GROUPED = 0x01,
    DROP_STEAL   = 0x02,
    DROP_DESPOIL = 0x04
};

struct DropItem_t
{
    DropItem_t(uint8 DropType, uint16 ItemID, uint16 DropRate);
    uint8 DropType;
    uint16 ItemID;
    uint16 DropRate;
};

struct DropGroup_t
{
    DropGroup_t(uint16 GroupRate);
    uint16 GroupRate;
    std::vector<DropItem_t> Items;
};

struct DropList_t
{
    std::vector<DropItem_t> Items;
    std::vector<DropGroup_t> Groups;
};

struct LootItem_t
{
    uint16 ItemID;
    uint16 Rolls;
    uint8  LootGroupId;
};

typedef std::vector<LootItem_t> LootList_t;

/************************************************************************
*                                                                       *
*  The namespace for working with a global lists of items               *
*                                                                       *
************************************************************************/

namespace itemutils
{
    void    Initialize();
    void    FreeItemList();

    CItem*  GetItem(CItem* PItem);
    CItem*  GetItem(uint16 ItemID);
    CItem*  GetItemPointer(uint16 ItemID);
    bool 	IsItemPointer(CItem* item);

    CItemWeapon* GetUnarmedItem();
    CItemWeapon* GetUnarmedH2HItem();

    DropList_t* GetDropList(uint16 DropID);
    LootList_t* GetLootList(uint16 LootDropID);

};
#endif
