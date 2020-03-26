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

#include "trust_controller.h"

#include "../ai_container.h"
#include "../../status_effect_container.h"
#include "../../enmity_container.h"
#include "../../ai/states/despawn_state.h"
#include "../../entities/charentity.h"
#include "../../entities/trustentity.h"
#include "../../packets/char.h"

CTrustController::CTrustController(CCharEntity* PChar, CTrustEntity* PTrust) : CMobController(PTrust)
{
}

CTrustController::~CTrustController()
{
    if (POwner->PAI->IsEngaged())
    {
        POwner->PAI->Internal_Disengage();
    }
    POwner->PAI->PathFind.reset();
    POwner->allegiance = ALLEGIANCE_PLAYER;
    POwner->PMaster = nullptr;

    m_LastTopEntity = nullptr;
}

void CTrustController::Despawn()
{
    POwner->animation = ANIMATION_DESPAWN;
    CMobController::Despawn();
}

void CTrustController::Tick(time_point tick)
{
    m_Tick = tick;

    if (POwner->PMaster == nullptr)
    {
        return;
    }

    if (POwner->PAI->IsEngaged())
    {
        DoCombatTick(tick);
    }
    else if (!POwner->isDead())
    {
        DoRoamTick(tick);
    }
}

void CTrustController::DoCombatTick(time_point tick)
{
    if (!POwner->PMaster->PAI->IsEngaged())
    {
        POwner->PAI->Internal_Disengage();
        m_LastTopEntity = nullptr;
    }

    if (POwner->PMaster->GetBattleTargetID() != POwner->GetBattleTargetID())
    {
        POwner->PAI->Internal_ChangeTarget(POwner->PMaster->GetBattleTargetID());
        m_LastTopEntity = nullptr;
    }

    float currentDistance = distance(POwner->loc.p, POwner->PMaster->loc.p);
    PTarget = POwner->GetBattleTarget();

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
                    auto new_position = GetDeclumpedPosition(PTarget->loc.p);
                    POwner->PAI->PathFind->PathAround(new_position, 3.0f, PATHFLAG_RUN | PATHFLAG_WALLHACK | PATHFLAG_SLIDE);
                    POwner->PAI->PathFind->FollowPath();
                }
            }
        }

        auto currentTopEnmity = GetTopEnmity();
        if (m_LastTopEntity != currentTopEnmity)
        {
            POwner->PAI->EventHandler.triggerListener("ENMITY_CHANGED", POwner, POwner->PMaster, PTarget);
            m_LastTopEntity = currentTopEnmity;
        }

        POwner->PAI->EventHandler.triggerListener("COMBAT_TICK", POwner, POwner->PMaster, PTarget);
    }
}

void CTrustController::DoRoamTick(time_point tick)
{
    if (POwner->PMaster->PAI->IsEngaged() && GetTopEnmity() == POwner->PMaster)
    {
        POwner->PAI->Internal_Engage(POwner->PMaster->GetBattleTargetID());
    }

    float currentDistance = distance(POwner->loc.p, POwner->PMaster->loc.p);

    if (currentDistance > RoamDistance)
    {
        auto new_position = GetDeclumpedPosition(POwner->PMaster->loc.p);
        if (currentDistance < 30.0f && POwner->PAI->PathFind->PathAround(new_position, 2.0f, PATHFLAG_RUN | PATHFLAG_WALLHACK | PATHFLAG_SLIDE))
        {
            POwner->PAI->PathFind->FollowPath();
        }
        else if (POwner->GetSpeed() > 0)
        {
            POwner->PAI->PathFind->WarpTo(POwner->PMaster->loc.p, RoamDistance);
        }
    }
}

bool CTrustController::Ability(uint16 targid, uint16 abilityid)
{
    if (POwner->PAI->CanChangeState())
    {
        return POwner->PAI->Internal_Ability(targid, abilityid);
    }
    return false;
}

CBattleEntity* CTrustController::GetTopEnmity()
{
    CBattleEntity* PEntity = nullptr;
    if (auto PMob = dynamic_cast<CMobEntity*>(POwner->PMaster->GetBattleTarget()))
    {
        return PMob->PEnmityContainer->GetHighestEnmity();
    }
    return PEntity;
}

position_t CTrustController::GetDeclumpedPosition(position_t target_pos)
{
    auto lerp = [](float a, float b, float f)
    {
        return a + f * (b - a);
    };

    auto lerp_position = [&](position_t a, position_t b, float ratio)
    {
        float safe_ratio = std::clamp(ratio, 0.0f, 1.0f);
        position_t final_pos{
            lerp(a.x, b.x, ratio),
            lerp(a.y, b.y, ratio),
            lerp(a.z, b.z, ratio),
            0, 0};
        return final_pos;
    };

    position_t final_pos = target_pos;
    for (auto PTrust : static_cast<CCharEntity*>(POwner->PMaster)->PTrusts)
    {
        if (POwner != PTrust && distance(POwner->loc.p, PTrust->loc.p) < 5.0f)
        {
            auto angle = getangle(POwner->loc.p, PTrust->loc.p);
            position_t declumped_pos{ POwner->loc.p.x - (cosf(rotationToRadian(angle)) * 2.0f),
                POwner->loc.p.y, POwner->loc.p.z + (sinf(rotationToRadian(angle)) * 2.0f), 0, 0 };

            final_pos = lerp_position(final_pos, declumped_pos, 0.5f);
        }
    }

    return lerp_position(final_pos, target_pos, 0.1f);
}
