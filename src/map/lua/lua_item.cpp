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

#include "lua_item.h"

#include "common/logging.h"
#include "items/item.h"
#include "items/item_equipment.h"
#include "items/item_general.h"
#include "items/item_weapon.h"
#include "map.h"
#include "utils/itemutils.h"

CLuaItem::CLuaItem(CItem* PItem)
: m_PLuaItem(PItem)
{
    if (PItem == nullptr)
    {
        ShowError("CLuaItem created with nullptr instead of valid CItem*!");
    }
}

uint16 CLuaItem::getID()
{
    return m_PLuaItem->getID();
}

uint16 CLuaItem::getSubID()
{
    return m_PLuaItem->getSubID();
}

uint16 CLuaItem::getFlag()
{
    return m_PLuaItem->getFlag();
}

uint8 CLuaItem::getAHCat()
{
    return m_PLuaItem->getAHCat();
}

uint32 CLuaItem::getQuantity()
{
    return m_PLuaItem->getQuantity();
}

uint32 CLuaItem::getBasePrice()
{
    return m_PLuaItem->getBasePrice();
}

uint8 CLuaItem::getLocationID()
{
    return m_PLuaItem->getLocationID();
}

uint8 CLuaItem::getSlotID()
{
    return m_PLuaItem->getSlotID();
}

uint16 CLuaItem::getTrialNumber()
{
    return static_cast<CItemEquipment*>(m_PLuaItem)->getTrialNumber();
}

uint8 CLuaItem::getWornUses()
{
    return m_PLuaItem->m_extra[0];
}

bool CLuaItem::isType(uint8 type)
{
    return m_PLuaItem->isType(static_cast<ITEM_TYPE>(type));
}

bool CLuaItem::isSubType(uint8 subtype)
{
    return m_PLuaItem->isSubType(static_cast<ITEM_SUBTYPE>(subtype));
}

auto CLuaItem::getName() -> std::string
{
    // TODO: Fix c-style cast
    return m_PLuaItem->getName();
}

uint16 CLuaItem::getILvl()
{
    return static_cast<CItemEquipment*>(m_PLuaItem)->getILvl();
}

uint16 CLuaItem::getReqLvl()
{
    return static_cast<CItemEquipment*>(m_PLuaItem)->getReqLvl();
}

int16 CLuaItem::getMod(uint16 modID)
{
    auto* PItem = static_cast<CItemEquipment*>(m_PLuaItem);
    Mod   mod   = static_cast<Mod>(modID);

    return PItem->getModifier(mod);
}

void CLuaItem::addMod(uint16 modID, int16 power)
{
    auto* PItem = static_cast<CItemEquipment*>(m_PLuaItem);

    // Checks if this item is just a pointer created by GetItem()
    // All item-modifying functions in this file should check this!
    if (itemutils::IsItemPointer(PItem))
    {
        return;
    }

    Mod mod = static_cast<Mod>(modID);

    PItem->addModifier(CModifier(mod, power));
}

void CLuaItem::delMod(uint16 modID, int16 power)
{
    auto* PItem = static_cast<CItemEquipment*>(m_PLuaItem);
    Mod   mod   = static_cast<Mod>(modID);

    PItem->addModifier(CModifier(mod, -power));
}

auto CLuaItem::getAugment(uint8 slot) -> sol::table
{
    auto* PItem = static_cast<CItemEquipment*>(m_PLuaItem);

    uint16 augment    = PItem->getAugment(slot);
    uint16 augmentId  = (uint16)unpackBitsBE((uint8*)(&augment), 0, 11);
    uint8  augmentVal = (uint8)unpackBitsBE((uint8*)(&augment), 11, 5);

    sol::table table = lua.create_table();
    table[1]         = augmentId;
    table[2]         = augmentVal;

    return table;
}

uint8 CLuaItem::getSkillType()
{
    auto* PItem = dynamic_cast<CItemWeapon*>(m_PLuaItem);
    return PItem ? PItem->getSkillType() : -1;
}

uint16 CLuaItem::getWeaponskillPoints()
{
    auto* PItem = dynamic_cast<CItemWeapon*>(m_PLuaItem);

    if (PItem)
    {
        return PItem->getCurrentUnlockPoints();
    }

    return 0;
}

bool CLuaItem::isTwoHanded()
{
    if (CItemWeapon* PWeapon = dynamic_cast<CItemWeapon*>(m_PLuaItem))
    {
        return PWeapon->isTwoHanded();
    }
    else
    {
        ShowError("CLuaItem::isTwoHanded - not a valid Weapon.");
    }

    return false;
}

bool CLuaItem::isHandToHand()
{
    if (CItemWeapon* PWeapon = dynamic_cast<CItemWeapon*>(m_PLuaItem))
    {
        return PWeapon->isHandToHand();
    }
    else
    {
        ShowError("CLuaItem::isHandToHand - not a valid Weapon.");
    }

    return false;
}

bool CLuaItem::isShield()
{
    if (CItemEquipment* PArmor = dynamic_cast<CItemEquipment*>(m_PLuaItem))
    {
        return PArmor->IsShield();
    }
    else
    {
        ShowError("CLuaItem::isShield - not a valid Armor.");
    }

    return false;
}

