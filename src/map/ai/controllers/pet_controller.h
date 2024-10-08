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

#ifndef _PET_CONTROLLER_H
#define _PET_CONTROLLER_H

#include "mob_controller.h"

class CPetEntity;
class CPetController : public CMobController
{
public:
    CPetController(CMobEntity* PPet);

    static constexpr float PetRoamDistance{ 2.1f };
    virtual void           DoRoamTick(time_point tick) override;
    bool                   PetSkill(uint16 targid, uint16 abilityid);

protected:
    bool PetIsHealing();

    virtual void Tick(time_point tick) override;
    virtual void HandleEnmity() override
    {
    }
    virtual bool TryDeaggro() override;
    virtual void TryLink() override
    {
    }
    virtual bool Ability(uint16 targid, uint16 abilityid) override;

private:
    CMobEntity* const PPet;
};

#endif // _AI_CONTROLLER_H
