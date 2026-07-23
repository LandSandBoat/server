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

#include "state.h"

class CDeathState : public CState
{
public:
    CDeathState(CBattleEntity* PEntity, timer::duration death_time);

    auto Update(timer::time_point tick) -> bool override;
    void Cleanup(timer::time_point tick) override;
    auto CanChangeState() -> bool override;
    auto CanFollowPath() -> bool override;
    auto CanInterrupt() -> bool override;
    void allowSendRaise();
    void acceptRaise();

private:
    CBattleEntity* const m_PEntity;
    timer::duration      m_deathTime;
    bool                 m_raiseSent{ false };
    bool                 m_raiseAccepted{ false };
    timer::time_point    m_raiseTime;
    timer::time_point    m_raiseAcceptedTime;
};
