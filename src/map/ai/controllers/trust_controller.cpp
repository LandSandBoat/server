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
#include "player_controller.h"

#include "../../ability.h"
#include "../ai_container.h"
#include "../../status_effect_container.h"
#include "../../enmity_container.h"
#include "../../ai/states/despawn_state.h"
#include "../../ai/helpers/gambits_container.h"
#include "../../entities/charentity.h"
#include "../../entities/trustentity.h"
#include "../../packets/char.h"
#include "../../recast_container.h"
#include "../../mob_spell_container.h"

CTrustController::CTrustController(CCharEntity* PChar, CTrustEntity* PTrust) : CMobController(PTrust)
{
    m_GambitsContainer = std::make_unique<gambits::CGambitsContainer>(PTrust);
}

CTrustController::~CTrustController()
{
    if (POwner->PAI->IsEngaged())
    {
        POwner->PAI->Internal_Disengage();
    }
    POwner->PAI->PathFind.reset();
    POwner->allegiance = ALLEGIANCE_PLAYER;
    POwner->status = STATUS_DISAPPEAR;
    m_LastTopEnmity = nullptr;
}

void CTrustController::Despawn()
{
    POwner->PMaster = nullptr;
    POwner->animation = ANIMATION_DESPAWN;
    CMobController::Despawn();
}

