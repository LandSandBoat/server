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

#include "lua_test_entity_assertions.h"

#include "common/lua.h"
#include "lua_test_entity.h"
#include "map/entities/charentity.h"
#include "map/modifier.h"
#include "map/status_effect.h"
#include "map/zone.h"
#include "status_effect_container.h"
#include "test_common.h"

#include <algorithm>
#include <format>
#include <sol/sol.hpp>
#include <unordered_map>

namespace
{

// Mission log IDs - used for xi.mission.id.*
const std::unordered_map<uint8, std::string> missionLogIdMap = {
    { 0, "sandoria" },
    { 1, "bastok" },
    { 2, "windurst" },
    { 3, "zilart" },
    { 4, "toau" },
    { 5, "wotg" },
    { 6, "cop" },
    { 7, "assault" },
    { 8, "campaign" },
    { 9, "anov" },
    { 10, "amk" },
    { 11, "asa" },
    { 12, "roe" },
    { 13, "voidwatch" },
    { 14, "abyssea" },
    { 15, "soa" },
    { 16, "rov" }
};

// Quest log IDs - used for xi.quest.id.*
const std::unordered_map<uint8, std::string> questLogIdMap = {
    { 0, "sandoria" },
    { 1, "bastok" },
    { 2, "windurst" },
    { 3, "jeuno" },
    { 4, "otherAreas" },
    { 5, "outlands" },
    { 6, "ahtUrhgan" },
    { 7, "crystalWar" },
    { 8, "abyssea" },
    { 9, "adoulin" },
    { 10, "coalition" }
};

auto getEnumKey = [](const std::string& enumPath, const uint32 value) -> std::string
{
    // Split the path by '.' and navigate to the enum table
    sol::table current = lua.globals();

    size_t start = 0;
    size_t end   = enumPath.find('.');

    while (end != std::string::npos)
    {
        std::string part = enumPath.substr(start, end - start);

        // Check if this part is a number (for indexed tables)
        sol::object next;
        if (std::ranges::all_of(part, ::isdigit))
        {
            next = current[std::stoi(part)];
        }
        else
        {
            next = current[part];
        }

        if (!next.valid() || !next.is<sol::table>())
        {
            return std::to_string(value); // Path invalid
        }

        current = next.as<sol::table>();
        start   = end + 1;
        end     = enumPath.find('.', start);
    }

    if (start < enumPath.length())
    {
        std::string lastPart = enumPath.substr(start);
        sol::object finalTable;

        if (std::ranges::all_of(lastPart, ::isdigit))
        {
            finalTable = current[std::stoi(lastPart)];
        }
        else
        {
            finalTable = current[lastPart];
        }

        if (!finalTable.valid() || !finalTable.is<sol::table>())
        {
            return std::to_string(value);
        }

        current = finalTable.as<sol::table>();
    }

    // Iterate through the table to find the matching value
    for (const auto& [key, val] : current)
    {
        if (val.is<uint32>() && val.as<uint32>() == value)
        {
            return key.as<std::string>();
        }
    }

    // Default to provided value if not found
    return std::to_string(value);
};

} // namespace

// Common assertions for a TestEntity/TestClientEntityPair
// Error messages include lua enum strings for quick referencing.
// Can be negated with .no
CLuaTestEntityAssertions::CLuaTestEntityAssertions(CLuaTestEntity* entity, const bool negate)
: entity_(entity)
, negate_(negate)
{
}

void CLuaTestEntityAssertions::assertCondition(const bool result, const std::string& positive, const std::string& negative)
{
    if (result && negate_)
    {
        TestError("{}", negative);
    }
    else if (!result && !negate_)
    {
        TestError("{}", positive);
    }

    // Reset negation after each assertion so it only applies once
    negate_ = false;
}

/************************************************************************
 *  Function: inZone()
 *  Purpose : Assert entity is in expected zone
 *  Example : player.assert:inZone(xi.zone.NORG)
 *  Notes   :
 ************************************************************************/

auto CLuaTestEntityAssertions::inZone(const ZONEID expectedZone) -> CLuaTestEntityAssertions&
{
    const auto actualZone = entity_->getZoneID();

    assertCondition(entity_->getZoneID() == expectedZone,
                    std::format("Expected to be in zone {}, but was in zone {}", getEnumKey("xi.zone", expectedZone), getEnumKey("xi.zone", actualZone)),
                    std::format("Expected to NOT be in zone {}", getEnumKey("xi.zone", expectedZone)));
    return *this;
}

/************************************************************************
 *  Function: hasLocalVar()
 *  Purpose : Assert entity has local variable with expected value
 *  Example : player.assert:hasLocalVar("TestVar", 123)
 *  Notes   :
 ************************************************************************/

