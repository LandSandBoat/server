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

#include <vector>

#include "common/mmo.h"

#include "entities/mob_entity.h"
#include "spell.h"

class CMobSpellContainer
{
public:
    CMobSpellContainer(CMobEntity* PMob);

    // These methods return a random spell
    auto GetAggroSpell() -> Maybe<SpellID>;                                // -ga spell, dia, bio, paralyze, silence, blind
    auto GetGaSpell() -> Maybe<SpellID>;                                   // AoE damage spells, stonega, diaga
    auto GetDamageSpell() -> Maybe<SpellID>;                               // Single target damage spells, stone
    auto GetBuffSpell() -> Maybe<SpellID>;                                 // stoneskin, utsusemi, blink
    auto GetBuffSpellsFor(CBattleEntity* PTarget) -> std::vector<SpellID>; // castable buffs the target still lacks
    auto GetDebuffSpell() -> Maybe<SpellID>;
    auto GetHealSpell() -> Maybe<SpellID>;   // cures, regen, armys paeon
    auto GetNaSpell() -> Maybe<SpellID>;     // silena, blindna etc
    auto GetSevereSpell() -> Maybe<SpellID>; // select spells like death, impact, meteor
    auto GetSpell() -> Maybe<SpellID>;       // return a random spell

    auto IsAnySpellAvailable() -> bool;

    auto HasSpells() const -> bool;
    auto HasMPSpells() const -> bool;
    auto HasNaSpell(SpellID spellId) const -> bool;
    auto HasGaSpells() const -> bool;
    auto HasDamageSpells() const -> bool;
    auto HasBuffSpells() const -> bool;
    auto HasHealSpells() const -> bool;
    auto HasNaSpells() const -> bool;
    auto HasRaiseSpells() const -> bool;
    auto HasDebuffSpells() const -> bool;
    auto HasSevereSpells() const -> bool;

    void ClearSpells();
    void AddSpell(SpellID spellId);
    void RemoveSpell(SpellID spellId);

    auto GetAvailable(SpellID spellId) -> Maybe<SpellID>;
    auto GetBestAvailable(SPELLFAMILY family) -> Maybe<SpellID>;
    auto GetBestIndiSpell(CBattleEntity* PMaster) -> Maybe<SpellID>;
    auto GetBestEntrustedSpell(CBattleEntity* PMaster) -> Maybe<SpellID>;
    auto GetBestAgainstTargetWeakness(CBattleEntity* PTarget, SpellID spellId) -> Maybe<SpellID>;
    auto EnSpellAgainstTargetWeakness(CBattleEntity* PTarget) -> Maybe<SpellID>;
    auto StormDayAgainstTargetWeakness(CBattleEntity* PTarget) -> Maybe<SpellID>;
    auto HelixAgainstTargetWeakness(CBattleEntity* PTarget) -> Maybe<SpellID>;
    auto GetStormDay() -> Maybe<SpellID>;
    auto GetHelixDay() -> Maybe<SpellID>;

    std::vector<SpellID> m_gaList;
    std::vector<SpellID> m_damageList;
    std::vector<SpellID> m_buffList;
    std::vector<SpellID> m_debuffList;
    std::vector<SpellID> m_healList;
    std::vector<SpellID> m_naList;
    std::vector<SpellID> m_raiseList;
    std::vector<SpellID> m_severeList;

private:
    CMobEntity* m_PMob;
    bool        m_hasSpells;
};
