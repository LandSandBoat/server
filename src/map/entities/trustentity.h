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

#ifndef _CTRUSTENTITY_H
#define _CTRUSTENTITY_H

#include "mobentity.h"

class CCharEntity;
class CAbilityState;
class CRangeState;
class CDespawnState;
class CMagicState;
class CMobSkillState;
class CWeaponSkillState;

class CTrustEntity : public CMobEntity
{
public:
    explicit CTrustEntity(CCharEntity*);
    ~CTrustEntity() override;

    auto getShieldSize() -> int8;

    void PostTick() override;
    void FadeOut() override;
    void Die() override;
    void Spawn() override;
    bool ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags) override;
    void OnDespawn(CDespawnState&) override;

    void OnCastFinished(CMagicState& state, action_t& action) override;
    void OnMobSkillFinished(CMobSkillState& state, action_t& action) override;
    void OnWeaponSkillFinished(CWeaponSkillState& state, action_t& action) override;

    bool GetUntargetable() const override;

    uint32 m_TrustID{};
    bool   isReleased       = false; // Track trust releasing (see c2s 0x01A action)
    bool   m_isPassiveTrust = false;

private:
    static constexpr int8 m_defaultShieldSize = 3;
};

#endif
