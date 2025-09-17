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

#include "lua_char_entity.h"

#include "entities/charentity.h"

CLuaCharEntity::CLuaCharEntity(CCharEntity* PChar)
: CLuaBaseEntity(PChar)
, char_(PChar)
{
}

/**
 * @brief Adds a set amount of XP to the player.
 * @details
 * Used in Dynamis Pages, etc.
 * @param [in] exp Amount of XP to grant the player.
 * @code{.lua}
 * player:addExp(math.random(500, 1000))
 * @endcode
 */
void CLuaCharEntity::addExp(const uint32 exp) const
{
    charutils::AddExperiencePoints(false, char_, char_, exp);
}

/************************************************************************
 *  Function: delExp()
 *  Purpose : Takes XP from a player
 *  Example : player:delExp(amount)
 *  Notes   : Used only in GM command takexp.lua
 ************************************************************************/

void CLuaCharEntity::delExp(const uint32 exp) const
{
    charutils::DelExperiencePoints(char_, 0, std::clamp<uint16>(exp, 0, 65535));
}

/************************************************************************
 *  Function: getMerit()
 *  Purpose : Checks for the existence of a merit and returns the value
 *  Example : caster:getMerit(xi.merit.DOTON_EFFECT)
 *  Notes   :
 ************************************************************************/

auto CLuaCharEntity::getMerit(uint16 merit) const -> int32
{
    return char_->PMeritPoints->GetMeritValue(static_cast<MERIT_TYPE>(merit), char_);
}

/************************************************************************
 *  Function: getMeritCount()
 *  Purpose : Returns the current value of merits a player has
 *  Example : player:getMeritCount()
 *  Notes   :
 ************************************************************************/

auto CLuaCharEntity::getMeritCount() const -> uint8
{
    return char_->PMeritPoints->GetMeritPoints();
}

void CLuaCharEntity::Register()
{
    SOL_USERTYPE_INHERIT("CCharEntity", CLuaCharEntity, CLuaBaseEntity);

    SOL_REGISTER("addExp", CLuaCharEntity::addExp);
    SOL_REGISTER("delExp", CLuaCharEntity::delExp);
    SOL_REGISTER("getMerit", CLuaCharEntity::getMerit);
    SOL_REGISTER("getMeritCount", CLuaCharEntity::getMeritCount);
}
