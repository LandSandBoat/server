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

#include <cstring>

#include "ai/ai_container.h"
#include "ai/controllers/pet_controller.h"
#include "ai/helpers/pathfind.h"
#include "ai/helpers/targetfind.h"
#include "ai/states/ability_state.h"
#include "ai/states/petskill_state.h"
#include "mob_modifier.h"
#include "mob_spell_container.h"
#include "mob_spell_list.h"
#include "packets/entity_update.h"
#include "packets/pet_sync.h"
#include "status_effect_container.h"
#include "utils/battleutils.h"
#include "utils/mobutils.h"
#include "utils/petutils.h"

#include "common/timer.h"
#include "common/utils.h"
#include "petentity.h"

#include "action/action.h"
#include "action/interrupts.h"
#include "packets/s2c/0x029_battle_message.h"

CPetEntity::CPetEntity(PET_TYPE petType)
: CMobEntity()
, m_PetID(0)
, m_PetType(petType)
, m_spawnLevel(0)
, m_jugSpawnTime(timer::time_point::min())
, m_jugDuration(timer::duration::min())
{
    TracyZoneScoped;
    objtype                     = TYPE_PET;
    m_EcoSystem                 = ECOSYSTEM::UNCLASSIFIED;
    allegiance                  = ALLEGIANCE_TYPE::PLAYER;
    m_MobSkillList              = 0;
    m_bReleaseTargIDOnDisappear = true;
    spawnAnimation              = SPAWN_ANIMATION::SPECIAL; // Initial spawn has the special spawn-in animation

    PAI = std::make_unique<CAIContainer>(this, std::make_unique<CPathFind>(this), std::make_unique<CPetController>(this), std::make_unique<CTargetFind>(this));
}

CPetEntity::~CPetEntity()
{
    TracyZoneScoped;
}

PET_TYPE CPetEntity::getPetType()
{
    return m_PetType;
}

uint8 CPetEntity::getSpawnLevel()
{
    return m_spawnLevel;
}

void CPetEntity::setSpawnLevel(uint8 level)
{
    m_spawnLevel = level;
}

bool CPetEntity::isBstPet()
{
    return getPetType() == PET_TYPE::JUG_PET || objtype == TYPE_MOB;
}

timer::time_point CPetEntity::getJugSpawnTime()
{
    if (m_PetType != PET_TYPE::JUG_PET)
    {
        ShowWarning("Non-Jug Pet calling function (%d).", static_cast<uint8>(m_PetType));
    }

    return m_jugSpawnTime;
}

void CPetEntity::setJugSpawnTime(timer::time_point spawnTime)
{
    if (m_PetType != PET_TYPE::JUG_PET)
    {
        ShowWarning("Non-Jug Pet calling function (%d).", static_cast<uint8>(m_PetType));
        return;
    }

    m_jugSpawnTime = spawnTime;
}

timer::duration CPetEntity::getJugDuration()
{
    if (m_PetType != PET_TYPE::JUG_PET)
    {
        ShowWarning("Non-Jug Pet calling function (%d).", static_cast<uint8>(m_PetType));
        return 0s;
    }

    return m_jugDuration;
}

void CPetEntity::setJugDuration(timer::duration seconds)
{
    if (m_PetType != PET_TYPE::JUG_PET)
    {
        ShowWarning("Non-Jug Pet calling function (%d).", static_cast<uint8>(m_PetType));
        return;
    }

    m_jugDuration = seconds;
}

const std::string CPetEntity::GetScriptName()
{
    switch (getPetType())
    {
        case PET_TYPE::AVATAR:
            return "avatar";
            break;
        case PET_TYPE::WYVERN:
            return "wyvern";
            break;
        case PET_TYPE::JUG_PET:
            return "jug";
            break;
        case PET_TYPE::CHARMED_MOB:
            return "charmed";
            break;
        case PET_TYPE::AUTOMATON:
            return "automaton";
            break;
        case PET_TYPE::ADVENTURING_FELLOW:
            return "fellow";
            break;
        case PET_TYPE::CHOCOBO:
            return "chocobo";
            break;
        case PET_TYPE::LUOPAN:
            return "luopan";
            break;
        default:
            return "";
            break;
    }
}

