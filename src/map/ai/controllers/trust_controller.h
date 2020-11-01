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

#include <memory>

#include "mob_controller.h"

class CCharEntity;
class CTrustEntity;

namespace gambits
{
    class CGambitsContainer;
}

class CTrustController : public CMobController
{
public:
    CTrustController(CCharEntity*, CTrustEntity*);
    ~CTrustController() override;

    void Tick(time_point) override;
    void Despawn() override;

    bool Ability(uint16 targid, uint16 abilityid) override;
    bool Cast(uint16 targid, SpellID spellid) override;

    bool RangedAttack(uint16 targid);

    static constexpr float RoamDistance = { 2.0f };
    static constexpr float SpawnDistance = { 3.0f };
    static constexpr float CastingDistance = { 15.0f };
    static constexpr float WarpDistance = { 30.0f };

    CBattleEntity* GetTopEnmity();

    std::unique_ptr<gambits::CGambitsContainer> m_GambitsContainer;

private:
    void DoCombatTick(time_point tick) override;
    void DoRoamTick(time_point tick) override;

    void Declump(CCharEntity* PMaster, CBattleEntity* PTarget);
    void PathOutToDistance(CBattleEntity* PTarget, float amount);

    uint8 GetPartyPosition();

    CBattleEntity* m_LastTopEnmity;

    time_point m_LastRepositionTime;
    uint8 m_failedRepositionAttempts;
    bool m_InTransit;

    time_point m_CombatEndTime;
    time_point m_LastHealTickTime;
    std::vector<std::chrono::seconds> m_tickDelays = { 15s, 10s, 10s, 3s };
    std::size_t m_NumHealingTicks = { 0 };

    time_point m_LastRangedAttackTime;
};

#endif // _TRUSTCONTROLLER
