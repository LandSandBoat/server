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
    { MsgBasic::MagicRecoversHP, MsgBasic::TargetRecoversHP },
    { MsgBasic::MagicTeleport, MsgBasic::TargetTeleport },
    { MsgBasic::MagicResisted, MsgBasic::MagicResistedTarget },
    { MsgBasic::MagicGainsEffect, MsgBasic::TargetGainsEffect },
    { MsgBasic::MagicStatus, MsgBasic::TargetStatus },
    { MsgBasic::MagicReceivesEffect, MsgBasic::TargetReceivesEffect },
    { MsgBasic::MagicDamage, MsgBasic::TargetTakesDamage },
    { MsgBasic::UsesSkillTakesDamage, MsgBasic::TargetTakesDamage },
    { MsgBasic::UsesSkillGainsEffect, MsgBasic::TargetGainsEffect },
    { MsgBasic::UsesSkillHPDrained, MsgBasic::TargetHPDrained },
    { MsgBasic::UsesSkillMisses, MsgBasic::TargetEvades },
    { MsgBasic::UsesSkillNoEffect, MsgBasic::TargetNoEffect },
    { MsgBasic::UsesSkillMPDrained, MsgBasic::TargetMPDrained },
    { MsgBasic::UsesSkillStatus, MsgBasic::TargetStatus },
    { MsgBasic::UsesSkillReceivesEffect, MsgBasic::TargetReceivesEffect },
    { MsgBasic::UsesSkillEffectDrained, MsgBasic::TargetEffectDrained },
    { MsgBasic::UsesSkillTPReduced, MsgBasic::TargetTPReduced },
    { MsgBasic::UsesSkillRecoversMP, MsgBasic::TargetRecoversMP },
    { MsgBasic::UsesRecoversHP, MsgBasic::TargetRecoversHP2 },
    { MsgBasic::SkillRecoversHP, MsgBasic::TargetRecoversHPSimple },
    { MsgBasic::UsesSkillRecoversHPAreaOfEffect, MsgBasic::TargetRecoversHPSimple },
    { MsgBasic::UsesItemRecoversHPAreaOfEffect, MsgBasic::TargetRecoversHPSimple },
    { MsgBasic::UsesItemRecoversHPAreaOfEffect2, MsgBasic::TargetRecoversHPSimple },
    { MsgBasic::UsesButMisses, MsgBasic::TargetEvades },
    { MsgBasic::AbilityMisses, MsgBasic::TargetEvades },
    { MsgBasic::UsesAbilityDispel, MsgBasic::TargetEffectDisappears },
    { MsgBasic::UsesJobAbilityTakeDamage, MsgBasic::TargetTakesDamage },
    { MsgBasic::UsesAbilityFortifiedUndead, MsgBasic::TargetFortifiedUndead },
    { MsgBasic::UsesAbilityFortifiedArcana, MsgBasic::TargetFortifiedArcana },
    { MsgBasic::UsesAbilityFortifiedDemons, MsgBasic::TargetFortifiedDemons },
    { MsgBasic::UsesAbilityFortifiedDragons, MsgBasic::TargetFortifiedDragons },
    { MsgBasic::UsesAbilityGainsEffect, MsgBasic::TargetGainsEffect },
    { MsgBasic::UsesAbilityEffect, MsgBasic::ReceivesEffectAbility },
    { MsgBasic::UsesAbilityRecharge, MsgBasic::TargetAbilitiesRecharged },
    { MsgBasic::UsesAbilityRechargeTP, MsgBasic::TargetRechargedTP },
    { MsgBasic::UsesAbilityRechargeMP, MsgBasic::TargetRechargedMP },
    { MsgBasic::VallationGain, MsgBasic::ValianceGainPartyMember },
    { MsgBasic::RollMain, MsgBasic::ReceivesEffectAbility },
    { MsgBasic::DoubleUp, MsgBasic::ReceivesEffectAbility },
    { MsgBasic::RollMainFail, MsgBasic::RollSubFail },
    { MsgBasic::DoubleUpFail, MsgBasic::RollSubFail },
    { MsgBasic::DoubleUpBust, MsgBasic::DoubleUpBustSub },
};

const std::unordered_map<MsgBasic, MsgBasic> absorbVariants = {
    { MsgBasic::UsesAbilityTakesDamage, MsgBasic::UsesRecoversHP },
    { MsgBasic::TargetTakesDamage, MsgBasic::TargetRecoversHP2 },
};

auto GetAoEVariant(MsgBasic primary) -> MsgBasic;
auto GetAbsorbVariant(MsgBasic primary) -> MsgBasic;
} // namespace messageutils
