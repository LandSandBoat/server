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
#include "action/action.h"
#include "action/interrupts.h"
#include "ai/ai_container.h"
#include "ai/controllers/trust_controller.h"
#include "ai/helpers/pathfind.h"
#include "ai/helpers/targetfind.h"
#include "ai/states/ability_state.h"
#include "ai/states/attack_state.h"
#include "ai/states/magic_state.h"
#include "ai/states/mobskill_state.h"
#include "ai/states/range_state.h"
#include "ai/states/weaponskill_state.h"
#include "attack.h"
#include "enmity_container.h"
#include "mob_modifier.h"
#include "mob_spell_container.h"
#include "mob_spell_list.h"
#include "packets/entity_set_name.h"
#include "packets/entity_update.h"
#include "packets/s2c/0x029_battle_message.h"
#include "packets/s2c/0x0df_group_attr.h"
#include "recast_container.h"
#include "status_effect_container.h"
#include "utils/battleutils.h"
#include "utils/messageutils.h"
#include "utils/trustutils.h"

CTrustEntity::CTrustEntity(CCharEntity* PChar)
: CMobEntity()
{
    objtype                     = TYPE_TRUST;
    m_EcoSystem                 = ECOSYSTEM::UNCLASSIFIED;
    allegiance                  = ALLEGIANCE_TYPE::PLAYER;
    m_MobSkillList              = 0;
    PMaster                     = PChar;
    m_bReleaseTargIDOnDisappear = true;
    spawnAnimation              = SPAWN_ANIMATION::SPECIAL; // Initial spawn has the special spawn-in animation

    PAI = std::make_unique<CAIContainer>(this,
                                         std::make_unique<CPathFind>(this),
                                         std::make_unique<CTrustController>(PChar, this),
                                         std::make_unique<CTargetFind>(this));
}

CTrustEntity::~CTrustEntity()
{
    TracyZoneScoped;
}

auto CTrustEntity::getShieldSize() -> int8
{
    const auto shieldSizeMod = static_cast<int8>(getMobMod(MOBMOD_TRUST_SHIELD_SIZE));
    return shieldSizeMod > 0 ? shieldSizeMod : m_defaultShieldSize;
}

void CTrustEntity::PostTick()
{
    // NOTE: This is purposefully calling CBattleEntity's impl.
    // TODO: Calling a grand-parent's impl. of an overridden function is bad
    CBattleEntity::PostTick();
    timer::time_point now = timer::now();
    if (loc.zone && updatemask && status != STATUS_TYPE::DISAPPEAR && now > m_nextUpdateTimer)
    {
        m_nextUpdateTimer = now + 250ms;
        loc.zone->UpdateEntityPacket(this, ENTITY_UPDATE, updatemask);

        if (PMaster && PMaster->PParty && updatemask & UPDATE_HP)
        {
            PMaster->ForParty(
                [this](auto PMember)
                {
                    static_cast<CCharEntity*>(PMember)->pushPacket<GP_SERV_COMMAND_GROUP_ATTR>(this);
                });
        }

        updatemask = 0;
    }
}

void CTrustEntity::FadeOut()
{
    CBaseEntity::FadeOut();
    loc.zone->UpdateEntityPacket(this, ENTITY_DESPAWN, UPDATE_NONE);
}

void CTrustEntity::Die()
{
    luautils::OnMobDeath(this, nullptr);
    PEnmityContainer->Clear();
    PAI->ClearStateStack();
    PAI->Internal_Die(0s);
    static_cast<CCharEntity*>(PMaster)->RemoveTrust(this);
    m_OwnerID.clean();

    // NOTE: This is purposefully calling CBattleEntity's impl.
    // TODO: Calling a grand-parent's impl. of an overridden function is bad
    CBattleEntity::Die();
}

void CTrustEntity::Spawn()
{
    // NOTE: This is purposefully calling CBattleEntity's impl.
    // TODO: Calling a grand-parent's impl. of an overridden function is bad
    // we need to skip CMobEntity's spawn because it calculates stats (and our stats are already calculated)
    CBattleEntity::Spawn();
    luautils::OnMobSpawn(this);

    // Recompute derived HP/MP after spawn-time modifiers (e.g. HPP/MPP)
    // and force current HP/MP to max so trusts start in a fully synchronized state.
    UpdateHealth();
    health.hp = GetMaxHP();
    health.mp = GetMaxMP();
    updatemask |= UPDATE_HP;

    static_cast<CCharEntity*>(PMaster)->pushPacket<CEntitySetNamePacket>(this);
}

