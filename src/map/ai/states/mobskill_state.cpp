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
#include "../../enmity_container.h"
#include "../../entities/mobentity.h"
#include "../../mobskill.h"
#include "../../packets/action.h"
#include "../../status_effect_container.h"
#include "../../utils/battleutils.h"
#include "../ai_container.h"

CMobSkillState::CMobSkillState(CMobEntity* PEntity, uint16 targid, uint16 wsid)
: CState(PEntity, targid)
, m_PEntity(PEntity)
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
        m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE, new CActionPacket(action));
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
    if (m_PSkill->isTpSkill())
    {
        m_spentTP            = m_PEntity->health.tp;
        m_PEntity->health.tp = 0;
    }
}

bool CMobSkillState::Update(time_point tick)
{
    if (tick > GetEntryTime() + m_castTime && !IsCompleted())
    {
        action_t action;
        m_PEntity->OnMobSkillFinished(*this, action);
        m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, new CActionPacket(action));
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

        if (m_PEntity->objtype == TYPE_PET && m_PEntity->PMaster && m_PEntity->PMaster->objtype == TYPE_PC && (WasBloodPactRage(m_PSkill->getID()) || WasBloodPactWard(m_PSkill->getID())))
        {
            CCharEntity* PSummoner = (CCharEntity*)(m_PEntity->PMaster);
            if (PSummoner && PSummoner->StatusEffectContainer->HasStatusEffect(EFFECT_AVATARS_FAVOR))
            {
                int power = PSummoner->StatusEffectContainer->GetStatusEffect(EFFECT_AVATARS_FAVOR)->GetPower();
                // Rage BPs reduce the power of Avatar's Favor by 4 levels
                // Ward BPs reduce the power of Avatar's Favor by 2 levels
                // Inorder for the effect drop to be noticable - bumping to 5 and 3
                int levelLost = WasBloodPactRage(m_PSkill->getID()) ? 5 : 3;
                power -= levelLost;
                PSummoner->StatusEffectContainer->GetStatusEffect(EFFECT_AVATARS_FAVOR)->SetPower(power > 0 ? power : 1);
            }
        }
        return true;
    }
    return false;
}

void CMobSkillState::Cleanup(time_point tick)
{
    if (!IsCompleted())
    {
        action_t action;
        action.id         = m_PEntity->id;
        action.actiontype = ACTION_MOBABILITY_INTERRUPT;

        actionList_t& actionList  = action.getNewActionList();
        actionList.ActionTargetID = m_PEntity->id;

        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.animation       = m_PSkill->getID();

        m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE, new CActionPacket(action));
    }
}

bool CMobSkillState::WasBloodPactRage(uint16 wsid)
{
    return (wsid == 831 || wsid == 832 || wsid == 836 || wsid == 838 || wsid == 839 || wsid == 840 || wsid == 841 || wsid == 842 || wsid == 843 || wsid == 845 || wsid == 846 || wsid == 847 ||
        wsid == 848 || wsid == 849 || wsid == 850 || wsid == 851 || wsid == 852 || wsid == 854 || wsid == 855 || wsid == 856 || wsid == 857 || wsid == 858 || wsid == 859 || wsid == 860 ||
        wsid == 863 || wsid == 864 || wsid == 865 || wsid == 866 || wsid == 867 || wsid == 868 || wsid == 872 || wsid == 873 || wsid == 874 || wsid == 875 || wsid == 876 || wsid == 877 ||
        wsid == 880 || wsid == 881 || wsid == 882 || wsid == 883 || wsid == 884 || wsid == 885 || wsid == 886 || wsid == 888 || wsid == 890 || wsid == 891 || wsid == 892 || wsid == 893 ||
        wsid == 907 || wsid == 910 || wsid == 912 || wsid == 913 || wsid == 914 || wsid == 915 || wsid == 916 || wsid == 917 || wsid == 918 || wsid == 919 || wsid == 1903 || wsid == 1910 ||
        wsid == 2448 || wsid == 2452 || wsid == 2453 || wsid == 2454 || wsid == 2455 || wsid == 2456 || wsid == 2457);
}

bool CMobSkillState::WasBloodPactWard(uint16 wsid)
{
    return ((wsid > 830 && wsid < 894) || (wsid > 905 && wsid < 920) || (wsid > 1902 && wsid < 1912) || (wsid > 2447 && wsid < 2458)) && !WasBloodPactRage(wsid);
}
