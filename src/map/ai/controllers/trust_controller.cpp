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

    m_LastTopEnmity = nullptr;
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
        m_LastTopEnmity = nullptr;
        m_CombatEndTime = m_Tick;
    }

    if (POwner->PMaster->GetBattleTargetID() != POwner->GetBattleTargetID())
    {
        POwner->PAI->Internal_ChangeTarget(POwner->PMaster->GetBattleTargetID());
        m_LastTopEnmity = nullptr;
    }

    float currentDistance = distance(POwner->loc.p, POwner->PMaster->loc.p);
    PTarget = POwner->GetBattleTarget();
    uint8 currentPartyPos = GetPartyPosition();

    if (PTarget)
    {
        if (POwner->PAI->CanFollowPath())
        {
            POwner->PAI->PathFind->LookAt(PTarget->loc.p);
            std::unique_ptr<CBasicPacket> err;
            if (!POwner->CanAttack(PTarget, err) && POwner->speed > 0)
            {
                if (currentDistance < WarpDistance && POwner->PAI->PathFind->PathAround(PTarget->loc.p, PATHFLAG_RUN | PATHFLAG_WALLHACK))
                {
                    POwner->PAI->PathFind->FollowPath();
                }
                else if (POwner->GetSpeed() > 0)
                {
                    POwner->PAI->PathFind->WarpTo(POwner->PMaster->loc.p, RoamDistance);
                }
            }
            else
            {
                for (auto POtherTrust : static_cast<CCharEntity*>(POwner->PMaster)->PTrusts)
                {
                    if (POtherTrust != POwner && !POtherTrust->PAI->PathFind->IsFollowingPath() && distance(POtherTrust->loc.p, POwner->loc.p) < 1.0f)
                    {
                        auto angle = getangle(POwner->loc.p, PTarget->loc.p) + 64;
                        auto amount = (currentPartyPos % 2) ? 1.0f : -1.0f;
                        position_t new_pos{ POwner->loc.p.x - (cosf(rotationToRadian(angle)) * amount),
                            PTarget->loc.p.y, POwner->loc.p.z + (sinf(rotationToRadian(angle)) * amount), 0, 0 };

                        if (POwner->PAI->PathFind->ValidPosition(new_pos))
                        {
                            POwner->PAI->PathFind->PathTo(new_pos, PATHFLAG_RUN | PATHFLAG_WALLHACK);
                        }
                        break;
                    }
                }
            }
            POwner->PAI->PathFind->FollowPath();
        }

        auto currentTopEnmity = GetTopEnmity();
        if (m_LastTopEnmity != currentTopEnmity)
        {
            POwner->PAI->EventHandler.triggerListener("ENMITY_CHANGED", POwner, POwner->PMaster, PTarget);
            m_LastTopEnmity = currentTopEnmity;
        }

        POwner->PAI->EventHandler.triggerListener("COMBAT_TICK", POwner, POwner->PMaster, PTarget);
    }
}

void CTrustController::DoRoamTick(time_point tick)
{
    auto PMaster = static_cast<CCharEntity*>(POwner->PMaster);
    bool trustEngageCondition = (PMaster->GetBattleTarget() && PMaster->GetBattleTarget()->PLastAttacker == PMaster);

    if (PMaster->PAI->IsEngaged() && trustEngageCondition)
    {
        POwner->PAI->Internal_Engage(PMaster->GetBattleTargetID());
    }

    uint8 currentPartyPos = GetPartyPosition();
    CBattleEntity* PFollowTarget = (GetPartyPosition() > 0) ? (CBattleEntity*)PMaster->PTrusts.at(currentPartyPos - 1) : POwner->PMaster;
    float currentDistance = distance(POwner->loc.p, PFollowTarget->loc.p);

    for (auto POtherTrust : PMaster->PTrusts)
    {
        if (POtherTrust != POwner && distance(POtherTrust->loc.p, POwner->loc.p) < 1.0f && !POwner->PAI->PathFind->IsFollowingPath())
        {
            auto angle = getangle(POwner->loc.p, POtherTrust->loc.p) + 64;
            auto amount = (currentPartyPos % 2) ? 1.0f : -1.0f;
            position_t new_pos{ POwner->loc.p.x - (cosf(rotationToRadian(angle)) * amount),
                POtherTrust->loc.p.y, POwner->loc.p.z + (sinf(rotationToRadian(angle)) * amount), 0, 0 };

            if (POwner->PAI->PathFind->ValidPosition(new_pos) && POwner->PAI->PathFind->PathAround(new_pos, RoamDistance, PATHFLAG_RUN | PATHFLAG_WALLHACK))
            {
                POwner->PAI->PathFind->FollowPath();
            }
            break;
        }
    }

    if (currentDistance > RoamDistance)
    {
        if (currentDistance < WarpDistance && POwner->PAI->PathFind->PathAround(PFollowTarget->loc.p, RoamDistance, PATHFLAG_RUN | PATHFLAG_WALLHACK))
        {
            POwner->PAI->PathFind->FollowPath();
        }
        else if (POwner->GetSpeed() > 0)
        {
            POwner->PAI->PathFind->WarpTo(PFollowTarget->loc.p, RoamDistance);
        }
    }

    if (POwner->CanRest() &&
        m_Tick - m_CombatEndTime > 10s &&
        m_Tick - m_LastHealTickTime > 3s)
    {
        if (POwner->Rest(0.03f))
        {
            m_LastHealTickTime = m_Tick;
            POwner->updatemask |= UPDATE_HP;
        }
        else if (POwner->Rest(0.05f))
        {
            m_LastHealTickTime = m_Tick;
            POwner->updatemask |= UPDATE_HP;
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

uint8 CTrustController::GetPartyPosition()
{
    auto& trustList = static_cast<CCharEntity*>(POwner->PMaster)->PTrusts;
    for (uint8 i = 0; i < trustList.size(); ++i)
    {
        if (trustList.at(i)->id == POwner->id)
        {
            return i;
        }
    }
    return 0;
}
