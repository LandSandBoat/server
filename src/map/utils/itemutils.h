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

#include <memory>
#include <optional>
#include <type_traits>
#include <vector>

#include "items/item.h"
#include "items/item_currency.h"
#include "items/item_weapon.h"
#include "packets/c2s/0x02b_translate.h"

namespace xi::items
{

auto lookup(uint16 itemId) -> const CItem*;

template <typename T>
auto lookup(const uint16 itemId) -> const T*
{
    static_assert(std::is_base_of_v<CItem, T>, "T must derive from CItem");
    return dynamic_cast<const T*>(lookup(itemId));
}

auto spawn(uint16 itemId) -> std::unique_ptr<CItem>;
auto clone(const CItem& source) -> std::unique_ptr<CItem>;

auto unarmed() -> CItemWeapon*;
auto unarmedH2H() -> CItemWeapon*;

} // namespace xi::items

#define MAX_ITEMID        32768
#define MAX_DROPID        5000
#define MAX_LOOTID        1300
#define MAX_DROP_GROUP_ID 255

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
    DropItem_t(uint8 DropType, uint16 ItemID, uint16 DropRate, bool hasFixedRate);
    uint8  DropType;
    uint16 ItemID;
    uint16 DropRate;
    bool   hasFixedRate;
};

struct DropGroup_t
{
    DropGroup_t(uint16 GroupRate);
    DropGroup_t(uint16 GroupRate, bool hasFixedRate);

    uint16                  GroupRate;
    bool                    hasFixedRate;
    std::vector<DropItem_t> Items;
};

struct DropList_t
{
    std::vector<DropItem_t>  Items;
    std::vector<DropGroup_t> Groups;
};

struct LootItem_t
{
    uint16 ItemID;
    uint16 Rolls;
    uint8  LootGroupId;
};

typedef std::vector<LootItem_t> LootList_t;

struct LootContainer
{
    LootContainer(DropList_t* dropList);
    DropList_t drops;

    void ForEachGroup(const std::function<void(const DropGroup_t&)>& func);
    void ForEachItem(const std::function<void(const DropItem_t&)>& func);

private:
    DropList_t* dropList;
};

/************************************************************************
 *                                                                       *
 *  The namespace for working with a global lists of items               *
 *                                                                       *
 ************************************************************************/

namespace itemutils
{

void Initialize();
void FreeItemList();

DropList_t* GetDropList(uint16 DropID);

auto TranslateItemName(GP_CLI_COMMAND_TRANSLATE_INDEX fromLang, GP_CLI_COMMAND_TRANSLATE_INDEX toLang, const std::string& name) -> std::optional<std::pair<uint16, std::string>>;

}; // namespace itemutils
