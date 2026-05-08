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
#include "items/exdata.h"
#include "items/item.h"
#include "items/item_equipment.h"
#include "items/item_fish.h"
#include "items/item_flowerpot.h"
#include "items/item_furnishing.h"
#include "items/item_general.h"
#include "items/item_linkshell.h"
#include "items/item_usable.h"
#include "items/item_weapon.h"
#include "map/enums/item_state.h"
#include "utils/itemutils.h"

CLuaItem::CLuaItem(CItem* PItem)
: m_readItem(PItem)
, m_writeItem(PItem)
{
    if (PItem == nullptr)
    {
        ShowError("CLuaItem created with nullptr instead of valid CItem*!");
    }
}

CLuaItem::CLuaItem(const CItem* PItem)
: m_readItem(PItem)
, m_writeItem(nullptr)
{
    if (PItem == nullptr)
    {
        ShowError("CLuaItem created with nullptr instead of valid CItem*!");
    }
}

uint16 CLuaItem::getID()
{
    return m_readItem->getID();
}

uint16 CLuaItem::getSubID()
{
    return m_readItem->getSubID();
}

auto CLuaItem::getFlag() const -> ItemFlag
{
    return m_readItem->getFlag();
}

uint8 CLuaItem::getAHCat()
{
    return m_readItem->getAHCat();
}

uint32 CLuaItem::getQuantity()
{
    return m_readItem->getQuantity();
}

uint32 CLuaItem::getBasePrice()
{
    return m_readItem->getBasePrice();
}

uint8 CLuaItem::getLocationID()
{
    return m_readItem->getLocationID();
}

uint8 CLuaItem::getSlotID()
{
    return m_readItem->getSlotID();
}

uint16 CLuaItem::getTrialNumber()
{
    return static_cast<const CItemEquipment*>(m_readItem)->getTrialNumber();
}

uint8 CLuaItem::getWornUses()
{
    return m_readItem->exdata<Exdata::WornItem>().UseCount;
}

bool CLuaItem::isType(uint8 type)
{
    return m_readItem->isType(static_cast<ITEM_TYPE>(type));
}

void CLuaItem::setSubType(uint8 subtype)
{
    if (!m_writeItem)
    {
        return;
    }

    m_writeItem->setSubType(static_cast<ITEM_SUBTYPE>(subtype));
}

bool CLuaItem::isSubType(uint8 subtype)
{
    return m_readItem->isSubType(static_cast<ITEM_SUBTYPE>(subtype));
}

auto CLuaItem::state() const -> ItemState
{
    return m_readItem->state();
}

void CLuaItem::setReservedValue(uint8 reserved)
{
    if (!m_writeItem)
    {
        return;
    }

    m_writeItem->setReserve(reserved);
}

uint8 CLuaItem::getReservedValue()
{
    return m_readItem->getReserve();
}

auto CLuaItem::getName() -> std::string
{
    // TODO: Fix c-style cast
    return m_readItem->getName();
}

uint16 CLuaItem::getILvl()
{
    return static_cast<const CItemEquipment*>(m_readItem)->getILvl();
}

uint16 CLuaItem::getReqLvl()
{
    return static_cast<const CItemEquipment*>(m_readItem)->getReqLvl();
}

int16 CLuaItem::getMod(uint16 modID)
{
    auto* PItem = static_cast<const CItemEquipment*>(m_readItem);
    Mod   mod   = static_cast<Mod>(modID);

    return PItem->getModifier(mod);
}

void CLuaItem::addMod(uint16 modID, int16 power)
{
    if (!m_writeItem)
    {
        return;
    }

    auto* PItem = static_cast<CItemEquipment*>(m_writeItem);
    Mod   mod   = static_cast<Mod>(modID);

    PItem->addModifier(CModifier(mod, power));
}

void CLuaItem::delMod(uint16 modID, int16 power)
{
    if (!m_writeItem)
    {
        return;
    }

    auto* PItem = static_cast<CItemEquipment*>(m_writeItem);
    Mod   mod   = static_cast<Mod>(modID);

    PItem->addModifier(CModifier(mod, -power));
}

auto CLuaItem::getAugment(uint8 slot) -> sol::table
{
    auto* PItem = static_cast<const CItemEquipment*>(m_readItem);

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
    auto* PItem = dynamic_cast<const CItemWeapon*>(m_readItem);
    return PItem ? PItem->getSkillType() : -1;
}

