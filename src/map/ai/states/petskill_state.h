/*
===========================================================================

Copyright (c) LandSandBoat Dev Team 2022

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

#ifndef _CPETSKILL_TATE_H
#define _CPETSKILL_TATE_H

#include "petskill.h"
#include "state.h"

class CPetEntity;

class CPetSkillState : public CState
{
public:
    CPetSkillState(CPetEntity* PEntity, uint16 targid, uint16 wsid);

    CPetSkill* GetPetSkill();

    int16 GetSpentTP()
    {
        return m_spentTP;
    }

protected:
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
        return true;
    }
    virtual bool Update(time_point tick) override;
    virtual void Cleanup(time_point tick) override;
    void         SpendCost();

private:
    CPetEntity* const          m_PEntity;
    std::unique_ptr<CPetSkill> m_PSkill;
    time_point                 m_finishTime;
    duration                   m_castTime{};
    int16                      m_spentTP;
};

#endif
