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

#include "enums/msg_basic.h"

#include <unordered_map>

namespace messageutils
{
// Maps the main message used by skills for their subtarget variant
const std::unordered_map<MsgBasic, MsgBasic> aoeVariants = {
    { MsgBasic::MAGIC_RECOVERS_HP, MsgBasic::TARGET_RECOVERS_HP },
    { MsgBasic::MAGIC_TELEPORT, MsgBasic::TARGET_TELEPORT },
    { MsgBasic::MAGIC_RESISTED, MsgBasic::MAGIC_RESISTED_TARGET },
    { MsgBasic::MAGIC_GAINS_EFFECT, MsgBasic::TARGET_GAINS_EFFECT },
    { MsgBasic::MAGIC_STATUS, MsgBasic::TARGET_STATUS },
    { MsgBasic::MAGIC_RECEIVES_EFFECT, MsgBasic::TARGET_RECEIVES_EFFECT },
    { MsgBasic::MAGIC_DAMAGE, MsgBasic::TARGET_TAKES_DAMAGE },
    { MsgBasic::USES_SKILL_TAKES_DAMAGE, MsgBasic::TARGET_TAKES_DAMAGE },
    { MsgBasic::USES_SKILL_GAINS_EFFECT, MsgBasic::TARGET_GAINS_EFFECT },
    { MsgBasic::USES_SKILL_HP_DRAINED, MsgBasic::TARGET_HP_DRAINED },
    { MsgBasic::USES_SKILL_MISSES, MsgBasic::TARGET_EVADES },
    { MsgBasic::USES_SKILL_NO_EFFECT, MsgBasic::TARGET_NO_EFFECT },
    { MsgBasic::USES_SKILL_MP_DRAINED, MsgBasic::TARGET_MP_DRAINED },
    { MsgBasic::USES_SKILL_STATUS, MsgBasic::TARGET_STATUS },
    { MsgBasic::USES_SKILL_RECEIVES_EFFECT, MsgBasic::TARGET_RECEIVES_EFFECT },
    { MsgBasic::USES_SKILL_EFFECT_DRAINED, MsgBasic::TARGET_EFFECT_DRAINED },
    { MsgBasic::USES_SKILL_TP_REDUCED, MsgBasic::TARGET_TP_REDUCED },
    { MsgBasic::USES_SKILL_RECOVERS_MP, MsgBasic::TARGET_RECOVERS_MP },
    { MsgBasic::USES_RECOVERS_HP, MsgBasic::TARGET_RECOVERS_HP2 },
    { MsgBasic::SKILL_RECOVERS_HP, MsgBasic::TARGET_RECOVERS_HP_SIMPLE },
    { MsgBasic::USES_SKILL_RECOVERS_HP_AOE, MsgBasic::TARGET_RECOVERS_HP_SIMPLE },
    { MsgBasic::USES_ITEM_RECOVERS_HP_AOE, MsgBasic::TARGET_RECOVERS_HP_SIMPLE },
    { MsgBasic::USES_ITEM_RECOVERS_HP_AOE2, MsgBasic::TARGET_RECOVERS_HP_SIMPLE },
    { MsgBasic::USES_BUT_MISSES, MsgBasic::TARGET_EVADES },
    { MsgBasic::ABILITY_MISSES, MsgBasic::TARGET_EVADES },
    { MsgBasic::USES_ABILITY_DISPEL, MsgBasic::TARGET_EFFECT_DISAPPEARS },
    { MsgBasic::USES_JA_TAKE_DAMAGE, MsgBasic::TARGET_TAKES_DAMAGE },
    { MsgBasic::USES_ABILITY_FORTIFIED_DRAGONS, MsgBasic::TARGET_FORTIFIED_DRAGONS },
    { MsgBasic::USES_ABILITY_RECHARGE, MsgBasic::TARGET_ABILITIES_RECHARGED },
    { MsgBasic::USES_ABILITY_RECHARGE_TP, MsgBasic::TARGET_RECHARGED_TP },
    { MsgBasic::USES_ABILITY_RECHARGE_MP, MsgBasic::TARGET_RECHARGED_MP },
    { MsgBasic::VALLATION_GAIN, MsgBasic::VALIANCE_GAIN_PARTY_MEMBER },
    { MsgBasic::ROLL_MAIN, MsgBasic::ROLL_SUB },
    { MsgBasic::DOUBLEUP, MsgBasic::ROLL_SUB },
    { MsgBasic::ROLL_MAIN_FAIL, MsgBasic::ROLL_SUB_FAIL },
    { MsgBasic::DOUBLEUP_FAIL, MsgBasic::ROLL_SUB_FAIL },
    { MsgBasic::DOUBLEUP_BUST, MsgBasic::DOUBLEUP_BUST_SUB },
};

const std::unordered_map<MsgBasic, MsgBasic> absorbVariants = {
    { MsgBasic::USES_ABILITY_TAKES_DAMAGE, MsgBasic::USES_RECOVERS_HP },
    { MsgBasic::TARGET_TAKES_DAMAGE, MsgBasic::TARGET_RECOVERS_HP2 },
};

auto GetAoEVariant(MsgBasic primary) -> MsgBasic;
auto GetAbsorbVariant(MsgBasic primary) -> MsgBasic;
} // namespace messageutils
