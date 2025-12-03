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

#include "ability_state.h"

#include "ability.h"
#include "action/action.h"
#include "action/interrupts.h"
#include "ai/ai_container.h"
#include "common/utils.h"
#include "enmity_container.h"
#include "entities/charentity.h"
#include "entities/mobentity.h"
#include "entities/petentity.h"
#include "packets/s2c/0x028_battle2.h"
#include "packets/s2c/0x029_battle_message.h"
#include "petskill.h"
#include "recast_container.h"
#include "status_effect_container.h"
#include "utils/battleutils.h"
#include "utils/charutils.h"

namespace
{
// Handle Blood Pacts and Ready distance checks separately.
// They come in as the final ability to be used through the packets but must pass the intermediary ability distance before triggering
// Examples:
// Predator Claws in packet -> PC must pass Blood Pact: Rage (20y) distance check
// Lamb Chop in packet -> PC must pass Ready (4y) distance check
auto PetSkillDistanceCheck(CCharEntity* PChar, CBaseEntity* PTarget, const CAbility* PAbility) -> bool
{
    auto*            PPet      = dynamic_cast<CPetEntity*>(PChar->PPet);
    const CPetSkill* PPetSkill = battleutils::GetPetSkill(PAbility->getID());

    if (!PPet || !PPetSkill)
    {
        return false;
    }

    if (PPetSkill->isBloodPactRage() || PPetSkill->isBloodPactWard())
    {
        // Blood Pacts:
        // 1 - PC must be within 20y + hitboxes from target
        // 2 - Avatar must be within skill range + hitboxes from target
        if (PChar != PTarget && distance(PChar->loc.p, PTarget->loc.p) > 20.0f + PChar->modelHitboxSize + PTarget->modelHitboxSize)
        {
            return false;
        }

        if (distance(PPet->loc.p, PTarget->loc.p) > PPetSkill->getDistance() + PPet->modelHitboxSize + PTarget->modelHitboxSize)
        {
            PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PTarget, 0, 0, MSGBASIC_TARG_OUT_OF_RANGE);
            return false;
        }
    }
    else if (PPetSkill->getMobSkillID() > 0)
    {
        // Jug pet skills:
        // 1 - PC must be within 4y + hitboxes from pet
        // 2 - Pet must be within skill range + hitboxes from enemy (if skill targets enemy)
        if (distance(PChar->loc.p, PPet->loc.p) > 4.0f + PChar->modelHitboxSize + PPet->modelHitboxSize)
        {
            PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MSGBASIC_TARG_OUT_OF_RANGE);
            return false;
        }

        if (PPetSkill->getValidTargets() & TARGET_ENEMY)
        {
            if (auto* PPetTarget = PPet->GetBattleTarget(); PPetTarget && distance(PPet->loc.p, PPetTarget->loc.p) > PPetSkill->getDistance() + PPet->modelHitboxSize + PPetTarget->modelHitboxSize)
            {
                PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PPetTarget, 0, 0, MSGBASIC_TARG_OUT_OF_RANGE);
                return false;
            }
        }
    }

    return true;
}
} // namespace