WYVERN_TYPE CPetEntity::getWyvernType()
{
    if (PMaster == nullptr)
    {
        ShowWarning("PMaster is null.");
        return WYVERN_TYPE::NONE;
    }

    switch (PMaster->GetSJob())
    {
        case JOB_BLM:
        case JOB_BLU:
        case JOB_SMN:
        case JOB_WHM:
        case JOB_RDM:
        case JOB_SCH:
        case JOB_GEO:
            return WYVERN_TYPE::DEFENSIVE;
        case JOB_DRK:
        case JOB_PLD:
        case JOB_NIN:
        case JOB_BRD:
        case JOB_RUN:
            return WYVERN_TYPE::MULTIPURPOSE;
        case JOB_WAR:
        case JOB_SAM:
        case JOB_THF:
        case JOB_BST:
        case JOB_RNG:
        case JOB_COR:
        case JOB_DNC:
            return WYVERN_TYPE::OFFENSIVE;

        default:
            return WYVERN_TYPE::OFFENSIVE;
    };
}

void CPetEntity::PostTick()
{
    CBattleEntity::PostTick();
    timer::time_point now = timer::now();
    if (loc.zone && updatemask && status != STATUS_TYPE::DISAPPEAR && now > m_nextUpdateTimer)
    {
        m_nextUpdateTimer = now + 250ms;
        loc.zone->UpdateEntityPacket(this, ENTITY_UPDATE, updatemask);

        if (PMaster && PMaster->PPet == this)
        {
            ((CCharEntity*)PMaster)->pushPacket<CPetSyncPacket>((CCharEntity*)PMaster);
        }

        updatemask = 0;
    }
}

void CPetEntity::FadeOut()
{
    CMobEntity::FadeOut();
    loc.zone->UpdateEntityPacket(this, ENTITY_DESPAWN, UPDATE_NONE);
}

void CPetEntity::Die()
{
    PAI->ClearStateStack();

    // master is zoning, don't go to death state, instead despawn instantly
    if (health.hp > 0 && PMaster && PMaster->objtype == TYPE_PC && static_cast<CCharEntity*>(PMaster)->petZoningInfo.respawnPet)
    {
        PAI->Internal_Despawn(true);
    }
    else
    {
        PAI->Internal_Die(2500ms);
    }

    luautils::OnMobDeath(this, nullptr);

    // NOTE: This is purposefully calling CBattleEntity's impl.
    // TODO: Calling a grand-parent's impl. of an overrideden function is bad
    CBattleEntity::Die();
    if (PMaster && PMaster->PPet == this && PMaster->objtype == TYPE_PC)
    {
        petutils::DetachPet(PMaster);
    }
}

void CPetEntity::Spawn()
{
    // we need to skip CMobEntity's spawn because it calculates stats (and our stats are already calculated)
    if (PMaster && PMaster->objtype == TYPE_PC && m_EcoSystem == ECOSYSTEM::ELEMENTAL)
    {
        this->defaultMobMod(MOBMOD_MAGIC_DELAY, 12);
        this->defaultMobMod(MOBMOD_MAGIC_COOL, 48);
        mobutils::GetAvailableSpells(this);
    }

    if (m_PetType == PET_TYPE::JUG_PET)
    {
        m_jugSpawnTime = timer::now();
    }

    // NOTE: This is purposefully calling CBattleEntity's impl.
    // TODO: Calling a grand-parent's impl. of an overridden function is bad
    CBattleEntity::Spawn();
    luautils::OnMobSpawn(this);
}

