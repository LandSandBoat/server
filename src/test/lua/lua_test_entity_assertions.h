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

#include "common/cbasetypes.h"
#include "common/lua.h"
#include <string>

enum class QuestLog : uint8_t;
enum class MissionLog : uint8_t;
enum class KeyItem : uint16_t;
enum ZONEID : uint16;
enum EFFECT : uint16;
enum class Mod;
class CLuaTestEntity;

class CLuaTestEntityAssertions
{
public:
    CLuaTestEntityAssertions(CLuaTestEntity* entity, bool negate = false);
    ~CLuaTestEntityAssertions() = default;

    auto inZone(ZONEID expectedZone) -> CLuaTestEntityAssertions&;
    auto hasLocalVar(const std::string& varName, uint32 expectedValue) -> CLuaTestEntityAssertions&;
    auto hasEffect(EFFECT effectId) -> CLuaTestEntityAssertions&;
    auto hasNationRank(uint8 expectedRank) -> CLuaTestEntityAssertions&;
    auto hasKI(KeyItem keyItemId) -> CLuaTestEntityAssertions&;
    auto hasMission(MissionLog logId, uint16 expectedMission) -> CLuaTestEntityAssertions&;
    auto hasCompletedMission(MissionLog logId, uint16 missionId) -> CLuaTestEntityAssertions&;
    auto hasItem(uint16 itemId) -> CLuaTestEntityAssertions&;
    auto hasModifier(Mod modifierId, int32 expectedValue) -> CLuaTestEntityAssertions&;
    auto isSpawned() -> CLuaTestEntityAssertions&;
    auto isAlive() -> CLuaTestEntityAssertions&;
    auto hasQuest(QuestLog logId, uint16 questId) -> CLuaTestEntityAssertions&;
    auto hasCompletedQuest(QuestLog logId, uint16 questId) -> CLuaTestEntityAssertions&;
    auto hasGil(uint32 amount) -> CLuaTestEntityAssertions&;

    auto no() -> CLuaTestEntityAssertions&;

    static void Register();

private:
    void assertCondition(bool result, const std::string& positive, const std::string& negative);

    CLuaTestEntity* entity_;
    bool            negate_;
};
