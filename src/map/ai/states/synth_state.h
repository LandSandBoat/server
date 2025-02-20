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

#ifndef _CSYNTH_STATE_H
#define _CSYNTH_STATE_H

#include "entities/battleentity.h"
#include "state.h"

class CSynthState : public CState
{
public:
    CSynthState(CCharEntity* PChar, SKILLTYPE skill);

    // state logic done per tick - returns whether to exit the state or not
    virtual bool Update(time_point tick) override;

    virtual void Cleanup(time_point tick) override;
    // whether the state can be changed by normal means
    virtual bool CanChangeState() override
    {
        return false;
    }
    virtual bool CanFollowPath() override
    {
        return false;
    }
    virtual bool CanInterrupt() override
    {
        return false;
    }

protected:
    virtual void UpdateTarget(uint16 = 0) override;
    virtual void UpdateTarget(CBaseEntity* target) override;

    bool SynthReady();

private:
    CCharEntity* const m_PEntity;
    duration           m_synthFinishTime{ 16s };
};

#endif
