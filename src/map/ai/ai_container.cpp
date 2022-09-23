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

#include "ai_container.h"

#include "../entities/baseentity.h"
#include "../entities/battleentity.h"
#include "../entities/charentity.h"
#include "../entities/mobentity.h"
#include "../packets/entity_animation.h"
#include "controllers/mob_controller.h"
#include "controllers/player_controller.h"
#include "states/ability_state.h"
#include "states/attack_state.h"
#include "states/death_state.h"
#include "states/despawn_state.h"
#include "states/inactive_state.h"
#include "states/item_state.h"
#include "states/magic_state.h"
#include "states/mobskill_state.h"
#include "states/raise_state.h"
#include "states/range_state.h"
#include "states/respawn_state.h"
#include "states/trigger_state.h"
#include "states/weaponskill_state.h"

CAIContainer::CAIContainer(CBaseEntity* _PEntity)
: CAIContainer(_PEntity, nullptr, nullptr, nullptr)
{
}

CAIContainer::CAIContainer(CBaseEntity* _PEntity, std::unique_ptr<CPathFind>&& _pathfind, std::unique_ptr<CController>&& _controller,
                           std::unique_ptr<CTargetFind>&& _targetfind)
: TargetFind(std::move(_targetfind))
, PathFind(std::move(_pathfind))
, Controller(std::move(_controller))
, m_Tick(server_clock::now())
, m_PrevTick(server_clock::now())
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

