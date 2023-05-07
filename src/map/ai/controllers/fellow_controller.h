/*
===========================================================================
Copyright (c) 2010-2018 Darkstar Dev Teams
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
This file is part of DarkStar-server source code.
===========================================================================
*/

#ifndef _FELLOWCONTROLLER_H
#define _FELLOWCONTROLLER_H

#include "mob_controller.h"

class CCharEntity;
class CFellowEntity;

class CFellowController : public CMobController
{
public:
    CFellowController(CCharEntity*, CFellowEntity*);
    virtual ~CFellowController();

    virtual void Tick(time_point) override;
    virtual void Despawn() override;

    virtual bool Ability(uint16 targid, uint16 abilityid) override;
    virtual void DoCombatTick(time_point tick) override;
    virtual void DoRoamTick(time_point tick) override;

protected:
    bool FellowIsHealing();
    bool FellowIsSitting();

private:
    static constexpr float RoamDistance{ 3.5f };
    time_point             m_LastRoamScript{ time_point::min() };
};

#endif // _FELLOWCONTROLLER
