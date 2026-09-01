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

#include "ai/ai_container.h"

#include "ai/controllers/mob_controller.h"
#include "ai/controllers/pet_controller.h"
#include "ai/controllers/player_controller.h"
#include "entities/base_entity.h"
#include "entities/battle_entity.h"
#include "entities/char_entity.h"
#include "states/ability_state.h"
#include "states/attack_state.h"
#include "states/death_state.h"
#include "states/despawn_state.h"
#include "states/inactive_state.h"
#include "states/item_state.h"
#include "states/magic_state.h"
#include "states/mobskill_state.h"
#include "states/petskill_state.h"
#include "states/range_state.h"
#include "states/synth_state.h"
#include "states/trigger_state.h"
#include "states/weaponskill_state.h"
#include "status_effect_container.h"

CAIContainer::CAIContainer(CBaseEntity* _PEntity)
: CAIContainer(_PEntity, nullptr, nullptr, nullptr)
{
}

CAIContainer::CAIContainer(CBaseEntity*                   _PEntity,
                           std::unique_ptr<CPathFind>&&   _pathfind,
                           std::unique_ptr<CController>&& _controller,
                           std::unique_ptr<CTargetFind>&& _targetfind)
: TargetFind(std::move(_targetfind))
, PathFind(std::move(_pathfind))
, Controller(std::move(_controller))
, m_Tick(timer::now())
, m_PrevTick(timer::now())
, PEntity(_PEntity)
, ActionQueue(_PEntity)
{
}

auto CAIContainer::Cast(const EntityId& target, SpellID spellid) const -> bool
{
    if (Controller)
    {
        return Controller->Cast(target, spellid);
    }
    return false;
}

auto CAIContainer::Engage(const EntityId& target) const -> bool
{
    if (Controller)
    {
        return Controller->Engage(target);
    }
    return false;
}

auto CAIContainer::ChangeTarget(const EntityId& target) const -> bool
{
    if (Controller)
    {
        return Controller->ChangeTarget(target);
    }
    return false;
}

auto CAIContainer::Disengage() const -> bool
{
    if (Controller)
    {
        return Controller->Disengage();
    }
    return false;
}

auto CAIContainer::WeaponSkill(const EntityId& target, const uint16 wsid) const -> bool
{
    if (Controller)
    {
        return Controller->WeaponSkill(target, wsid);
    }
    return false;
}

auto CAIContainer::MobSkill(const EntityId& target, const uint16 wsid, const Maybe<timer::duration> castTimeOverride) const -> bool
{
    auto* AIController = dynamic_cast<CMobController*>(Controller.get());
    if (AIController)
    {
        return AIController->MobSkill(target, wsid, castTimeOverride);
    }
    return false;
}

auto CAIContainer::PetSkill(const EntityId& target, const uint16 wsid) const -> bool
{
    auto* AIController = dynamic_cast<CPetController*>(Controller.get());
    if (AIController)
    {
        return AIController->PetSkill(target, wsid);
    }
    return false;
}

auto CAIContainer::Ability(const EntityId& target, const uint16 abilityid) const -> bool
{
    if (Controller)
    {
        return Controller->Ability(target, abilityid);
    }

    return false;
}

auto CAIContainer::RangedAttack(const EntityId& target) const -> bool
{
    if (Controller)
    {
        return Controller->RangedAttack(target);
    }

    return false;
}

auto CAIContainer::Trigger(CCharEntity* player) -> bool
{
    // TODO: ensure idempotency of all onTrigger lua calls (i.e. chests can only be opened once)
    bool isDoor = luautils::OnTrigger(player, PEntity) == -1;
    PEntity->PAI->EventHandler.triggerListener("ON_TRIGGER", player, PEntity);
    if (CanChangeState())
    {
        auto ret = ChangeState<CTriggerState>(PEntity, player->entityId(), isDoor);
        if (PathFind && PEntity->GetLocalVar("stopPathingOnTrigger") == 1)
        {
            PEntity->SetLocalVar("pauseNPCPathing", 1);
        }
        return ret;
    }
    return false;
}

auto CAIContainer::UseItem(const EntityId& target, uint8 loc, uint8 slotid) const -> bool
{
    auto* PlayerController = dynamic_cast<CPlayerController*>(PEntity->PAI->GetController());
    if (PlayerController)
    {
        return PlayerController->UseItem(target, loc, slotid);
    }

    return false;
}

auto CAIContainer::Inactive(timer::duration _duration, bool canChangeState) -> bool
{
    return ForceChangeState<CInactiveState>(PEntity, _duration, canChangeState, false);
}