uint16 CLuaItem::getWeaponskillPoints()
{
    auto* PItem = dynamic_cast<const CItemWeapon*>(m_readItem);

    if (PItem)
    {
        return PItem->getCurrentUnlockPoints();
    }

    return 0;
}

void CLuaItem::setWeaponskillPointsNeeded(uint16 points)
{
    if (!m_writeItem)
    {
        return;
    }

    auto* PItem = dynamic_cast<CItemWeapon*>(m_writeItem);

    if (PItem)
    {
        PItem->setTotalUnlockPointsNeeded(points);
    }
}

uint16 CLuaItem::getWeaponskillPointsNeeded()
{
    auto* PItem = dynamic_cast<const CItemWeapon*>(m_readItem);

    if (PItem)
    {
        return PItem->getTotalUnlockPointsNeeded();
    }

    return 0;
}

bool CLuaItem::isTwoHanded()
{
    if (const CItemWeapon* PWeapon = dynamic_cast<const CItemWeapon*>(m_readItem))
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
    if (const CItemWeapon* PWeapon = dynamic_cast<const CItemWeapon*>(m_readItem))
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
    if (const CItemEquipment* PArmor = dynamic_cast<const CItemEquipment*>(m_readItem))
    {
        return PArmor->IsShield();
    }
    else
    {
        ShowError("CLuaItem::isShield - not a valid Armor.");
    }

    return false;
}

uint8 CLuaItem::getShieldSize()
{
    if (const CItemEquipment* PArmor = dynamic_cast<const CItemEquipment*>(m_readItem))
    {
        if (PArmor->IsShield())
        {
            return PArmor->getShieldSize();
        }
        else
        {
            ShowError("CLuaItem::getShieldSize - not a valid Shield.");
        }
    }
    else
    {
        ShowError("CLuaItem::getShieldSize - not a valid Armor.");
    }

    return 0;
}

uint8 CLuaItem::getShieldAbsorptionRate()
{
    if (const CItemEquipment* PArmor = dynamic_cast<const CItemEquipment*>(m_readItem))
    {
        if (PArmor->IsShield())
        {
            return PArmor->getShieldAbsorption();
        }
        else
        {
            ShowError("CLuaItem::getShieldSize - not a valid Shield.");
        }
    }
    else
    {
        ShowError("CLuaItem::getShieldSize - not a valid Armor.");
    }

    return 0;
}

auto CLuaItem::getSignature() -> std::string
{
    return m_readItem->getSignature();
}

uint8 CLuaItem::getCurrentCharges()
{
    if (auto* PUsableItem = dynamic_cast<const CItemUsable*>(m_readItem))
    {
        return PUsableItem->getCurrentCharges();
    }

    return 0;
}

uint8 CLuaItem::getAppraisalID()
{
    return m_readItem->getAppraisalID();
}

void CLuaItem::setAppraisalID(uint8 id)
{
    if (!m_writeItem)
    {
        return;
    }

    m_writeItem->setAppraisalID(id);
}

bool CLuaItem::isInstalled()
{
    if (!m_readItem->isType(ITEM_FURNISHING))
    {
        return false;
    }
    auto* PFurnishing = static_cast<const CItemFurnishing*>(m_readItem);
    return PFurnishing->isInstalled();
}

/************************************************************************
 *  Function: getExData()
 *  Purpose : Returns the item's extra data as a typed table.
 *  Example : item:getExData() -- typed table (e.g. ExdataLegionPass)
 ************************************************************************/
auto CLuaItem::getExData() const -> sol::table
{
    sol::table table = lua.create_table();

    if (Exdata::toTable(m_readItem, table))
    {
        return table;
    }

    for (std::size_t idx = 0; idx < m_readItem->extra_size; ++idx)
    {
        table[idx] = m_readItem->m_extra[idx];
    }
    return table;
}

/************************************************************************
 *  Function: setExData()
 *  Purpose : Writes the item's extra data from a typed table.
 *  Example : item:setExData({ timestamp = t, title = 1 })
 ************************************************************************/
void CLuaItem::setExData(const sol::table& data) const
{
    if (!m_writeItem)
    {
        return;
    }

    if (Exdata::fromTable(m_writeItem, data))
    {
        m_writeItem->setDirty(true);
        return;
    }

    for (const auto& [keyObj, valObj] : data)
    {
        uint8       key = keyObj.as<uint8>();
        const uint8 val = valObj.as<uint8>();

        if (key >= CItem::extra_size)
        {
            ShowWarning("setExData: key too large for exdata array: %s[%i]", m_writeItem->getName(), key);
            continue;
        }

        m_writeItem->m_extra[key] = val;
    }

    m_writeItem->setDirty(true);
}

