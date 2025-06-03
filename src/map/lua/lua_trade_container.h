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

#ifndef _LUATRADECONTAINER_H
#define _LUATRADECONTAINER_H

#include "common/cbasetypes.h"
#include "luautils.h"

class CTradeContainer;
class CLuaTradeContainer
{
    CTradeContainer* m_pMyTradeContainer;

public:
    CLuaTradeContainer(CTradeContainer*);

    CTradeContainer* GetTradeContainer() const
    {
        return m_pMyTradeContainer;
    }

    friend std::ostream& operator<<(std::ostream& out, const CTradeContainer& trade);

    uint32 getGil();
    auto   getItem(sol::object const& SlotIDObj) -> CItem*;
    uint16 getItemId(sol::object const& SlotIDObj);
    uint16 getItemSubId(sol::object const& SlotIDObj);
    uint32 getItemQty(uint16 itemID);
    bool   hasItemQty(uint16 itemID, uint32 quantity);
    uint32 getSlotQty(uint8 slotID); // number of items in the specified slot
    uint32 getItemCount();           // total number of items
    uint8  getSlotCount();
    bool   confirmItem(uint16 itemID, sol::object const& amountObj);
    bool   confirmSlot(uint8 slotID, sol::object const& amountObj);
    void   clean();

    bool operator==(const CLuaTradeContainer& other) const
    {
        return this->m_pMyTradeContainer == other.m_pMyTradeContainer;
    }

    static void Register();
};

#endif // _LUATRADECONTAINER_H