auto CAIContainer::Untargetable(timer::duration _duration, bool canChangeState) -> bool
{
    return ForceChangeState<CInactiveState>(PEntity, _duration, canChangeState, true);
}

auto CAIContainer::Internal_Engage(EntityId target) -> bool
{
    // TODO: pet engage/disengage
    auto* entity = dynamic_cast<CBattleEntity*>(PEntity);

    if (entity && entity->PAI->IsEngaged())
    {
        if (entity->battleTarget() != target)
        {
            ChangeTarget(target);
            return true;
        }
        return false;
    }
    // TODO: use valid target stuff from spell
    if (entity)
    {
        // TODO: remove m_battleTarget if possible (need to check disengage)
        //  Check if an entity can change to the attack state
        //  Allow entity with prevent action effect to very briefly switch to the attack state to be properly engaged
        if (CanChangeState() || (GetCurrentState() && GetCurrentState()->IsCompleted()) || entity->StatusEffectContainer->HasPreventActionEffect(true))
        {
            if (ForceChangeState<CAttackState>(entity, target))
            {
                entity->OnEngage(*static_cast<CAttackState*>(GetCurrentState()));

                // Resume being inactive if entity has a status effect preventing them from doing actions
                if (entity->StatusEffectContainer->HasPreventActionEffect(true))
                {
                    entity->PAI->Inactive(0ms, false);
                }
            }
        }
        return true;
    }
    return false;
}

auto CAIContainer::Internal_Cast(EntityId target, SpellID spellid) -> bool
{
    auto* entity = dynamic_cast<CBattleEntity*>(PEntity);
    if (entity)
    {
        if (const auto* PTarget = target.resolve<CBattleEntity>(); PTarget && PTarget->PAI->IsUntargetable())
        {
            return false;
        }

        return ChangeState<CMagicState>(entity, target, spellid);
    }
    return false;
}

auto CAIContainer::Internal_ChangeTarget(const EntityId& target) const -> bool
{
    auto* entity = dynamic_cast<CBattleEntity*>(PEntity);
    if (entity)
    {
        if (IsEngaged() || !target.isSet())
        {
            entity->setBattleTarget(target);
            return true;
        }
        else
        {
            return Engage(target);
        }
    }
    return false;
}

auto CAIContainer::Internal_Disengage() const -> bool
{
    auto* entity = dynamic_cast<CBattleEntity*>(PEntity);
    if (entity)
    {
        entity->setBattleTarget(std::nullopt);
        return true;
    }
    return false;
}

auto CAIContainer::Internal_WeaponSkill(const EntityId& target, uint16 wsid) -> bool
{
    auto* entity = dynamic_cast<CBattleEntity*>(PEntity);
    if (entity)
    {
        if (const auto* PTarget = target.resolve<CBattleEntity>(); PTarget && PTarget->PAI->IsUntargetable())
        {
            return false;
        }

        return ChangeState<CWeaponSkillState>(entity, target, wsid);
    }
    return false;
}

auto CAIContainer::Internal_MobSkill(const EntityId& target, uint16 wsid, Maybe<timer::duration> castTimeOverride) -> bool
{
    auto* entity = dynamic_cast<CBattleEntity*>(PEntity);
    if (entity)
    {
        if (const auto* PTarget = target.resolve<CBattleEntity>(); PTarget && PTarget->PAI->IsUntargetable())
        {
            return false;
        }

        return ChangeState<CMobSkillState>(entity, target, wsid, castTimeOverride);
    }
    return false;
}

auto CAIContainer::Internal_PetSkill(const EntityId& target, uint16 abilityid) -> bool
{
    auto* entity = dynamic_cast<CPetEntity*>(PEntity);
    if (entity)
    {
        if (const auto* PTarget = target.resolve<CBattleEntity>(); PTarget && PTarget->PAI->IsUntargetable())
        {
            return false;
        }

        return ChangeState<CPetSkillState>(entity, target, abilityid);
    }
    return false;
}

auto CAIContainer::Internal_Ability(const EntityId& target, uint16 abilityid) -> bool
{
    auto* entity = dynamic_cast<CBattleEntity*>(PEntity);
    if (entity)
    {
        if (const auto* PTarget = target.resolve<CBattleEntity>(); PTarget && PTarget->PAI->IsUntargetable())
        {
            return false;
        }

        return ChangeState<CAbilityState>(entity, target, abilityid);
    }
    return false;
}

auto CAIContainer::Internal_RangedAttack(const EntityId& target) -> bool
{
    auto* entity = dynamic_cast<CBattleEntity*>(PEntity);
    if (entity)
    {
        if (const auto* PTarget = target.resolve<CBattleEntity>(); PTarget && PTarget->PAI->IsUntargetable())
        {
            return false;
        }

        return ChangeState<CRangeState>(entity, target);
    }
    return false;
}

