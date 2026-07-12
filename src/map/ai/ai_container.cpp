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

bool CAIContainer::Cast(uint16 targid, SpellID spellid)
{
    if (Controller)
    {
        return Controller->Cast(targid, spellid);
    }
    return false;
}

bool CAIContainer::Engage(uint16 targid)
{
    if (Controller)
    {
        return Controller->Engage(targid);
    }
    return false;
}

bool CAIContainer::ChangeTarget(uint16 targid)
{
    if (Controller)
    {
        return Controller->ChangeTarget(targid);
    }
    return false;
}

bool CAIContainer::Disengage()
{
    if (Controller)
    {
        return Controller->Disengage();
    }
    return false;
}

bool CAIContainer::WeaponSkill(uint16 targid, uint16 wsid)
{
    if (Controller)
    {
        return Controller->WeaponSkill(targid, wsid);
    }
    return false;
}

bool CAIContainer::MobSkill(uint16 targid, uint16 wsid, Maybe<timer::duration> castTimeOverride)
{
    auto* AIController = dynamic_cast<CMobController*>(Controller.get());
    if (AIController)
    {
        return AIController->MobSkill(targid, wsid, castTimeOverride);
    }
    return false;
}

bool CAIContainer::PetSkill(uint16 targid, uint16 wsid)
{
    auto* AIController = dynamic_cast<CPetController*>(Controller.get());
    if (AIController)
    {
        return AIController->PetSkill(targid, wsid);
    }
    return false;
}

bool CAIContainer::Ability(uint16 targid, uint16 abilityid)
{
    if (Controller)
    {
        return Controller->Ability(targid, abilityid);
    }
    return false;
}

bool CAIContainer::RangedAttack(uint16 targid)
{
    if (Controller)
    {
        return Controller->RangedAttack(targid);
    }
    return false;
}

bool CAIContainer::Trigger(CCharEntity* player)
{
    // TODO: ensure idempotency of all onTrigger lua calls (i.e. chests can only be opened once)
    bool isDoor = luautils::OnTrigger(player, PEntity) == -1;
    PEntity->PAI->EventHandler.triggerListener("ON_TRIGGER", player, PEntity);
    if (CanChangeState())
    {
        auto ret = ChangeState<CTriggerState>(PEntity, player->targid, isDoor);
        if (PathFind && PEntity->GetLocalVar("stopPathingOnTrigger") == 1)
        {
            PEntity->SetLocalVar("pauseNPCPathing", 1);
        }
        return ret;
    }
    return false;
}

bool CAIContainer::UseItem(uint16 targid, uint8 loc, uint8 slotid)
{
    auto* PlayerController = dynamic_cast<CPlayerController*>(PEntity->PAI->GetController());
    if (PlayerController)
    {
        return PlayerController->UseItem(targid, loc, slotid);
    }
    return false;
}

bool CAIContainer::Inactive(timer::duration _duration, bool canChangeState)
{
    return ForceChangeState<CInactiveState>(PEntity, _duration, canChangeState, false);
}

bool CAIContainer::Untargetable(timer::duration _duration, bool canChangeState)
{
    return ForceChangeState<CInactiveState>(PEntity, _duration, canChangeState, true);
}

