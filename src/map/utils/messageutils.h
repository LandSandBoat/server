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

#include "data/enums/msg_basic.h"

#include <common/types/hash_map.h>

namespace messageutils
{

// Maps the main message used by skills for their subtarget variant
const HashMap<xi::MsgBasic, xi::MsgBasic> aoeVariants = {
    { xi::MsgBasic::MagicRecoversHp, xi::MsgBasic::TargetRecoversHp },
    { xi::MsgBasic::MagicTeleport, xi::MsgBasic::TargetTeleport },
    { xi::MsgBasic::MagicResist, xi::MsgBasic::MagicResistedTarget },
    { xi::MsgBasic::MagicGainEffect, xi::MsgBasic::JaGainEffect },
    { xi::MsgBasic::MagicEnfeebIs, xi::MsgBasic::TargetStatus },
    { xi::MsgBasic::MagicEnfeeb, xi::MsgBasic::TargetReceivesEffect },
    { xi::MsgBasic::MagicDmg, xi::MsgBasic::TargetTakesDamage },
    { xi::MsgBasic::Damage, xi::MsgBasic::TargetTakesDamage },
    { xi::MsgBasic::SkillGainEffect, xi::MsgBasic::JaGainEffect },
    { xi::MsgBasic::UsesSkillHpDrained, xi::MsgBasic::TargetHpDrained },
    { xi::MsgBasic::SkillMiss, xi::MsgBasic::TargetEvades },
    { xi::MsgBasic::SkillNoEffect, xi::MsgBasic::NoEffect },
    { xi::MsgBasic::SkillDrainMp, xi::MsgBasic::TargetMpDrained },
    { xi::MsgBasic::SkillEnfeebIs, xi::MsgBasic::TargetStatus },
    { xi::MsgBasic::SkillEnfeeb, xi::MsgBasic::TargetReceivesEffect },
    { xi::MsgBasic::EffectDrained, xi::MsgBasic::TargetEffectDrained },
    { xi::MsgBasic::TpReduced, xi::MsgBasic::TargetTpReduced },
    { xi::MsgBasic::SkillRecoversMp, xi::MsgBasic::TargetRecoversMp },
    { xi::MsgBasic::JaRecoversHp, xi::MsgBasic::SelfHealSecondary },
    { xi::MsgBasic::SkillRecoversHp, xi::MsgBasic::RecoversHp },
    { xi::MsgBasic::UsesSkillRecoversHpAreaOfEffect, xi::MsgBasic::TargetRecoversHp },
    { xi::MsgBasic::UsesItemRecoversHpAreaOfEffect, xi::MsgBasic::RecoversHp },
    { xi::MsgBasic::JaRecoversHp2, xi::MsgBasic::SelfHealSecondary },
    { xi::MsgBasic::JaMiss2, xi::MsgBasic::TargetEvades },
    { xi::MsgBasic::JaMiss, xi::MsgBasic::TargetEvades },
    { xi::MsgBasic::ItemEffectDisappears, xi::MsgBasic::TargetEffectDisappears },
    { xi::MsgBasic::UsesJaTakeDamage, xi::MsgBasic::TargetTakesDamage },
    { xi::MsgBasic::UsesAbilityFortifiedUndead, xi::MsgBasic::TargetFortifiedUndead },
    { xi::MsgBasic::UsesAbilityFortifiedArcana, xi::MsgBasic::TargetFortifiedArcana },
    { xi::MsgBasic::UsesAbilityFortifiedDemons, xi::MsgBasic::TargetFortifiedDemons },
    { xi::MsgBasic::UsesAbilityFortifiedDragons, xi::MsgBasic::TargetFortifiedDragons },
    { xi::MsgBasic::UsesAbilityGainsEffect, xi::MsgBasic::JaGainEffect },
    { xi::MsgBasic::JaReceivesEffect2, xi::MsgBasic::JaReceivesEffect },
    { xi::MsgBasic::JaNoEffect2, xi::MsgBasic::NoEffect },
    { xi::MsgBasic::UsesAbilityEffect, xi::MsgBasic::ReceivesEffectAbility },
    { xi::MsgBasic::UsesAbilityRecharge, xi::MsgBasic::TargetAbilitiesRecharged },
    { xi::MsgBasic::UsesAbilityRechargeTp, xi::MsgBasic::TargetRechargedTp },
    { xi::MsgBasic::UsesAbilityRechargeMp, xi::MsgBasic::TargetRechargedMp },
    { xi::MsgBasic::VallationGain, xi::MsgBasic::ValianceGainPartyMember },
    { xi::MsgBasic::RollMain, xi::MsgBasic::ReceivesEffectAbility },
    { xi::MsgBasic::DoubleUp, xi::MsgBasic::ReceivesEffectAbility },
    { xi::MsgBasic::RollMainFail, xi::MsgBasic::RollSubFail },
    { xi::MsgBasic::DoubleUpFail, xi::MsgBasic::RollSubFail },
    { xi::MsgBasic::DoubleUpBust, xi::MsgBasic::DoubleUpBustSub },
};

const HashMap<xi::MsgBasic, xi::MsgBasic> absorbVariants = {
    { xi::MsgBasic::JaDamage, xi::MsgBasic::JaRecoversHp },
    { xi::MsgBasic::TargetTakesDamage, xi::MsgBasic::SelfHealSecondary },
};

auto GetAoEVariant(xi::MsgBasic primary) -> xi::MsgBasic;
auto GetAbsorbVariant(xi::MsgBasic primary) -> xi::MsgBasic;

} // namespace messageutils
