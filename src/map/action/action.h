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
#include "entities/battleentity.h"
#include "enums/action/animation.h"
#include "enums/action/category.h"
#include "enums/action/hit_distortion.h"
#include "enums/action/info.h"
#include "enums/action/knockback.h"
#include "enums/action/modifier.h"
#include "enums/action/proc_kind.h"
#include "enums/action/react_kind.h"
#include "enums/action/resolution.h"
#include "enums/four_cc.h"
#include "spell.h"
#include "zone.h"

#define MAX_ACTION_TARGETS 64

struct attack_outcome_t
{
    ATTACK_TYPE    atkType{ ATTACK_TYPE::PHYSICAL };
    int32          damage{ 0 };
    CBattleEntity* target{ nullptr };
    bool           isCritical{ false };
};

struct action_result_t
{
    ActionResolution resolution{ ActionResolution::Hit };   // result.miss (3 bits)
    uint8_t          kind{ 0 };                             // result.kind (2 bits)
    ActionAnimation  animation{ ActionAnimation::None };    // result.sub_kind (12 bits)
    ActionInfo       info{ ActionInfo::None };              // result.info (5 bits)
    HitDistortion    hitDistortion{ HitDistortion::None };  // result.scale (2 bits) (shared with knockback)
    Knockback        knockback{ Knockback::None };          // result.scale (3 bits) (shared with hitDistortion)
    int32            param{ 0 };                            // result.value - 17 bits
    MSGBASIC_ID      messageID{ MSGBASIC_NONE };            // result.message - 10 bits
    ActionModifier   modifier{ ActionModifier::None };      // result.bit - 31 bits
    ActionProcKind   additionalEffect{};                    // result.has_proc (1 bit), result.proc_kind (6 bits)
    uint8_t          addEffectInfo{ 0 };                    // result.proc_info (4 bits)
    int32            addEffectParam{ 0 };                   // result.proc_value (17 bits)
    MSGBASIC_ID      addEffectMessage{ MSGBASIC_NONE };     // result.proc_message (10 bits)
    ActionReactKind  spikesEffect{ ActionReactKind::None }; // result.has_react (1 bit), result.react_kind (6 bits)
    uint8_t          spikesInfo{ 0 };                       // result.react_info (4 bits)
    uint16           spikesParam{ 0 };                      // result.react_value (14 bits)
    MSGBASIC_ID      spikesMessage{ MSGBASIC_NONE };        // result.react_message (10 bits)

    void recordSkillchain(ActionProcSkillChain effect, int16_t dmg);
    auto recordDamage(const attack_outcome_t& outcome) -> action_result_t&;

    inline auto hasAdditionalEffect() const -> bool
    {
        return std::visit([]<typename T>(const T& value)
                          {
                              return value != T{ 0 };
                          },
                          this->additionalEffect);
    }
};

struct action_target_t
{
    uint32                       actorId{ 0 };
    std::vector<action_result_t> results{};

    auto addResult() -> action_result_t&
    {
        return *results.emplace(results.end());
    }
};

struct action_t
{
    uint32                       actorId{ 0 };
    ActionCategory               actiontype{ ActionCategory::None };
    uint32                       actionid{ 0 };
    timer::duration              recast{ 0s };
    SPELLGROUP                   spellgroup{ SPELLGROUP_NONE };
    std::vector<action_target_t> targets{};

    auto addTarget(const uint32 targetId) -> action_target_t&
    {
        return targets.emplace_back(action_target_t{ .actorId = targetId });
    }

    template <typename Func>
    void ForEachResult(Func&& func)
    {
        for (auto& actionTarget : targets)
        {
            std::ranges::for_each(actionTarget.results, std::forward<Func>(func));
        }
    }

    template <typename Func>
    void ForEachTarget(Func&& func)
    {
        for (auto& target : targets)
        {
            func(target);
        }
    }

    void normalize();
};
