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

#ifndef _CMAGIC_STATE_H
#define _CMAGIC_STATE_H

#include "state.h"
#include "../../spell.h"

struct action_t;

enum MAGICFLAGS {
  MAGICFLAGS_NONE = 0,
  MAGICFLAGS_IGNORE_MP = 1,
  MAGICFLAGS_IGNORE_TOOLS = 2
};

class CMagicState : public CState
{
public:
    CMagicState(CBattleEntity* PEntity, uint16 targid, SpellID spellid, uint8 flags = 0);
    virtual bool Update(time_point tick) override;
    virtual void Cleanup(time_point tick) override;
    virtual bool CanChangeState() override;
    virtual bool CanFollowPath() override { return false; }
    virtual bool CanInterrupt() override { return true; }

    CSpell* GetSpell();
    virtual void TryInterrupt(CBattleEntity* PAttacker) override;

    void SpendCost();
    uint32 GetRecast();
    void ApplyEnmity(CBattleEntity* PTarget, int ce, int ve);
    void ApplyMagicCoverEnmity(CBattleEntity* PCoverAbilityTarget, CBattleEntity* PCoverAbilityUser, CMobEntity* PMob);

    void SetInstantCast(const bool bInstantCast) { m_instantCast = bInstantCast; }

protected:
    bool CanCastSpell(CBattleEntity* PTarget);

    bool HasCost();

    bool HasMoved();

    CBattleEntity* const m_PEntity;
    std::unique_ptr<CSpell> m_PSpell;
    duration m_castTime;
    position_t m_startPos;
    bool m_interrupted {false};
    bool m_instantCast {false};
    uint8 m_flags {0};
};

#endif