void CPetEntity::loadPetZoningInfo()
{
    if (!PAI->IsSpawned())
    {
        ShowWarning("Attempt to load info without Pet spawned.");
        return;
    }

    if (auto* master = dynamic_cast<CCharEntity*>(PMaster))
    {
        health.tp = static_cast<uint16>(master->petZoningInfo.petTP);
        health.hp = master->petZoningInfo.petHP;
        health.mp = master->petZoningInfo.petMP;

        if (m_PetType == PET_TYPE::JUG_PET)
        {
            setJugDuration(master->petZoningInfo.jugDuration);
            setJugSpawnTime(master->petZoningInfo.jugSpawnTime);
        }
    }
}

void CPetEntity::OnAbility(CAbilityState& state, action_t& action)
{
    auto* PAbility = state.GetAbility();
    auto* PTarget  = static_cast<CBattleEntity*>(state.GetTarget());

    std::unique_ptr<CBasicPacket> errMsg;
    if (PTarget && IsValidTarget(PTarget->targid, PAbility->getValidTarget(), errMsg))
    {
        if (this != PTarget && distance(this->loc.p, PTarget->loc.p) > PAbility->getRange() + modelHitboxSize + PTarget->modelHitboxSize)
        {
            return;
        }

        // Currently, only the Wyvern uses abilities at all as of writing, but their abilities are not instant and are mob abilities.
        // Abilities are not subject to paralyze if they have non-zero cast time due to this corner case.
        if (state.GetAbility()->getCastTime() == 0s && battleutils::IsParalyzed(this))
        {
            ActionInterrupts::AbilityParalyzed(this, PTarget);
            return;
        }

        action.actorId                = this->id;
        action.actiontype             = PAbility->getActionType();
        action.actionid               = PAbility->getID();
        action_target_t& actionTarget = action.addTarget(PTarget->id);
        action_result_t& actionResult = actionTarget.addResult();
        actionResult.resolution       = ActionResolution::Hit;
        actionResult.animation        = PAbility->getAnimationID();
        actionResult.param            = 0;
        auto prevMsg                  = actionResult.messageID;

        int32 value = luautils::OnUseAbility(this, PTarget, PAbility, &action);
        if (prevMsg == actionResult.messageID)
        {
            actionResult.messageID = PAbility->getMessage();
        }

        if (actionResult.messageID == 0)
        {
            actionResult.messageID = MSGBASIC_USES_JA;
        }

        actionResult.param = value;

        if (value < 0)
        {
            actionResult.messageID = ability::GetAbsorbMessage(actionResult.messageID);
            actionResult.param     = -value;
        }
    }
    else // Can't target anything, just cancel the animation.
    {
        ActionInterrupts::AbilityInterrupt(this);
    }
}

bool CPetEntity::ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags)
{
    if (targetFlags & TARGET_PLAYER && PInitiator->allegiance == allegiance)
    {
        return false;
    }
    return CMobEntity::ValidTarget(PInitiator, targetFlags);
}

bool CPetEntity::CanAttack(CBattleEntity* PTarget, std::unique_ptr<CBasicPacket>& errMsg)
{
    // prevent pets from attacking mobs that the PC master does not own
    if (this->PMaster)
    {
        auto* PChar = dynamic_cast<CCharEntity*>(this->PMaster);
        if (PChar && !PChar->IsMobOwner(PTarget))
        {
            errMsg = std::make_unique<GP_SERV_COMMAND_BATTLE_MESSAGE>(this, PTarget, 0, 0, MSGBASIC_ALREADY_CLAIMED);
            PAI->Disengage();
            return false;
        }
    }

    return CBattleEntity::CanAttack(PTarget, errMsg);
}