bool CAIContainer::MobSkill(uint16 targid, uint16 wsid)
{
    auto* AIController = dynamic_cast<CMobController*>(Controller.get());
    if (AIController)
    {
        return AIController->MobSkill(targid, wsid);
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
    auto* PlayerController = dynamic_cast<CPlayerController*>(Controller.get());
    if (PlayerController)
    {
        return PlayerController->RangedAttack(targid);
    }
    return false;
}

bool CAIContainer::Trigger(CCharEntity* player)
{
    // TODO: ensure idempotency of all onTrigger lua calls (i.e. chests can only be opened once)
    bool isDoor = luautils::OnTrigger(player, PEntity) == -1;
    if (CanChangeState())
    {
        auto ret = ChangeState<CTriggerState>(PEntity, player->targid, isDoor);
        if (PathFind)
        {
            PathFind->Clear(); //#TODO: pause/resume after?
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

bool CAIContainer::Inactive(duration _duration, bool canChangeState)
{
    return ForceChangeState<CInactiveState>(PEntity, _duration, canChangeState);
}

bool CAIContainer::Internal_Engage(uint16 targetid)
{
    //#TODO: pet engage/disengage
    auto* entity{ dynamic_cast<CBattleEntity*>(PEntity) };

    if (entity && entity->PAI->IsEngaged())
    {
        if (entity->GetBattleTargetID() != targetid)
        {
            ChangeTarget(targetid);
            return true;
        }
        return false;
    }
    //#TODO: use valid target stuff from spell
    if (entity)
    {
        //#TODO: remove m_battleTarget if possible (need to check disengage)
        if (CanChangeState() || (GetCurrentState() && GetCurrentState()->IsCompleted()))
        {
            if (ForceChangeState<CAttackState>(entity, targetid))
            {
                entity->OnEngage(*static_cast<CAttackState*>(m_stateStack.top().get()));
            }
        }
        return true;
    }
    return false;
}

bool CAIContainer::Internal_Cast(uint16 targetid, SpellID spellid)
{
    auto* entity{ dynamic_cast<CBattleEntity*>(PEntity) };
    if (entity)
    {
        return ChangeState<CMagicState>(entity, targetid, spellid);
    }
    return false;
}

bool CAIContainer::Internal_ChangeTarget(uint16 targetid)
{
    auto* entity{ dynamic_cast<CBattleEntity*>(PEntity) };
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
    auto* entity{ dynamic_cast<CBattleEntity*>(PEntity) };
    if (entity)
    {
        entity->SetBattleTargetID(0);
        return true;
    }
    return false;
}

bool CAIContainer::Internal_WeaponSkill(uint16 targid, uint16 wsid)
{
    auto* entity{ dynamic_cast<CBattleEntity*>(PEntity) };
    if (entity)
    {
        return ChangeState<CWeaponSkillState>(entity, targid, wsid);
    }
    return false;
}

bool CAIContainer::Internal_MobSkill(uint16 targid, uint16 wsid)
{
    auto* entity{ dynamic_cast<CMobEntity*>(PEntity) };
    if (entity)
    {
        return ChangeState<CMobSkillState>(entity, targid, wsid);
    }
    return false;
}

bool CAIContainer::Internal_Ability(uint16 targetid, uint16 abilityid)
{
    auto* entity{ dynamic_cast<CBattleEntity*>(PEntity) };
    if (entity)
    {
        return ChangeState<CAbilityState>(entity, targetid, abilityid);
    }
    return false;
}

bool CAIContainer::Internal_RangedAttack(uint16 targetid)
{
    auto* entity{ dynamic_cast<CBattleEntity*>(PEntity) };
    if (entity)
    {
        return ChangeState<CRangeState>(entity, targetid);
    }
    return false;
}

bool CAIContainer::Internal_Die(duration deathTime)
{
    auto* entity{ dynamic_cast<CBattleEntity*>(PEntity) };
    if (entity)
    {
        return ChangeState<CDeathState>(entity, deathTime);
    }
    return false;
}

bool CAIContainer::Internal_Raise()
{
    auto* entity{ dynamic_cast<CBattleEntity*>(PEntity) };
    if (entity)
    {
        return ForceChangeState<CRaiseState>(entity);
    }
    return false;
}

bool CAIContainer::Internal_UseItem(uint16 targetid, uint8 loc, uint8 slotid)
{
    auto* entity{ dynamic_cast<CCharEntity*>(PEntity) };
    if (entity)
    {
        return ChangeState<CItemState>(entity, targetid, loc, slotid);
    }
    return false;
}

CState* CAIContainer::GetCurrentState()
{
    if (!m_stateStack.empty())
    {
        return m_stateStack.top().get();
    }
    return nullptr;
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

    while (!m_stateStack.empty())
    {
        m_stateStack.pop();
    }
}

void CAIContainer::Tick(time_point _tick)
{
    TracyZoneScoped;
    m_PrevTick = m_Tick;
    m_Tick     = _tick;

    //#TODO: timestamp in the event?
    EventHandler.triggerListener("TICK", CLuaBaseEntity(PEntity));
    PEntity->Tick(_tick);

    //#TODO: check this in the controller instead maybe? (might not want to check every tick)
    ActionQueue.checkAction(_tick);

    // check pathfinding only if there is no controller to do it
    bool isPathingPaused = PEntity->GetLocalVar("pauseNPCPathing");
    if (!Controller && CanFollowPath() && !isPathingPaused)
    {
        PathFind->FollowPath();
        if (PathFind->OnPoint())
        {
            luautils::OnPath(PEntity);
        }
    }

    if (Controller && Controller->canUpdate)
    {
        Controller->Tick(_tick);
    }
    CState* top = nullptr;
    while (!m_stateStack.empty() && (top = m_stateStack.top().get())->DoUpdate(_tick))
    {
        if (top == GetCurrentState())
        {
            auto state = std::move(m_stateStack.top());
            m_stateStack.pop();
            state->Cleanup(_tick);
        }
    }

    PEntity->PostTick();
}

bool CAIContainer::IsStateStackEmpty()
{
    return m_stateStack.empty();
}

void CAIContainer::ClearStateStack()
{
    while (!m_stateStack.empty())
    {
        m_stateStack.top()->Cleanup(server_clock::now());
        m_stateStack.pop();
    }
}

void CAIContainer::InterruptStates()
{
    while (!m_stateStack.empty() && m_stateStack.top()->CanInterrupt())
    {
        m_stateStack.top()->Cleanup(server_clock::now());
        m_stateStack.pop();
    }
}

bool CAIContainer::IsSpawned()
{
    return PEntity->status != STATUS_TYPE::DISAPPEAR;
}

bool CAIContainer::IsRoaming()
{
    return PEntity->animation == ANIMATION_NONE;
}

bool CAIContainer::IsEngaged()
{
    return PEntity->animation == ANIMATION_ATTACK;
}

time_point CAIContainer::getTick()
{
    return m_Tick;
}

time_point CAIContainer::getPrevTick()
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

bool CAIContainer::Internal_Despawn()
{
    if (!IsCurrentState<CDespawnState>() && !IsCurrentState<CRespawnState>())
    {
        return ForceChangeState<CDespawnState>(PEntity);
    }
    return false;
}

bool CAIContainer::Internal_Respawn(duration _duration)
{
    if (!IsCurrentState<CRespawnState>())
    {
        return ForceChangeState<CRespawnState>(PEntity, _duration);
    }
    return false;
}

void CAIContainer::CheckCompletedStates()
{
    while (!m_stateStack.empty() && m_stateStack.top()->IsCompleted())
    {
        m_stateStack.top()->Cleanup(server_clock::now());
        m_stateStack.pop();
    }
}
