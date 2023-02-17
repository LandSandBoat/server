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

    if (!PTarget || m_errorMsg)
    {
        throw CStateInitException(std::move(m_errorMsg));
    }
    SetTarget(PTarget->targid);
    m_PAbility = std::make_unique<CAbility>(*PAbility);
    m_castTime = PAbility->getCastTime();
    if (m_castTime > 0s)
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
        PEntity->loc.zone->PushPacket(PEntity, CHAR_INRANGE_SELF, new CActionPacket(action));
    }
    m_PEntity->PAI->EventHandler.triggerListener("ABILITY_START", CLuaBaseEntity(m_PEntity), CLuaAbility(PAbility));
}

CAbility* CAbilityState::GetAbility()
{
    return m_PAbility.get();
}

void CAbilityState::ApplyEnmity()
{
    auto* PTarget = GetTarget();
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

bool CAbilityState::CanChangeState()
{
    return IsCompleted();
}

bool CAbilityState::Update(time_point tick)
{
    if (!IsCompleted() && tick > GetEntryTime() + m_castTime)
    {
        if (CanUseAbility())
        {
            action_t action;
            m_PEntity->OnAbility(*this, action);
            m_PEntity->PAI->EventHandler.triggerListener("ABILITY_USE", CLuaBaseEntity(m_PEntity), CLuaBaseEntity(GetTarget()), CLuaAbility(m_PAbility.get()), CLuaAction(&action));
            m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, new CActionPacket(action));
            if (auto* target = GetTarget())
            {
                target->PAI->EventHandler.triggerListener("ABILITY_TAKE", CLuaBaseEntity(target), CLuaBaseEntity(m_PEntity), CLuaAbility(m_PAbility.get()), CLuaAction(&action));
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
        m_PEntity->PAI->EventHandler.triggerListener("ABILITY_STATE_EXIT", CLuaBaseEntity(m_PEntity), CLuaAbility(m_PAbility.get()));
        return true;
    }

    return false;
}

bool CAbilityState::CanUseAbility()
{
    if (m_PEntity->objtype == TYPE_PC)
    {
        auto* PAbility = GetAbility();
        auto* PChar    = static_cast<CCharEntity*>(m_PEntity);
        if (PChar->PRecastContainer->HasRecast(RECAST_ABILITY, PAbility->getRecastId(), PAbility->getRecastTime()))
        {
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_WAIT_LONGER));
            return false;
        }

        if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_AMNESIA) ||
            (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_IMPAIRMENT) && (PChar->StatusEffectContainer->GetStatusEffect(EFFECT_IMPAIRMENT)->GetPower() == 0x01 || PChar->StatusEffectContainer->GetStatusEffect(EFFECT_IMPAIRMENT)->GetPower() == 0x03)) ||
            (PAbility->getID() >= ABILITY_CONCENTRIC_PULSE && PAbility->getID() <= ABILITY_RADIAL_ARCANA &&
             PAbility->isPetAbility() && !charutils::hasAbility(PChar, PAbility->getID())) ||
            (!PAbility->isPetAbility() && !charutils::hasAbility(PChar, PAbility->getID())) ||
            (PAbility->isPetAbility() && PAbility->getID() >= ABILITY_HEALING_RUBY && !charutils::hasPetAbility(PChar, PAbility->getID() - ABILITY_HEALING_RUBY)))
        {
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_JA2));
            return false;
        }

        std::unique_ptr<CBasicPacket> errMsg;
        auto*                         PTarget = GetTarget();
        if (PChar->IsValidTarget(PTarget->targid, PAbility->getValidTarget(), errMsg))
        {
            if (PChar != PTarget && distance(PChar->loc.p, PTarget->loc.p) > PAbility->getRange())
            {
                PChar->pushPacket(new CMessageBasicPacket(PChar, PTarget, 0, 0, MSGBASIC_TOO_FAR_AWAY));
                return false;
            }

            if (m_PEntity->loc.zone->CanUseMisc(MISC_LOS_PLAYER_BLOCK) && !m_PEntity->CanSeeTarget(PTarget, false))
            {
                m_errorMsg = std::make_unique<CMessageBasicPacket>(m_PEntity, PTarget, PAbility->getID(), 0, MSGBASIC_CANNOT_PERFORM_ACTION);
                return false;
            }

            if (PAbility->getID() >= ABILITY_HEALING_RUBY)
            {
                // Blood pact MP costs are stored under animation ID
                if (PChar->health.mp < PAbility->getAnimationID())
                {
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PTarget, 0, 0, MSGBASIC_UNABLE_TO_USE_JA));
                    return false;
                }
            }

            CBaseEntity* PMsgTarget = PChar;
            int32        errNo      = luautils::OnAbilityCheck(PChar, PTarget, PAbility, &PMsgTarget);
            if (errNo != 0)
            {
                PChar->pushPacket(new CMessageBasicPacket(PChar, PMsgTarget, PAbility->getID(), PAbility->getID(), errNo));
                return false;
            }
            return true;
        }
        return false;
    }
    return true;
}
