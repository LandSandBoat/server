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
#include "entities/pet_entity.h"
#include "status_effect_container.h"
#include "utils/petutils.h"

namespace
{

const std::set immobilePets = {
    PETID_LUOPAN,
    PETID_ALEXANDER,
    PETID_ODIN,
    PETID_ATOMOS,
};

}

CPetController::CPetController(CMobEntity* _PPet)
: CMobController(_PPet)
, PPet(_PPet)
{
    // TODO: this probably will have to depend on pet type (automaton does WS on its own..)
    SetWeaponSkillEnabled(false);
}

auto CPetController::Tick(timer::time_point tick) -> Task<void>
{
    TracyZoneScoped;
    TracyZoneString(PPet->getName());

    bool isPlayerPet = PPet->objtype == TYPE_PET || (PPet->objtype == TYPE_MOB && PPet->PMaster && PPet->PMaster->objtype == TYPE_PC);

    // if a player pet then check if a charmed mob or jug pet and if it should despawn
    if (isPlayerPet)
    {
        // if a charmed mob and charm time is up then despawn
        if (PPet->isCharmed && tick > PPet->charmTime)
        {
            petutils::DespawnPet(PPet->PMaster);
            co_return;
        }

        // if a jug pet and the current time > jug spawn time + jug duration then despawn
        auto* PPetEntity = dynamic_cast<CPetEntity*>(PPet);
        if (PPetEntity && PPetEntity->isAlive() && PPetEntity->getPetType() == PET_TYPE::JUG_PET)
        {
            if (tick > PPetEntity->getJugSpawnTime() + PPetEntity->getJugDuration())
            {
                petutils::DespawnPet(PPetEntity->PMaster);
                co_return;
            }
        }
    }

    co_await CMobController::Tick(tick);
}

// Light Spirit is the only elemental spirit that is allowed to cast out of combat.
auto CPetController::DoBuffTick() -> bool
{
    const auto* PPetEntity = dynamic_cast<CPetEntity*>(PPet);
    if (!PPetEntity || PPetEntity->petID() != PETID_LIGHTSPIRIT)
    {
        return false;
    }

    return CMobController::DoBuffTick();
}

auto CPetController::DoRoamTick(timer::time_point tick) -> Task<void>
{
    TracyZoneScoped;

    if ((PPet->PMaster == nullptr || PPet->PMaster->isDead()) && PPet->isAlive() && PPet->objtype != TYPE_MOB)
    {
        PPet->Die();
        co_return;
    }

    // If pet cannot change state (for example because pet is asleep) then just return
    if (!PPet->PAI->CanChangeState())
    {
        co_return;
    }

    const auto isPet        = PPet->objtype == TYPE_PET;
    const auto isCharmedMob = PPet->objtype == TYPE_MOB && PPet->PMaster && PPet->PMaster->objtype == TYPE_PC;

    if (isPet || isCharmedMob)
    {
        const auto* PPetEntity = dynamic_cast<CPetEntity*>(PPet);

        // A non-CPetEntity is a CMobEntity that has been charmed - a BST pet
        const auto isBstPet = PPetEntity ? PPetEntity->isBstPet() : true;

        if (PPetEntity != nullptr)
        {
            const auto petType             = PPetEntity->getPetType();
            const auto isWyvernOrAutomaton = petType == PET_TYPE::WYVERN || petType == PET_TYPE::AUTOMATON;

            if (isWyvernOrAutomaton)
            {
                if (PetIsHealing())
                {
                    co_return;
                }

                // TODO: Other logic?
            }

            // Certain pets do not roam
            if (immobilePets.contains(static_cast<PETID>(PPetEntity->petID())))
            {
                co_return;
            }
        }

        if (isBstPet && PPet->StatusEffectContainer->GetStatusEffect(xi::StatusEffect::Healing))
        {
            co_return;
        }
    }

    if (!PPet->PMaster)
    {
        co_return;
    }

    const float currentDistance = distance(PPet->loc.p, PPet->PMaster->loc.p);

    if (currentDistance <= PetRoamDistance)
    {
        co_return;
    }

    // Recalculate path only if owner moves more than X yalms
    if (!PPet->PAI->PathFind->IsFollowingPath() ||
        distance(PPet->PAI->PathFind->GetDestination(), PPet->PMaster->loc.p) > 2.0f)
    {
        if (!PPet->PAI->PathFind->PathAround(PPet->PMaster->loc.p, 2.0f, PATHFLAG_RUN | PATHFLAG_WALLHACK) &&
            !PPet->PAI->PathFind->PathInRange(PPet->PMaster->loc.p, 2.0f, PATHFLAG_RUN | PATHFLAG_WALLHACK))
        {
            // If we got here, the pet isn't able to path to master
            // But it cant, so maybe we teleported or dropped down a hole
            PPet->PAI->PathFind->WarpTo(PPet->PMaster->loc.p, PetRoamDistance);
        }
    }

    PPet->PAI->PathFind->FollowPath(m_Tick);

    co_return;
}

bool CPetController::PetIsHealing()
{
    const auto isMasterHealing = PPet->PMaster->animation == ANIMATION_HEALING;
    const auto isPetHealing    = PPet->animation == ANIMATION_HEALING;

    if (isMasterHealing && !isPetHealing && !PPet->StatusEffectContainer->HasPreventActionEffect())
    {
        // Animation down
        PPet->animation = ANIMATION_HEALING;
        PPet->StatusEffectContainer->AddStatusEffect(xi::StatusEffect::Healing, 0, 0, std::chrono::seconds(settings::get<uint8>("map.HEALING_TICK_DELAY")), 0s);
        PPet->updatemask |= UPDATE_HP;
        return true;
    }
    else if (!isMasterHealing && isPetHealing)
    {
        // Animation up
        PPet->animation = ANIMATION_NONE;
        PPet->StatusEffectContainer->DelStatusEffect(xi::StatusEffect::Healing);
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
    TracyZoneScoped;

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
