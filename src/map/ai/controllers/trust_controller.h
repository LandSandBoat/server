/*
===========================================================================

Copyright (c) 2018 Darkstar Dev Teams

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

#ifndef _TRUSTCONTROLLER_H
#define _TRUSTCONTROLLER_H

#include "mob_controller.h"

class CCharEntity;
class CTrustEntity;

class CTrustController : public CMobController
{
public:
    CTrustController(CCharEntity*, CTrustEntity*);
    ~CTrustController() override;
   
    void Tick(time_point) override;
    void Despawn() override;

    bool Ability(uint16 targid, uint16 abilityid) override;

    static constexpr float RoamDistance{ 5.5f };
    static constexpr float SpawnDistance{ 5.5f };

private:
    void DoCombatTick(time_point tick) override;
    void DoRoamTick(time_point tick) override;

    CBattleEntity* GetTopEnmity();
    position_t GetDeclumpedPosition(position_t target_pos);

    CBattleEntity* m_LastTopEntity;
};

#endif // _TRUSTCONTROLLER