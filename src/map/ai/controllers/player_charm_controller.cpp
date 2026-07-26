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
#include "status_effect_container.h"

CPlayerCharmController::CPlayerCharmController(CCharEntity* PChar)
: CPlayerController(PChar)
, charmer_(PChar->PMaster)
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
    POwner->allegiance = xi::Allegiance::Player;
}

auto CPlayerCharmController::Tick(const timer::time_point tick) -> Task<void>
{
    m_Tick = tick;

    auto* PMaster = charmer_.resolve<CBattleEntity>();
    if (PMaster == nullptr || !PMaster->isAlive())
    {
        POwner->StatusEffectContainer->DelStatusEffect(xi::StatusEffect::CharmI);
        co_return;
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

void CPlayerCharmController::DoCombatTick(timer::time_point tick) const
{
    if (!POwner->PMaster->PAI->IsEngaged())
    {
        POwner->PAI->Internal_Disengage();
    }
    if (POwner->PMaster->battleTarget() != POwner->battleTarget())
    {
        POwner->PAI->Internal_ChangeTarget(POwner->PMaster->battleTarget());
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

void CPlayerCharmController::DoRoamTick(timer::time_point tick) const
{
    if (POwner->PMaster->PAI->IsEngaged())
    {
        POwner->PAI->Internal_Engage(POwner->PMaster->battleTarget());
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

auto CPlayerCharmController::Cast(const EntityId target, SpellID spellid) -> bool
{
    return false;
}

auto CPlayerCharmController::ChangeTarget(const EntityId& target) -> bool
{
    return false;
}

auto CPlayerCharmController::WeaponSkill(EntityId target, uint16 wsid) -> bool
{
    return false;
}

auto CPlayerCharmController::Ability(EntityId target, uint16 abilityid) -> bool
{
    return false;
}

auto CPlayerCharmController::RangedAttack(const EntityId target) -> bool
{
    return false;
}