void CTrustController::Tick(time_point tick)
{
    m_Tick = tick;

    if (!POwner->PMaster)
    {
        return;
    }

    if (POwner->PMaster->isCharmed)
    {
        this->Despawn();
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

    CTrustEntity* PTrust = static_cast<CTrustEntity*>(POwner);
    CCharEntity* PMaster = static_cast<CCharEntity*>(POwner->PMaster);
    PTarget = POwner->GetBattleTarget();

    if (PTarget)
    {
        if (POwner->PAI->CanFollowPath() && POwner->speed > 0)
        {
            float currentDistanceToTarget = distance(POwner->loc.p, PTarget->loc.p);
            float currentDistanceToMaster = distance(POwner->loc.p, PMaster->loc.p);

            if (currentDistanceToTarget > WarpDistance)
            {
                POwner->PAI->PathFind->WarpTo(PTarget->loc.p);
            }

            POwner->PAI->PathFind->LookAt(PTarget->loc.p);

            switch (PTrust->m_MovementType)
            {
            case NO_MOVE:
            {
                if (currentDistanceToMaster > CastingDistance)
                {
                    POwner->PAI->PathFind->PathAround(PMaster->loc.p, 10.0f, PATHFLAG_RUN | PATHFLAG_WALLHACK);
                }
                else if (currentDistanceToTarget > CastingDistance)
                {
                    POwner->PAI->PathFind->PathAround(PTarget->loc.p, 10.0f, PATHFLAG_RUN | PATHFLAG_WALLHACK);
                }
                break;
            }
            case MID_RANGE:
            {
                PathOutToDistance(PTarget, 6.0f);
                break;
            }
            case LONG_RANGE:
            {
                PathOutToDistance(PTarget, 12.0f);
                break;
            }
            case MELEE_RANGE:
            default:
            {
                std::unique_ptr<CBasicPacket> err;
                if (!POwner->CanAttack(PTarget, err) && POwner->speed > 0)
                {
                    if (currentDistanceToTarget > RoamDistance)
                    {
                        if (currentDistanceToTarget < RoamDistance * 3.0f && POwner->PAI->PathFind->PathAround(PTarget->loc.p, RoamDistance, PATHFLAG_RUN | PATHFLAG_WALLHACK))
                        {
                            POwner->PAI->PathFind->FollowPath();
                        }
                        else if (POwner->GetSpeed() > 0)
                        {
                            POwner->PAI->PathFind->StepTo(PTarget->loc.p, true);
                        }
                    }
                }
                break;
            }
            }

            if (!POwner->PAI->PathFind->IsFollowingPath())
            {
                Declump(PMaster, PTarget);
            }

            POwner->PAI->PathFind->FollowPath();
        }

        // If repositioning, bail out until you arrive
        if (m_InTransit)
        {
            return;
        }

        m_GambitsContainer->Tick(tick);

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
    auto masterLastAttackTime = static_cast<CPlayerController*>(PMaster->PAI->GetController())->getLastAttackTime();
    bool masterMeleeSwing = masterLastAttackTime > server_clock::now() - 1s;
    bool trustEngageCondition = PMaster->GetBattleTarget() && masterMeleeSwing;

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

    if (currentDistance > WarpDistance)
    {
        POwner->PAI->PathFind->WarpTo(PFollowTarget->loc.p);
    }
    else if (currentDistance > RoamDistance)
    {
        if (currentDistance < RoamDistance * 3.0f && POwner->PAI->PathFind->PathAround(PFollowTarget->loc.p, RoamDistance, PATHFLAG_RUN | PATHFLAG_WALLHACK))
        {
            POwner->PAI->PathFind->FollowPath();
        }
        else if (POwner->GetSpeed() > 0)
        {
            POwner->PAI->PathFind->StepTo(PFollowTarget->loc.p, true);
        }
    }

    if (POwner->CanRest() &&
        m_Tick - m_CombatEndTime > 10s &&
        m_Tick - m_LastHealTickTime > 3s &&
        PMaster != GetTopEnmity()) // TODO: Replace with reverse enmity container
    {
        if (POwner->health.hp != POwner->health.maxhp || POwner->health.mp != POwner->health.maxmp)
        {
            // recover 5% HP & MP
            uint32 recoverHP = (uint32)(POwner->health.maxhp * 0.05);
            uint32 recoverMP = (uint32)(POwner->health.maxmp * 0.05);
            POwner->addHP(recoverHP);
            POwner->addMP(recoverMP);
            m_LastHealTickTime = m_Tick;
            POwner->updatemask |= UPDATE_HP;
        }
    }
}

void CTrustController::Declump(CCharEntity* PMaster, CBattleEntity* PTarget)
{
    uint8 currentPartyPos = GetPartyPosition();
    for (auto POtherTrust : PMaster->PTrusts)
    {
        if (POtherTrust != POwner && !POtherTrust->PAI->PathFind->IsFollowingPath() && distance(POtherTrust->loc.p, POwner->loc.p) < 2.0f)
        {
            auto angle = getangle(POwner->loc.p, PTarget->loc.p) + 64;
            auto amount = (currentPartyPos % 2) ? 1.0f : -1.0f;
            position_t new_pos {POwner->loc.p.x - (cosf(rotationToRadian(angle)) * amount),
                PTarget->loc.p.y, POwner->loc.p.z + (sinf(rotationToRadian(angle)) * amount), 0, 0};

            if (POwner->PAI->PathFind->ValidPosition(new_pos))
            {
                POwner->PAI->PathFind->PathTo(new_pos, PATHFLAG_RUN | PATHFLAG_WALLHACK);
            }
            break;
        }
    }
}

void CTrustController::PathOutToDistance(CBattleEntity* PTarget, float amount)
{
    float currentDistanceToTarget = distance(POwner->loc.p, PTarget->loc.p);
    position_t target_position = POwner->loc.p;

    // Invalidate position and pick new one (limit: every 3s)
    if ((currentDistanceToTarget < amount || currentDistanceToTarget > amount + 5.0f) && m_Tick - m_LastRepositionTime > 3s)
    {
        // Away from target, +/- 45 degrees
        auto half_sector_size = 32 + (10 * m_failedRepositionAttempts);
        auto angle = getangle(PTarget->loc.p, POwner->loc.p) + 128 + tpzrand::GetRandomNumber(-half_sector_size, half_sector_size);
        position_t potential_position = {PTarget->loc.p.x - (cosf(rotationToRadian(angle)) * amount),
            PTarget->loc.p.y, PTarget->loc.p.z + (sinf(rotationToRadian(angle)) * amount), 0, 0};

        // Validate position
        if (POwner->PAI->PathFind->ValidPosition(potential_position) && POwner->loc.zone->m_navMesh->raycast(potential_position, PTarget->loc.p))
        {
            m_InTransit = true;
            target_position = potential_position;
            m_LastRepositionTime = m_Tick;
        }
        else
        {
            ++m_failedRepositionAttempts;
        }

        // If stuck, reset
        if (m_failedRepositionAttempts > 3)
        {
            m_InTransit = true;
            target_position = POwner->PMaster->loc.p;
            m_LastRepositionTime = m_Tick;
        }
    }

    // Get somewhat close to the target destination
    if (distance(POwner->loc.p, target_position) > 2.0f && POwner->PAI->PathFind->PathAround(target_position, 0.0f, PATHFLAG_RUN | PATHFLAG_WALLHACK))
    {
        POwner->PAI->PathFind->FollowPath();
    }
    else
    {
        m_failedRepositionAttempts = 0;
        m_InTransit = false;
    }
}

bool CTrustController::Ability(uint16 targid, uint16 abilityid)
{
    if (static_cast<CMobEntity*>(POwner)->PRecastContainer->HasRecast(RECAST_ABILITY, abilityid, 0))
    {
        return false;
    }

    if (POwner->PAI->CanChangeState())
    {
        return POwner->PAI->Internal_Ability(targid, abilityid);
    }

    return false;
}

bool CTrustController::Cast(uint16 targid, SpellID spellid)
{
    FaceTarget(targid);
    if (static_cast<CMobEntity*>(POwner)->PRecastContainer->Has(RECAST_MAGIC, static_cast<uint16>(spellid)))
    {
        return false;
    }

    auto PSpell = spell::GetSpell(spellid);
    if (PSpell->getValidTarget() == TARGET_SELF)
    {
        targid = POwner->targid;
    }

    return CController::Cast(targid, spellid);
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
