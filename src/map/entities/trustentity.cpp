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
#include "mob_spell_container.h"
#include "mob_spell_list.h"
#include "packets/char_health.h"
#include "packets/entity_set_name.h"
#include "packets/entity_update.h"
#include "recast_container.h"
#include "status_effect_container.h"
#include "utils/battleutils.h"
#include "utils/trustutils.h"

CTrustEntity::CTrustEntity(CCharEntity* PChar)
: CMobEntity()
{
    objtype                     = TYPE_TRUST;
    m_EcoSystem                 = ECOSYSTEM::UNCLASSIFIED;
    allegiance                  = ALLEGIANCE_TYPE::PLAYER;
    m_MobSkillList              = 0;
    PMaster                     = PChar;
    m_IsClaimable               = false;
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

void CTrustEntity::PostTick()
{
    // NOTE: This is purposefully calling CBattleEntity's impl.
    // TODO: Calling a grand-parent's impl. of an overridden function is bad
    CBattleEntity::PostTick();
    std::chrono::steady_clock::time_point now = std::chrono::steady_clock::now();
    if (loc.zone && updatemask && status != STATUS_TYPE::DISAPPEAR && now > m_nextUpdateTimer)
    {
        m_nextUpdateTimer = now + 250ms;
        loc.zone->UpdateEntityPacket(this, ENTITY_UPDATE, updatemask);

        if (PMaster && PMaster->PParty && updatemask & UPDATE_HP)
        {
            // clang-format off
            PMaster->ForParty([this](auto PMember)
            {
                static_cast<CCharEntity*>(PMember)->pushPacket<CCharHealthPacket>(this);
            });
            // clang-format on
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
    ((CCharEntity*)PMaster)->RemoveTrust(this);
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
    ((CCharEntity*)PMaster)->pushPacket<CEntitySetNamePacket>(this);
}

void CTrustEntity::OnAbility(CAbilityState& state, action_t& action)
{
    auto* PAbility = state.GetAbility();
    auto* PTarget  = dynamic_cast<CBattleEntity*>(state.GetTarget());
    if (!PTarget)
    {
        return;
    }

    std::unique_ptr<CBasicPacket> errMsg;
    if (IsValidTarget(PTarget->targid, PAbility->getValidTarget(), errMsg))
    {
        if (this != PTarget && distance(this->loc.p, PTarget->loc.p) > PAbility->getRange())
        {
            return;
        }

        if (battleutils::IsParalyzed(this))
        {
            setActionInterrupted(action, PTarget, MSGBASIC_IS_PARALYZED, 0);
            return;
        }

        action.id         = this->id;
        action.actiontype = PAbility->getActionType();
        action.actionid   = PAbility->getID();
        action.recast     = PAbility->getRecastTime();

        if (PAbility->isAoE())
        {
            PAI->TargetFind->reset();

            float distance = PAbility->getRange();

            PAI->TargetFind->findWithinArea(this, AOE_RADIUS::ATTACKER, distance, FINDFLAGS_NONE, PAbility->getValidTarget());

            uint16 prevMsg = 0;
            for (auto&& PTargetFound : PAI->TargetFind->m_targets)
            {
                actionList_t& actionList     = action.getNewActionList();
                actionList.ActionTargetID    = PTargetFound->id;
                actionTarget_t& actionTarget = actionList.getNewActionTarget();
                actionTarget.reaction        = REACTION::NONE;
                actionTarget.speceffect      = SPECEFFECT::NONE;
                actionTarget.animation       = PAbility->getAnimationID();
                actionTarget.messageID       = PAbility->getMessage();
                actionTarget.param           = 0;

                int32 value = luautils::OnUseAbility(this, PTargetFound, PAbility, &action);

                if (prevMsg == 0) // get default message for the first target
                {
                    actionTarget.messageID = PAbility->getMessage();
                }
                else // get AoE message for second, if there's a manual override, otherwise return message from PAbility->getMessage().
                {
                    actionTarget.messageID = PAbility->getAoEMsg();
                }

                actionTarget.param = value;

                if (value < 0)
                {
                    actionTarget.messageID = ability::GetAbsorbMessage(actionTarget.messageID);
                    actionTarget.param     = -actionTarget.param;
                }

                prevMsg = actionTarget.messageID;

                state.ApplyEnmity();
            }
        }
        else
        {
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
            {
                actionTarget.messageID = PAbility->getMessage();
            }
            if (actionTarget.messageID == 0)
            {
                actionTarget.messageID = MSGBASIC_USES_JA;
            }
            actionTarget.param = value;

            if (value < 0)
            {
                actionTarget.messageID = ability::GetAbsorbMessage(actionTarget.messageID);
                actionTarget.param     = -value;
            }
        }

        state.ApplyEnmity();

        PRecastContainer->Add(RECAST_ABILITY, action.actionid, action.recast);
    }
}

void CTrustEntity::OnRangedAttack(CRangeState& state, action_t& action)
{
    auto* PTarget = dynamic_cast<CBattleEntity*>(state.GetTarget());
    if (!PTarget)
    {
        return;
    }

    int32 damage      = 0;
    int32 totalDamage = 0;

    action.id         = id;
    action.actiontype = ACTION_RANGED_FINISH;

    actionList_t& actionList  = action.getNewActionList();
    actionList.ActionTargetID = PTarget->id;

    actionTarget_t& actionTarget = actionList.getNewActionTarget();
    actionTarget.reaction        = REACTION::HIT;   // 0x10
    actionTarget.speceffect      = SPECEFFECT::HIT; // 0x60 (SPECEFFECT_HIT + SPECEFFECT_RECOIL)
    actionTarget.messageID       = 352;

    /*
    CItemWeapon* PItem = (CItemWeapon*)this->getEquip(SLOT_RANGED);
    CItemWeapon* PAmmo = (CItemWeapon*)this->getEquip(SLOT_AMMO);

    bool ammoThrowing = PAmmo ? PAmmo->isThrowing() : false;
    bool rangedThrowing = PItem ? PItem->isThrowing() : false;

    uint8 slot = SLOT_RANGED;

    if (ammoThrowing)
    {
        slot = SLOT_AMMO;
        PItem = nullptr;
    }
    if (rangedThrowing)
    {
        PAmmo = nullptr;
    }
    */

    uint8 slot         = SLOT_RANGED;
    uint8 shadowsTaken = 0;
    uint8 hitCount     = 1; // 1 hit by default
    uint8 realHits     = 0; // to store the real number of hit for tp multipler
    // auto  ammoConsumed = 0;
    bool hitOccured = false; // track if player hit mob at all
    bool isBarrage  = StatusEffectContainer->HasStatusEffect(EFFECT_BARRAGE, 0);

    /*
    // if barrage is detected, getBarrageShotCount also checks for ammo count
    if (!ammoThrowing && !rangedThrowing && isBarrage)
    {
        hitCount += battleutils::getBarrageShotCount(this);
    }
    */

    // loop for barrage hits, if a miss occurs, the loop will end
    // TODO: do trusts need barrage racc & ratt bonus mods?
    for (uint8 i = 1; i <= hitCount; ++i)
    {
        if (xirand::GetRandomNumber(100) < battleutils::GetRangedHitRate(this, PTarget, isBarrage, 0)) // hit!
        {
            // absorbed by shadow
            if (battleutils::IsAbsorbByShadow(PTarget, this))
            {
                shadowsTaken++;
            }
            else
            {
                bool  isCritical = xirand::GetRandomNumber(100) < battleutils::GetCritHitRate(this, PTarget, true);
                float pdif       = battleutils::GetRangedDamageRatio(this, PTarget, isCritical, 0);

                if (isCritical)
                {
                    actionTarget.speceffect = SPECEFFECT::CRITICAL_HIT;
                    actionTarget.messageID  = 353;
                }

                // at least 1 hit occured
                hitOccured = true;
                realHits++;

                damage = (int32)((this->GetRangedWeaponDmg() + battleutils::GetFSTR(this, PTarget, slot)) * pdif);
                /*
                if (slot == SLOT_RANGED)
                {
                    if (state.IsRapidShot())
                    {
                        damage = attackutils::CheckForDamageMultiplier(this, PItem, damage, PHYSICAL_ATTACK_TYPE::RAPID_SHOT, SLOT_RANGED);
                    }
                    else
                    {
                        damage = attackutils::CheckForDamageMultiplier(this, PItem, damage, PHYSICAL_ATTACK_TYPE::RANGED, SLOT_RANGED);
                    }

                    if (PItem != nullptr)
                    {
                        charutils::TrySkillUP(this, (SKILLTYPE)PItem->getSkillType(), PTarget->GetMLevel());
                    }
                }
                else if (slot == SLOT_AMMO && PAmmo != nullptr)
                {
                    charutils::TrySkillUP(this, (SKILLTYPE)PAmmo->getSkillType(), PTarget->GetMLevel());
                }
                */
            }
        }
        else // miss
        {
            actionTarget.reaction   = REACTION::EVADE;
            actionTarget.speceffect = SPECEFFECT::NONE;
            actionTarget.messageID  = 354;
            hitCount                = i; // end barrage, shot missed
        }
        /*
        // check for recycle chance
        uint16 recycleChance = getMod(Mod::RECYCLE);
        if (charutils::hasTrait(this, TRAIT_RECYCLE))
        {
            recycleChance += PMeritPoints->GetMeritValue(MERIT_RECYCLE, this);
        }

        // Only remove unlimited shot on hit
        if (hitOccured && this->StatusEffectContainer->HasStatusEffect(EFFECT_UNLIMITED_SHOT))
        {
            StatusEffectContainer->DelStatusEffect(EFFECT_UNLIMITED_SHOT);
            recycleChance = 100;
        }

        if (PAmmo != nullptr && xirand::GetRandomNumber(100) > recycleChance)
        {
            ++ammoConsumed;
            TrackArrowUsageForScavenge(PAmmo);
            if (PAmmo->getQuantity() == i)
            {
                hitCount = i;
            }
        }
        */
        totalDamage += damage;
    }

    // if a hit did occur (even without barrage)
    if (hitOccured)
    {
        // any misses with barrage cause remaining shots to miss, meaning we must check Action.reaction
        if ((actionTarget.reaction & REACTION::MISS) != REACTION::NONE && StatusEffectContainer->HasStatusEffect(EFFECT_BARRAGE))
        {
            actionTarget.messageID  = 352;
            actionTarget.reaction   = REACTION::HIT;
            actionTarget.speceffect = SPECEFFECT::CRITICAL_HIT;
        }

        actionTarget.param =
            battleutils::TakePhysicalDamage(this, PTarget, PHYSICAL_ATTACK_TYPE::RANGED, totalDamage, false, slot, realHits, nullptr, true, true);

        // lower damage based on shadows taken
        if (shadowsTaken)
        {
            actionTarget.param = (int32)(actionTarget.param * (1 - ((float)shadowsTaken / realHits)));
        }

        // absorb message
        if (actionTarget.param < 0)
        {
            actionTarget.param     = -(actionTarget.param);
            actionTarget.messageID = 382;
        }

        /*
        //add additional effects
        //this should go AFTER damage taken
        //or else sleep effect won't work
        //battleutils::HandleRangedAdditionalEffect(this,PTarget,&Action);
        //TODO: move all hard coded additional effect ammo to scripts
        if ((PAmmo != nullptr && battleutils::GetScaledItemModifier(this, PAmmo, Mod::ADDITIONAL_EFFECT) > 0) ||
            (PItem != nullptr && battleutils::GetScaledItemModifier(this, PItem, Mod::ADDITIONAL_EFFECT) > 0)) {}
        luautils::OnAdditionalEffect(this, PTarget, (PAmmo != nullptr ? PAmmo : PItem), &actionTarget, totalDamage);
         */
    }
    else if (shadowsTaken > 0)
    {
        // shadows took damage
        actionTarget.messageID = 0;
        actionTarget.reaction  = REACTION::EVADE;
        PTarget->loc.zone->PushPacket(PTarget, CHAR_INRANGE_SELF, std::make_unique<CMessageBasicPacket>(PTarget, PTarget, 0, shadowsTaken, MSGBASIC_SHADOW_ABSORB));
    }

    if (actionTarget.speceffect == SPECEFFECT::HIT && actionTarget.param > 0)
    {
        actionTarget.speceffect = SPECEFFECT::RECOIL;
    }

    // remove barrage effect if present
    if (this->StatusEffectContainer->HasStatusEffect(EFFECT_BARRAGE, 0))
    {
        StatusEffectContainer->DelStatusEffect(EFFECT_BARRAGE, 0);
    }

    battleutils::ClaimMob(PTarget, this);
    // battleutils::RemoveAmmo(this, ammoConsumed);
    // only remove detectables
    StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DETECTABLE);
}

bool CTrustEntity::ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags)
{
    if (PInitiator->objtype == TYPE_TRUST && PMaster == PInitiator->PMaster)
    {
        return true;
    }

    if ((targetFlags & TARGET_PLAYER_PARTY_PIANISSIMO) && PInitiator->allegiance == allegiance && PMaster && PInitiator != this)
    {
        return true;
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

    PRecastContainer->Add(RECAST_MAGIC, static_cast<uint16>(PSpell->getID()), action.recast);
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

    if (distance(loc.p, PBattleTarget->loc.p) - PBattleTarget->m_ModelRadius <= PWeaponSkill->getRange())
    {
        PAI->TargetFind->reset();
        if (PWeaponSkill->isAoE())
        {
            PAI->TargetFind->findWithinArea(PBattleTarget, AOE_RADIUS::TARGET, 10, FINDFLAGS_NONE, TARGET_NONE);
        }
        else
        {
            PAI->TargetFind->findSingleTarget(PBattleTarget, FINDFLAGS_NONE, TARGET_NONE);
        }

        // Assumed, it's very difficult to produce this due to WS being nearly instant
        // TODO: attempt to verify.
        if (PAI->TargetFind->m_targets.size() == 0)
        {
            // No targets, perhaps something like Super Jump or otherwise untargetable
            action.actiontype         = ACTION_MAGIC_FINISH;
            action.actionid           = 28787; // Some hardcoded magic for interrupts
            actionList_t& actionList  = action.getNewActionList();
            actionList.ActionTargetID = id;

            actionTarget_t& actionTarget = actionList.getNewActionTarget();
            actionTarget.animation       = 0x1FC; // assumed
            actionTarget.messageID       = 0;
            actionTarget.reaction        = REACTION::ABILITY | REACTION::HIT;

            return;
        }

        for (auto&& PTarget : PAI->TargetFind->m_targets)
        {
            bool          primary     = PTarget == PBattleTarget;
            actionList_t& actionList  = action.getNewActionList();
            actionList.ActionTargetID = PTarget->id;

            actionTarget_t& actionTarget = actionList.getNewActionTarget();

            uint16         tpHitsLanded    = 0;
            uint16         extraHitsLanded = 0;
            int32          damage          = 0;
            CBattleEntity* taChar          = battleutils::getAvailableTrickAttackChar(this, PTarget);

            actionTarget.reaction                           = REACTION::NONE;
            actionTarget.speceffect                         = SPECEFFECT::NONE;
            actionTarget.animation                          = PWeaponSkill->getAnimationId();
            actionTarget.messageID                          = 0;
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
                actionTarget.reaction  = REACTION::HIT;
                damage                 = std::max(damage, 0);
                actionTarget.param     = addMP(damage);
            }

            if (primary)
            {
                if ((actionTarget.reaction & REACTION::MISS) == REACTION::NONE)
                {
                    if (PBattleTarget->health.hp > 0 && PWeaponSkill->getPrimarySkillchain() != 0)
                    {
                        // NOTE: GetSkillChainEffect is INSIDE this if statement because it
                        //  ALTERS the state of the resonance, which misses and non-elemental skills should NOT do.
                        SUBEFFECT effect = battleutils::GetSkillChainEffect(PBattleTarget, PWeaponSkill->getPrimarySkillchain(),
                                                                            PWeaponSkill->getSecondarySkillchain(), PWeaponSkill->getTertiarySkillchain());
                        if (effect != SUBEFFECT_NONE)
                        {
                            actionTarget.addEffectParam = battleutils::TakeSkillchainDamage(this, PBattleTarget, damage, taChar);
                            if (actionTarget.addEffectParam < 0)
                            {
                                actionTarget.addEffectParam   = -actionTarget.addEffectParam;
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
    else
    {
        actionList_t& actionList  = action.getNewActionList();
        actionList.ActionTargetID = PBattleTarget->id;
        action.actiontype         = ACTION_MAGIC_FINISH; // all "too far" messages use cat 4

        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.animation       = 0x1FC; // seems hardcoded, 2 bits away from 0x1FF.
        actionTarget.messageID       = MSGBASIC_TOO_FAR_AWAY;

        actionTarget.speceffect = SPECEFFECT::NONE; // It seems most mobs use NONE, but player-like models use BLOOD for their weaponskills
                                                    // TODO: figure out a good way to differentiate between the two. There does not seem to be a functional difference.
    }
}