void CPetEntity::OnPetSkillFinished(CPetSkillState& state, action_t& action)
{
    TracyZoneScoped;
    auto* PSkill  = state.GetPetSkill();
    auto* PTarget = dynamic_cast<CBattleEntity*>(state.GetTarget());

    if (PTarget == nullptr)
    {
        ShowWarning("CMobEntity::OnMobSkillFinished: PTarget is null");
        return;
    }

    PAI->TargetFind->reset();
    uint8 findFlags = 0;

    // Mob buff abilities also hit monster's pets
    if (PSkill->getValidTargets() & TARGET_SELF)
    {
        findFlags |= FINDFLAGS_PET;
        // skill can target self and is aoe, add itself to targetfind first
        if (PSkill->isAoE())
        {
            PTarget = this;
        }
    }

    if ((PSkill->getValidTargets() & TARGET_IGNORE_BATTLEID) == TARGET_IGNORE_BATTLEID)
    {
        findFlags |= FINDFLAGS_IGNORE_BATTLEID;
    }

    if ((PSkill->getValidTargets() & TARGET_PLAYER_DEAD) == TARGET_PLAYER_DEAD)
    {
        findFlags |= FINDFLAGS_DEAD;
    }

    action.actorId    = id;
    action.actiontype = PSkill->getSkillFinishCategory();
    if (PSkill->getMobSkillID() > 0)
    {
        // jug pet skills emulate mob skills but still have the same flow as wyvern and smn pet skills
        action.actionid = PSkill->getMobSkillID();
    }
    else
    {
        action.actionid = PSkill->getID();
    }

    if (PAI->TargetFind->isWithinRange(&PTarget->loc.p, PSkill->getDistance() + this->modelHitboxSize + PTarget->modelHitboxSize))
    {
        if (PSkill->isAoE())
        {
            PAI->TargetFind->findWithinArea(PTarget, static_cast<AOE_RADIUS>(PSkill->getAoe()), PSkill->getRadius(), findFlags, PSkill->getValidTargets());
        }
        else if (PSkill->isConal())
        {
            float angle = 45.0f;
            PAI->TargetFind->findWithinCone(PTarget, PSkill->getRadius(), angle, findFlags, PSkill->getValidTargets());
        }
        else
        {
            if (this->objtype == TYPE_MOB && PTarget->objtype == TYPE_PC)
            {
                CBattleEntity* PCoverAbilityUser = battleutils::GetCoverAbilityUser(PTarget, this);
                if (PCoverAbilityUser != nullptr)
                {
                    PTarget = PCoverAbilityUser;
                }
            }

            PAI->TargetFind->findSingleTarget(PTarget, findFlags, PSkill->getValidTargets());
            // special jug pet skills that affect pet and owner: non-aoe-skill, primary target is the pet, and targetflag includes "actor's party"
            // If we didn't filter on pet type, skills like healing ruby would fit the condition
            if (this->getPetType() == PET_TYPE::JUG_PET && this->PMaster != nullptr && PTarget == this && PSkill->getValidTargets() & TARGET_PLAYER_PARTY)
            {
                // addEntity does not handle range checking
                if (PAI->TargetFind->isWithinRange(&this->PMaster->loc.p, PSkill->getRadius()))
                {
                    PAI->TargetFind->addEntity(this->PMaster, false);
                }
            }
        }
    }
    else // Out of range
    {
        if (this->getPetType() == PET_TYPE::AVATAR)
        {
            ActionInterrupts::AvatarOutOfRange(this, PSkill, PTarget);
        }
        else if (this->getPetType() == PET_TYPE::WYVERN)
        {
            ActionInterrupts::WyvernOutOfRange(this, PSkill, PTarget);
        }

        return;
    }

    uint16 targets = (uint16)PAI->TargetFind->m_targets.size();

    // No targets, perhaps something like Super Jump or otherwise untargetable
    if (targets == 0)
    {
        // There used to be a specific interrupt here, but it's not clear in what conditions it should occur
        // Add a test and retail capture before reintroducing.
        return;
    }

    PSkill->setTotalTargets(targets);
    PSkill->setPrimaryTargetID(PTarget->id);
    PSkill->setTP(state.GetSpentTP());
    PSkill->setHP(health.hp);
    PSkill->setHPP(GetHPP());

    MSGBASIC_ID msg            = MSGBASIC_NONE;
    MSGBASIC_ID defaultMessage = PSkill->getMsg();

    bool first{ true };
    for (auto&& PTargetFound : PAI->TargetFind->m_targets)
    {
        action_target_t& actionTarget = action.addTarget(PTargetFound->id);
        action_result_t& actionResult = actionTarget.addResult();
        actionTarget.actorId          = PTargetFound->id;
        actionResult.resolution       = ActionResolution::Hit;
        actionResult.animation        = PSkill->getAnimationID();
        actionResult.messageID        = PSkill->getMsg();

        // reset the skill's message back to default
        PSkill->setMsg(defaultMessage);
        int32 damage = 0;

        /* if (petType == PET_TYPE::AUTOMATON) // TODO: figure out Automaton
        {
            damage = luautils::OnAutomatonAbility(PTarget, this, PSkill, PMaster, &action);
        }
        else*/
        {
            damage = luautils::OnPetAbility(PTargetFound, this, PSkill, PMaster, &action);
        }

        // primary target will have msg == 0
        if (msg == 0)
        {
            msg = PSkill->getMsg();
        }
        else
        {
            // convert to aoe message
            msg = PSkill->getAoEMsg();
        }

        // damage was absorbed
        if (damage < 0)
        {
            // TODO: verify this message does/does not vary depending on mob/avatar/automaton use
            //       furthermore, this likely needs to be PSkill->setMsg(MSGBASIC_SKILL_RECOVERS_HP) and happen before the above code
            msg = MSGBASIC_SKILL_RECOVERS_HP;
            actionResult.recordDamage(attack_outcome_t{
                .atkType = ATTACK_TYPE::PHYSICAL,
                .damage  = std::clamp(-damage, 0, PTargetFound->GetMaxHP() - PTargetFound->health.hp),
                .target  = PTargetFound,
            });
        }
        else if (damage > 0 && PSkill->isDamageMsg())
        {
            // We use the skill to carry the critical flag and the attack type
            // This should be deprecated in favor of onPetAbility returning a table...
            actionResult.recordDamage(attack_outcome_t{
                .atkType    = PSkill->getAttackType(),
                .damage     = damage,
                .target     = PTargetFound,
                .isCritical = PSkill->isCritical(),
            });

            // Reset the flag
            PSkill->setCritical(false);
        }
        else
        {
            // Buffs/debuffs/status effects - just set param directly
            actionResult.param = damage;
        }

        actionResult.messageID = msg;

        if (PSkill->hasMissMsg())
        {
            actionResult.resolution = ActionResolution::Miss;
        }
        else
        {
            actionResult.resolution = ActionResolution::Hit;
        }

        if (actionResult.resolution != ActionResolution::Miss && actionResult.resolution != ActionResolution::Parry)
        {
            actionResult.knockback = PSkill->getKnockback();
            if (first && PTargetFound->health.hp > 0 && PSkill->getPrimarySkillchain() != 0)
            {
                const auto effect = battleutils::GetSkillChainEffect(
                    PTargetFound,
                    PSkill->getPrimarySkillchain(),
                    PSkill->getSecondarySkillchain(),
                    PSkill->getTertiarySkillchain());
                if (effect != ActionProcSkillChain::None)
                {
                    actionResult.recordSkillchain(effect, battleutils::TakeSkillchainDamage(this, PTargetFound, actionResult.param, nullptr));
                }

                first = false;
            }
        }

        if (PSkill->getValidTargets() & TARGET_ENEMY)
        {
            PTargetFound->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DETECTABLE);
        }

        if (PTargetFound->isDead())
        {
            battleutils::ClaimMob(PTargetFound, this);
        }
        battleutils::DirtyExp(PTargetFound, this);
    }

    PTarget = dynamic_cast<CBattleEntity*>(state.GetTarget()); // TODO: why is this recast here? can state change between now and the original cast?

    if (PTarget)
    {
        if (PTarget->objtype == TYPE_MOB && (PTarget->isDead() || (this->getPetType() == PET_TYPE::AVATAR)))
        {
            battleutils::ClaimMob(PTarget, this);
        }
        battleutils::DirtyExp(PTarget, this);
    }
}
