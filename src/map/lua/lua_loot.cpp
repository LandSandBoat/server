/*
===========================================================================

  Copyright (c) 2022-2022 LandSandBoat

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

#include "lua_loot.h"

// Converts known TH rarity rates to their respective percentages
// Once the new TH logic has been applied to mobentity.cpp then this can be removed
static const std::array<uint16, 9> RATE_PERCENTAGES = {
    0,    // NEVER         0.00%
    1,    // ULTRA_RARE    0.10%
    5,    // SUPER_RARE    0.50%
    10,   // VERY_RARE     1.00%
    50,   // RARE          5.00%
    100,  // UNCOMMON     10.00%
    150,  // COMMON       15.00%
    240,  // VERY_COMMON  24.00%
    1000, // GUARANTEED  100.00%
};

CLuaLootContainer::CLuaLootContainer(LootContainer* loot)
: m_PLootContainer(loot)
{
    if (m_PLootContainer == nullptr)
    {
        ShowError("CLuaLootContainer created with nullptr instead of valid LootContainer*!");
    }
}

/************************************************************************
 *  Function: addItem()
 *  Purpose : Adds an item to the loot container
 *  Example : loot:addItem(xi.items.ANCIENT_BEASTCOIN, xi.loot.rate.GUARENTEED, 2);
 *  Notes   : Last parameter, quantity, is optional and defaults to 1
 ************************************************************************/

void CLuaLootContainer::addItem(uint16 item, uint16 rate, sol::variadic_args va)
{
    addItemToContainer(item, RATE_PERCENTAGES[rate], va, false);
}

/************************************************************************
 *  Function: addGroup()
 *  Purpose : Adds a group of items to the loot container
 *  Example : loot:addGroup(xi.loot.rate.COMMON, { { item = xi.items.ANCIENT_BEASTCOIN, weight = 100 } });
 *  Notes   : Item table is a list of tables with "item" key and an optional "weight" which defaults to 1
 ************************************************************************/

void CLuaLootContainer::addGroup(uint16 groupRate, sol::table items)
{
    addGroupToContainer(RATE_PERCENTAGES[groupRate], items, false);
}

/************************************************************************
 *  Function: addItemFixed()
 *  Purpose : Adds an item to the loot container with a fixed drop rate
 *  Example : loot:addItemFixed(xi.items.ANCIENT_BEASTCOIN, 500, 2);
 *  Notes   : Last parameter, quantity, is optional and defaults to 1
 *            Fixed drop rate is 0-1000.
 ************************************************************************/

void CLuaLootContainer::addItemFixed(uint16 item, uint16 rate, sol::variadic_args va)
{
    addItemToContainer(item, rate, va, true);
}

/************************************************************************
 *  Function: addGroupFixed()
 *  Purpose : Adds a group of items to the loot container with a fixed drop rate
 *  Example : loot:addGroup(500, { { item = xi.items.ANCIENT_BEASTCOIN, weight = 100 } });
 *  Notes   : Item table is a list of tables with "item" key and an optional "weight" which defaults to 1
 *            Fixed drop rate is 0-1000.
 ************************************************************************/

void CLuaLootContainer::addGroupFixed(uint16 groupRate, sol::table items)
{
    addGroupToContainer(groupRate, items, true);
}

void CLuaLootContainer::addItemToContainer(uint16 item, uint16 rate, sol::variadic_args va, bool hasFixedRate)
{
    const auto quantity = va.get_type(0) == sol::type::number ? va.get<uint16>(0) : 1;
    for (uint16 i = 0; i < quantity; ++i)
    {
        m_PLootContainer->drops.Items.emplace_back(DROP_TYPE::DROP_NORMAL, item, rate, hasFixedRate);
    }
}

void CLuaLootContainer::addGroupToContainer(uint16 groupRate, sol::table items, bool hasFixedRate)
{
    DropGroup_t group(groupRate, hasFixedRate);

    for (const auto& entryTable : items)
    {
        sol::table entry = entryTable.second;
        auto       item  = entry["item"];
        if (!item.valid() || !item.is<uint16>())
        {
            ShowError("CLuaLootContainer::addGroup() - entry in group is missing valid 'item'");
            continue;
        }

        uint16 weight = entry.get_or<uint16>("weight", 1);
        group.Items.emplace_back(DROP_TYPE::DROP_GROUPED, item.get<uint16>(), weight);
    }

    m_PLootContainer->drops.Groups.push_back(std::move(group));
}

void CLuaLootContainer::Register()
{
    SOL_USERTYPE("CLootContainer", CLuaLootContainer);
    SOL_REGISTER("addItem", CLuaLootContainer::addItem);
    SOL_REGISTER("addGroup", CLuaLootContainer::addGroup);
    SOL_REGISTER("addItemFixed", CLuaLootContainer::addItemFixed);
    SOL_REGISTER("addGroupFixed", CLuaLootContainer::addGroupFixed);
};

std::ostream& operator<<(std::ostream& os, const CLuaLootContainer& loot)
{
    os << "CLuaLootContainer(\n";

    // clang-format off
    loot.m_PLootContainer->ForEachGroup([&](const DropGroup_t& group)
    {
        os << "    Group(rate = " << group.GroupRate << ", items = {\n";
        for (const auto& item : group.Items)
        {
            os << "        item(id = " << item.ItemID << ", rate = " << item.DropRate << "),\n";
        }
        os << "    ),\n";
    });

    loot.m_PLootContainer->ForEachItem([&](const DropItem_t& item)
    {
        os << "    item(id = " << item.ItemID << ", rate = " << item.DropRate << "),\n";
    });
    os << ")";
    // clang-format on

    return os;
}
