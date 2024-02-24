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

#ifndef _CRESPAWN_STATE_H
#define _CRESPAWN_STATE_H

#include "ai/state.h"

class CRespawnState : public CState
{
public:
    CRespawnState(CBaseEntity* PEntity, duration spawnTime);

    auto Initialize() -> CState::StateResult override { return CState::StateResult(); }

    bool Update(time_point tick) override;
    void Cleanup(time_point tick) override;
    bool CanChangeState() override;

    bool CanFollowPath() override
    {
        return false;
    }

    bool CanInterrupt() override
    {
        return false;
    }

private:
    duration m_spawnTime;
};

#endif
