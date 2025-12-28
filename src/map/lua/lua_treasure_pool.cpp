/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include "lua_treasure_pool.h"

#include "treasure_pool.h"
#include "utils/zoneutils.h"

CLuaTreasurePool::CLuaTreasurePool(CTreasurePool* PTreasurePool)
: m_PLuaTreasurePool(PTreasurePool)
{
}

/************************************************************************
 *  Function: getType()
 *  Purpose : Returns the type of the Treasure Pool
 *  Example : pool:getType()
 *  Notes   : See xi.treasurePool enum
 ************************************************************************/
auto CLuaTreasurePool::getType() const -> TreasurePoolType
{
    return m_PLuaTreasurePool->getPoolType();
}

/************************************************************************
 *  Function: flush()
 *  Purpose : Forcibly flushes the treasure pool, as if all items timers expired
 *  Example : pool:flush()
 *  Notes   :
 ************************************************************************/
void CLuaTreasurePool::flush() const
{
    m_PLuaTreasurePool->flush();
}

/************************************************************************
 *  Function: addMember()
 *  Purpose : Adds a PC to the treasure pool
 *  Example : pool:addMember(target)
 *  Notes   :
 ************************************************************************/
void CLuaTreasurePool::addMember(CBaseEntity* PEntity) const
{
    if (const auto PChar = dynamic_cast<CCharEntity*>(PEntity))
    {
        m_PLuaTreasurePool->addMember(PChar);
    }
}

/************************************************************************
 *  Function: delMember()
 *  Purpose : Removes a PC from the treasure pool
 *  Example : pool:delMember(target)
 *  Notes   :
 ************************************************************************/
void CLuaTreasurePool::delMember(CBaseEntity* PEntity) const
{
    if (const auto PChar = dynamic_cast<CCharEntity*>(PEntity))
    {
        m_PLuaTreasurePool->delMember(PChar);
    }
}

/************************************************************************
 *  Function: update()
 *  Purpose : Force refreshes the treasure pool content for a PC
 *  Example : pool:update(target)
 *  Notes   :
 ************************************************************************/
void CLuaTreasurePool::update(CBaseEntity* PEntity) const
{
    if (const auto PChar = dynamic_cast<CCharEntity*>(PEntity))
    {
        m_PLuaTreasurePool->updatePool(PChar);
    }
}

/************************************************************************
 *  Function: addItem()
 *  Purpose : Adds an item to the treasure pool
 *  Example : pool:addItem(xi.item.RIDILL)
 *  Notes   : The entity can be either a NPC, a mob or nullptr.
 ************************************************************************/
auto CLuaTreasurePool::addItem(const uint16 ItemID, CBaseEntity* PEntity) const -> uint8
{
    return m_PLuaTreasurePool->addItem(ItemID, PEntity);
}

/************************************************************************
 *  Function: memberCount()
 *  Purpose : Returns the number of members in the treasure pool
 *  Example : pool:memberCount()
 *  Notes   :
 ************************************************************************/
auto CLuaTreasurePool::memberCount() const -> size_t
{
    return m_PLuaTreasurePool->memberCount();
}

/************************************************************************
 *  Function: getMembers()
 *  Purpose : Returns all members present in the pool.
 *  Example : pool:getMembers()
 *  Notes   :
 ************************************************************************/
auto CLuaTreasurePool::getMembers() const -> sol::table
{
    sol::table result = lua.create_table();
    uint8      index  = 1;

    for (const auto& member : m_PLuaTreasurePool->getMembers())
    {
        result[index++] = member;
    }

    return result;
}

/************************************************************************
 *  Function: getItems()
 *  Purpose : Returns all items present in the pool, along with their lotters
 *  Example : pool:getItems()
 *  Notes   : id of 0 means no item present in the given slot.
 *  {
 *    { id = 1, slotId = 0, timestamp = 0, Lotters = { { member = {...}, lot = 0 } } },
 *    [...]
 *  }
 ************************************************************************/
auto CLuaTreasurePool::getItems() const -> sol::table
{
    sol::table result = lua.create_table();
    uint8      index  = 1;

    for (const auto& item : m_PLuaTreasurePool->getItems())
    {
        sol::table itemRow   = lua.create_table();
        itemRow["id"]        = item.ID;
        itemRow["slotId"]    = item.SlotID;
        itemRow["timestamp"] = earth_time::timestamp(timer::to_utc(item.TimeStamp));

        sol::table lotters     = lua.create_table();
        int        lotterIndex = 1;

        for (const auto& lotter : item.Lotters)
        {
            sol::table lotterRow   = lua.create_table();
            lotterRow["member"]    = lotter.member;
            lotterRow["lot"]       = lotter.lot;
            lotters[lotterIndex++] = lotterRow;
        }

        itemRow["lotters"] = lotters;
        result[index++]    = itemRow;
    }

    return result;
}

//==========================================================//

void CLuaTreasurePool::Register()
{
    SOL_USERTYPE("CTreasurePool", CLuaTreasurePool);
    SOL_REGISTER("getType", CLuaTreasurePool::getType);
    SOL_REGISTER("flush", CLuaTreasurePool::flush);
    SOL_REGISTER("addMember", CLuaTreasurePool::addMember);
    SOL_REGISTER("delMember", CLuaTreasurePool::delMember);
    SOL_REGISTER("updatePool", CLuaTreasurePool::update);
    SOL_REGISTER("addItem", CLuaTreasurePool::addItem);
    SOL_REGISTER("memberCount", CLuaTreasurePool::memberCount);
    SOL_REGISTER("getMembers", CLuaTreasurePool::getMembers);
    SOL_REGISTER("getItems", CLuaTreasurePool::getItems);
}
