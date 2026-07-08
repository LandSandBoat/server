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

#pragma once

#include "common/cbasetypes.h"
#include "common/mmo.h"

#include <vector>

#include "modifier.h"

#include "data/enums/status_effect.h"
#include "data/enums/status_effect_flag.h"

#define MAX_EFFECTID 814 // 768 real + 46 custom

/************************************************************************
 *                                                                       *
 *  TODO: (?) Unsolved problems:                                         *
 *                                                                       *
 *  - updating the effect (e.g., rewriting Protect I to Protect II)      *
 *                                                                       *
 ************************************************************************/

class CBattleEntity;

enum EffectSourceType : uint8_t
{
    SOURCE_NONE           = 0,
    SOURCE_EQUIPPED_ITEM  = 1,
    SOURCE_TEMPORARY_ITEM = 2,
    SOURCE_MOB            = 3,
    SOURCE_FOOD           = 4,
    SOURCE_CORSAIR_ROLL   = 5,
};

class CStatusEffect final
{
public:
    CStatusEffect(xi::StatusEffect id, uint16 icon, uint16 power, timer::duration tick, timer::duration duration, uint32 subid = 0, uint16 subPower = 0, uint16 subIcon = 0, uint16 tier = 0, xi::StatusEffectFlag flags = xi::StatusEffectFlag::None, uint16 sourceType = EffectSourceType::SOURCE_NONE, uint32 sourceTypeParam = 0, uint32 originID = 0, uint8 slot = 0);
    ~CStatusEffect();

    auto GetStatusID() const -> xi::StatusEffect;
    auto GetSubID() const -> uint32;
    auto GetSourceType() const -> uint16;
    auto GetSourceTypeParam() const -> uint32;
    auto GetOriginID() const -> uint32;
    auto GetIcon() const -> uint16;
    auto GetPower() const -> uint16;
    auto GetSubPower() const -> uint16;
    auto GetSubIcon() const -> uint16;
    auto GetTier() const -> uint16;
    auto GetEffectFlags() const -> xi::StatusEffectFlag;
    auto GetEffectType() const -> uint16;
    auto GetEffectSlot() const -> uint8;

    auto GetTickTime() const -> timer::duration;
    auto GetDuration() const -> timer::duration;
    auto GetElapsedTickCount() const -> int;
    auto GetStartTime() const -> timer::time_point;
    auto GetOwner() const -> CBattleEntity*;

    auto SetEffectFlags(xi::StatusEffectFlag flags) -> void;
    auto AddEffectFlag(xi::StatusEffectFlag flag) -> void;
    auto DelEffectFlag(xi::StatusEffectFlag flag) -> void;
    auto HasEffectFlag(xi::StatusEffectFlag flag) const -> bool;
    auto SetEffectType(uint16 type) -> void;
    auto SetEffectSlot(uint8 slot) -> void;
    auto SetIcon(uint16 icon) -> void;
    auto SetSource(uint16 sourceType, uint32 sourceTypeParam) -> void;
    auto SetPower(uint16 power) -> void;
    auto SetSubPower(uint16 subPower) -> void;
    auto SetSubIcon(uint16 subIcon) -> void;
    auto SetTier(uint16 tier) -> void;
    auto SetDuration(timer::duration duration) -> void;
    auto SetOwner(CBattleEntity* owner) -> void;
    auto SetTickTime(timer::duration tick) -> void;
    auto SetOriginID(uint32 originID) -> void;

    auto IncrementElapsedTickCount() -> void;
    auto SetStartTime(timer::time_point startTime) -> void;

    auto addMod(Mod modType, int16 amount) -> void;
    auto setMod(Mod modType, int16 value) -> void;

    auto SetEffectName(std::string name) -> void;
    auto GetName() const -> const std::string&;

    auto modList() -> std::vector<CModifier>&;

    auto markDeleted() -> void;
    auto isDeleted() const -> bool;

private:
    CBattleEntity* owner_{ nullptr };

    std::vector<CModifier> modList_;          // List of modifiers
    bool                   deleted_{ false }; // Pending-removal flag, swept by CStatusEffectContainer

    xi::StatusEffect     statusID_{ xi::StatusEffect::None };  // Main effect type
    uint32               subID_{ 0 };                          // Additional effect type
    uint16               icon_{ 0 };                           // Effect icon
    uint16               power_{ 0 };                          // Strength of effect
    uint16               subPower_{ 0 };                       // Secondary power of the effect
    uint16               subIcon_{ 0 };                        // Secondary icon for the sub effect (used for things like setting an Aura sub effect icon)
    uint16               tier_{ 0 };                           // Tier of the effect
    xi::StatusEffectFlag flags_{ xi::StatusEffectFlag::None }; // Effect flags (conditions for its disappearance)
    uint32               originID_{ 0 };                       // The effect's origin ID. (This is usually the ID of the entity that created the effect)
    uint16               sourceType_{ 0 };                     // The effect's source type
    uint32               sourceTypeParam_{ 0 };                // The effect's source ID
    uint16               type_{ 0 };                           // Used to enforce only one
    uint8                slot_{ 0 };                           // Used to determine slot order for songs/rolls

    timer::duration   tickTime_{ 0ms }; // Effect repetition time
    timer::duration   duration_{ 0ms }; // Duration of effect
    timer::time_point startTime_;       // Time to obtain effect
    int               tickCount_{ 0 };  // Elapsed ticks

    std::string name_; // Effect name for scripts
};