auto CLuaTestEntityAssertions::hasLocalVar(const std::string& varName, uint32 expectedValue) -> CLuaTestEntityAssertions&
{
    auto actualValue = entity_->getLocalVar(varName);

    assertCondition(actualValue == expectedValue,
                    std::format("Expected local var '{}' to be {}, but was {}", varName, expectedValue, actualValue),
                    std::format("Expected local var '{}' NOT to be {}", varName, expectedValue));
    return *this;
}

/************************************************************************
 *  Function: hasEffect()
 *  Purpose : Assert entity has specified status effect
 *  Example : player.assert:hasEffect(xi.effect.PROTECT)
 *  Notes   :
 ************************************************************************/

auto CLuaTestEntityAssertions::hasEffect(const EFFECT effectId) -> CLuaTestEntityAssertions&
{
    assertCondition(entity_->hasStatusEffect(effectId, sol::lua_nil),
                    std::format("Does not have effect {}", getEnumKey("xi.effect", effectId)),
                    std::format("Has effect {}", getEnumKey("xi.effect", effectId)));
    return *this;
}

/************************************************************************
 *  Function: hasAnimation()
 *  Purpose : Assert entity has specified animation
 *  Example : player.assert:hasAnimation(xi.animation.CHOCOBO)
 *  Notes   :
 ************************************************************************/

auto CLuaTestEntityAssertions::hasAnimation(const uint8 animation) -> CLuaTestEntityAssertions&
{
    assertCondition(entity_->getAnimation() == animation,
                    std::format("Does not have animation {} set", getEnumKey("xi.animation", animation)),
                    std::format("Does have animation {} set", getEnumKey("xi.animation", animation)));
    return *this;
}

/************************************************************************
 *  Function: hasNationRank()
 *  Purpose : Assert player has expected nation rank
 *  Example : player.assert:hasNationRank(5)
 *  Notes   :
 ************************************************************************/

auto CLuaTestEntityAssertions::hasNationRank(uint8 expectedRank) -> CLuaTestEntityAssertions&
{
    if (!entity_->isPC())
    {
        TestError("Can only be called on player entities, but was called on {}", entity_->getName());
        return *this;
    }

    auto actualRank = entity_->getRank(entity_->getNation());

    assertCondition(actualRank == expectedRank,
                    std::format("Expected player to have nation rank {}, but had rank {}", expectedRank, actualRank),
                    std::format("Expected player NOT to have nation rank {}", expectedRank));
    return *this;
}

/************************************************************************
 *  Function: hasKI()
 *  Purpose : Assert player has specified key item
 *  Example : player.assert:hasKI(xi.ki.AIRSHIP_PASS)
 *  Notes   :
 ************************************************************************/

auto CLuaTestEntityAssertions::hasKI(KeyItem keyItemId) -> CLuaTestEntityAssertions&
{
    if (!entity_->isPC())
    {
        TestError("Can only be called on player entities, but was called on {}", entity_->getName());
        return *this;
    }

    assertCondition(entity_->hasKeyItem(keyItemId),
                    std::format("Expected player to have key item {}", getEnumKey("xi.ki", static_cast<uint16>(keyItemId))),
                    std::format("Expected player NOT to have key item {}", getEnumKey("xi.ki", static_cast<uint16>(keyItemId))));
    return *this;
}

/************************************************************************
 *  Function: hasMission()
 *  Purpose : Assert player has expected current mission
 *  Example : player.assert:hasMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_PRICE_OF_PEACE)
 *  Notes   :
 ************************************************************************/

auto CLuaTestEntityAssertions::hasMission(const MissionLog logId, const uint16 expectedMission) -> CLuaTestEntityAssertions&
{
    if (!entity_->isPC())
    {
        TestError("Can only be called on player entities, but was called on {}", entity_->getName());
        return *this;
    }

    const auto currentMission     = entity_->getCurrentMission(sol::make_object(lua.lua_state(), logId));
    const auto logIdValue         = logId;
    const auto logIdStr           = getEnumKey("xi.mission.log_id", static_cast<uint8_t>(logIdValue));
    const auto missionArea        = missionLogIdMap.contains(static_cast<uint8_t>(logIdValue)) ? missionLogIdMap.at(static_cast<uint8_t>(logIdValue)) : std::to_string(static_cast<uint8_t>(logIdValue));
    const auto expectedMissionStr = getEnumKey(std::format("xi.mission.id.{}", missionArea), expectedMission);
    const auto currentMissionStr  = getEnumKey(std::format("xi.mission.id.{}", missionArea), currentMission);

    assertCondition(currentMission == expectedMission,
                    std::format("Expected player to have mission {}::{}, but had mission {}", logIdStr, expectedMissionStr, currentMissionStr),
                    std::format("Expected player NOT to have mission {}::{}", logIdStr, expectedMissionStr));
    return *this;
}

