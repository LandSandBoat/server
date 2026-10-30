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

#include "enums/action/knockback.h"
#include "spell.h"

class CBlueSpell : public CSpell
{
public:
    CBlueSpell(SpellID id);
    auto clone() -> std::unique_ptr<CSpell> override;

    auto getMonsterSkillId() const -> uint16;
    auto getSetPoints() const -> uint8;
    auto getEcosystem() const -> uint8;
    auto getTraitCategory() const -> uint8;
    auto getTraitWeight() const -> uint8;
    auto getPrimarySkillchain() const -> uint8;
    auto getSecondarySkillchain() const -> uint8;
    auto getTertiarySkillchain() const -> uint8;
    auto getKnockback() const -> Knockback;

    void setMonsterSkillId(uint16 skillid);
    void setSetPoints(uint8 setpoints);
    void setEcosystem(uint8 ecosystem);
    void setTraitCategory(uint8 category);
    void setTraitWeight(uint8 weight);
    void setPrimarySkillchain(uint8 sc);
    void setSecondarySkillchain(uint8 sc);
    void setTertiarySkillchain(uint8 sc);
    void setKnockback(Knockback kb);
    void addModifier(CModifier modifier);

    std::vector<CModifier> modList; // modifiers added when blue spell is equipped

private:
    uint16    m_monsterSkillId{}; // matching skill for a blue spell
    uint8     m_setPoints{};
    uint8     m_ecosystem{};
    uint8     m_traitCategory{};
    uint8     m_traitWeight{};
    uint8     m_PrimarySkillchain{};
    uint8     m_SecondarySkillchain{};
    uint8     m_TertiarySkillchain{};
    Knockback knockback_{ Knockback::None };
};
