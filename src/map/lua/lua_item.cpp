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
#include "items/item_furnishing.h"
#include "items/item_usable.h"
#include "items/item_weapon.h"
#include "luautils.h"

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

auto CLuaItem::getID() -> uint16
{
    return m_readItem->getID();
}

auto CLuaItem::getSubID() -> uint16
{
    return m_readItem->getSubID();
}

auto CLuaItem::getFlag() const -> xi::ItemFlag
{
    return m_readItem->getFlag();
}

auto CLuaItem::getAHCat() -> uint8
{
    return m_readItem->getAHCat();
}

auto CLuaItem::getQuantity() -> uint32
{
    return m_readItem->getQuantity();
}

auto CLuaItem::getBasePrice() -> uint32
{
    return m_readItem->getBasePrice();
}

auto CLuaItem::getLocationID() -> uint8
{
    return m_readItem->getLocationID();
}

auto CLuaItem::getSlotID() -> uint8
{
    return m_readItem->getSlotID();
}

auto CLuaItem::getTrialNumber() -> uint16
{
    return static_cast<const CItemEquipment*>(m_readItem)->getTrialNumber();
}

auto CLuaItem::getWornUses() -> uint8
{
    return m_readItem->exdata<Exdata::WornItem>().UseCount;
}

auto CLuaItem::isType(uint8 type) -> bool
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

auto CLuaItem::isSubType(uint8 subtype) -> bool
{
    return m_readItem->isSubType(static_cast<ITEM_SUBTYPE>(subtype));
}

auto CLuaItem::state() const -> xi::ItemState
{
    return m_readItem->state();
}

auto CLuaItem::getName() -> std::string
{
    // TODO: Fix c-style cast
    return m_readItem->getName();
}

auto CLuaItem::getILvl() -> uint16
{
    return static_cast<const CItemEquipment*>(m_readItem)->getILvl();
}

auto CLuaItem::getReqLvl() -> uint16
{
    return static_cast<const CItemEquipment*>(m_readItem)->getReqLvl();
}

auto CLuaItem::getMod(uint16 modID) -> int16
{
    auto*   PItem = static_cast<const CItemEquipment*>(m_readItem);
    xi::Mod mod   = static_cast<xi::Mod>(modID);

    return PItem->getModifier(mod);
}

void CLuaItem::addMod(uint16 modID, int16 power)
{
    if (!m_writeItem)
    {
        return;
    }

    auto*   PItem = static_cast<CItemEquipment*>(m_writeItem);
    xi::Mod mod   = static_cast<xi::Mod>(modID);

    PItem->addModifier(CModifier(mod, power));
}

void CLuaItem::delMod(uint16 modID, int16 power)
{
    if (!m_writeItem)
    {
        return;
    }

    auto*   PItem = static_cast<CItemEquipment*>(m_writeItem);
    xi::Mod mod   = static_cast<xi::Mod>(modID);

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

auto CLuaItem::getSkillType() -> uint8
{
    auto* PItem = dynamic_cast<const CItemWeapon*>(m_readItem);
    return PItem ? static_cast<uint8>(PItem->getSkillType()) : -1;
}

auto CLuaItem::getWeaponskillPoints() -> uint16
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

auto CLuaItem::getWeaponskillPointsNeeded() -> uint16
{
    auto* PItem = dynamic_cast<const CItemWeapon*>(m_readItem);

    if (PItem)
    {
        return PItem->getTotalUnlockPointsNeeded();
    }

    return 0;
}

auto CLuaItem::isTwoHanded() -> bool
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

auto CLuaItem::isHandToHand() -> bool
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

auto CLuaItem::isShield() -> bool
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

auto CLuaItem::getShieldSize() -> uint8
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

auto CLuaItem::getShieldAbsorptionRate() -> uint8
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

auto CLuaItem::getCurrentCharges() -> uint8
{
    if (auto* PUsableItem = dynamic_cast<const CItemUsable*>(m_readItem))
    {
        return PUsableItem->getCurrentCharges();
    }

    return 0;
}

auto CLuaItem::getAppraisalID() -> uint8
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

auto CLuaItem::isInstalled() -> bool
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

auto operator<<(std::ostream& os, const CLuaItem& item) -> std::ostream&
{
    std::string id = item.m_readItem ? std::to_string(item.m_readItem->getID()) : "nullptr";
    return os << "CLuaItem(" << id << ")";
}

//======================================================//
