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

#include "pet_controller.h"

#include "ai/ai_container.h"
#include "common/utils.h"
#include "entities/petentity.h"
#include "status_effect_container.h"
#include "utils/petutils.h"

CPetController::CPetController(CPetEntity* _PPet)
: CMobController(_PPet)
, PPet(_PPet)
{
    // #TODO: this probably will have to depend on pet type (automaton does WS on its own..)
    SetWeaponSkillEnabled(false);
}

void CPetController::Tick(time_point tick)
{
    TracyZoneScoped;
    TracyZoneString(PPet->getName());

    if (PPet->shouldDespawn(tick))
    {
        petutils::DespawnPet(PPet->PMaster);
        return;
    }
    CMobController::Tick(tick);
}

void CPetController::DoRoamTick(time_point tick)
{
    if ((PPet->PMaster == nullptr || PPet->PMaster->isDead()) && PPet->isAlive() && PPet->objtype != TYPE_MOB)
    {
        PPet->Die();
        return;
    }

    // if pet cannot change state (for example because pet is asleep) then just return
    if (!PPet->PAI->CanChangeState())
    {
        return;
    }

    // automaton, wyvern
    if (PPet->getPetType() == PET_TYPE::WYVERN || PPet->getPetType() == PET_TYPE::AUTOMATON)
    {
        if (PetIsHealing())
        {
            return;
        }
    }
    else if (PPet->isBstPet() && PPet->StatusEffectContainer->GetStatusEffect(EFFECT_HEALING))
    {
        return;
    }
    else if (PPet->m_PetID <= PETID_DARKSPIRIT)
    {
        // this will respect the pet's mob casting cooldown properties via MOBMOD_MAGIC_COOL
        if (CMobController::IsSpellReady(0) && CMobController::TryCastSpell())
        {
            return;
        }
    }

    float currentDistance = distance(PPet->loc.p, PPet->PMaster->loc.p);

    if (currentDistance > PetRoamDistance)
    {
        if (currentDistance < 35.0f && PPet->PAI->PathFind->PathAround(PPet->PMaster->loc.p, 2.0f, PATHFLAG_RUN | PATHFLAG_WALLHACK))
        {
            PPet->PAI->PathFind->FollowPath(m_Tick);
        }
        else if (PPet->GetSpeed() > 0)
        {
            PPet->PAI->PathFind->WarpTo(PPet->PMaster->loc.p, PetRoamDistance);
        }
    }
}

bool CPetController::PetIsHealing()
{
    bool isMasterHealing = (PPet->PMaster->animation == ANIMATION_HEALING);
    bool isPetHealing    = (PPet->animation == ANIMATION_HEALING);

    if (isMasterHealing && !isPetHealing && !PPet->StatusEffectContainer->HasPreventActionEffect())
    {
        // animation down
        PPet->animation = ANIMATION_HEALING;
        PPet->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_HEALING, 0, 0, settings::get<uint8>("map.HEALING_TICK_DELAY"), 0));
        PPet->updatemask |= UPDATE_HP;
        return true;
    }
    else if (!isMasterHealing && isPetHealing)
    {
        // animation up
        PPet->animation = ANIMATION_NONE;
        PPet->StatusEffectContainer->DelStatusEffect(EFFECT_HEALING);
        PPet->updatemask |= UPDATE_HP;
        return false;
    }
    return isMasterHealing;
}

bool CPetController::TryDeaggro()
{
    if (PTarget == nullptr)
    {
        return true;
    }

    // target is no longer valid, so wipe them from our enmity list
    if (PTarget->isDead() || PTarget->isMounted() || PTarget->loc.zone->GetID() != PPet->loc.zone->GetID() ||
        PPet->StatusEffectContainer->GetConfrontationEffect() != PTarget->StatusEffectContainer->GetConfrontationEffect() ||
        PPet->getBattleID() != PTarget->getBattleID())
    {
        return true;
    }
    return false;
}

bool CPetController::Ability(uint16 targid, uint16 abilityid)
{
    if (PPet->PAI->CanChangeState())
    {
        return PPet->PAI->Internal_Ability(targid, abilityid);
    }
    return false;
}

bool CPetController::PetSkill(uint16 targid, uint16 abilityid)
{
    TracyZoneScoped;
    if (POwner)
    {
        FaceTarget(targid);
        PPet->PAI->EventHandler.triggerListener("WEAPONSKILL_BEFORE_USE", PPet, abilityid);
        return POwner->PAI->Internal_PetSkill(targid, abilityid);
    }

    return false;
}
