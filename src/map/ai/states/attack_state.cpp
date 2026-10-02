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

#include "action/action.h"
#include "entities/battle_entity.h"

#include "ai/ai_container.h"
#include "entities/char_entity.h"
#include "packets/s2c/0x028_battle2.h"
#include "packets/s2c/0x058_assist.h"
#include "utils/battleutils.h"
#include "zone.h"

namespace
{

constexpr timer::duration kEngageDelay    = 3s;     // time from engaging to the first swing
constexpr timer::duration kEngageCooldown = 1500ms; // shortest wait before engaging again after a fight ends

} // namespace

CAttackState::CAttackState(xi::Badge<CState>, CBattleEntity* PEntity, const EntityId& target)
: CState(PEntity, target)
, m_PEntity(PEntity)
, m_attackTime(kEngageDelay)
{
    // Capture constructor arguments into members and nothing else. All other logic goes into init().
}

auto CAttackState::init() -> StateErrorOr<void>
{
    m_PEntity->setBattleTarget(target());
    m_PEntity->SetBattleStartTime(timer::now());
    m_swingDelay = std::chrono::milliseconds(m_PEntity->GetWeaponDelay(false));
    CAttackState::UpdateTarget();

    if (!m_PEntity->GetBattleTarget() || m_errorMsg)
    {
        m_PEntity->setBattleTarget(std::nullopt);
        return refuseWithErrorMsg();
    }

    if (m_PEntity->PAI->PathFind)
    {
        m_PEntity->PAI->PathFind->Clear();
    }

    return Success();
}

auto CAttackState::Update(timer::time_point tick) -> bool
{
    auto* PTarget = m_PEntity->GetBattleTarget();
    if (!PTarget || PTarget->isDead())
    {
        return true;
    }

    // Subtract on every tick, including the one we swing on, or each swing costs an extra tick.
    m_attackTime -= (m_PEntity->PAI->getTick() - m_PEntity->PAI->getPrevTick());

    if (AttackReady())
    {
        if (CanAttack(PTarget))
        {
            // CanAttack may have set target id to 0 (disengage from out of range)
            if (!m_PEntity->battleTarget().isSet())
            {
                return true;
            }
            action_t action{};
            if (m_PEntity->OnAttack(*this, action))
            {
                // TODO: what about AoE auto attacks?
                battleutils::handleKillshotEnmity(m_PEntity, PTarget);

                // CMobEntity::OnAttack(...) can generate it's own action with a mobmod, and that leaves this action.actionType = 0, which is never valid. Skip sending the packet.
                if (action.actiontype != ActionCategory::None)
                {
                    m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, std::make_unique<GP_SERV_COMMAND_BATTLE2>(action));
                }
            }
        }
        else if (m_PEntity->OnAttackError(*this))
        {
            m_PEntity->HandleErrorMessage(m_errorMsg);
        }
        if (!m_PEntity->battleTarget().isSet())
        {
            return true;
        }
    }

    // Don't bank time while we can't swing. Sits after the swing so leftover time carries.
    m_attackTime = std::max<timer::duration>(m_attackTime, 0ms);

    return false;
}

void CAttackState::Cleanup(timer::time_point tick)
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

auto CAttackState::EngageLockout() const -> timer::duration
{
    // Uses the delay of the last swing, not the current weapon.
    const timer::duration timeLeftOnSwing = m_attackTime;
    const timer::duration longestLockout  = std::max(kEngageCooldown, m_swingDelay - kEngageDelay);

    return std::clamp(timeLeftOnSwing, kEngageCooldown, longestLockout);
}

void CAttackState::UpdateTarget(const EntityId& target)
{
    m_errorMsg.reset();
    auto           newTarget{ m_PEntity->battleTarget() };
    CBattleEntity* PNewTarget{ nullptr };
    if (newTarget.isSet())
    {
        PNewTarget = m_PEntity->IsValidTarget(newTarget, TARGET_ENEMY, m_errorMsg);
        if (!PNewTarget)
        {
            const auto* PLostTarget = newTarget.resolve<CBattleEntity>();

            newTarget          = EntityId{};
            CCharEntity* PChar = dynamic_cast<CCharEntity*>(m_PEntity);
            if (PChar && PChar->hasAutoTargetEnabled())
            {
                for (auto&& PPotentialTarget : PChar->SpawnMOBList)
                {
                    if (PPotentialTarget.second->animation == xi::Animation::Attack && facing(PChar->loc.p, PPotentialTarget.second->loc.p, 64) &&
                        distance(PChar->loc.p, PPotentialTarget.second->loc.p) <= 10)
                    {
                        std::unique_ptr<CBasicPacket> errMsg;
                        if (PChar->IsValidTarget(EntityId(PPotentialTarget.second), TARGET_ENEMY, errMsg))
                        {
                            newTarget = EntityId(PPotentialTarget.second);
                            PChar->pushPacket<GP_SERV_COMMAND_ASSIST>(PChar, static_cast<CBattleEntity*>(PPotentialTarget.second));
                            break;
                        }
                    }
                }
            }

            // target died: restart the swing timer at a full delay
            if (!newTarget.isSet() && PLostTarget && PLostTarget->isDead())
            {
                m_attackTime = m_swingDelay;
            }

            m_PEntity->PAI->ChangeTarget(newTarget);
        }
    }
    if (target != newTarget)
    {
        if (target.isSet())
        {
            m_PEntity->OnChangeTarget(PNewTarget);
            SetTarget(newTarget);
            if (!PNewTarget)
            {
                m_errorMsg.reset();
                return;
            }
        }
    }
}

auto CAttackState::CanAttack(CBattleEntity* PTarget) -> bool
{
    const auto ret = m_PEntity->CanAttack(PTarget, m_errorMsg);

    if (ret && !m_errorMsg)
    {
        m_swingDelay = std::chrono::milliseconds(m_PEntity->GetWeaponDelay(false));
        m_attackTime += m_swingDelay;
    }
    return ret;
}

auto CAttackState::AttackReady() const -> bool
{
    return m_attackTime <= 0ms && m_PEntity->isAlive();
}

auto CAttackState::CanChangeState() -> bool
{
    return true;
}

auto CAttackState::CanFollowPath() -> bool
{
    return true;
}

auto CAttackState::CanInterrupt() -> bool
{
    return false;
}
