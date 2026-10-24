/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTItem or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#pragma once

#include "common/cbasetypes.h"
#include "data/enums/item_flag.h"
#include "data/enums/item_state.h"

#include <sol/forward.hpp>

#include <string>
class CItem;

class CLuaItem
{
    const CItem* m_readItem;  // observer; always set
    CItem*       m_writeItem; // null when wrapping a read-only template

public:
    CLuaItem(CItem*);
    CLuaItem(const CItem*);

    auto GetItem() const -> const CItem*
    {
        return m_readItem;
    }

    friend auto operator<<(std::ostream& out, const CLuaItem& item) -> std::ostream&;

    auto getID() -> uint16;    // get the item's id
    auto getSubID() -> uint16; // get the item's subid

    auto getFlag() const -> xi::ItemFlag; // get the item flag
    auto getAHCat() -> uint8;             // get the ah category

    auto getQuantity() -> uint32; // get the quantity of item

    auto getLocationID() -> uint8; // get the location id (container id)
    auto getSlotID() -> uint8;     // get the slot id
    auto getTrialNumber() -> uint16;
    auto getWornUses() -> uint8;   // check if the item has been used
    auto getBasePrice() -> uint32; // get the base sell price

    auto isType(uint8 type) -> bool;       // check the item type
    void setSubType(uint8 subtype);        // set the item's sub type
    auto isSubType(uint8 subtype) -> bool; // check the item's sub type

    auto state() const -> xi::ItemState; // current ItemState (xi.itemState.*)

    auto getName() -> std::string; // get the item's name
    auto getILvl() -> uint16;      // get the item's ilvl
    auto getReqLvl() -> uint16;    // get the item's level

    auto getMod(uint16 modID) -> int16;     // get the power of a mod
    void addMod(uint16 modID, int16 power); // add mod to item (or add to a mod already applied on item)
    void delMod(uint16 modID, int16 power); // remove power from mod

    auto getAugment(uint8 slot) -> sol::table; // get the augment id and power in slot
    // int32 setAugment(lua_State*);           // set the augment id and power in slot

    auto getSkillType() -> uint8;                   // get skill type
    auto getWeaponskillPoints() -> uint16;          // get current ws points
    void setWeaponskillPointsNeeded(uint16 points); // set required ws points to unlock (used for Unlocking a Myth era module)
    auto getWeaponskillPointsNeeded() -> uint16;    // confirm required ws points on this item object

    auto isTwoHanded() -> bool;              // is a two handed weapon
    auto isHandToHand() -> bool;             // is a hand to hand weapon (or unarmed H2H)
    auto isShield() -> bool;                 // is a Shield
    auto getShieldSize() -> uint8;           // get the shield size (used for block rate calculation)
    auto getShieldAbsorptionRate() -> uint8; // get the shield absorbtion rate (used for block rate calculation)

    auto getSignature() -> std::string;

    auto getAppraisalID() -> uint8; // get an appraisal ID
    void setAppraisalID(uint8 id);  // set an appraisal ID

    auto getCurrentCharges() -> uint8; // Get remaining charges

    auto isInstalled() -> bool;

    auto getExData() const -> sol::table;
    void setExData(const sol::table& data) const;
    auto getExDataRaw() const -> sol::table;         // NOTE: 0-indexed, to be in line with the underlying C++ data
    void setExDataRaw(const sol::table& data) const; // NOTE: 0-indexed, to be in line with the underlying C++ data

    auto operator==(const CLuaItem& other) const -> bool
    {
        return this->m_readItem == other.m_readItem;
    }

    static void Register();
};