/************************************************************************
 *  Function: hasCompletedMission()
 *  Purpose : Assert player has completed specified mission
 *  Example : player.assert:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.SMASH_THE_ORCISH_SCOUTS)
 *  Notes   :
 ************************************************************************/

auto CLuaTestEntityAssertions::hasCompletedMission(const MissionLog logId, const uint16 missionId) -> CLuaTestEntityAssertions&
{
    if (!entity_->isPC())
    {
        TestError("Can only be called on player entities, but was called on {}", entity_->getName());
        return *this;
    }

    const auto logIdStr     = getEnumKey("xi.mission.log_id", static_cast<uint8_t>(logId));
    const auto missionArea  = missionLogIdMap.contains(static_cast<uint8_t>(logId)) ? missionLogIdMap.at(static_cast<uint8_t>(logId)) : std::to_string(static_cast<uint8_t>(logId));
    const auto missionIdStr = getEnumKey(std::format("xi.mission.id.{}", missionArea), missionId);

    assertCondition(entity_->hasCompletedMission(logId, missionId),
                    std::format("Expected player to have completed mission {}::{}", logIdStr, missionIdStr),
                    std::format("Expected player NOT to have completed mission {}::{}", logIdStr, missionIdStr));
    return *this;
}

/************************************************************************
 *  Function: hasItem()
 *  Purpose : Assert player has specified item in inventory
 *  Example : player.assert:hasItem(xi.item.BRONZE_SWORD)
 *  Notes   :
 ************************************************************************/

auto CLuaTestEntityAssertions::hasItem(const uint16 itemId) -> CLuaTestEntityAssertions&
{
    if (!entity_->isPC())
    {
        TestError("Can only be called on player entities, but was called on {}", entity_->getName());
        return *this;
    }

    assertCondition(entity_->hasItem(itemId, sol::lua_nil),
                    std::format("Expected player to have item {}", getEnumKey("xi.item", itemId)),
                    std::format("Expected player NOT to have item {}", getEnumKey("xi.item", itemId)));
    return *this;
}

/************************************************************************
 *  Function: hasModifier()
 *  Purpose : Assert entity has modifier with expected value
 *  Example : player.assert:hasModifier(xi.mod.STR, 10)
 *  Notes   :
 ************************************************************************/

auto CLuaTestEntityAssertions::hasModifier(const Mod modifierId, int32 expectedValue) -> CLuaTestEntityAssertions&
{
    auto actualValue = entity_->getMod(static_cast<uint16>(modifierId));

    assertCondition(actualValue == expectedValue,
                    std::format("Modifier {} != {} (actual {})", getEnumKey("xi.mod", static_cast<uint32>(modifierId)), expectedValue, actualValue),
                    std::format("Modifier {} == {}", getEnumKey("xi.mod", static_cast<uint32>(modifierId)), expectedValue));
    return *this;
}

/************************************************************************
 *  Function: isSpawned()
 *  Purpose : Assert entity is currently spawned
 *  Example : mob.assert:isSpawned()
 *  Notes   :
 ************************************************************************/

auto CLuaTestEntityAssertions::isSpawned() -> CLuaTestEntityAssertions&
{
    auto name = entity_->getName();

    assertCondition(entity_->isSpawned(),
                    std::format("{} is not spawned", name),
                    std::format("{} is spawned", name));
    return *this;
}

/************************************************************************
 *  Function: isAlive()
 *  Purpose : Assert entity is currently alive
 *  Example : mob.assert:isAlive()
 *  Notes   :
 ************************************************************************/

auto CLuaTestEntityAssertions::isAlive() -> CLuaTestEntityAssertions&
{
    auto name = entity_->getName();

    assertCondition(entity_->isAlive(),
                    std::format("{} is not alive", name),
                    std::format("{} is alive", name));
    return *this;
}

/************************************************************************
 *  Function: hasQuest()
 *  Purpose : Assert player has specified quest
 *  Example : player.assert:hasQuest(xi.questLog.BASTOK, xi.quest.id.bastok.SHADY_BUSINESS)
 *  Notes   :
 ************************************************************************/

