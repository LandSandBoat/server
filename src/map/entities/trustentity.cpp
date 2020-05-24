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

#include <string.h>

#include "trustentity.h"
#include "../mob_spell_container.h"
#include "../mob_spell_list.h"
#include "../packets/char_health.h"
#include "../packets/entity_update.h"
#include "../packets/trust_sync.h"
#include "../ai/ai_container.h"
#include "../ai/controllers/trust_controller.h"
#include "../ai/helpers/pathfind.h"
#include "../ai/helpers/targetfind.h"
#include "../ai/states/ability_state.h"
#include "../utils/battleutils.h"
#include "../utils/petutils.h"
#include "../utils/mobutils.h"
#include "../../common/utils.h"
#include "../mob_modifier.h"

CTrustEntity::CTrustEntity(CCharEntity* PChar)
{
    objtype = TYPE_TRUST;
    m_EcoSystem = SYSTEM_UNCLASSIFIED;
    allegiance = ALLEGIANCE_PLAYER;
    m_MobSkillList = 0;
    PMaster = PChar;
    PAI = std::make_unique<CAIContainer>(this, std::make_unique<CPathFind>(this), std::make_unique<CTrustController>(PChar, this), std::make_unique<CTargetFind>(this));
}

CTrustEntity::~CTrustEntity()
{
}

void CTrustEntity::PostTick()
{
    CBattleEntity::PostTick();
    if (loc.zone && updatemask && status != STATUS_DISAPPEAR)
    {
        loc.zone->PushPacket(this, CHAR_INRANGE, new CEntityUpdatePacket(this, ENTITY_UPDATE, updatemask));
        for (auto PTrust : ((CCharEntity*)PMaster)->PTrusts)
        {
            if (PTrust == this)
            {
                ((CCharEntity*)PMaster)->pushPacket(new CTrustSyncPacket((CCharEntity*)PMaster, this));
            }
        }

        if (updatemask & UPDATE_HP)
        {
            if (PMaster->PParty != nullptr)
            {
                PMaster->ForParty([this](auto PMember)
                {
                    if (PMember->objtype == TYPE_PC)
                    {
                        static_cast<CCharEntity*>(PMember)->pushPacket(new CCharHealthPacket(this));
                    }
                });
            }
        }

        updatemask = 0;
    }
}

void CTrustEntity::FadeOut()
{
    CMobEntity::FadeOut();
    loc.zone->PushPacket(this, CHAR_INRANGE, new CEntityUpdatePacket(this, ENTITY_DESPAWN, UPDATE_NONE));
}

void CTrustEntity::Die()
{
    PAI->ClearStateStack();
    PAI->Internal_Die(0s);
    luautils::OnMobDeath(this, nullptr);
    CBattleEntity::Die();
    if (PMaster->objtype == TYPE_PC)
    {
        CCharEntity* PChar = (CCharEntity*)PMaster;
        PChar->RemoveTrust(this);
    }
}

void CTrustEntity::Spawn()
{
    //we need to skip CMobEntity's spawn because it calculates stats (and our stats are already calculated)
    CBattleEntity::Spawn();
    ((CCharEntity*)PMaster)->pushPacket(new CTrustSyncPacket((CCharEntity*)PMaster, this));
    luautils::OnMobSpawn(this);
}

bool CTrustEntity::ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags)
{
    if (targetFlags & TARGET_PLAYER && PInitiator->allegiance == allegiance)
    {
        return false;
    }
    return CMobEntity::ValidTarget(PInitiator, targetFlags);
}
