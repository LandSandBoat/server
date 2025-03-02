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
#include "ai/ai_container.h"
#include "common/utils.h"
#include "enmity_container.h"
#include "entities/charentity.h"
#include "entities/mobentity.h"
#include "packets/action.h"
#include "recast_container.h"
#include "status_effect_container.h"
#include "utils/battleutils.h"
#include "utils/charutils.h"

CAbilityState::CAbilityState(CBattleEntity* PEntity, uint16 targid, uint16 abilityid)
: CState(PEntity, targid)
, m_PEntity(PEntity)
{
    CAbility* PAbility = ability::GetAbility(abilityid);

    if (!PAbility)
    {
        throw CStateInitException(std::make_unique<CMessageBasicPacket>(m_PEntity, m_PEntity, 0, 0, MSGBASIC_UNABLE_TO_USE_JA));
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
        action_t action;
        action.id              = PEntity->id;
        action.actiontype      = ACTION_WEAPONSKILL_START;
        auto& list             = action.getNewActionList();
        list.ActionTargetID    = PTarget->id;
        auto& actionTarget     = list.getNewActionTarget();
        actionTarget.reaction  = REACTION::HIT | REACTION::ABILITY; // TODO: not all abilities are HIT + Ability (provoke/chi blast has been observed as only REACTION:ABILITY)
        actionTarget.animation = 121;
        actionTarget.messageID = 326;
        actionTarget.param     = PAbility->getID();
        PEntity->loc.zone->PushPacket(PEntity, CHAR_INRANGE_SELF, std::make_unique<CActionPacket>(action));
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

bool CAbilityState::Update(time_point tick)
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
            action_t action;
            m_PEntity->OnAbility(*this, action);
            m_PEntity->PAI->EventHandler.triggerListener("ABILITY_USE", m_PEntity, GetTarget(), m_PAbility.get(), &action);
            m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, std::make_unique<CActionPacket>(action));
            if (auto* target = GetTarget())
            {
                target->PAI->EventHandler.triggerListener("ABILITY_TAKE", target, m_PEntity, m_PAbility.get(), &action);
            }
        }
        else if (m_castTime > 0s) // Instant abilities do not need to be interrupted
        {
            CBaseEntity* PTarget = GetTarget();

            action_t action;
            action.id         = m_PEntity->id;
            action.actiontype = ACTION_JOBABILITY_INTERRUPT;
            action.actionid   = 28787;

            actionList_t& actionList  = action.getNewActionList();
            actionList.ActionTargetID = PTarget ? PTarget->id : m_PEntity->id;

            actionTarget_t& actionTarget = actionList.getNewActionTarget();
            actionTarget.animation       = 0x1FC;
            actionTarget.reaction        = REACTION::MISS;

            m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, std::make_unique<CActionPacket>(action));
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
            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_WAIT_LONGER);
            return false;
        }

        if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_AMNESIA) ||
            (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_IMPAIRMENT) && (PChar->StatusEffectContainer->GetStatusEffect(EFFECT_IMPAIRMENT)->GetPower() == 0x01 || PChar->StatusEffectContainer->GetStatusEffect(EFFECT_IMPAIRMENT)->GetPower() == 0x03)) ||
            (PAbility->getID() >= ABILITY_CONCENTRIC_PULSE && PAbility->getID() <= ABILITY_RADIAL_ARCANA &&
             PAbility->isPetAbility() && !charutils::hasAbility(PChar, PAbility->getID())) ||
            (!PAbility->isPetAbility() && !charutils::hasAbility(PChar, PAbility->getID())) ||
            (PAbility->isPetAbility() && PAbility->getID() >= ABILITY_HEALING_RUBY && !charutils::hasPetAbility(PChar, PAbility->getID() - ABILITY_HEALING_RUBY)))
        {
            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_JA2);
            return false;
        }

        if (PTarget && PChar->IsValidTarget(PTarget->targid, PAbility->getValidTarget(), errMsg))
        {
            if (PChar != PTarget && distance(PChar->loc.p, PTarget->loc.p) > PAbility->getRange())
            {
                PChar->pushPacket<CMessageBasicPacket>(PChar, PTarget, 0, 0, MSGBASIC_TOO_FAR_AWAY);
                return false;
            }

            if (m_PEntity->loc.zone->CanUseMisc(MISC_LOS_PLAYER_BLOCK) && !m_PEntity->CanSeeTarget(PTarget, false))
            {
                m_errorMsg = std::make_unique<CMessageBasicPacket>(m_PEntity, PTarget, PAbility->getID(), 0, MSGBASIC_CANNOT_PERFORM_ACTION);
                return false;
            }

            // TODO: Remove this when all pet abilities are moved to PetSkill system.
            if (PAbility->getID() >= ABILITY_HEALING_RUBY && !battleutils::GetPetSkill(PAbility->getID()))
            {
                // Blood pact MP costs are stored under animation ID
                if (PChar->health.mp < PAbility->getAnimationID())
                {
                    PChar->pushPacket<CMessageBasicPacket>(PChar, PTarget, 0, 0, MSGBASIC_UNABLE_TO_USE_JA);
                    return false;
                }
            }

            CBaseEntity* PMsgTarget = PChar;
            int32        errNo      = luautils::OnAbilityCheck(PChar, PTarget, PAbility, &PMsgTarget);
            if (errNo != 0)
            {
                PChar->pushPacket<CMessageBasicPacket>(PChar, PMsgTarget, PAbility->getID(), PAbility->getID(), errNo);
                return false;
            }
            return true;
        }
        return false;
    }
    else
    {
        bool   tooFarAway      = false;
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
            if (m_PEntity != PTarget && distance(m_PEntity->loc.p, PTarget->loc.p) > PAbility->getRange())
            {
                cancelAbility = true;
                tooFarAway    = true;
            }
        }

        if (cancelAbility)
        {
            // Only create a packet if the ability isn't instant
            if (m_castTime > 0s)
            {
                // Create this action packet that also sort of looks like an animation cancel packet to emit a red "Target is too far away" message.
                // Captured from a red "<target> is too far away" message from healing breath IV
                action_t action;

                action.id         = m_PEntity->id;
                action.actiontype = ACTION_MAGIC_FINISH;
                action.actionid   = 0;

                actionList_t& actionList  = action.getNewActionList();
                actionList.ActionTargetID = PTarget ? PTarget->id : m_PEntity->id;

                actionTarget_t& actionTarget = actionList.getNewActionTarget();
                actionTarget.animation       = 0x1FC;
                actionTarget.reaction        = REACTION::MISS;
                actionTarget.speceffect      = static_cast<SPECEFFECT>(0x24);
                actionTarget.param           = 0; // Observed as 639 on retail, but I'm not sure that it actually does anything.
                actionTarget.messageID       = tooFarAway ? MSGBASIC_TOO_FAR_AWAY_RED : 0;

                m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, std::make_unique<CActionPacket>(action));
            }
            return false;
        }

        // TODO: should luautils::OnAbilityCheck go here too?
    }
    return true;
}
