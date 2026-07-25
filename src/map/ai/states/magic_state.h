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

#include "spell.h"
#include "state.h"

class CMobEntity;

enum MAGICFLAGS
{
    MAGICFLAGS_NONE         = 0,
    MAGICFLAGS_IGNORE_MP    = 1,
    MAGICFLAGS_IGNORE_TOOLS = 2
};

class CMagicState : public CState
{
public:
    CMagicState(CBattleEntity* PEntity, const EntityId& target, SpellID spellid, uint8 flags = 0);

    auto Update(timer::time_point tick) -> bool override;
    void Cleanup(timer::time_point tick) override;
    auto CanChangeState() -> bool override;
    auto CanFollowPath() -> bool override;
    auto CanInterrupt() -> bool override;
    auto GetSpell() const -> CSpell*;
    void TryInterrupt(CBattleEntity* PAttacker) override;
    void SpendCost();
    auto GetRecast() const -> timer::duration;
    void ApplyEnmity(CBattleEntity* PTarget, int ce, int ve) const;
    void ApplyMagicCoverEnmity(CBattleEntity* PCoverAbilityTarget, CBattleEntity* PCoverAbilityUser, CMobEntity* PMob) const;
    void SetInstantCast(bool bInstantCast);
    auto IsInstantCast() const -> bool;

protected:
    auto CanCastSpell(CBattleEntity* PTarget, bool isEndOfCast) -> bool;
    auto HasCost() -> bool;
    auto HasMoved() const -> bool;

    CBattleEntity* const    m_PEntity;
    std::unique_ptr<CSpell> m_PSpell;
    timer::duration         m_castTime{};
    position_t              m_startPos;
    bool                    m_interrupted{ false };
    bool                    m_instantCast{ false };
    uint8                   m_flags{ 0 };
};
