/*
===========================================================================

Copyright (c) 2010-2018 Darkstar Dev Teams

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

This file is part of DarkStar-server source code.

===========================================================================
*/

#include <string.h>

#include "../../common/utils.h"
#include "../ai/ai_container.h"
#include "../ai/controllers/fellow_controller.h"
#include "../ai/helpers/pathfind.h"
#include "../ai/helpers/targetfind.h"
#include "../ai/states/ability_state.h"
#include "../enmity_container.h"
#include "../mob_modifier.h"
#include "../mob_spell_container.h"
#include "../mob_spell_list.h"
#include "../packets/char_health.h"
#include "../packets/entity_update.h"
#include "../utils/battleutils.h"
#include "fellowentity.h"

CFellowEntity::CFellowEntity(CCharEntity* PChar)
: CMobEntity()
{
    objtype                     = TYPE_FELLOW;
    m_EcoSystem                 = ECOSYSTEM::HUMANOID;
    allegiance                  = ALLEGIANCE_TYPE::PLAYER;
    PMaster                     = PChar;
    spawnAnimation              = SPAWN_ANIMATION::SPECIAL;
    m_IsClaimable               = false;
    m_bReleaseTargIDOnDisappear = true;
    isRenamed                   = true;
    zoneKills                   = 0;

    PAI = std::make_unique<CAIContainer>(this, std::make_unique<CPathFind>(this), std::make_unique<CFellowController>(PChar, this), std::make_unique<CTargetFind>(this));
}

CFellowEntity::~CFellowEntity()
{
}

void CFellowEntity::PostTick()
{
    CBattleEntity::PostTick();

    if (loc.zone && updatemask && status != STATUS_TYPE::DISAPPEAR)
    {
        loc.zone->UpdateEntityPacket(this, ENTITY_UPDATE, updatemask);

        if (PMaster && PMaster->PParty && updatemask & UPDATE_HP)
        {
            // clang-format off
            PMaster->ForParty([this](auto PMember)
            {
                static_cast<CCharEntity*>(PMember)->pushPacket(new CCharHealthPacket(this));
            });
            // clang-format on
        }
        updatemask = 0;
    }
}

void CFellowEntity::FadeOut()
{
    animation = ANIMATION_DESPAWN;
    CBaseEntity::FadeOut();
    loc.zone->UpdateEntityPacket(this, ENTITY_DESPAWN, UPDATE_NONE);
}

void CFellowEntity::Die()
{
    PAI->ClearStateStack();
    PAI->Internal_Die(0s);
    luautils::OnMobDeath(this, nullptr);
    CBattleEntity::Die();
    if (PMaster != nullptr && PMaster->objtype == TYPE_PC)
    {
        CCharEntity* PChar = (CCharEntity*)PMaster;
        PChar->RemoveFellow();
    }
}

void CFellowEntity::Spawn()
{
    CBattleEntity::Spawn();
    luautils::OnMobSpawn(this);
}

bool CFellowEntity::ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags)
{
    if (targetFlags & TARGET_PLAYER && PInitiator->allegiance == allegiance)
    {
        return false;
    }
    return CBattleEntity::ValidTarget(PInitiator, targetFlags);
}

void CFellowEntity::OnAbility(CAbilityState& state, action_t& action)
{
    auto PAbility = state.GetAbility();
    auto PTarget  = static_cast<CBattleEntity*>(state.GetTarget());

    std::unique_ptr<CBasicPacket> errMsg;
    if (IsValidTarget(PTarget->targid, PAbility->getValidTarget(), errMsg))
    {
        if (this != PTarget && distance(this->loc.p, PTarget->loc.p) > PAbility->getRange())
        {
            return;
        }
        if (battleutils::IsParalyzed(this))
        {
            // display paralyzed
            loc.zone->PushPacket(this, CHAR_INRANGE_SELF, new CMessageBasicPacket(this, PTarget, 0, 0, MSGBASIC_IS_PARALYZED));
            return;
        }

        action.id                    = this->id;
        action.actiontype            = PAbility->getActionType();
        action.actionid              = PAbility->getID();
        actionList_t& actionList     = action.getNewActionList();
        actionList.ActionTargetID    = PTarget->id;
        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.reaction        = REACTION::NONE;
        actionTarget.speceffect      = SPECEFFECT::RECOIL;
        actionTarget.animation       = PAbility->getAnimationID();
        actionTarget.param           = 0;
        auto prevMsg                 = actionTarget.messageID;

        int32 value = luautils::OnUseAbility(this, PTarget, PAbility, &action);
        if (prevMsg == actionTarget.messageID)
            actionTarget.messageID = PAbility->getMessage();
        if (actionTarget.messageID == 0)
            actionTarget.messageID = MSGBASIC_USES_JA;
        actionTarget.param = value;

        if (value < 0)
        {
            actionTarget.messageID = ability::GetAbsorbMessage(actionTarget.messageID);
            actionTarget.param     = -value;
        }

        if (PAbility->getID() == ABILITY_PROVOKE && PTarget->objtype == TYPE_MOB)
        {
            PTarget->updatemask |= UPDATE_STATUS;
            ((CMobEntity*)PTarget)->PEnmityContainer->UpdateEnmity(this, PAbility->getCE(), PAbility->getVE(), true, false);
        }
    }
}
