/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "player_charm_controller.h"

#include "ai/ai_container.h"
#include "common/utils.h"
#include "entities/charentity.h"
#include "status_effect_container.h"

CPlayerCharmController::CPlayerCharmController(CCharEntity* PChar)
: CPlayerController(PChar)
{
    POwner->PAI->PathFind = std::make_unique<CPathFind>(PChar);
}

CPlayerCharmController::~CPlayerCharmController()
{
    if (POwner->PAI->IsEngaged())
    {
        POwner->PAI->Internal_Disengage();
    }
    POwner->PAI->PathFind.reset();
    POwner->allegiance = ALLEGIANCE_TYPE::PLAYER;
}

void CPlayerCharmController::Tick(time_point tick)
{
    m_Tick = tick;
    if (POwner->PMaster == nullptr || !POwner->PMaster->isAlive())
    {
        POwner->StatusEffectContainer->DelStatusEffect(EFFECT_CHARM);
        return;
    }

    if (POwner->PAI->IsEngaged())
    {
        DoCombatTick(tick);
    }
    else
    {
        DoRoamTick(tick);
    }
}

void CPlayerCharmController::DoCombatTick(time_point tick)
{
    if (!POwner->PMaster->PAI->IsEngaged())
    {
        POwner->PAI->Internal_Disengage();
    }
    if (POwner->PMaster->GetBattleTargetID() != POwner->GetBattleTargetID())
    {
        POwner->PAI->Internal_ChangeTarget(POwner->PMaster->GetBattleTargetID());
    }
    auto* PTarget{ POwner->GetBattleTarget() };
    if (PTarget)
    {
        if (POwner->PAI->CanFollowPath())
        {
            POwner->PAI->PathFind->LookAt(PTarget->loc.p);
            std::unique_ptr<CBasicPacket> err;
            if (!POwner->CanAttack(PTarget, err))
            {
                if (POwner->GetSpeed() > 0)
                {
                    POwner->PAI->PathFind->PathAround(PTarget->loc.p, 2.0f, PATHFLAG_WALLHACK | PATHFLAG_RUN);
                    POwner->PAI->PathFind->FollowPath(m_Tick);
                }
            }
        }
    }
}

void CPlayerCharmController::DoRoamTick(time_point tick)
{
    if (POwner->PMaster->PAI->IsEngaged())
    {
        POwner->PAI->Internal_Engage(POwner->PMaster->GetBattleTargetID());
    }

    float currentDistance = distance(POwner->loc.p, POwner->PMaster->loc.p);

    if (currentDistance > RoamDistance)
    {
        if (POwner->PAI->PathFind)
        {
            if (currentDistance < 35.0f && POwner->PAI->PathFind->PathAround(POwner->PMaster->loc.p, 2.0f, PATHFLAG_RUN | PATHFLAG_WALLHACK))
            {
                POwner->PAI->PathFind->FollowPath(m_Tick);
            }
            else if (POwner->GetSpeed() > 0)
            {
                POwner->PAI->PathFind->WarpTo(POwner->PMaster->loc.p, RoamDistance);
            }
        }
    }
}
