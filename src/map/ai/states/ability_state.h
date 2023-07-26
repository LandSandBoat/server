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

#ifndef _CABILITY_STATE_H
#define _CABILITY_STATE_H

#include "ability.h"
#include "state.h"

class CCharEntity;

class CAbilityState : public CState
{
public:
    CAbilityState(CBattleEntity* PEntity, uint16 targid, uint16 abilityid);

    CAbility* GetAbility();

    void ApplyEnmity();

protected:
    virtual bool CanChangeState() override;
    virtual bool CanFollowPath() override
    {
        return true;
    }
    virtual bool CanInterrupt() override
    {
        return true;
    }
    virtual bool Update(time_point tick) override;
    virtual void Cleanup(time_point tick) override
    {
    }

    bool CanUseAbility();

private:
    duration                  m_castTime{ 0s };
    CBattleEntity* const      m_PEntity;
    std::unique_ptr<CAbility> m_PAbility;
};

#endif
