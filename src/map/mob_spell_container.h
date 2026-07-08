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

#ifndef _CMOBSPELLCONTAINER_H
#define _CMOBSPELLCONTAINER_H

#include <vector>

#include "common/cbasetypes.h"
#include "common/mmo.h"

#include "entities/mob_entity.h"
#include "spell.h"

class CMobSpellContainer
{
public:
    CMobSpellContainer(CMobEntity* PMob);

    // These methods return a random spell
    Maybe<SpellID> GetAggroSpell();  // -ga spell, dia, bio, paralyze, silence, blind
    Maybe<SpellID> GetGaSpell();     // AoE damage spells, stonega, diaga
    Maybe<SpellID> GetDamageSpell(); // Single target damage spells, stone
    Maybe<SpellID> GetBuffSpell();   // stoneskin, utsusemi, blink
    Maybe<SpellID> GetDebuffSpell();
    Maybe<SpellID> GetHealSpell();   // cures, regen, armys paeon
    Maybe<SpellID> GetNaSpell();     // silena, blindna etc
    Maybe<SpellID> GetSevereSpell(); // select spells like death, impact, meteor
    Maybe<SpellID> GetSpell();       // return a random spell

    bool IsAnySpellAvailable();

    bool HasSpells() const;
    bool HasMPSpells() const;
    bool HasNaSpell(SpellID spellId) const;
    bool HasGaSpells() const;
    bool HasDamageSpells() const;
    bool HasBuffSpells() const;
    bool HasHealSpells() const;
    bool HasNaSpells() const;
    bool HasRaiseSpells() const;
    bool HasDebuffSpells() const;
    bool HasSevereSpells() const;

    void ClearSpells();
    void AddSpell(SpellID spellId);
    void RemoveSpell(SpellID spellId);

    Maybe<SpellID> GetAvailable(SpellID spellId);
    Maybe<SpellID> GetBestAvailable(SPELLFAMILY family);
    Maybe<SpellID> GetBestIndiSpell(CBattleEntity* PMaster);
    Maybe<SpellID> GetBestEntrustedSpell(CBattleEntity* PMaster);
    Maybe<SpellID> GetBestAgainstTargetWeakness(CBattleEntity* PTarget, SpellID spellId);
    Maybe<SpellID> EnSpellAgainstTargetWeakness(CBattleEntity* PTarget);
    Maybe<SpellID> StormDayAgainstTargetWeakness(CBattleEntity* PTarget);
    Maybe<SpellID> HelixAgainstTargetWeakness(CBattleEntity* PTarget);
    Maybe<SpellID> GetStormDay();
    Maybe<SpellID> GetHelixDay();

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

#endif
