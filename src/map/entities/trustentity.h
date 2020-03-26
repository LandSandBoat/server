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
class CTrustEntity : public CMobEntity
{
public:
    explicit CTrustEntity(CCharEntity*);
    ~CTrustEntity() override = default;

    // Note: The default name is the lowercase spell script name, so we override GetName()
    // to return the packetName instead, which makes the behaviour consistant with other uses
    // of GetName()
    const int8* GetName() override;

    void PostTick() override;
    void FadeOut() override;
    void Die() override;
    void Spawn() override;
    bool ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags) override;
    void OnDespawn(CDespawnState&) override;

    uint32 m_TrustID{};
};

#endif
