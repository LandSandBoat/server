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

#ifndef _LUAITEM_H
#define _LUAITEM_H

#include "common/cbasetypes.h"
#include "luautils.h"

class CItem;
class CLuaItem
{
    CItem* m_PLuaItem;

public:
    CLuaItem(CItem*);

    CItem* GetItem() const
    {
        return m_PLuaItem;
    }

    friend std::ostream& operator<<(std::ostream& out, const CLuaItem& item);

    uint16 getID();    // get the item's id
    uint16 getSubID(); // get the item's subid

    uint16 getFlag();  // get the item flag
    uint8  getAHCat(); // get the ah category

    uint32 getQuantity(); // get the quantity of item

    uint8  getLocationID(); // get the location id (container id)
    uint8  getSlotID();     // get the slot id
    uint16 getTrialNumber();
    auto   getMatchingTrials() -> sol::table; // returns a table of trial #'s which match this item precisely
    uint8  getWornUses();                     // check if the item has been used
    uint32 getBasePrice();                    // get the base sell price

    bool isType(uint8 type);       // check the item type
    bool isSubType(uint8 subtype); // check the item's sub type

    auto   getName() -> std::string; // get the item's name
    uint16 getILvl();                // get the item's ilvl
    uint16 getReqLvl();              // get the item's level

    int16 getMod(uint16 modID);              // get the power of a mod
    void  addMod(uint16 modID, int16 power); // add mod to item (or add to a mod already applied on item)
    void  delMod(uint16 modID, int16 power); // remove power from mod

    auto getAugment(uint8 slot) -> std::tuple<uint16, uint8>; // get the augment id and power in slot
    // int32 setAugment(lua_State*);           // set the augment id and power in slot

    uint8  getSkillType();         // get skill type
    uint16 getWeaponskillPoints(); // get current ws points

    bool isTwoHanded();  // is a two handed weapon
    bool isHandToHand(); // is a hand to hand weapon (or unarmed H2H)
    bool isShield();     // is a Shield

    auto getSignature() -> std::string;

    uint8 getAppraisalID();         // get an appraisal ID
    void  setAppraisalID(uint8 id); // set an appraisal ID

    bool isInstalled();

    void setSoulPlateData(std::string const& name, uint16 mobFamily, uint8 zeni, uint16 skillIndex, uint8 fp);
    auto getSoulPlateData() -> sol::table;

    static void Register();
};

#endif