CAbilityState::CAbilityState(CBattleEntity* PEntity, uint16 targid, uint16 abilityid)
: CState(PEntity, targid)
, m_PEntity(PEntity)
{
    CAbility* PAbility = ability::GetAbility(abilityid);

    if (!PAbility)
    {
        throw CStateInitException(std::make_unique<GP_SERV_COMMAND_BATTLE_MESSAGE>(m_PEntity, m_PEntity, 0, 0, MSGBASIC_UNABLE_TO_USE_JA));
    }
    auto* PTarget = m_PEntity->IsValidTarget(m_targid, PAbility->getValidTarget(), m_errorMsg);

    if (!PTarget || this->HasErrorMsg())
    {
        if (this->HasErrorMsg())
        {
            throw CStateInitException(m_errorMsg->copy());
        }
        else
        {
            throw CStateInitException(std::make_unique<CBasicPacket>());
        }
    }
    SetTarget(PTarget->targid);
    m_PAbility = std::make_unique<CAbility>(*PAbility);
    m_castTime = PAbility->getCastTime();

    if (m_castTime > 0s && CanUseAbility())
    {
        action_t action{
            .actorId    = PEntity->id,
            .actiontype = ActionCategory::AbilityStart,
            .targets    = {
                {
                       .actorId = PTarget->id,
                       .results = {
                        {
                               .animation = ActionAnimation::SkillStart,
                               .param     = PAbility->getID(),
                               .messageID = MSGBASIC_READIES_SKILL,
                        },
                    },
                },
            }
        };

        PEntity->loc.zone->PushPacket(PEntity, CHAR_INRANGE_SELF, std::make_unique<GP_SERV_COMMAND_BATTLE2>(action));
        m_PEntity->PAI->EventHandler.triggerListener("ABILITY_START", m_PEntity, PAbility);

        // face toward target
        battleutils::turnTowardsTarget(m_PEntity, PTarget);
    }
    else
    {
        m_PEntity->PAI->EventHandler.triggerListener("ABILITY_START", m_PEntity, PAbility);
    }
}

CAbility* CAbilityState::GetAbility()
{
    return m_PAbility.get();
}

void CAbilityState::ApplyEnmity()
{
    auto* PTarget = GetTarget();
    if (PTarget)
    {
        if (m_PAbility->getValidTarget() & TARGET_ENEMY && PTarget->allegiance != m_PEntity->allegiance)
        {
            if (PTarget->objtype == TYPE_MOB && !(m_PAbility->getCE() == 0 && m_PAbility->getVE() == 0))
            {
                CMobEntity* mob = (CMobEntity*)PTarget;
                mob->PEnmityContainer->UpdateEnmity(m_PEntity, m_PAbility->getCE(), m_PAbility->getVE(), false, m_PAbility->getID() == ABILITY_CHARM);
                battleutils::ClaimMob(mob, m_PEntity);
            }
        }
        else if (PTarget->allegiance == m_PEntity->allegiance)
        {
            battleutils::GenerateInRangeEnmity(m_PEntity, m_PAbility->getCE(), m_PAbility->getVE());
        }
    }
}

bool CAbilityState::CanChangeState()
{
    return IsCompleted();
}

bool CAbilityState::Update(timer::time_point tick)
{
    // Rotate towards target during ability
    if (m_castTime > 0s && tick < GetEntryTime() + m_castTime)
    {
        CBaseEntity* PTarget = GetTarget();
        if (PTarget)
        {
            battleutils::turnTowardsTarget(m_PEntity, PTarget);
        }
    }

    if (!IsCompleted() && tick > GetEntryTime() + m_castTime)
    {
        if (CanUseAbility())
        {
            action_t action{};
            m_PEntity->OnAbility(*this, action);
            m_PEntity->PAI->EventHandler.triggerListener("ABILITY_USE", m_PEntity, GetTarget(), m_PAbility.get(), &action);
            // Only send packet if action was populated (e.g. interrupts return early)
            if (!action.targets.empty())
            {
                m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, std::make_unique<GP_SERV_COMMAND_BATTLE2>(action));
            }
            if (auto* target = GetTarget())
            {
                target->PAI->EventHandler.triggerListener("ABILITY_TAKE", target, m_PEntity, m_PAbility.get(), &action);
            }
        }

        Complete();
    }

    if (IsCompleted() && tick > GetEntryTime() + m_castTime + m_PAbility->getAnimationTime())
    {
        if (m_PEntity->objtype == TYPE_PC)
        {
            CCharEntity* PChar = static_cast<CCharEntity*>(m_PEntity);
            PChar->m_charHistory.abilitiesUsed++;
        }
        m_PEntity->PAI->EventHandler.triggerListener("ABILITY_STATE_EXIT", m_PEntity, m_PAbility.get());
        return true;
    }

    return false;
}

