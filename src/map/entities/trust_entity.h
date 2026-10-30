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

#include <common/macros.h>
#include <map/entities/mob_entity.h>

#include <common/types/flag.h>

class CCharEntity;

using IsPassiveTrust = xi::Flag<struct IsPassiveTrustTag>;

class CTrustEntity final : public CMobEntity
{
public:
    CTrustEntity(CCharEntity* PMaster, uint32 trustId, IsPassiveTrust isPassiveTrust);
    ~CTrustEntity() override;

    DISALLOW_COPY_AND_MOVE(CTrustEntity);

    auto trustID() const -> uint32;

    auto shieldSize() -> int8;

    auto released() const -> bool;
    void setReleased(bool released);

    auto passiveTrust() -> IsPassiveTrust;

    //
    // CMobEntity, CBattleEntity, etc.
    //

    void PostTick() override;
    void FadeOut() override;
    void Die() override;
    void Spawn() override;
    auto ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags) -> bool override;
    void OnDespawn(CDespawnState&) override;

    void OnCastFinished(CMagicState& state, action_t& action) override;
    void OnMobSkillFinished(CMobSkillState& state, action_t& action) override;
    void OnWeaponSkillFinished(CWeaponSkillState& state, action_t& action) override;

    auto GetUntargetable() const -> bool override;

private:
    uint32         trustID_{};
    bool           released_{};
    IsPassiveTrust passiveTrust_ = IsPassiveTrust::No;
};