bool CAIContainer::Internal_Engage(uint16 targetid)
{
    // TODO: pet engage/disengage
    auto* entity = dynamic_cast<CBattleEntity*>(PEntity);

    if (entity && entity->PAI->IsEngaged())
    {
        if (entity->GetBattleTargetID() != targetid)
        {
            ChangeTarget(targetid);
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
            if (ForceChangeState<CAttackState>(entity, targetid))
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

bool CAIContainer::Internal_Cast(uint16 targetid, SpellID spellid)
{
    auto* entity = dynamic_cast<CBattleEntity*>(PEntity);
    if (entity)
    {
        if (auto* target = entity->GetEntity(targetid); target && target->PAI->IsUntargetable())
        {
            return false;
        }
        return ChangeState<CMagicState>(entity, targetid, spellid);
    }
    return false;
}

bool CAIContainer::Internal_ChangeTarget(uint16 targetid)
{
    auto* entity = dynamic_cast<CBattleEntity*>(PEntity);
    if (entity)
    {
        if (IsEngaged() || targetid == 0)
        {
            entity->SetBattleTargetID(targetid);
            return true;
        }
        else
        {
            return Engage(targetid);
        }
    }
    return false;
}

bool CAIContainer::Internal_Disengage()
{
    auto* entity = dynamic_cast<CBattleEntity*>(PEntity);
    if (entity)
    {
        entity->SetBattleTargetID(0);
        return true;
    }
    return false;
}

bool CAIContainer::Internal_WeaponSkill(uint16 targid, uint16 wsid)
{
    auto* entity = dynamic_cast<CBattleEntity*>(PEntity);
    if (entity)
    {
        if (auto* target = entity->GetEntity(targid); target && target->PAI->IsUntargetable())
        {
            return false;
        }
        return ChangeState<CWeaponSkillState>(entity, targid, wsid);
    }
    return false;
}

bool CAIContainer::Internal_MobSkill(uint16 targid, uint16 wsid, Maybe<timer::duration> castTimeOverride)
{
    auto* entity = dynamic_cast<CBattleEntity*>(PEntity);
    if (entity)
    {
        if (auto* target = entity->GetEntity(targid); target && target->PAI->IsUntargetable())
        {
            return false;
        }
        return ChangeState<CMobSkillState>(entity, targid, wsid, castTimeOverride);
    }
    return false;
}

bool CAIContainer::Internal_PetSkill(uint16 targid, uint16 abilityid)
{
    auto* entity = dynamic_cast<CPetEntity*>(PEntity);
    if (entity)
    {
        if (auto* target = entity->GetEntity(targid); target && target->PAI->IsUntargetable())
        {
            return false;
        }
        return ChangeState<CPetSkillState>(entity, targid, abilityid);
    }
    return false;
}

bool CAIContainer::Internal_Ability(uint16 targetid, uint16 abilityid)
{
    auto* entity = dynamic_cast<CBattleEntity*>(PEntity);
    if (entity)
    {
        if (auto* target = entity->GetEntity(targetid); target && target->PAI->IsUntargetable())
        {
            return false;
        }
        return ChangeState<CAbilityState>(entity, targetid, abilityid);
    }
    return false;
}

bool CAIContainer::Internal_RangedAttack(uint16 targetid)
{
    auto* entity = dynamic_cast<CBattleEntity*>(PEntity);
    if (entity)
    {
        if (auto* target = entity->GetEntity(targetid); target && target->PAI->IsUntargetable())
        {
            return false;
        }
        return ChangeState<CRangeState>(entity, targetid);
    }
    return false;
}

bool CAIContainer::Internal_Die(timer::duration deathTime)
{
    auto* entity = dynamic_cast<CBattleEntity*>(PEntity);
    if (entity)
    {
        return ChangeState<CDeathState>(entity, deathTime);
    }
    return false;
}

bool CAIContainer::Internal_UseItem(uint16 targetid, uint8 loc, uint8 slotid)
{
    auto* entity = dynamic_cast<CCharEntity*>(PEntity);
    if (entity)
    {
        return ChangeState<CItemState>(entity, targetid, loc, slotid);
    }
    return false;
}

CState* CAIContainer::GetCurrentState()
{
    return m_currentState.get();
}

void CAIContainer::enterState(std::unique_ptr<CState> next)
{
    // Suspend the state we're leaving beneath the new one, which becomes current.
    if (m_currentState)
    {
        m_stateStack.push(std::move(m_currentState));
    }
    m_currentState = std::move(next);
}

void CAIContainer::resumeNextState()
{
    // The current state is finished; resume the one suspended beneath it, or go idle.
    if (m_stateStack.empty())
    {
        m_currentState.reset();
    }
    else
    {
        m_currentState = std::move(m_stateStack.top());
        m_stateStack.pop();
    }
}

bool CAIContainer::CanChangeState()
{
    return !GetCurrentState() || GetCurrentState()->CanChangeState();
}

bool CAIContainer::CanFollowPath()
{
    return PathFind && (!GetCurrentState() || GetCurrentState()->CanChangeState());
}

void CAIContainer::SetController(std::unique_ptr<CController> controller)
{
    Controller = std::move(controller);
}

CController* CAIContainer::GetController()
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

    m_currentState.reset();
    while (!m_stateStack.empty())
    {
        m_stateStack.pop();
    }
}

auto CAIContainer::Tick(timer::time_point tick) -> Task<void>
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
    bool isPathingPaused = PEntity->GetLocalVar("pauseNPCPathing");
    if (!Controller && CanFollowPath() && !isPathingPaused)
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
    // The current state is held in m_currentState (not on the stack) while it runs, so a
    // re-entrant change can't free the object we're executing in. Entering a state only
    // suspends the current one beneath it, never frees it.
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

        if (running->DoUpdate(tick))
        {
            // A state can enter a successor during its own update (e.g. petskill
            // re-engages), which becomes current. Only retire the state we actually ran.
            if (running == m_currentState.get())
            {
                running->Cleanup(tick);
                resumeNextState();
            }
        }
        else // Not finished: leave it current and stop.
        {
            break;
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

    co_return;
}

bool CAIContainer::IsStateStackEmpty()
{
    return !m_currentState;
}

void CAIContainer::ClearStateStack()
{
    while (m_currentState)
    {
        m_currentState->Cleanup(timer::now());
        resumeNextState();
    }
}

void CAIContainer::InterruptStates()
{
    while (m_currentState && m_currentState->CanInterrupt())
    {
        m_currentState->Cleanup(timer::now());
        resumeNextState();
    }
}

bool CAIContainer::IsSpawned()
{
    return PEntity->status != xi::Status::Disappear;
}

bool CAIContainer::IsRoaming()
{
    return PEntity->animation == ANIMATION_NONE;
}

bool CAIContainer::IsEngaged()
{
    return PEntity->animation == ANIMATION_ATTACK;
}

bool CAIContainer::IsUntargetable()
{
    return (PEntity->PAI->IsCurrentState<CInactiveState>() && static_cast<CInactiveState*>(PEntity->PAI->GetCurrentState())->GetUntargetable()) || PEntity->GetUntargetable();
}

timer::time_point CAIContainer::getTick()
{
    return m_Tick;
}

timer::time_point CAIContainer::getPrevTick()
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

bool CAIContainer::QueueEmpty()
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

bool CAIContainer::Internal_Despawn(bool instantDespawn)
{
    if (!IsCurrentState<CDespawnState>())
    {
        return ForceChangeState<CDespawnState>(PEntity, instantDespawn);
    }
    return false;
}

bool CAIContainer::Internal_Synth(xi::SkillType synthSkill)
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
        m_currentState->Cleanup(timer::now());
        resumeNextState();
    }
}

bool CAIContainer::Accept_Raise()
{
    if (IsCurrentState<CDeathState>())
    {
        static_cast<CDeathState*>(PEntity->PAI->GetCurrentState())->acceptRaise();
    }
    return false;
}

size_t CAIContainer::stateCount() const
{
    return m_stateStack.size() + (m_currentState ? 1 : 0);
}
