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

#ifndef _CRANGE_STATE_H
#define _CRANGE_STATE_H

#include "state.h"

class CRangeState : public CState
{
public:
    CRangeState(CBattleEntity* PEntity, uint16 targid);

    void SpendCost();

    bool IsRapidShot()
    {
        return m_rapidShot;
    }

    bool IsOutOfRange()
    {
        return m_isOutOfRange;
    }

protected:
    virtual bool CanChangeState() override;

    virtual bool CanFollowPath() override
    {
        return false;
    }

    virtual bool CanInterrupt() override
    {
        return true;
    }

    virtual bool Update(timer::time_point tick) override;
    virtual void Cleanup(timer::time_point tick) override;
    bool         CanUseRangedAttack(CBattleEntity* PTarget, bool isEndOfAttack);
    bool         HasMoved();

    // This will likely need to be re-adjusted when states tick more precisely. Changed in 2012. https://wiki.ffo.jp/html/1734.html
private:
    CBattleEntity* const m_PEntity;
    timer::duration      m_aimTime{};                  // Phase 1: Delay based on weapon and job trait reductions. 120 delay = 1000 milliseconds.
    timer::duration      m_returnWeaponDelay = 800ms;  // Phase 2: Time to be locked in place while putting your weapon away after a shot.
    timer::duration      m_freePhaseTimeMob  = 1100ms; // Phase 3 (mobs/trusts): Cooldown before a ranged attack can fire again.
    timer::duration      m_freePhaseTimePlayer{};      // Phase 3 (players): Cooldown before a ranged attack can fire again, set from RANGED_ATTACK_FREE_PHASE_DELAY (Default 500ms)
    bool                 m_rapidShot{ false };
    position_t           m_startPos;
    bool                 m_isOutOfRange{ false }; // True if target moved out of range during aim time
};

#endif
