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

#include "attack_state.h"

#include "entities/battleentity.h"

#include "ai/ai_container.h"
#include "packets/action.h"
#include "packets/lock_on.h"
#include "utils/battleutils.h"

CAttackState::CAttackState(CBattleEntity* PEntity, uint16 targid)
: CState(PEntity, targid)
, m_PEntity(PEntity)
{
    PEntity->SetBattleTargetID(targid);
    PEntity->SetBattleStartTime(server_clock::now());
    CAttackState::UpdateTarget();

    if (!GetTarget() || m_errorMsg)
    {
        PEntity->SetBattleTargetID(0);
        if (this->HasErrorMsg())
        {
            throw CStateInitException(m_errorMsg->copy());
        }
        else
        {
            throw CStateInitException(std::make_unique<CBasicPacket>());
        }
    }

    if (PEntity->PAI->PathFind)
    {
        PEntity->PAI->PathFind->Clear();
    }
}

bool CAttackState::Update(time_point tick)
{
    auto* PTarget = static_cast<CBattleEntity*>(GetTarget());
    if (!PTarget || PTarget->isDead())
    {
        return true;
    }
    if (AttackReady())
    {
        if (CanAttack(PTarget))
        {
            // CanAttack may have set target id to 0 (disengage from out of range)
            if (m_PEntity->GetBattleTargetID() == 0)
            {
                return true;
            }
            action_t action;
            if (m_PEntity->OnAttack(*this, action))
            {
                // CMobEntity::OnAttack(...) can generate it's own action with a mobmod, and that leaves this action.actionType = 0, which is never valid. Skip sending the packet.
                if (action.actiontype != ACTION_NONE)
                {
                    m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, std::make_unique<CActionPacket>(action));
                }
            }
        }
        else if (m_PEntity->OnAttackError(*this))
        {
            m_PEntity->HandleErrorMessage(m_errorMsg);
        }
        if (m_PEntity->GetBattleTargetID() == 0)
        {
            return true;
        }
    }
    else
    {
        m_attackTime -= (m_PEntity->PAI->getTick() - m_PEntity->PAI->getPrevTick());
    }
    return false;
}

void CAttackState::Cleanup(time_point tick)
{
    if (!m_PEntity->isDead())
    {
        m_PEntity->OnDisengage(*this);
    }
}

void CAttackState::ResetAttackTimer()
{
    m_attackTime = std::chrono::milliseconds(m_PEntity->GetWeaponDelay(false));
}

void CAttackState::UpdateTarget(CBaseEntity* target)
{
    if (target != nullptr)
    {
        CAttackState::UpdateTarget(target->targid);
    }
}

void CAttackState::UpdateTarget(uint16 targid)
{
    m_errorMsg.reset();
    auto           newTargid{ m_PEntity->GetBattleTargetID() };
    CBattleEntity* PNewTarget{ nullptr };
    if (newTargid != 0)
    {
        PNewTarget = m_PEntity->IsValidTarget(newTargid, TARGET_ENEMY, m_errorMsg);
        if (!PNewTarget)
        {
            newTargid          = 0;
            CCharEntity* PChar = dynamic_cast<CCharEntity*>(m_PEntity);
            if (PChar && PChar->hasAutoTargetEnabled())
            {
                for (auto&& PPotentialTarget : PChar->SpawnMOBList)
                {
                    if (PPotentialTarget.second->animation == ANIMATION_ATTACK && facing(PChar->loc.p, PPotentialTarget.second->loc.p, 64) &&
                        distance(PChar->loc.p, PPotentialTarget.second->loc.p) <= 10)
                    {
                        std::unique_ptr<CBasicPacket> errMsg;
                        if (PChar->IsValidTarget(PPotentialTarget.second->targid, TARGET_ENEMY, errMsg))
                        {
                            newTargid = PPotentialTarget.second->targid;
                            PChar->pushPacket<CLockOnPacket>(PChar, static_cast<CBattleEntity*>(PPotentialTarget.second));
                            break;
                        }
                    }
                }
            }
            m_PEntity->PAI->ChangeTarget(newTargid);
        }
    }
    if (targid != newTargid)
    {
        if (targid != 0)
        {
            m_PEntity->OnChangeTarget(PNewTarget);
            SetTarget(newTargid);
            if (!PNewTarget)
            {
                m_errorMsg.reset();
                return;
            }
        }
    }
    CState::UpdateTarget(m_PEntity->GetBattleTargetID());
}

bool CAttackState::CanAttack(CBattleEntity* PTarget)
{
    auto ret = m_PEntity->CanAttack(PTarget, m_errorMsg);

    if (ret && !m_errorMsg)
    {
        m_attackTime += std::chrono::milliseconds(m_PEntity->GetWeaponDelay(false));
    }
    return ret;
}

bool CAttackState::AttackReady()
{
    return m_attackTime < 0ms && m_PEntity->isAlive();
}