auto CLuaItem::getSignature() -> std::string
{
    char signature[DecodeStringLength] = {};

    if (m_PLuaItem->isType(ITEM_LINKSHELL))
    {
        DecodeStringLinkshell(m_PLuaItem->getSignature(), signature);
    }
    else
    {
        DecodeStringSignature(m_PLuaItem->getSignature(), signature);
    }

    return signature;
}

uint8 CLuaItem::getAppraisalID()
{
    return m_PLuaItem->m_extra[0x16];
}

void CLuaItem::setAppraisalID(uint8 id)
{
    m_PLuaItem->m_extra[0x16] = id;
}

bool CLuaItem::isInstalled()
{
    if (!m_PLuaItem->isType(ITEM_FURNISHING))
    {
        return false;
    }
    auto* PFurnishing = static_cast<CItemFurnishing*>(m_PLuaItem);
    return PFurnishing->isInstalled();
}

void CLuaItem::setSoulPlateData(std::string const& name, uint16 mobFamily, uint8 zeni, uint16 skillIndex, uint8 fp)
{
    m_PLuaItem->setSoulPlateData(name, mobFamily, zeni, skillIndex, fp);
}

auto CLuaItem::getSoulPlateData() -> sol::table
{
    auto       data  = m_PLuaItem->getSoulPlateData();
    sol::table table = lua.create_table();

    table["name"]       = std::get<0>(data);
    table["mobFamily"]  = std::get<1>(data);
    table["zeni"]       = std::get<2>(data);
    table["skillIndex"] = std::get<3>(data);
    table["fp"]         = std::get<4>(data);

    return table;
}

auto CLuaItem::getExData() -> sol::table
{
    sol::table table = lua.create_table();
    for (std::size_t idx = 0; idx < m_PLuaItem->extra_size; ++idx)
    {
        table[idx] = m_PLuaItem->m_extra[idx];
    }
    return table;
}

void CLuaItem::setExData(sol::table const& newData)
{
    for (auto const& [keyObj, valObj] : newData)
    {
        uint8 key = keyObj.as<uint8>();
        uint8 val = valObj.as<uint8>();

        if (key >= CItem::extra_size)
        {
            ShowWarning("Tried to write to key too large for item exdata array: %s[%i]", m_PLuaItem->getName(), key);
            continue;
        }

        m_PLuaItem->m_extra[key] = val;
    }
}

//==========================================================//

void CLuaItem::Register()
{
    SOL_USERTYPE("CItem", CLuaItem);
    SOL_REGISTER("getID", CLuaItem::getID);
    SOL_REGISTER("getSubID", CLuaItem::getSubID);
    SOL_REGISTER("getFlag", CLuaItem::getFlag);
    SOL_REGISTER("getAHCat", CLuaItem::getAHCat);
    SOL_REGISTER("getQuantity", CLuaItem::getQuantity);
    SOL_REGISTER("getLocationID", CLuaItem::getLocationID);
    SOL_REGISTER("getBasePrice", CLuaItem::getBasePrice);
    SOL_REGISTER("getSlotID", CLuaItem::getSlotID);
    SOL_REGISTER("getTrialNumber", CLuaItem::getTrialNumber);
    SOL_REGISTER("getWornUses", CLuaItem::getWornUses);
    SOL_REGISTER("isType", CLuaItem::isType);
    SOL_REGISTER("isSubType", CLuaItem::isSubType);
    SOL_REGISTER("getName", CLuaItem::getName);
    SOL_REGISTER("getILvl", CLuaItem::getILvl);
    SOL_REGISTER("getReqLvl", CLuaItem::getReqLvl);
    SOL_REGISTER("getMod", CLuaItem::getMod);
    SOL_REGISTER("addMod", CLuaItem::addMod);
    SOL_REGISTER("delMod", CLuaItem::delMod);
    SOL_REGISTER("getAugment", CLuaItem::getAugment);
    SOL_REGISTER("getSkillType", CLuaItem::getSkillType);
    SOL_REGISTER("getWeaponskillPoints", CLuaItem::getWeaponskillPoints);
    SOL_REGISTER("isTwoHanded", CLuaItem::isTwoHanded);
    SOL_REGISTER("isHandToHand", CLuaItem::isHandToHand);
    SOL_REGISTER("isShield", CLuaItem::isShield);
    SOL_REGISTER("getSignature", CLuaItem::getSignature);
    SOL_REGISTER("getAppraisalID", CLuaItem::getAppraisalID);
    SOL_REGISTER("setAppraisalID", CLuaItem::setAppraisalID);
    SOL_REGISTER("isInstalled", CLuaItem::isInstalled);
    SOL_REGISTER("setSoulPlateData", CLuaItem::setSoulPlateData);
    SOL_REGISTER("getSoulPlateData", CLuaItem::getSoulPlateData);
    SOL_REGISTER("getExData", CLuaItem::getExData);
    SOL_REGISTER("setExData", CLuaItem::setExData);
}

std::ostream& operator<<(std::ostream& os, const CLuaItem& item)
{
    std::string id = item.m_PLuaItem ? std::to_string(item.m_PLuaItem->getID()) : "nullptr";
    return os << "CLuaItem(" << id << ")";
}

//======================================================//
