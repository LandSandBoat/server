/*
===========================================================================

Copyright (c) 2018 Darkstar Dev Teams

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

#include "trustentity.h"
#include "../mob_spell_container.h"
#include "../mob_spell_list.h"
#include "../packets/char_health.h"
#include "../packets/entity_update.h"
#include "../packets/trust_sync.h"
#include "../ai/ai_container.h"
#include "../ai/controllers/trust_controller.h"
#include "../ai/helpers/pathfind.h"
#include "../ai/helpers/targetfind.h"
#include "../ai/states/ability_state.h"
#include "../utils/battleutils.h"
#include "../utils/trustutils.h"
#include "../ai/states/attack_state.h"
#include "../ai/states/weaponskill_state.h"
#include "../ai/states/mobskill_state.h"
#include "../ai/states/magic_state.h"
#include "../recast_container.h"
#include "../mob_spell_container.h"

CTrustEntity::CTrustEntity(CCharEntity* PChar)
{
    objtype = TYPE_TRUST;
    m_EcoSystem = SYSTEM_UNCLASSIFIED;
    allegiance = ALLEGIANCE_PLAYER;
    m_MobSkillList = 0;
    PMaster = PChar;
    PAI = std::make_unique<CAIContainer>(this, std::make_unique<CPathFind>(this), std::make_unique<CTrustController>(PChar, this), std::make_unique<CTargetFind>(this));
}

void CTrustEntity::PostTick()
{
    CBattleEntity::PostTick();
    if (loc.zone && updatemask && status != STATUS_DISAPPEAR)
    {
        loc.zone->PushPacket(this, CHAR_INRANGE, new CEntityUpdatePacket(this, ENTITY_UPDATE, updatemask));

        if (PMaster && PMaster->PParty && updatemask & UPDATE_HP)
        {
            PMaster->ForParty([this](auto PMember)
            {
                static_cast<CCharEntity*>(PMember)->pushPacket(new CCharHealthPacket(this));
            });
        }
        updatemask = 0;
    }
}

void CTrustEntity::FadeOut()
{
    CBaseEntity::FadeOut();
    loc.zone->PushPacket(this, (loc.zone->m_BattlefieldHandler) ? CHAR_INZONE : CHAR_INRANGE, new CEntityUpdatePacket(this, ENTITY_DESPAWN, UPDATE_NONE));
}

void CTrustEntity::Die()
{
    luautils::OnMobDeath(this, nullptr);
    PAI->ClearStateStack();
    PAI->Internal_Die(0s);
    ((CCharEntity*)PMaster)->RemoveTrust(this);
    CBattleEntity::Die();
}

void CTrustEntity::Spawn()
{
    //we need to skip CMobEntity's spawn because it calculates stats (and our stats are already calculated)
    CBattleEntity::Spawn();
    luautils::OnMobSpawn(this);
    ((CCharEntity*)PMaster)->pushPacket(new CTrustSyncPacket((CCharEntity*)PMaster, this));
}

void CTrustEntity::OnAbility(CAbilityState& state, action_t& action)
{
    auto PAbility = state.GetAbility();
    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());

    std::unique_ptr<CBasicPacket> errMsg;
    if (IsValidTarget(PTarget->targid, PAbility->getValidTarget(), errMsg))
    {
        if (this != PTarget && distance(this->loc.p, PTarget->loc.p) > PAbility->getRange())
        {
            return;
        }

        if (battleutils::IsParalyzed(this))
        {
            loc.zone->PushPacket(this, CHAR_INRANGE_SELF, new CMessageBasicPacket(this, PTarget, 0, 0, MSGBASIC_IS_PARALYZED));
            return;
        }

        action.id = this->id;
        action.actiontype = PAbility->getActionType();
        action.actionid = PAbility->getID();
        action.recast = PAbility->getRecastTime();
        actionList_t& actionList = action.getNewActionList();
        actionList.ActionTargetID = PTarget->id;
        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.reaction = REACTION_NONE;
        actionTarget.speceffect = SPECEFFECT_RECOIL;
        actionTarget.animation = PAbility->getAnimationID();
        actionTarget.param = 0;
        auto prevMsg = actionTarget.messageID;

        int32 value = luautils::OnUseAbility(this, PTarget, PAbility, &action);
        if (prevMsg == actionTarget.messageID) actionTarget.messageID = PAbility->getMessage();
        if (actionTarget.messageID == 0) actionTarget.messageID = MSGBASIC_USES_JA;
        actionTarget.param = value;

        if (value < 0)
        {
            actionTarget.messageID = ability::GetAbsorbMessage(actionTarget.messageID);
            actionTarget.param = -value;
        }

        state.ApplyEnmity();

        PRecastContainer->Add(RECAST_ABILITY, action.actionid, action.recast);
    }
}

bool CTrustEntity::ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags)
{
    if (PInitiator->objtype == TYPE_TRUST && PMaster == PInitiator->PMaster)
    {
        return true;
    }

    if (targetFlags & TARGET_PLAYER_PARTY && PInitiator->objtype == TYPE_PET && PInitiator->allegiance == allegiance)
    {
        return true;
    }

    if (targetFlags & TARGET_PLAYER_PARTY && PInitiator->allegiance == allegiance && PMaster)
    {
        return PInitiator->PParty == PMaster->PParty;
    }

    return CMobEntity::ValidTarget(PInitiator, targetFlags);
}

void CTrustEntity::OnDespawn(CDespawnState&)
{
    if (GetHPP())
    {
        // Don't call this when despawning after being killed
        luautils::OnMobDespawn(this);
    }
    FadeOut();
    PAI->EventHandler.triggerListener("DESPAWN", this);
}


void CTrustEntity::OnCastFinished(CMagicState& state, action_t& action)
{
    CBattleEntity::OnCastFinished(state, action);

    auto PSpell = state.GetSpell();

    PRecastContainer->Add(RECAST_MAGIC, static_cast<uint16>(PSpell->getID()), action.recast);
}

void CTrustEntity::OnMobSkillFinished(CMobSkillState& state, action_t& action)
{
    CMobEntity::OnMobSkillFinished(state, action);
}

void CTrustEntity::OnWeaponSkillFinished(CWeaponSkillState& state, action_t& action)
{
    CBattleEntity::OnWeaponSkillFinished(state, action);

    auto PWeaponSkill = state.GetSkill();
    auto PBattleTarget = static_cast<CBattleEntity*>(state.GetTarget());

    int16 tp = state.GetSpentTP();
    tp = battleutils::CalculateWeaponSkillTP(this, PWeaponSkill, tp);

    if (distance(loc.p, PBattleTarget->loc.p) - PBattleTarget->m_ModelSize <= PWeaponSkill->getRange())
    {
        PAI->TargetFind->reset();
        if (PWeaponSkill->isAoE())
        {
            PAI->TargetFind->findWithinArea(PBattleTarget, AOERADIUS_TARGET, 10);
        }
        else
        {
            PAI->TargetFind->findSingleTarget(PBattleTarget);
        }

        for (auto&& PTarget : PAI->TargetFind->m_targets)
        {
            bool primary = PTarget == PBattleTarget;
            actionList_t& actionList = action.getNewActionList();
            actionList.ActionTargetID = PTarget->id;

            actionTarget_t& actionTarget = actionList.getNewActionTarget();

            uint16 tpHitsLanded;
            uint16 extraHitsLanded;
            int32 damage;
            CBattleEntity* taChar = battleutils::getAvailableTrickAttackChar(this, PTarget);

            actionTarget.reaction = REACTION_NONE;
            actionTarget.speceffect = SPECEFFECT_NONE;
            actionTarget.animation = PWeaponSkill->getAnimationId();
            actionTarget.messageID = 0;
            std::tie(damage, tpHitsLanded, extraHitsLanded) = luautils::OnUseWeaponSkill(this, PTarget, PWeaponSkill, tp, primary, action, taChar);

            if (!battleutils::isValidSelfTargetWeaponskill(PWeaponSkill->getID()))
            {
                if (primary && PBattleTarget->objtype == TYPE_MOB)
                {
                    luautils::OnWeaponskillHit(PBattleTarget, this, PWeaponSkill->getID());
                }
            }
            else // Self-targetting WS restoring MP
            {
                actionTarget.messageID = primary ? 224 : 276; // Restores mp msg
                actionTarget.reaction = REACTION_HIT;
                damage = std::max(damage, 0);
                actionTarget.param = addMP(damage);
            }

            if (primary)
            {
                if (PWeaponSkill->getPrimarySkillchain() != 0)
                {
                    // NOTE: GetSkillChainEffect is INSIDE this if statement because it
                    //  ALTERS the state of the resonance, which misses and non-elemental skills should NOT do.
                    SUBEFFECT effect = battleutils::GetSkillChainEffect(PBattleTarget, PWeaponSkill->getPrimarySkillchain(), PWeaponSkill->getSecondarySkillchain(), PWeaponSkill->getTertiarySkillchain());
                    if (effect != SUBEFFECT_NONE)
                    {
                        actionTarget.addEffectParam = battleutils::TakeSkillchainDamage(this, PBattleTarget, damage, taChar);
                        if (actionTarget.addEffectParam < 0)
                        {
                            actionTarget.addEffectParam = -actionTarget.addEffectParam;
                            actionTarget.addEffectMessage = 384 + effect;
                        }
                        else
                        {
                            actionTarget.addEffectMessage = 287 + effect;
                        } 
                        actionTarget.additionalEffect = effect;
                    }
                }
            }
        }
    }
}