auto CLuaTestEntityAssertions::hasQuest(const QuestLog logId, const uint16 questId) -> CLuaTestEntityAssertions&
{
    if (!entity_->isPC())
    {
        TestError("Can only be called on player entities, but was called on {}", entity_->getName());
        return *this;
    }

    const auto logIdStr   = getEnumKey("xi.questLog", static_cast<uint8_t>(logId));
    const auto questArea  = questLogIdMap.contains(static_cast<uint8_t>(logId)) ? questLogIdMap.at(static_cast<uint8_t>(logId)) : std::to_string(static_cast<uint8_t>(logId));
    const auto questIdStr = getEnumKey(std::format("xi.quest.id.{}", questArea), questId);

    assertCondition(entity_->getQuestStatus(logId, questId) != 0,
                    std::format("Expected player to have quest {}::{}", logIdStr, questIdStr),
                    std::format("Expected player NOT to have quest {}::{}", logIdStr, questIdStr));
    return *this;
}

/************************************************************************
 *  Function: hasCompletedQuest()
 *  Purpose : Assert player has completed specified quest
 *  Example : player.assert:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.SHADY_BUSINESS)
 *  Notes   :
 ************************************************************************/

auto CLuaTestEntityAssertions::hasCompletedQuest(const QuestLog logId, const uint16 questId) -> CLuaTestEntityAssertions&
{
    if (!entity_->isPC())
    {
        TestError("Can only be called on player entities, but was called on {}", entity_->getName());
        return *this;
    }

    const auto logIdStr   = getEnumKey("xi.questLog", static_cast<uint8_t>(logId));
    const auto questArea  = questLogIdMap.contains(static_cast<uint8_t>(logId)) ? questLogIdMap.at(static_cast<uint8_t>(logId)) : std::to_string(static_cast<uint8_t>(logId));
    const auto questIdStr = getEnumKey(std::format("xi.quest.id.{}", questArea), questId);

    assertCondition(entity_->hasCompletedQuest(logId, questId),
                    std::format("Expected player to have completed quest {}::{}", logIdStr, questIdStr),
                    std::format("Expected player NOT to have completed quest {}::{}", logIdStr, questIdStr));
    return *this;
}

/************************************************************************
 *  Function: hasGil()
 *  Purpose : Assert player has at least the specified amount of gil
 *  Example : player.assert:hasGil(1000)
 *  Notes   :
 ************************************************************************/

auto CLuaTestEntityAssertions::hasGil(const uint32 amount) -> CLuaTestEntityAssertions&
{
    if (!entity_->isPC())
    {
        TestError("Can only be called on player entities, but was called on {}", entity_->getName());
        return *this;
    }

    const auto actualGil = entity_->getGil();

    assertCondition(actualGil >= amount,
                    std::format("Expected player to have at least {} gil, but had {} gil", amount, actualGil),
                    std::format("Expected player NOT to have {} gil", amount));
    return *this;
}

/************************************************************************
 *  Property: no
 *  Purpose : Negate the next assertion
 *  Example : mob.assert.no:isAlive()
 *  Notes   : Sets negation flag for the next assertion only
 ************************************************************************/

auto CLuaTestEntityAssertions::no() -> CLuaTestEntityAssertions&
{
    negate_ = true;
    return *this;
}

void CLuaTestEntityAssertions::Register()
{
    SOL_USERTYPE("CTestEntityAssertions", CLuaTestEntityAssertions);
    SOL_REGISTER("inZone", CLuaTestEntityAssertions::inZone);
    SOL_REGISTER("hasLocalVar", CLuaTestEntityAssertions::hasLocalVar);
    SOL_REGISTER("hasEffect", CLuaTestEntityAssertions::hasEffect);
    SOL_REGISTER("hasAnimation", CLuaTestEntityAssertions::hasAnimation);
    SOL_REGISTER("hasNationRank", CLuaTestEntityAssertions::hasNationRank);
    SOL_REGISTER("hasKI", CLuaTestEntityAssertions::hasKI);
    SOL_REGISTER("hasMission", CLuaTestEntityAssertions::hasMission);
    SOL_REGISTER("hasCompletedMission", CLuaTestEntityAssertions::hasCompletedMission);
    SOL_REGISTER("hasItem", CLuaTestEntityAssertions::hasItem);
    SOL_REGISTER("hasModifier", CLuaTestEntityAssertions::hasModifier);
    SOL_REGISTER("isSpawned", CLuaTestEntityAssertions::isSpawned);
    SOL_REGISTER("isAlive", CLuaTestEntityAssertions::isAlive);
    SOL_REGISTER("hasQuest", CLuaTestEntityAssertions::hasQuest);
    SOL_REGISTER("hasCompletedQuest", CLuaTestEntityAssertions::hasCompletedQuest);
    SOL_REGISTER("hasGil", CLuaTestEntityAssertions::hasGil);
    SOL_READONLY("no", CLuaTestEntityAssertions::no);
}
