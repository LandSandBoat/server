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

#include "player_controller.h"

#ifndef _PLAYERCHARMCONTROLLER_H
#define _PLAYERCHARMCONTROLLER_H

class CCharEntity;

class CPlayerCharmController : public CPlayerController
{
public:
    CPlayerCharmController(CCharEntity*);
    virtual ~CPlayerCharmController();

    virtual void Tick(time_point) override;

    virtual bool Cast(uint16 targid, SpellID spellid) override
    {
        return false;
    }
    virtual bool ChangeTarget(uint16 targid) override
    {
        return false;
    }
    virtual bool WeaponSkill(uint16 targid, uint16 wsid) override
    {
        return false;
    }

    virtual bool Ability(uint16 targid, uint16 abilityid) override
    {
        return false;
    }
    virtual bool RangedAttack(uint16 targid) override
    {
        return false;
    }

private:
    static constexpr float RoamDistance{ 2.1f };
    void                   DoCombatTick(time_point tick);
    void                   DoRoamTick(time_point tick);
};

#endif // _PLAYERCONTROLLER
