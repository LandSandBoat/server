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

#pragma once

#include "common/cbasetypes.h"

#include <sol/forward.hpp>

class CItem;
class CCharEntity;
class CTradeContainer;

class CLuaTradeContainer
{
    CTradeContainer* m_pMyTradeContainer;

    CCharEntity* m_owner{};

public:
    CLuaTradeContainer(CTradeContainer*, CCharEntity* owner);

    auto GetTradeContainer() const -> CTradeContainer*
    {
        return m_pMyTradeContainer;
    }

    friend auto operator<<(std::ostream& out, const CTradeContainer& trade) -> std::ostream&;

    auto getGil() -> uint32;
    auto getItem(const sol::object& SlotIDObj) -> CItem*;
    auto getItemId(const sol::object& SlotIDObj) -> uint16;
    auto getItemSubId(const sol::object& SlotIDObj) -> uint16;
    auto getItemQty(uint16 itemID) -> uint32;
    auto hasItemQty(uint16 itemID, uint32 quantity) -> bool;
    auto getSlotQty(uint8 slotID) -> uint32; // number of items in the specified slot
    auto getItemCount() -> uint32;           // total number of items
    auto getSlotCount() -> uint8;
    auto confirmItem(uint16 itemID, const sol::object& amountObj) -> bool;
    auto confirmSlot(uint8 slotID, const sol::object& amountObj) -> bool;
    void clean();

private:
    // the items live in the transaction, the container only describes the offer
    auto tradedItem(uint8 slotID) const -> CItem*;
    auto confirmQuantity(uint8 slotID, uint32 quantity) const -> bool;

public:
    auto operator==(const CLuaTradeContainer& other) const -> bool
    {
        return this->m_pMyTradeContainer == other.m_pMyTradeContainer;
    }

    static void Register();
};
