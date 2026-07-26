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

#pragma once

#include <memory>
#include <stack>

#include "ai/controllers/controller.h"
#include "entities/base_entity.h"
#include "helpers/action_queue.h"
#include "helpers/event_handler.h"
#include "helpers/pathfind.h"
#include "helpers/targetfind.h"
#include "states/state.h"

class CBaseEntity;
class CCharEntity;
class CState;
class CPathFind;
class CTargetFind;

class CAIContainer
{
public:
    CAIContainer(CBaseEntity*);
    CAIContainer(CBaseEntity*, std::unique_ptr<CPathFind>&&, std::unique_ptr<CController>&&, std::unique_ptr<CTargetFind>&&);

    // no copy construct/assign (only move)
    CAIContainer(const CAIContainer&)            = delete;
    CAIContainer& operator=(const CAIContainer&) = delete;

    auto Cast(const EntityId& target, SpellID spellid) const -> bool;
    auto Engage(const EntityId& target) const -> bool;
    auto ChangeTarget(uint16 targid) const -> bool;
    auto Disengage() const -> bool;
    auto WeaponSkill(const EntityId& target, uint16 wsid) const -> bool;
    auto MobSkill(const EntityId& target, uint16 wsid, Maybe<timer::duration> castTimeOverride) const -> bool;
    auto PetSkill(const EntityId& target, uint16 wsid) const -> bool;
    auto Ability(const EntityId& target, uint16 abilityid) const -> bool;
    auto RangedAttack(const EntityId& target) const -> bool;
    auto Trigger(CCharEntity* player) -> bool;
    auto UseItem(const EntityId& target, uint8 loc, uint8 slotid) const -> bool;
    auto Inactive(timer::duration _duration, bool canChangeState) -> bool;
    auto Untargetable(timer::duration _duration, bool canChangeState) -> bool; // Used to make owner entity untargetable & inactionable in TargetFind for _duration

    //
    // Internal Controller functions
    //

    auto Internal_Engage(EntityId target) -> bool;
    auto Internal_Cast(EntityId target, SpellID spellid) -> bool;
    auto Internal_ChangeTarget(uint16 targetid) const -> bool;
    auto Internal_Disengage() const -> bool;
    auto Internal_WeaponSkill(const EntityId& target, uint16 wsid) -> bool;
    auto Internal_MobSkill(const EntityId& target, uint16 wsid, Maybe<timer::duration> castTimeOverride) -> bool;
    auto Internal_PetSkill(const EntityId& target, uint16 abilityid) -> bool;
    auto Internal_Ability(const EntityId& target, uint16 abilityid) -> bool;
    auto Internal_RangedAttack(const EntityId& target) -> bool;
    auto Internal_Die(timer::duration) -> bool;
    auto Internal_UseItem(const EntityId& target, uint8 loc, uint8 slotid) -> bool;
    auto Internal_Despawn(bool instantDespawn = false) -> bool;
    auto Internal_Synth(xi::SkillType synthSkill) -> bool;
    auto Accept_Raise() -> bool;

    void Reset();
    auto Tick(timer::time_point tick) -> Task<void>;
    auto GetCurrentState() const -> CState*;
    auto IsStateStackEmpty() const -> bool;
    void ClearStateStack();
    void InterruptStates();

    // Pop the top state if it's the expected state
    template <typename State>
    auto PopState() -> bool;

    // Or have each state return a static number/string that Lua can use as well, in case this is not sufficient
    template <typename State, typename = std::enable_if_t<std::is_base_of<CState, State>::value>>
    auto IsCurrentState() -> bool;

    auto IsSpawned() const -> bool;
    auto IsRoaming() const -> bool;
    auto IsEngaged() const -> bool;
    auto IsUntargetable() const -> bool;

    // whether AI is currently able to change state from external means
    auto CanChangeState() const -> bool;
    auto CanFollowPath() const -> bool;

    void SetController(std::unique_ptr<CController> controller);
    auto GetController() const -> CController*;

    auto getTick() const -> timer::time_point;
    auto getPrevTick() const -> timer::time_point;

    void Despawn();

    void QueueAction(queueAction_t&&);
    auto QueueEmpty() const -> bool;
    void ClearActionQueue();
    void ClearTimerQueue();
    void checkQueueImmediately();

    // stores all events and their associated lua callbacks
    CAIEventHandler              EventHandler;
    std::unique_ptr<CTargetFind> TargetFind;

    // pathfinder, not guaranteed to be implemented
    std::unique_ptr<CPathFind> PathFind;

protected:
    // input controller
    std::unique_ptr<CController> Controller;

    // current synchronized server time (before AI loop execution)
    timer::time_point m_Tick;
    timer::time_point m_PrevTick;

    // entity who holds this AI
    CBaseEntity* PEntity;

    void CheckCompletedStates();

    template <typename T, typename... Args>
    auto ChangeState(Args&&... args) -> bool;

    template <typename T, typename... Args>
    auto ForceChangeState(Args&&... args) -> bool;

private:
    // Suspend the current state (if any) beneath `next`, then make `next` current.
    void enterState(std::unique_ptr<CState> next);

    // Finish with the current state and resume the one suspended beneath it (or go idle).
    void resumeNextState();

    auto stateCount() const -> size_t;

    // The state the entity is currently in (null == idle). It lives here rather than on
    // the stack so it can never be freed from underneath its own DoUpdate; m_stateStack
    // holds the states suspended beneath it.
    std::unique_ptr<CState>             m_currentState;
    std::stack<std::unique_ptr<CState>> m_stateStack;

    CAIActionQueue ActionQueue;
};

//
// Template impls
//

template <typename State>
auto CAIContainer::PopState() -> bool
{
    if (IsCurrentState<State>())
    {
        resumeNextState();
        return true;
    }

    return false;
}

template <typename State, typename>
auto CAIContainer::IsCurrentState() -> bool
{
    return dynamic_cast<State*>(GetCurrentState());
}

template <typename T, typename... Args>
auto CAIContainer::ChangeState(Args&&... args) -> bool
{
    if (stateCount() > 10)
    {
        ShowWarning("State Stack size exceeds maximum.");
        return false;
    }

    if (CanChangeState())
    {
        try
        {
            CheckCompletedStates();

            // Construct first: if it throws, the current state is left untouched.
            enterState(std::make_unique<T>(std::forward<Args>(args)...));
            return true;
        }
        catch (CStateInitException& e)
        {
            PEntity->HandleErrorMessage(e.packet);
        }
    }

    return false;
}

template <typename T, typename... Args>
auto CAIContainer::ForceChangeState(Args&&... args) -> bool
{
    if (stateCount() > 10)
    {
        ShowWarning("State Stack size exceeds maximum.");
        return false;
    }

    try
    {
        CheckCompletedStates();

        // Construct first: if it throws, the current state is left untouched.
        enterState(std::make_unique<T>(std::forward<Args>(args)...));
        return true;
    }
    catch (CStateInitException& e)
    {
        PEntity->HandleErrorMessage(e.packet);
    }

    return false;
}
