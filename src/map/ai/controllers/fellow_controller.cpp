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

#include "fellow_controller.h"

#include "../../../common/utils.h"
#include "../../ai/states/despawn_state.h"
#include "../../entities/charentity.h"
#include "../../entities/fellowentity.h"
#include "../../packets/char.h"
#include "../../status_effect_container.h"
#include "../ai_container.h"

CFellowController::CFellowController(CCharEntity* PChar, CFellowEntity* PFellow)
: CMobController(PFellow)
{
}

CFellowController::~CFellowController()
{
    if (POwner->PAI->IsEngaged())
    {
        POwner->PAI->Internal_Disengage();
    }
    POwner->PAI->PathFind.reset();
    POwner->allegiance = ALLEGIANCE_TYPE::PLAYER;
}

void CFellowController::Despawn()
{
    if (POwner->PMaster)
    {
        POwner->PMaster = nullptr;
    }
    POwner->animation = ANIMATION_DESPAWN;
    CController::Despawn();
}

void CFellowController::Tick(time_point tick)
{
    m_Tick = tick;

    if (POwner->PAI->IsEngaged())
    {
        DoCombatTick(tick);
    }
    else if (!POwner->isDead())
    {
        DoRoamTick(tick);
    }
}

void CFellowController::DoCombatTick(time_point tick)
{
    if ((POwner->PMaster == nullptr || POwner->PMaster->isMounted() || POwner->PMaster->isDead()) && POwner->isAlive())
    {
        POwner->Die();
        return;
    }

    auto PTarget{ POwner->GetBattleTarget() };
    if (PTarget)
    {
        if (POwner->PAI->CanFollowPath())
        {
            POwner->PAI->PathFind->LookAt(PTarget->loc.p);
            std::unique_ptr<CBasicPacket> err;
            if (!POwner->CanAttack(PTarget, err))
            {
                if (POwner->speed > 0)
                {
                    POwner->PAI->PathFind->PathAround(PTarget->loc.p, 3.0f, PATHFLAG_WALLHACK | PATHFLAG_RUN);
                    POwner->PAI->PathFind->FollowPath(tick);
                }
            }
        }
        POwner->PAI->EventHandler.triggerListener("COMBAT_TICK", POwner, POwner->PMaster, PTarget);
        luautils::OnMobFight(POwner, PTarget);
    }
}

void CFellowController::DoRoamTick(time_point tick)
{
    if ((POwner->PMaster == nullptr || POwner->PMaster->isMounted() || POwner->PMaster->isDead()) && POwner->isAlive())
    {
        POwner->Die();
        return;
    }

    if (FellowIsHealing() || FellowIsSitting())
    {
    }

    float currentDistance = distance(POwner->loc.p, POwner->PMaster->loc.p);

    if (currentDistance > RoamDistance && !FellowIsHealing() && !FellowIsSitting())
    {
        if (currentDistance < 6.0f && POwner->PAI->PathFind->PathAround(POwner->PMaster->loc.p, 3.0f, PATHFLAG_RUN | PATHFLAG_WALLHACK))
        {
            POwner->PAI->PathFind->FollowPath(tick);
        }
        else if (POwner->GetSpeed() > 0)
        {
            POwner->PAI->PathFind->StepTo(POwner->PMaster->loc.p, RoamDistance);
        }
    }
    if (m_Tick >= m_LastRoamScript + 3s)
    {
        POwner->PAI->EventHandler.triggerListener("ROAM_TICK", POwner);
        luautils::OnMobRoam(POwner);
        m_LastRoamScript = m_Tick;
    }
}

bool CFellowController::Ability(uint16 targid, uint16 abilityid)
{
    if (POwner->PAI->CanChangeState())
    {
        return POwner->PAI->Internal_Ability(targid, abilityid);
    }
    return false;
}

bool CFellowController::FellowIsHealing()
{
    bool isMasterHealing = (POwner->PMaster->animation == ANIMATION_HEALING);
    bool isFellowHealing = (POwner->animation == ANIMATION_HEALING);

    if (isMasterHealing && !isFellowHealing && !POwner->StatusEffectContainer->HasPreventActionEffect())
    {
        // animation down
        POwner->animation = ANIMATION_HEALING;
        POwner->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_HEALING, 0, 0, settings::get<uint8>("map.HEALING_TICK_DELAY"), 0));
        POwner->updatemask |= UPDATE_HP;
        return true;
    }
    else if (!isMasterHealing && isFellowHealing)
    {
        // animation up
        POwner->animation = ANIMATION_NONE;
        POwner->StatusEffectContainer->DelStatusEffect(EFFECT_HEALING);
        POwner->updatemask |= UPDATE_HP;
        return false;
    }
    return isMasterHealing;
}

bool CFellowController::FellowIsSitting()
{
    bool isMasterSitting = (POwner->PMaster->animation == ANIMATION_SIT);
    bool isFellowSitting = (POwner->animation == ANIMATION_SIT);

    if (isMasterSitting && !isFellowSitting && !POwner->StatusEffectContainer->HasPreventActionEffect())
    {
        // animation down
        POwner->animation = ANIMATION_SIT;
        POwner->updatemask |= UPDATE_HP;
        return true;
    }
    else if (!isMasterSitting && isFellowSitting)
    {
        // animation up
        POwner->animation = ANIMATION_NONE;
        POwner->updatemask |= UPDATE_HP;
        return false;
    }
    return isMasterSitting;
}