/************************************************************************
 *  Function: getExDataRaw()
 *  Purpose : Returns the item's extra data as a 0-indexed byte table.
 *  Example : item:getExDataRaw()
 *  Notes   : Keys are 0-indexed to be in line with the underlying C++ data.
 ************************************************************************/
auto CLuaItem::getExDataRaw() const -> sol::table
{
    sol::table table = lua.create_table();
    for (std::size_t idx = 0; idx < m_readItem->extra_size; ++idx)
    {
        table[idx] = m_readItem->m_extra[idx];
    }
    return table;
}

/************************************************************************
 *  Function: setExDataRaw()
 *  Purpose : Writes the item's extra data from a 0-indexed byte table.
 *  Example : item:setExDataRaw({ [0] = 5, [1] = 10 })
 *  Notes   : Keys are 0-indexed byte offsets into m_extra.
 ************************************************************************/
void CLuaItem::setExDataRaw(const sol::table& data) const
{
    if (!m_writeItem)
    {
        return;
    }

    for (const auto& [keyObj, valObj] : data)
    {
        uint8       key = keyObj.as<uint8>();
        const uint8 val = valObj.as<uint8>();

        if (key >= CItem::extra_size)
        {
            ShowWarning("setExDataRaw: key too large for exdata array: %s[%i]", m_writeItem->getName(), key);
            continue;
        }

        m_writeItem->m_extra[key] = val;
    }

    m_writeItem->setDirty(true);
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
    SOL_REGISTER("setSubType", CLuaItem::setSubType);
    SOL_REGISTER("isSubType", CLuaItem::isSubType);
    SOL_REGISTER("state", CLuaItem::state);
    SOL_REGISTER("setReservedValue", CLuaItem::setReservedValue);
    SOL_REGISTER("getReservedValue", CLuaItem::getReservedValue);
    SOL_REGISTER("getName", CLuaItem::getName);
    SOL_REGISTER("getILvl", CLuaItem::getILvl);
    SOL_REGISTER("getReqLvl", CLuaItem::getReqLvl);
    SOL_REGISTER("getMod", CLuaItem::getMod);
    SOL_REGISTER("addMod", CLuaItem::addMod);
    SOL_REGISTER("delMod", CLuaItem::delMod);
    SOL_REGISTER("getAugment", CLuaItem::getAugment);
    SOL_REGISTER("getSkillType", CLuaItem::getSkillType);
    SOL_REGISTER("getWeaponskillPoints", CLuaItem::getWeaponskillPoints);
    SOL_REGISTER("setWeaponskillPointsNeeded", CLuaItem::setWeaponskillPointsNeeded);
    SOL_REGISTER("getWeaponskillPointsNeeded", CLuaItem::getWeaponskillPointsNeeded);
    SOL_REGISTER("isTwoHanded", CLuaItem::isTwoHanded);
    SOL_REGISTER("isHandToHand", CLuaItem::isHandToHand);
    SOL_REGISTER("isShield", CLuaItem::isShield);
    SOL_REGISTER("getShieldSize", CLuaItem::getShieldSize);
    SOL_REGISTER("getShieldAbsorptionRate", CLuaItem::getShieldAbsorptionRate);
    SOL_REGISTER("getSignature", CLuaItem::getSignature);
    SOL_REGISTER("getAppraisalID", CLuaItem::getAppraisalID);
    SOL_REGISTER("setAppraisalID", CLuaItem::setAppraisalID);
    SOL_REGISTER("getCurrentCharges", CLuaItem::getCurrentCharges);
    SOL_REGISTER("isInstalled", CLuaItem::isInstalled);
    SOL_REGISTER("getExData", CLuaItem::getExData);
    SOL_REGISTER("setExData", CLuaItem::setExData);
    SOL_REGISTER("getExDataRaw", CLuaItem::getExDataRaw);
    SOL_REGISTER("setExDataRaw", CLuaItem::setExDataRaw);
}

std::ostream& operator<<(std::ostream& os, const CLuaItem& item)
{
    std::string id = item.m_readItem ? std::to_string(item.m_readItem->getID()) : "nullptr";
    return os << "CLuaItem(" << id << ")";
}

//======================================================//