bool CTrustEntity::ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags)
{
    // Passive GEO trusts like Sakura etc are basically walking indicolures and cant be targeted
    if (m_isPassiveTrust)
    {
        return false;
    }

    if (PInitiator->objtype == TYPE_TRUST && PMaster == PInitiator->PMaster)
    {
        return true;
    }

    if ((targetFlags & TARGET_PLAYER_PARTY_PIANISSIMO) && PInitiator->allegiance == allegiance && PMaster && PInitiator != this)
    {
        if (PInitiator->StatusEffectContainer->HasStatusEffect(EFFECT_PIANISSIMO))
        {
            return true;
        }
    }

    if ((targetFlags & TARGET_PLAYER_PARTY_ENTRUST) && PInitiator->allegiance == allegiance && PMaster && PInitiator != this)
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

void CTrustEntity::OnDespawn(CDespawnState& /*unused*/)
{
    if (GetHPP() > 0)
    {
        // Don't call this when despawning after being killed
        luautils::OnMobDespawn(this);
    }
    FadeOut();
    PAI->EventHandler.triggerListener("DESPAWN", this);
}

void CTrustEntity::OnCastFinished(CMagicState& state, action_t& action)
{
    // NOTE: This is purposefully calling CBattleEntity's impl.
    // TODO: Calling a grand-parent's impl. of an overridden function is bad
    CBattleEntity::OnCastFinished(state, action);

    auto* PSpell = state.GetSpell();

    PRecastContainer->Add(RECAST_MAGIC, static_cast<Recast>(PSpell->getID()), action.recast);
}

void CTrustEntity::OnMobSkillFinished(CMobSkillState& state, action_t& action)
{
    CMobEntity::OnMobSkillFinished(state, action);
}

void CTrustEntity::OnWeaponSkillFinished(CWeaponSkillState& state, action_t& action)
{
    // NOTE: This is purposefully calling CBattleEntity's impl.
    // TODO: Calling a grand-parent's impl. of an overridden function is bad
    CBattleEntity::OnWeaponSkillFinished(state, action);

    auto* PWeaponSkill  = state.GetSkill();
    auto* PBattleTarget = dynamic_cast<CBattleEntity*>(state.GetTarget());
    if (!PBattleTarget)
    {
        return;
    }

    int16 tp = state.GetSpentTP();
    tp       = battleutils::CalculateWeaponSkillTP(this, PWeaponSkill, tp);

    if (distance(loc.p, PBattleTarget->loc.p) <= PWeaponSkill->getRange() + PBattleTarget->modelHitboxSize + modelHitboxSize)
    {
        PAI->TargetFind->reset();
        if (PWeaponSkill->isAoE())
        {
            PAI->TargetFind->findWithinArea(PBattleTarget, AOE_RADIUS::TARGET, PWeaponSkill->getRadius(), FINDFLAGS_NONE, TARGET_NONE);
        }
        else
        {
            PAI->TargetFind->findSingleTarget(PBattleTarget, FINDFLAGS_NONE, TARGET_NONE);
        }

        if (PAI->TargetFind->m_targets.size() == 0)
        {
            // There used to be an assumed interrupt handler
            // Add a test and capture before reintroducing.
            return;
        }

        for (auto&& PTarget : PAI->TargetFind->m_targets)
        {
            bool             primary      = PTarget == PBattleTarget;
            action_target_t& actionTarget = action.addTarget(PTarget->id);
            action_result_t& actionResult = actionTarget.addResult();

            uint16         tpHitsLanded    = 0;
            uint16         extraHitsLanded = 0;
            int32          damage          = 0;
            CBattleEntity* taChar          = battleutils::getAvailableTrickAttackChar(this, PTarget);

            actionResult.resolution                         = ActionResolution::Hit;
            actionResult.animation                          = PWeaponSkill->getAnimationId();
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
                actionResult.messageID  = primary ? MsgBasic::UsesSkillRecoversMP : MsgBasic::TargetRecoversMP;
                actionResult.resolution = ActionResolution::Hit;
                damage                  = std::max(damage, 0);
                actionResult.param      = addMP(damage);
            }

            if (primary)
            {
                if (actionResult.resolution == ActionResolution::Hit)
                {
                    if (PBattleTarget->health.hp > 0 && PWeaponSkill->getPrimarySkillchain() != 0)
                    {
                        // NOTE: GetSkillChainEffect is INSIDE this if statement because it
                        //  ALTERS the state of the resonance, which misses and non-elemental skills should NOT do.
                        const auto effect = battleutils::GetSkillChainEffect(
                            PBattleTarget,
                            PWeaponSkill->getPrimarySkillchain(),
                            PWeaponSkill->getSecondarySkillchain(),
                            PWeaponSkill->getTertiarySkillchain());
                        if (effect != ActionProcSkillChain::None)
                        {
                            actionResult.recordSkillchain(effect, battleutils::TakeSkillchainDamage(this, PBattleTarget, damage, taChar));
                        }
                    }
                }
            }
        }
    }
    else
    {
        ActionInterrupts::WeaponSkillOutOfRange(this, PBattleTarget);
    }

    this->processActionEffectFlags(action);
}

bool CTrustEntity::GetUntargetable() const
{
    // Passive GEO trusts like Sakura etc are basically walking indicolures and cant be targeted
    if (m_isPassiveTrust)
    {
        return true;
    }

    return CMobEntity::GetUntargetable();
}
