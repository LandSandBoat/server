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

#include "../common/cbasetypes.h"
#include "../common/mmo.h"

#include "spell.h"
#include "entities/mobentity.h"
#include <optional>

class CMobSpellContainer
{
public:

  CMobSpellContainer(CMobEntity* PMob);

  // These methods return a random spell
  std::optional<SpellID> GetAggroSpell(); // -ga spell, dia, bio, paralyze, silence, blind
  std::optional<SpellID> GetGaSpell(); // AoE damage spells, stonega, diaga
  std::optional<SpellID> GetDamageSpell(); // Single target damage spells, stone
  std::optional<SpellID> GetBuffSpell(); // stoneskin, utsusemi, blink
  std::optional<SpellID> GetDebuffSpell();
  std::optional<SpellID> GetHealSpell(); // cures, regen, armys paeon
  std::optional<SpellID> GetNaSpell(); // silena, blindna etc
  std::optional<SpellID> GetSpell(); // return a random spell

  bool HasSpells() const;
  bool HasMPSpells() const;
  bool HasNaSpell(SpellID spellId) const;
  bool HasGaSpells() const;
  bool HasDamageSpells() const;
  bool HasBuffSpells() const;
  bool HasHealSpells() const;
  bool HasNaSpells() const;
  bool HasDebuffSpells() const;

  void ClearSpells();
  void AddSpell(SpellID spellId);
  void RemoveSpell(SpellID spellId);

  std::optional<SpellID> GetAvailable(SpellID spellId);
  std::optional<SpellID> GetBestAvailable(SPELLFAMILY family);

  std::vector<SpellID> m_gaList;
  std::vector<SpellID> m_damageList;
  std::vector<SpellID> m_buffList;
  std::vector<SpellID> m_debuffList;
  std::vector<SpellID> m_healList;
  std::vector<SpellID> m_naList;

private:
  CMobEntity* m_PMob;
  bool m_hasSpells;
};

#endif