auto CAIContainer::Internal_Die(timer::duration deathTime, DeathParams params) -> bool
{
    auto* entity = dynamic_cast<CBattleEntity*>(PEntity);
    if (entity)
    {
        return ChangeState<CDeathState>(entity, deathTime, params);
    }
    return false;
}

auto CAIContainer::Internal_UseItem(const EntityId& target, uint8 loc, uint8 slotid) -> bool
{
    auto* entity = dynamic_cast<CCharEntity*>(PEntity);
    if (entity)
    {
        if (const auto* PTarget = target.resolve<CBattleEntity>(); PTarget && PTarget->PAI->IsUntargetable())
        {
            return false;
        }

        return ChangeState<CItemState>(entity, target, loc, slotid);
    }
    return false;
}

auto CAIContainer::GetCurrentState() const -> CState*
{
    return m_currentState.get();
}

auto CAIContainer::enterState(std::unique_ptr<CState> next) -> bool
{
    // init() decides whether the entity may enter the state. If it refuses, drop the new
    // state and keep the current one.
    if (auto result = next->init(); !result)
    {
        PEntity->HandleErrorMessage(result.error());
        return false;
    }

    // Suspend the state we're leaving beneath the new one, which becomes current.
    if (m_currentState)
    {
        m_stateStack.push(std::move(m_currentState));
    }
    m_currentState = std::move(next);

    return true;
}

void CAIContainer::resumeNextState()
{
    // The current state is finished; resume the one suspended beneath it, or go idle.
    retire(std::move(m_currentState));

    if (!m_stateStack.empty())
    {
        m_currentState = std::move(m_stateStack.top());
        m_stateStack.pop();
    }
}

void CAIContainer::finishCurrentState(const timer::time_point tick)
{
    auto finished = std::move(m_currentState);
    resumeNextState();

    if (finished)
    {
        finished->Cleanup(tick);
        retire(std::move(finished));
    }
}

void CAIContainer::retire(std::unique_ptr<CState> state)
{
    if (state)
    {
        m_retiredStates.push_back(std::move(state));
    }
}

auto CAIContainer::CanChangeState() const -> bool
{
    return !GetCurrentState() || GetCurrentState()->CanChangeState();
}

auto CAIContainer::CanFollowPath() const -> bool
{
    return PathFind && (!GetCurrentState() || GetCurrentState()->CanChangeState());
}

void CAIContainer::SetController(std::unique_ptr<CController> controller)
{
    Controller = std::move(controller);
}

auto CAIContainer::GetController() const -> CController*
{
    return Controller.get();
}

void CAIContainer::Reset()
{
    if (PathFind)
    {
        PathFind->Clear();
    }

    if (Controller)
    {
        Controller->Reset();
    }

    retire(std::move(m_currentState));
    while (!m_stateStack.empty())
    {
        retire(std::move(m_stateStack.top()));
        m_stateStack.pop();
    }

    // drop the queues too, or an action from the previous life fires on the next spawn.
    ClearActionQueue();
    ClearTimerQueue();

    // no Cleanup ran, so clear the engaged flags by hand. Internal_Engage skips anything that still looks engaged, leaving it with nothing to swing with.
    if (auto* battle = dynamic_cast<CBattleEntity*>(PEntity); battle && battle->animation == xi::Animation::Attack)
    {
        battle->animation = xi::Animation::None;
        battle->setBattleTarget(std::nullopt);
        battle->updatemask |= UPDATE_HP;
    }
}

