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

#include "mobskill_state.h"
#include "ai/ai_container.h"
#include "enmity_container.h"
#include "entities/battleentity.h"
#include "entities/mobentity.h"
#include "mobskill.h"
#include "packets/action.h"
#include "status_effect_container.h"
#include "utils/battleutils.h"

CMobSkillState::CMobSkillState(CBattleEntity* PEntity, uint16 targid, uint16 wsid)
: CState(PEntity, targid)
, m_PEntity(PEntity)
, m_spentTP(0)
{
    auto* skill = battleutils::GetMobSkill(wsid);
    if (!skill)
    {
        throw CStateInitException(nullptr);
    }

    if (m_PEntity->StatusEffectContainer->HasStatusEffect({ EFFECT_AMNESIA, EFFECT_IMPAIRMENT }))
    {
        throw CStateInitException(nullptr);
    }

    auto* PTarget = m_PEntity->IsValidTarget(m_targid, skill->getValidTargets(), m_errorMsg);

    if (!PTarget || m_errorMsg)
    {
        throw CStateInitException(std::move(m_errorMsg));
    }

    m_PSkill = std::make_unique<CMobSkill>(*skill);

    m_castTime = std::chrono::milliseconds(m_PSkill->getActivationTime());

    if (m_castTime > 0s)
    {
        action_t action;
        action.id         = m_PEntity->id;
        action.actiontype = ACTION_MOBABILITY_START;

        actionList_t& actionList  = action.getNewActionList();
        actionList.ActionTargetID = PTarget->id;

        actionTarget_t& actionTarget = actionList.getNewActionTarget();

        actionTarget.reaction   = REACTION::NONE;
        actionTarget.speceffect = SPECEFFECT::NONE;
        actionTarget.animation  = 0;
        actionTarget.param      = m_PSkill->getID();
        actionTarget.messageID  = 43;
        m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, std::make_unique<CActionPacket>(action));

        // face toward target // TODO : add force param to turnTowardsTarget on certain TP moves like Petro Eyes
        battleutils::turnTowardsTarget(m_PEntity, PTarget);
    }
    m_PEntity->PAI->EventHandler.triggerListener("WEAPONSKILL_STATE_ENTER", CLuaBaseEntity(m_PEntity), m_PSkill->getID());
    SpendCost();
}

CMobSkill* CMobSkillState::GetSkill()
{
    return m_PSkill.get();
}

void CMobSkillState::SpendCost()
{
    if (!m_PSkill->isTpFreeSkill())
    {
        if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_SEKKANOKI))
        {
            m_spentTP = m_PEntity->addTP(-1000);
            m_PEntity->StatusEffectContainer->DelStatusEffect(EFFECT_SEKKANOKI);
        }
        else if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_MEIKYO_SHISUI) &&
                 m_PEntity->GetLocalVar("[MeikyoShisui]MobSkillCount") > 0)
        {
            auto currentCount = m_PEntity->GetLocalVar("[MeikyoShisui]MobSkillCount");
            m_PEntity->SetLocalVar("[MeikyoShisui]MobSkillCount", currentCount - 1);
            m_spentTP = m_PEntity->addTP(-1000);
        }
        else
        {
            m_spentTP            = m_PEntity->health.tp;
            m_PEntity->health.tp = 0;
        }
    }
}

bool CMobSkillState::Update(time_point tick)
{
    // Rotate towards target during ability // TODO : add force param to turnTowardsTarget on certain TP moves like Petro Eyes
    if (m_castTime > 0s && tick < GetEntryTime() + m_castTime)
    {
        CBaseEntity* PTarget = GetTarget();
        if (PTarget)
        {
            battleutils::turnTowardsTarget(m_PEntity, PTarget);
        }
    }

    if (m_PEntity && m_PEntity->isAlive() && (tick > GetEntryTime() + m_castTime && !IsCompleted()))
    {
        action_t action;
        m_PEntity->OnMobSkillFinished(*this, action);
        m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, std::make_unique<CActionPacket>(action));
        auto delay   = std::chrono::milliseconds(m_PSkill->getAnimationTime());
        m_finishTime = tick + delay;
        Complete();
    }
    if (IsCompleted() && tick > m_finishTime)
    {
        auto* PTarget = GetTarget();
        if (PTarget && PTarget->objtype == TYPE_MOB && PTarget != m_PEntity && m_PEntity->allegiance == ALLEGIANCE_TYPE::PLAYER)
        {
            static_cast<CMobEntity*>(PTarget)->PEnmityContainer->UpdateEnmity(m_PEntity, 0, 0);
        }
        m_PEntity->PAI->EventHandler.triggerListener("WEAPONSKILL_STATE_EXIT", CLuaBaseEntity(m_PEntity), m_PSkill->getID());

        if (m_PEntity->objtype == TYPE_PET && m_PEntity->PMaster && m_PEntity->PMaster->objtype == TYPE_PC && (m_PSkill->isBloodPactRage() || m_PSkill->isBloodPactWard()))
        {
            CCharEntity* PSummoner = dynamic_cast<CCharEntity*>(m_PEntity->PMaster);
            if (PSummoner && PSummoner->StatusEffectContainer->HasStatusEffect(EFFECT_AVATARS_FAVOR))
            {
                auto power = PSummoner->StatusEffectContainer->GetStatusEffect(EFFECT_AVATARS_FAVOR)->GetPower();
                // Retail: Power is gained for BP use
                auto levelGained = m_PSkill->isBloodPactRage() ? 3 : 2;
                power += levelGained;
                PSummoner->StatusEffectContainer->GetStatusEffect(EFFECT_AVATARS_FAVOR)->SetPower(power > 11 ? power : 11);
            }
        }
        return true;
    }
    return false;
}

void CMobSkillState::Cleanup(time_point tick)
{
    if (m_PEntity && m_PEntity->isAlive() && !IsCompleted())
    {
        action_t action;
        action.id         = m_PEntity->id;
        action.actiontype = ACTION_MOBABILITY_INTERRUPT;
        action.actionid   = 28787;

        actionList_t& actionList  = action.getNewActionList();
        actionList.ActionTargetID = m_PEntity->id;

        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.animation       = 0x1FC; // Not perfectly accurate, this animation ID can change from time to time for unknown reasons.
        actionTarget.reaction        = REACTION::HIT;

        m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, std::make_unique<CActionPacket>(action));

        // On retail testing, mobs lose 33% of their TP at 2900 or higher TP
        // But lose 25% at < 2900 TP.
        // Testing was done via charm on a steelshell, methodology was the following on BST/DRK with a scythe
        // charm -> build tp -> leave -> stun -> interrupt TP move with weapon bash -> charm and check TP. Note that weapon bash incurs damage and thus adds TP.
        // Note: this is very incomplete. Further testing shows that other statuses also reduce TP but in addition it seems that specific mobskills may reduce TP more or less than these numbers
        // Thus while incomplete, is better than nothing.
        if (m_PEntity->StatusEffectContainer &&
            m_PEntity->StatusEffectContainer->HasStatusEffect({ EFFECT::EFFECT_STUN, EFFECT::EFFECT_TERROR, EFFECT::EFFECT_PETRIFICATION, EFFECT::EFFECT_SLEEP, EFFECT::EFFECT_SLEEP_II, EFFECT::EFFECT_LULLABY }))
        {
            int16 tp = m_spentTP;
            if (tp >= 2900)
            {
                m_PEntity->health.tp = std::floor(std::round(0.333333f * tp));
            }
            else
            {
                m_PEntity->health.tp = std::floor(0.25f * tp);
            }
        }
    }
}
