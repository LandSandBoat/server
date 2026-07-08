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

#include <common/types/maybe.h>

#include "entities/automaton_entity.h"

#include "pet_controller.h"
#include "spell.h"
#include "status_effect.h"

struct CurrentManeuvers
{
    int fire{ 0 };
    int ice{ 0 };
    int wind{ 0 };
    int earth{ 0 };
    int thunder{ 0 };
    int water{ 0 };
    int light{ 0 };
    int dark{ 0 };
};

struct AutomatonAbility
{
    uint8  requiredFrame = 0;
    uint16 skillLevel    = 0;
};

struct AutomatonSpell
{
    uint16                        skilllevel{ 0 };
    uint8                         heads{ 0 };
    xi::StatusEffect              enfeeble{ xi::StatusEffect::Ko };
    IMMUNITY                      immunity{ IMMUNITY_NONE };
    std::vector<xi::StatusEffect> removes;
};

class CAutomatonEntity;

class CAutomatonController : public CPetController
{
public:
    CAutomatonController(CAutomatonEntity* PPet);

    virtual auto Disengage() -> bool override;

protected:
    virtual auto DoCombatTick(timer::time_point tick) -> Task<void> override;
    virtual void Move() override;

    void setCooldowns();
    void setMagicCooldowns();

    virtual auto CanCastSpells(IgnoreRecastsAndCosts ignoreRecastsAndCosts) -> bool override;
    virtual auto Cast(uint16 targid, SpellID spellid) -> bool override;
    virtual auto MobSkill(uint16 targid, uint16 wsid, Maybe<timer::duration> castTimeOverride) -> bool override;

private:
    auto TryAction() -> bool;
    auto TryShieldBash() -> bool;
    auto TrySpellcast(const CurrentManeuvers& maneuvers) -> bool;
    auto TryHeal(const CurrentManeuvers& maneuvers) -> bool;
    auto TryElemental(const CurrentManeuvers& maneuvers) -> bool;
    auto TryEnfeeble(const CurrentManeuvers& maneuvers) -> bool;
    auto TryStatusRemoval(const CurrentManeuvers& maneuvers) -> bool;
    auto TryEnhance() -> bool;
    auto TryTPMove() -> bool;
    auto TryRangedAttack() -> bool;
    auto TryAttachment() -> bool;
    auto shouldStandBack() const -> bool;

    auto GetCurrentManeuvers() const -> CurrentManeuvers;

    CAutomatonEntity* PAutomaton;

    timer::duration      m_actionCooldown{ 3s };
    timer::duration      m_rangedCooldown{};
    static constexpr int m_RangedAbility{ 1949 };
    timer::duration      m_magicCooldown{};
    timer::duration      m_enfeebleCooldown{};
    timer::duration      m_elementalCooldown{};
    timer::duration      m_healCooldown{};
    timer::duration      m_enhanceCooldown{};
    timer::duration      m_statusCooldown{};
    timer::duration      m_shieldbashCooldown{};
    static constexpr int m_ShieldBashAbility{ 1944 };

    timer::time_point m_LastActionTime;
    timer::time_point m_LastMagicTime;
    timer::time_point m_LastEnfeebleTime;
    timer::time_point m_LastElementalTime;
    timer::time_point m_LastHealTime;
    timer::time_point m_LastEnhanceTime;
    timer::time_point m_LastStatusTime;
    timer::time_point m_LastRangedTime;
    timer::time_point m_LastShieldBashTime;
};

namespace automaton
{

void LoadAutomatonSpellList();
bool CanUseSpell(CAutomatonEntity* PCaster, SpellID spellid);
bool CanUseEnfeeble(CBattleEntity* PTarget, SpellID spell);
auto FindNaSpell(CStatusEffect* PStatus) -> Maybe<SpellID>;
void LoadAutomatonAbilities();

}; // namespace automaton