bool CAbilityState::CanUseAbility()
{
    CAbility*    PAbility = GetAbility();
    CBaseEntity* PTarget  = GetTarget();

    std::unique_ptr<CBasicPacket> errMsg;

    if (m_PEntity->objtype == TYPE_PC)
    {
        auto* PChar = static_cast<CCharEntity*>(m_PEntity);
        if (PChar->PRecastContainer->HasRecast(RECAST_ABILITY, PAbility->getRecastId(), PAbility->getRecastTime()))
        {
            PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MSGBASIC_WAIT_LONGER);
            return false;
        }

        if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_AMNESIA) ||
            (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_IMPAIRMENT) && (PChar->StatusEffectContainer->GetStatusEffect(EFFECT_IMPAIRMENT)->GetPower() == 0x01 || PChar->StatusEffectContainer->GetStatusEffect(EFFECT_IMPAIRMENT)->GetPower() == 0x03)) ||
            (!PAbility->isPetAbility() && !charutils::hasAbility(PChar, PAbility->getID())) ||
            (PAbility->isPetAbility() && PAbility->getID() >= ABILITY_HEALING_RUBY && !charutils::hasPetAbility(PChar, PAbility->getID() - ABILITY_HEALING_RUBY)))
        {
            PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_JA2);
            return false;
        }

        if (PTarget && PChar->IsValidTarget(PTarget->targid, PAbility->getValidTarget(), errMsg))
        {
            // TODO: Rework the way abilities and pet abilities are laid out so it can all go through the same block and have the pet special checks done in lua
            const CPetSkill* PPetSkill       = PAbility->isPetAbility() ? battleutils::GetPetSkill(PAbility->getID()) : nullptr;
            const bool       isLuopanAbility = PAbility->getID() >= ABILITY_CONCENTRIC_PULSE && PAbility->getID() <= ABILITY_RADIAL_ARCANA;
            if (PPetSkill && !isLuopanAbility && (PPetSkill->isBloodPactRage() || PPetSkill->isBloodPactWard() || PPetSkill->getMobSkillID() > 0))
            {
                if (!PetSkillDistanceCheck(PChar, PTarget, PAbility))
                {
                    return false;
                }
            }
            else if (PChar != PTarget && distance(PChar->loc.p, PTarget->loc.p) > PAbility->getRange() + PChar->modelHitboxSize + PTarget->modelHitboxSize)
            {
                PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PTarget, 0, 0, MSGBASIC_TOO_FAR_AWAY);
                return false;
            }

            if (m_PEntity->loc.zone->CanUseMisc(MISC_LOS_PLAYER_BLOCK) && !m_PEntity->CanSeeTarget(PTarget, false))
            {
                PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PTarget, 0, 0, MSGBASIC_UNABLE_TO_SEE_TARG);
                return false;
            }

            CBaseEntity* PMsgTarget = PChar;
            int32        errNo      = luautils::OnAbilityCheck(PChar, PTarget, PAbility, &PMsgTarget);
            if (errNo != 0)
            {
                PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PMsgTarget, PAbility->getID(), PAbility->getID(), static_cast<MSGBASIC_ID>(errNo));
                return false;
            }
            return true;
        }
        return false;
    }
    else
    {
        bool   cancelAbility   = false;
        bool   hasAmnesia      = m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_AMNESIA);
        bool   hasImpairment   = m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_IMPAIRMENT);
        uint16 impairmentPower = hasImpairment ? m_PEntity->StatusEffectContainer->GetStatusEffect(EFFECT_IMPAIRMENT)->GetPower() : 0;

        if (!PTarget)
        {
            cancelAbility = true;
        }

        if (hasAmnesia ||
            (hasImpairment && (impairmentPower == 0x01 || impairmentPower == 0x03)))
        {
            cancelAbility = true;
        }

        if (PTarget && m_PEntity->IsValidTarget(PTarget->targid, PAbility->getValidTarget(), errMsg))
        {
            if (m_PEntity != PTarget && distance(m_PEntity->loc.p, PTarget->loc.p) > PAbility->getRange() + m_PEntity->modelHitboxSize + PTarget->modelHitboxSize)
            {
                cancelAbility = true;
            }
        }

        if (cancelAbility)
        {
            return false;
        }

        // TODO: should luautils::OnAbilityCheck go here too?
    }
    return true;
}
