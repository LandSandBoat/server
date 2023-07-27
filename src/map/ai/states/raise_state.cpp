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

#include "raise_state.h"

#include "entities/battleentity.h"
#include "entities/charentity.h"

CRaiseState::CRaiseState(CBattleEntity* PEntity)
: CState(PEntity, PEntity->targid)
, m_PEntity(PEntity)
{
}

bool CRaiseState::Update(time_point tick)
{
    if (!IsCompleted())
    {
        Complete();
        m_PEntity->OnRaise();
    }
    else if (IsCompleted() && tick > GetEntryTime() + 2s)
    {
        m_PEntity->animation = ANIMATION_NONE;
        m_PEntity->updatemask |= UPDATE_HP;
        return true;
    }
    return false;
}