auto CAIContainer::Tick(const timer::time_point tick) -> Task<void>
{
    TracyZoneScoped;

    m_PrevTick = m_Tick;
    m_Tick     = tick;

    // TODO: timestamp in the event?
    EventHandler.triggerListener("TICK", PEntity);

    co_await PEntity->Tick(tick);

    // TODO: check this in the controller instead maybe? (might not want to check every tick)
    ActionQueue.checkAction(tick);

    // check pathfinding only if there is no controller to do it
    if (!Controller && CanFollowPath() && PEntity->GetLocalVar("pauseNPCPathing") == 0)
    {
        PathFind->FollowPath(tick);
        if (PathFind->OnPoint())
        {
            EventHandler.triggerListener("PATH", PEntity);
            luautils::OnPath(PEntity);
        }
    }

    if (Controller && Controller->canUpdate)
    {
        co_await Controller->Tick(tick);
    }

    //
    // The current state is held in m_currentState (not on the stack) while it runs, and finished states sit in m_retiredStates until the end of the tick.
    // A re-entrant change can suspend or retire the state we are executing in, but never free it.
    //

    // The guard is a backstop against
    // a state that completes and re-enters itself every iteration (the stack is capped at
    // 10, so a healthy tick drains well within this bound).
    int guard = 0;

    while (m_currentState)
    {
        if (++guard > 32)
        {
            ShowWarning("AI state loop exceeded its iteration bound; breaking to avoid a hang.");
            break;
        }

        CState* running = m_currentState.get();

        if (!running->DoUpdate(tick)) // Not finished: leave it current and stop.
        {
            break;
        }

        // A state can enter a successor during its own update (e.g. petskill
        // re-engages), which becomes current. Only retire the state we actually ran.
        if (running == m_currentState.get())
        {
            finishCurrentState(tick);
        }
    }

    // Magic and mobskill states decide their own interrupt at their finish (mid-action
    // prevent-action effects don't cancel them on retail), so we never force them inactive
    // from here. Once such a state ends, this poll parks the entity inactive.
    if (auto* battle = dynamic_cast<CBattleEntity*>(PEntity);
        battle && battle->isAlive() && !IsCurrentState<CInactiveState>() &&
        !IsCurrentState<CMagicState>() && !IsCurrentState<CMobSkillState>() &&
        battle->StatusEffectContainer->HasPreventActionEffect())
    {
        Inactive(0ms, false);
    }

    PEntity->PostTick();

    // nothing is executing now, so the states retired this tick can go.
    m_retiredStates.clear();

    co_return;
}

auto CAIContainer::IsStateStackEmpty() const -> bool
{
    return !m_currentState;
}

void CAIContainer::ClearStateStack()
{
    while (m_currentState)
    {
        finishCurrentState(timer::now());
    }
}

void CAIContainer::InterruptStates()
{
    // a state running its own Update is left alone - tearing it out would free it under its own frame. whatever wanted the interrupt stacks above it instead.
    while (m_currentState && !m_currentState->isExecuting() && m_currentState->CanInterrupt())
    {
        finishCurrentState(timer::now());
    }
}

auto CAIContainer::IsSpawned() const -> bool
{
    return PEntity->status != xi::Status::Disappear;
}

auto CAIContainer::IsRoaming() const -> bool
{
    return PEntity->animation == xi::Animation::None;
}

auto CAIContainer::IsEngaged() const -> bool
{
    return PEntity->animation == xi::Animation::Attack;
}

auto CAIContainer::IsUntargetable() const -> bool
{
    return (PEntity->PAI->IsCurrentState<CInactiveState>() && static_cast<CInactiveState*>(PEntity->PAI->GetCurrentState())->GetUntargetable()) || PEntity->GetUntargetable();
}

auto CAIContainer::getTick() const -> timer::time_point
{
    return m_Tick;
}

auto CAIContainer::getPrevTick() const -> timer::time_point
{
    return m_PrevTick;
}

void CAIContainer::Despawn()
{
    if (Controller)
    {
        Controller->Despawn();
    }
    else
    {
        Internal_Despawn();
    }
}

void CAIContainer::QueueAction(queueAction_t&& action)
{
    ActionQueue.pushAction(std::move(action));
}

auto CAIContainer::QueueEmpty() const -> bool
{
    return ActionQueue.isEmpty();
}

void CAIContainer::ClearActionQueue()
{
    ActionQueue.clearActionQueue();
}

void CAIContainer::ClearTimerQueue()
{
    ActionQueue.clearTimerQueue();
}

void CAIContainer::checkQueueImmediately()
{
    ActionQueue.checkAction(timer::now());
}

auto CAIContainer::Internal_Despawn(bool instantDespawn) -> bool
{
    if (!IsCurrentState<CDespawnState>())
    {
        return ForceChangeState<CDespawnState>(PEntity, instantDespawn);
    }
    return false;
}

auto CAIContainer::Internal_Synth(xi::SkillType synthSkill) -> bool
{
    auto PChar = dynamic_cast<CCharEntity*>(PEntity);
    if (PChar && !IsCurrentState<CSynthState>())
    {
        return ForceChangeState<CSynthState>(PChar, synthSkill);
    }
    return false;
}

void CAIContainer::CheckCompletedStates()
{
    while (m_currentState && m_currentState->IsCompleted())
    {
        finishCurrentState(timer::now());
    }
}

auto CAIContainer::Accept_Raise() -> bool
{
    if (IsCurrentState<CDeathState>())
    {
        static_cast<CDeathState*>(PEntity->PAI->GetCurrentState())->acceptRaise();
    }
    return false;
}

auto CAIContainer::stateCount() const -> size_t
{
    return m_stateStack.size() + (m_currentState ? 1 : 0);
}
