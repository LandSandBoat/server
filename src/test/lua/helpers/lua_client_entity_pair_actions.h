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

#pragma once

#include "ability.h"
#include "common/cbasetypes.h"
#include "sol/forward.hpp"
#include <sol/sol.hpp>

enum class SpellID : uint16;
class CLuaClientEntityPair;
class CLuaBaseEntity;
class CLuaClientEntityPairActions
{
public:
    CLuaClientEntityPairActions(CLuaClientEntityPair* parent);
    ~CLuaClientEntityPairActions() = default;

    void move(float x, float y, float z, sol::optional<uint8_t> rot) const;
    void useSpell(CLuaBaseEntity* target, SpellID spellId) const;
    void useWeaponskill(CLuaBaseEntity* target, uint16 wsId) const;
    void useAbility(CLuaBaseEntity* target, ABILITY abilityId) const;
    void changeTarget(CLuaBaseEntity* target) const;
    void rangedAttack(CLuaBaseEntity* target) const;
    void useItem(CLuaBaseEntity* target, uint8 slotId, sol::optional<uint8> storageId) const;
    void trigger(CLuaBaseEntity* target, sol::optional<sol::table> expectedEvent = sol::nullopt) const;
    void inviteToParty(CLuaBaseEntity* player) const;
    void formAlliance(CLuaBaseEntity* player) const;
    void acceptPartyInvite() const;
    void tradeNpc(const sol::object& npcQuery, const sol::table& items, sol::optional<sol::table> expectedEvent) const;
    void acceptRaise() const;
    void engage(CLuaBaseEntity* mob) const;
    void skillchain(CLuaBaseEntity* target, sol::variadic_args weaponskillIds) const;

    static void Register();

private:
    CLuaClientEntityPair* parent_;
};
