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
class CCharEntity;

class CRangeState : public CState
{
public:
    CRangeState(CBattleEntity* PEntity, uint16 targid);

    void SpendCost();
    bool IsRapidShot() { return m_rapidShot; }
protected:
    virtual bool CanChangeState() override;
    virtual bool CanFollowPath() override { return false; }
    virtual bool CanInterrupt() override { return true; }
    virtual bool Update(time_point tick) override;
    virtual void Cleanup(time_point tick) override;
    bool CanUseRangedAttack(CBattleEntity* PTarget);

private:
    CBattleEntity* const m_PEntity;
    duration m_aimTime;
    bool m_rapidShot {false};
    position_t m_startPos;
};

#endif
