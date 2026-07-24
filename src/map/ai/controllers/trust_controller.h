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

#pragma once

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

    auto Tick(timer::time_point) -> Task<void> override;
    void Despawn() override;
    auto Ability(uint16 targid, uint16 abilityid) -> bool override;
    auto Cast(uint16 targid, SpellID spellid) -> bool override;
    auto RangedAttack(uint16 targid) -> bool override;

    static constexpr float RoamDistance    = { 3.0f };
    static constexpr float SpawnDistance   = { 3.0f };
    static constexpr float CastingDistance = { 15.0f };
    static constexpr float WarpDistance    = { 30.0f };

    auto GetTopEnmity() const -> CBattleEntity*;
    auto GetPartyPosition() const -> uint8;

    std::unique_ptr<gambits::CGambitsContainer> m_GambitsContainer;

private:
    auto DoCombatTick(timer::time_point tick) -> Task<void> override;
    auto DoRoamTick(timer::time_point tick) -> Task<void> override;
    auto DoNonCombatTick(timer::time_point tick) -> Task<void>;
    void Declump(const CCharEntity* PMaster, const CBattleEntity* PTarget) const;
    void PathOutToDistance(const CBattleEntity* PTarget, float amount);

    CBattleEntity* m_LastTopEnmity;

    timer::time_point m_LastRepositionTime;
    uint8             m_failedRepositionAttempts;
    bool              m_InTransit;

    timer::time_point                 m_CombatEndTime;
    timer::time_point                 m_LastHealTickTime;
    std::vector<std::chrono::seconds> m_tickDelays      = { 15s, 10s, 10s, 3s };
    std::size_t                       m_NumHealingTicks = { 0 };

    timer::time_point m_LastRangedAttackTime;
};
