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

#include "mob_controller.h"

#include "ai/ai_container.h"
#include "ai/helpers/targetfind.h"
#include "ai/states/ability_state.h"
#include "ai/states/attack_state.h"
#include "ai/states/inactive_state.h"
#include "ai/states/magic_state.h"
#include "ai/states/weaponskill_state.h"
#include "battlefield.h"
#include "common/utils.h"
#include "enmity_container.h"
#include "entities/mobentity.h"
#include "mob_modifier.h"
#include "mob_spell_container.h"
#include "mobskill.h"
#include "party.h"
#include "recast_container.h"
#include "spawn_handler.h"
#include "status_effect_container.h"
#include "utils/battleutils.h"
#include "utils/petutils.h"
#include "zone.h"

CMobController::CMobController(CMobEntity* PEntity)
: CController(PEntity)
, PMob(PEntity)
{
}

auto CMobController::Ability(uint16 targid, uint16 abilityid) -> bool
{
    if (PMob->PRecastContainer->HasRecast(RECAST_ABILITY, static_cast<Recast>(abilityid), 0s))
    {
        return false;
    }

    if (!POwner->PAI->CanChangeState())
    {
        return false;
    }

    return POwner->PAI->Internal_Ability(targid, abilityid);
}

auto CMobController::Tick(const timer::time_point tick) -> Task<void>
{
    TracyZoneScoped;
    TracyZoneString(PMob->getName());

    m_Tick = tick;

    // Invalidate the per-tick LOS cache so every tick starts with a fresh raycast.
    targetLosCache_.reset();

    if (!PMob->isAlive())
    {
        co_return;
    }

    if (PMob->PAI->IsEngaged())
    {
        co_await DoCombatTick(tick);
    }
    else
    {
        co_await DoRoamTick(tick);
    }

    co_return;
}

auto CMobController::TryDeaggro() -> bool
{
    TracyZoneScoped;

    if (PTarget == nullptr && (PMob->PEnmityContainer != nullptr && PMob->PEnmityContainer->GetHighestEnmity() == nullptr))
    {
        return true;
    }

    // target is no longer valid, so wipe them from our enmity list
    if (!PTarget || PTarget->isDead() || PTarget->isMounted() || PTarget->loc.zone->GetID() != PMob->loc.zone->GetID() ||
        PMob->StatusEffectContainer->GetConfrontationEffect() != PTarget->StatusEffectContainer->GetConfrontationEffect() ||
        PMob->allegiance == PTarget->allegiance || CheckDetection(PTarget) || CheckHide(PTarget) || CheckLock(PTarget) ||
        PMob->getBattleID() != PTarget->getBattleID())
    {
        if (PTarget)
        {
            PMob->PEnmityContainer->Clear(PTarget->id);
        }
        PTarget = PMob->PEnmityContainer->GetHighestEnmity();
        if (PTarget)
        {
            PMob->SetBattleTargetID(PTarget->targid);
            // Reset deaggro time so that the mob is given time to actually try to path towards the new highest enmity target
            TapDeaggroTime();
        }
        else
        {
            PMob->SetBattleTargetID(0);
        }

        return TryDeaggro();
    }

    return false;
}

auto CMobController::CanTrackByScent(const CBattleEntity* PTarget) const -> bool
{
    TracyZoneScoped;

    if (!(PMob->getMobMod(MOBMOD_DETECTION) & DETECT_SCENT))
    {
        return false;
    }

    // Mobs underwater instantly deaggro if scent fails (deodorize / no target).
    if (PMob->PAI->PathFind->InWater() || !PTarget || PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_DEODORIZE))
    {
        return false;
    }

    // Certain weather / deodorize will turn on time deaggro.
    return !PMob->m_disableScent;
}

auto CMobController::CheckHide(const CBattleEntity* PTarget) const -> bool
{
    TracyZoneScoped;

    if (!PTarget || PTarget->GetMJob() != JOB_THF || !PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_HIDE))
    {
        return false;
    }

    return !CanTrackByScent(PTarget) && !PMob->m_TrueDetection && !(PMob->getMobMod(MOBMOD_DETECTION) & DETECT_HEARING);
}

auto CMobController::CheckLock(CBattleEntity* PTarget) const -> bool
{
    TracyZoneScoped;

    if (!PTarget)
    {
        return false;
    }

    // Resolve the (potentially pet-owning) character whose Locked flag we care about.
    const auto* PChar = [&]() -> const CCharEntity*
    {
        if (PTarget->objtype == TYPE_PC)
        {
            return dynamic_cast<CCharEntity*>(PTarget);
        }

        if (PTarget->objtype == TYPE_PET)
        {
            const auto* PPet = dynamic_cast<CPetEntity*>(PTarget);
            return PPet ? dynamic_cast<CCharEntity*>(PPet->PMaster) : nullptr;
        }

        return nullptr;
    }();

    if (!PChar || !PChar->m_Locked)
    {
        return false;
    }

    return !CanTrackByScent(PTarget);
}

auto CMobController::CheckDetection(CBattleEntity* PTarget) -> bool
{
    TracyZoneScoped;

    const bool isImmobilised = PMob->StatusEffectContainer->HasStatusEffect({ EFFECT_BIND, EFFECT_SLEEP, EFFECT_SLEEP_II, EFFECT_LULLABY, EFFECT_PETRIFICATION });
    if (CanTrackByScent(PTarget) || CanDetectTarget(PTarget) || isImmobilised)
    {
        TapDeaggroTime();
    }

    const auto additionalDeaggroTime = [&]() -> std::chrono::seconds
    {
        if (PMob->m_roamFlags & ROAMFLAG_WORM)
        {
            return std::chrono::seconds(0);
        }
        return std::chrono::seconds(settings::get<uint32>("map.MOB_ADDITIONAL_TIME_TO_DEAGGRO"));
    }();

    return PMob->CanDeaggro() && (m_Tick >= m_DeaggroTime + 25s + additionalDeaggroTime);
}

void CMobController::TryLink()
{
    TracyZoneScoped;

    if (PTarget == nullptr)
    {
        return;
    }

    // Pet bodyguard: avatar pets engage the mob when their master is being attacked.
    // Alexander, Odin and Atomos are passive and do not protect their master.
    const auto tryAvatarBodyguard = [&]()
    {
        if (PTarget->PPet == nullptr || PTarget->PPet->GetBattleTargetID() != 0 || PTarget->PPet->objtype != TYPE_PET)
        {
            return;
        }

        const auto* PPetEntity         = static_cast<CPetEntity*>(PTarget->PPet);
        const bool  isProtectiveAvatar = PPetEntity->getPetType() == PET_TYPE::AVATAR &&
                                        PPetEntity->m_PetID != PETID_ALEXANDER &&
                                        PPetEntity->m_PetID != PETID_ODIN &&
                                        PPetEntity->m_PetID != PETID_ATOMOS;
        if (!isProtectiveAvatar)
        {
            return;
        }

        // PCs only get bodyguarded by the avatar they own; non-PC targets always do.
        if (PTarget->objtype == TYPE_PC)
        {
            auto* const PChar = dynamic_cast<CCharEntity*>(PTarget);
            if (!PChar || !PChar->IsMobOwner(PMob))
            {
                return;
            }
        }

        petutils::AttackTarget(PTarget, PMob);
    };
    tryAvatarBodyguard();

    // My pet should help as well.
    if (PMob->PPet != nullptr && PMob->PPet->PAI->IsRoaming())
    {
        PMob->PPet->PAI->Engage(PTarget->targid);
    }

    // Pull in linked party members that are close enough.
    if (PMob->PParty != nullptr && !PMob->getMobMod(MOBMOD_ONE_WAY_LINKING))
    {
        for (auto& member : PMob->PParty->members)
        {
            auto* PPartyMember = dynamic_cast<CMobEntity*>(member);

            // Pets only link with their masters, never with the rest of the party.
            if (!PPartyMember || PPartyMember->PMaster || PPartyMember->isDead())
            {
                continue;
            }

            // A sublink groups same-family mobs into the same party so they can link via *another*
            // family. Skip same-family party members unless this mob actually wants to link with kin.
            const bool sameFamilyButNoSelfLink = PMob->m_Family == PPartyMember->m_Family && !PMob->ShouldForceLink() && !PMob->m_Link;
            if (sameFamilyButNoSelfLink)
            {
                continue;
            }

            if (PPartyMember->PAI->IsRoaming() && PPartyMember->CanLink(&PMob->loc.p, PMob->getMobMod(MOBMOD_SUPERLINK)))
            {
                PPartyMember->PAI->Engage(PTarget->targid);
            }
        }
    }

    // Ask my master for help.
    if (PMob->PMaster != nullptr && PMob->PMaster->PAI->IsRoaming())
    {
        auto* PMaster = static_cast<CMobEntity*>(PMob->PMaster);
        if (PMaster->CanLink(&PMob->loc.p, PMob->getMobMod(MOBMOD_SUPERLINK)))
        {
            PMaster->PAI->Engage(PTarget->targid);
        }
    }
}

//
// Checks if the mob can detect the target using it's detection (sight, sound, etc)
// This is used to aggro and deaggro (Mobs start to deaggro after failing to detect target).
//
auto CMobController::CanDetectTarget(CBattleEntity* PTarget, const bool forceSight) const -> bool
{
    TracyZoneScoped;

    if (!PTarget || PTarget->isDead() || PTarget->isMounted())
    {
        return false;
    }

    const auto detects         = PMob->getMobMod(MOBMOD_DETECTION);
    const auto currentDistance = distance(PTarget->loc.p, PMob->loc.p) + PTarget->getMod(Mod::STEALTH);
    const bool detectSight     = (detects & DETECT_SIGHT) || forceSight;

    // Determine which stealth effects are actually masking the target from us. True detection ignores
    // both, but Illusion overrides true detection (true-sound Porrogos don't aggro with Illusion up).
    // Mobs that "see through Illusion" still respect a player's actual sneak.
    const auto [hasInvisible, hasSneak] = [&]() -> std::pair<bool, bool>
    {
        bool invisible = false;
        bool sneak     = false;

        if (!PMob->m_TrueDetection)
        {
            invisible = PTarget->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_INVISIBLE);
            sneak     = PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_SNEAK);
        }

        const bool hasIllusion = PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_ILLUSION);
        if (hasIllusion && !PMob->getMobMod(MOBMOD_SEES_THROUGH_ILLUSION))
        {
            invisible = true;
            sneak     = true;
        }

        return { invisible, sneak };
    }();

    // If this is already our battle target and we're in melee range, detection bypasses LOS.
    const bool isTargetAndInRange = PMob->GetBattleTargetID() == PTarget->targid && currentDistance <= PMob->GetMeleeRange(PTarget);

    const auto detected = [&]() -> bool
    {
        return isTargetAndInRange || PMob->CanSeeTarget(PTarget);
    };

    if (detectSight && !hasInvisible && currentDistance < PMob->getMobMod(MOBMOD_SIGHT_RANGE) && facing(PMob->loc.p, PTarget->loc.p, 64))
    {
        return detected();
    }

    if ((PMob->m_Behavior & BEHAVIOR_AGGRO_AMBUSH) && currentDistance < 3 && !hasSneak)
    {
        return true;
    }

    if ((detects & DETECT_HEARING) && currentDistance < PMob->getMobMod(MOBMOD_SOUND_RANGE) && !hasSneak)
    {
        return detected();
    }

    const bool detectMagicCast = (detects & DETECT_MAGIC) &&
                                 currentDistance < PMob->getMobMod(MOBMOD_MAGIC_RANGE) &&
                                 PTarget->PAI->IsCurrentState<CMagicState>() &&
                                 static_cast<CMagicState*>(PTarget->PAI->GetCurrentState())->GetSpell()->hasMPCost();
    if (detectMagicCast)
    {
        return detected();
    }

    // The remaining detection types only fire at close range.
    if (currentDistance > 20)
    {
        return false;
    }

    if ((detects & DETECT_LOWHP) && PTarget->GetHPP() < 75)
    {
        return detected();
    }

    if ((detects & DETECT_WEAPONSKILL) && PTarget->PAI->IsCurrentState<CWeaponSkillState>())
    {
        return detected();
    }

    if ((detects & DETECT_JOBABILITY) && PTarget->PAI->IsCurrentState<CAbilityState>())
    {
        return detected();
    }

    return false;
}

auto CMobController::MobSkill(int listId) -> bool
{
    TracyZoneScoped;

    if (!PTarget)
    {
        return false;
    }

    // Fall back to the mob's default skill list if the caller didn't pick one.
    const int resolvedListId = listId != 0 ? listId : PMob->getMobMod(MOBMOD_SKILL_LIST);

    auto skillList = battleutils::GetMobSkillList(resolvedListId);
    if (skillList.empty())
    {
        return false;
    }
    std::shuffle(skillList.begin(), skillList.end(), xirand::rng());

    // Pick the first valid mob skill from the shuffled list.
    const uint16 firstValidSkillId = [&]() -> uint16
    {
        for (const auto skillId : skillList)
        {
            if (battleutils::GetMobSkill(skillId) != nullptr)
            {
                return skillId;
            }
            ShowError("CMobController::MobSkill -> Mobskill with ID (%i) [called from skill-list ID (%i)] isn't properly defined in mob_skills.sql", skillId, resolvedListId);
        }
        return 0;
    }();

    // Lua may override the chosen skill.
    const uint16 chosenSkillId = [&]() -> uint16
    {
        const auto overrideSkill = luautils::OnMobMobskillChoose(PMob, PTarget, firstValidSkillId);
        return overrideSkill > 0 ? overrideSkill : firstValidSkillId;
    }();

    auto* PMobSkill = battleutils::GetMobSkill(chosenSkillId);
    if (!PMobSkill)
    {
        return false;
    }

    // Resolve the action target: enemy/self defaults, then let lua substitute.
    CBattleEntity* PActionTarget = nullptr;
    if (PMobSkill->getValidTargets() & TARGET_ENEMY)
    {
        PActionTarget = PTarget;
    }
    else if (PMobSkill->getValidTargets() & TARGET_SELF)
    {
        PActionTarget = PMob;
    }
    PActionTarget = luautils::OnMobSkillTarget(PActionTarget, PMob, PMobSkill);

    // NOTE: OnMobSkillReadyTime is intentionally invoked unconditionally so its Lua side effects fire
    // even when the skill ultimately doesn't go off.
    const auto mobSkillReadyTime = luautils::OnMobSkillReadyTime(PActionTarget, PMob, PMobSkill);

    if (!PActionTarget || PMobSkill->isAstralFlow())
    {
        return false;
    }

    // The Lua check returns 0 to mean "yes, this skill is valid here".
    if (luautils::OnMobSkillCheck(PActionTarget, PMob, PMobSkill) != 0)
    {
        return false;
    }

    const float currentDistance = distance(PMob->loc.p, PActionTarget->loc.p);
    if (currentDistance > PMobSkill->getDistance())
    {
        return false;
    }

    return MobSkill(PActionTarget->targid, PMobSkill->getID(), mobSkillReadyTime);
}

auto CMobController::TrySpecialSkill() -> bool
{
    TracyZoneScoped;

    auto* const PSpecialSkill = battleutils::GetMobSkill(PMob->getMobMod(MOBMOD_SPECIAL_SKILL));
    if (PSpecialSkill == nullptr)
    {
        ShowError("CAIMobDummy::ActionSpawn Special skill was set but not found! (%d)", PMob->getMobMod(MOBMOD_SPECIAL_SKILL));
        return false;
    }

    if (!IsWeaponSkillEnabled())
    {
        return false;
    }

    if ((PMob->m_specialFlags & SPECIALFLAG_HIDDEN) && !PMob->IsNameHidden())
    {
        return false;
    }

    // Resolve the ability target. Self-targeted skills always hit the mob; otherwise we need a
    // PTarget within range.
    CBattleEntity* const PAbilityTarget = [&]() -> CBattleEntity*
    {
        if (PSpecialSkill->getValidTargets() & TARGET_SELF)
        {
            return PMob;
        }
        if (PTarget != nullptr && distance(PMob->loc.p, PTarget->loc.p) <= PSpecialSkill->getDistance())
        {
            return PTarget;
        }
        return nullptr;
    }();

    if (PAbilityTarget == nullptr)
    {
        return false;
    }

    if (luautils::OnMobSkillCheck(PAbilityTarget, PMob, PSpecialSkill) != 0)
    {
        return false;
    }

    if (!MobSkill(PAbilityTarget->targid, PSpecialSkill->getID(), std::nullopt))
    {
        return false;
    }

    m_LastSpecialTime = m_Tick;
    return true;
}

auto CMobController::TryCastSpell() -> bool
{
    TracyZoneScoped;

    if (!CanCastSpells(IgnoreRecastsAndCosts::No))
    {
        return false; // Can't cast spells.
    }

    // Pick the initial spell candidate. Lua may still override this below via OnMobSpellChoose.
    Maybe<SpellID> chosenSpellId = [&]() -> Maybe<SpellID>
    {
        if (!PMob->PAI->IsEngaged())
        {
            // TODO: is this even possible to have a valid target without a buff spell?
            return PMob->SpellContainer->HasBuffSpells()
                       ? PMob->SpellContainer->GetBuffSpell()
                       : PMob->SpellContainer->GetSpell();
        }

        if (m_firstSpell)
        {
            // mob's first combat spell should be the aggro spell
            m_firstSpell = false;
            return PMob->SpellContainer->GetAggroSpell();
        }

        return PMob->SpellContainer->GetSpell();
    }();

    // Lua's OnMobSpellChoose can override the spell and/or the target.
    auto* const PSpellTarget = PTarget ? PTarget : PMob;

    const auto [maybeSpellOverride, maybeTargetOverride] = luautils::OnMobSpellChoose(PMob, PSpellTarget, chosenSpellId);
    if (maybeSpellOverride.has_value())
    {
        chosenSpellId = maybeSpellOverride.value();
    }

    if (!chosenSpellId.has_value())
    {
        return false;
    }

    auto* const PSpell = spell::GetSpell(chosenSpellId.value());
    if (!PSpell)
    {
        return false;
    }

    if (PMob->PRecastContainer->Has(RECAST_MAGIC, static_cast<Recast>(chosenSpellId.value())))
    {
        return false; // Spell is on cooldown.
    }

    if (!battleutils::CanAffordSpell(PMob, PSpell, PSpell->getFlag()))
    {
        return false; // Not enough MP.
    }

    // Resolve cast target. Lua override wins; otherwise self for self-targeted spells, else PTarget.
    auto* const PCastTarget = maybeTargetOverride.value_or((PSpell->getValidTarget() & TARGET_SELF) ? PMob : PTarget);
    if (PCastTarget && distance(PMob->loc.p, PCastTarget->loc.p) > PSpell->getRange() + PMob->modelHitboxSize + PCastTarget->modelHitboxSize)
    {
        return false; // Target out of range.
    }

    CastSpell(chosenSpellId.value());
    return true;
}

auto CMobController::CanCastSpells(IgnoreRecastsAndCosts ignoreRecastsAndCosts) -> bool
{
    TracyZoneScoped;

    if (!PMob->SpellContainer->HasSpells())
    {
        return false;
    }

    // Spell blockers (silence, mute).
    if (PMob->StatusEffectContainer->HasStatusEffect({ EFFECT_SILENCE, EFFECT_MUTE }))
    {
        return false;
    }

    // SMN can only cast while pet-less.
    const bool smnHasLivePet = PMob->GetMJob() == JOB_SMN && PMob->PPet && !PMob->PPet->isDead();
    if (smnHasLivePet)
    {
        return false;
    }

    if (!IsMagicCastingEnabled())
    {
        return false;
    }

    if (!ignoreRecastsAndCosts && !PMob->SpellContainer->IsAnySpellAvailable())
    {
        return false;
    }

    return true;
}

void CMobController::CastSpell(SpellID spellid)
{
    TracyZoneScoped;

    const auto* const PSpell = spell::GetSpell(spellid);
    if (PSpell == nullptr)
    {
        ShowWarning("ai_mob_dummy::CastSpell: SpellId <%i> is not found", static_cast<uint16>(spellid));
        return;
    }

    // Pick a buff target. For self-targeted party buffs we sometimes redirect to the master or to a
    // random nearby ally (only allies in the same engaged/idle state - engaged mobs don't buff idle
    // mobs, see TODO). For non-self spells we always cast at PTarget.
    const auto pickPartyBuffTarget = [&]() -> CBattleEntity*
    {
        if (PMob->PMaster != nullptr && xirand::GetRandomNumber(2) == 0)
        {
            return PMob->PMaster;
        }

        if (xirand::GetRandomNumber(2) != 0)
        {
            return PMob;
        }

        PMob->PAI->TargetFind->reset();
        PMob->PAI->TargetFind->findWithinArea(PMob, AOE_RADIUS::ATTACKER, PSpell->getRange(), FINDFLAGS_NONE, TARGET_NONE);

        const auto& candidates = PMob->PAI->TargetFind->m_targets;
        if (candidates.empty())
        {
            return PMob;
        }

        auto* const PCandidate = candidates[xirand::GetRandomNumber(candidates.size())];
        // TODO: can engaged mobs buff idle mobs?
        return PMob->PAI->IsEngaged() == PCandidate->PAI->IsEngaged() ? PCandidate : PMob;
    };

    auto* const PCastTarget = [&]() -> CBattleEntity*
    {
        if (!(PSpell->getValidTarget() & TARGET_SELF))
        {
            return PTarget;
        }
        if (PSpell->getValidTarget() & TARGET_PLAYER_PARTY)
        {
            return pickPartyBuffTarget();
        }
        return PMob;
    }();

    if (PCastTarget)
    {
        Cast(PCastTarget->targid, spellid);
    }
}

auto CMobController::DoCombatTick(timer::time_point tick) -> Task<void>
{
    TracyZoneScopedC(0xFF0000);

    // If the claiming player has moved on (PClaimedMob no longer points at us) for >3s, drop the
    // claim so somebody else can engage.
    if (PMob->m_OwnerID.targid != 0)
    {
        const auto* const POwnerChar = dynamic_cast<CCharEntity*>(PMob->GetEntity(PMob->m_OwnerID.targid));
        const bool        claimStale = POwnerChar && POwnerChar->PClaimedMob != static_cast<CBattleEntity*>(PMob) && m_Tick >= m_DeclaimTime + 3s;
        if (claimStale)
        {
            PMob->m_OwnerID.clean();
            PMob->updatemask |= UPDATE_STATUS;
        }
    }

    HandleEnmity();
    PTarget = static_cast<CBattleEntity*>(PMob->GetEntity(PMob->GetBattleTargetID()));

    if (TryDeaggro())
    {
        Disengage();
        co_return;
    }

    TryLink();

    PMob->PAI->EventHandler.triggerListener("COMBAT_TICK", PMob);
    luautils::OnMobFight(PMob, PTarget);

    if (PMob->PAI->IsCurrentState<CInactiveState>() || !PMob->PAI->CanChangeState())
    {
        co_return;
    }

    // Run-away follow: chase or terminate based on distance to the follow target.
    if (PFollowTarget != nullptr && m_followType == FollowType::RunAway)
    {
        if (distance(PMob->loc.p, PFollowTarget->loc.p) > FollowRunAwayDistance)
        {
            if (!PMob->PAI->PathFind->IsFollowingPath())
            {
                PMob->PAI->PathFind->PathTo(PFollowTarget->loc.p);
            }
            PMob->PAI->PathFind->FollowPath(m_Tick);
        }
        else
        {
            PMob->PAI->EventHandler.triggerListener("RUN_AWAY", PMob, PFollowTarget);
            ClearFollowTarget();
        }
        co_return;
    }

    // Try special / spell / TP / ranged actions in priority order. Each helper returns true if it
    // produced an action this tick, in which case we yield until next tick.
    if (PTarget)
    {
        const float currentDistance   = distance(PMob->loc.p, PTarget->loc.p);
        const float rangedAttackRange = PMob->GetRangedAttackRange();
        const float meleeAttackRange  = PMob->GetMeleeRange(PTarget);

        if (IsSpecialSkillReady(currentDistance) && TrySpecialSkill())
        {
            co_return;
        }

        // Spellcast first so things like Chainspell spam are prioritised over TP moves.
        if (IsSpellReady(currentDistance, meleeAttackRange) && TryCastSpell())
        {
            co_return;
        }

        if (m_Tick >= m_LastMobSkillTime && PMob->shouldUseTPMove(m_tpThreshold) && MobSkill())
        {
            m_tpThreshold = xirand::GetRandomNumber(1000, 3000);
            co_return;
        }

        const bool canFireRanged = IsRangedAttackEnabled() &&
                                   currentDistance <= rangedAttackRange &&
                                   m_Tick >= PMob->m_LastRangedAttackTime &&
                                   PMob->PAI->CanChangeState() &&
                                   PTarget != nullptr;
        if (canFireRanged)
        {
            LookAtTarget(PTarget->targid);
            if (POwner->PAI->Internal_RangedAttack(PTarget->targid))
            {
                TapDeaggroTime();
                PMob->m_LastRangedAttackTime = m_Tick;
                co_return;
            }
        }
    }

    Move();
}

void CMobController::LookAtTarget(const uint16 targid) const
{
    TracyZoneScoped;

    const uint16      resolvedTargid = targid != 0 ? targid : PMob->GetBattleTargetID();
    const auto* const maybeTarget    = PMob->GetEntity(resolvedTargid);

    if (maybeTarget && !(PMob->m_Behavior & BEHAVIOR_NO_TURN))
    {
        PMob->PAI->PathFind->LookAt(maybeTarget->loc.p);
    }

    PMob->UpdateSpeed();
}

void CMobController::Move()
{
    TracyZoneScoped;

    if (!PMob->PAI->CanFollowPath())
    {
        return;
    }

    if (PMob->PAI->PathFind->IsFollowingScriptedPath())
    {
        PMob->PAI->PathFind->FollowPath(m_Tick);
        return;
    }

    // Determine attack range. Ranged attacks override skill-list ranges since the
    // mob skill lists are not fully audited.
    const auto attackRange = [&]() -> float
    {
        if (IsRangedAttackEnabled())
        {
            return PMob->GetRangedAttackRange();
        }

        if (PMob->getMobMod(MOBMOD_ATTACK_SKILL_LIST) > 0)
        {
            const auto skillList = battleutils::GetMobSkillList(PMob->getMobMod(MOBMOD_ATTACK_SKILL_LIST));
            if (!skillList.empty())
            {
                if (const auto* skill = battleutils::GetMobSkill(skillList.front()))
                {
                    return skill->getDistance();
                }
            }
        }

        return PMob->GetMeleeRange(PTarget);
    }();

    // How close PathInRange should stop short of the target. Defaults to attackRange minus a
    // small slack (0.4y) so the mob ends up just inside melee range without overshooting; can
    // be tuned per-mob via MOBMOD_TARGET_DISTANCE_OFFSET (units of 0.1y).
    const float closeDistance = [&]() -> float
    {
        const int16 offsetMod = PMob->getMobMod(MOBMOD_TARGET_DISTANCE_OFFSET);
        const float offset    = offsetMod == 0 ? 0.4f : static_cast<float>(offsetMod) / 10.0f;
        return std::max(0.0f, attackRange - offset);
    }();

    // Position-share mobs mirror their leader and skip all other movement logic.
    if (PMob->getMobMod(MOBMOD_SHARE_POS) > 0)
    {
        if (const auto* posShare = static_cast<CMobEntity*>(PMob->GetEntity(PMob->getMobMod(MOBMOD_SHARE_POS) + PMob->targid, TYPE_MOB)))
        {
            PMob->loc = posShare->loc;
        }
        else
        {
            ShowWarning("CMobController::Move() failed to get mob for MOBMOD_SHARE_POS");
        }

        return;
    }

    if (!PTarget)
    {
        LookAtTarget();
        return;
    }

    const float currentDistance = distance(PMob->loc.p, PTarget->loc.p);
    const bool  isFollowingPath = PMob->PAI->PathFind->IsFollowingPath();

    // Teleport type 1: jump in if out of melee range but within 30y and off cooldown.
    if (PMob->getMobMod(MOBMOD_TELEPORT_TYPE) == 1 &&
        currentDistance > attackRange &&
        currentDistance <= 30.0f &&
        m_Tick >= m_LastSpecialTime + std::chrono::seconds(PMob->getMobMod(MOBMOD_TELEPORT_CD)))
    {
        if (const CMobSkill* teleportBegin = battleutils::GetMobSkill(PMob->getMobMod(MOBMOD_TELEPORT_START)))
        {
            m_LastSpecialTime = m_Tick;
            MobSkill(PMob->targid, teleportBegin->getID(), std::nullopt);
        }
    }

    // Already in range and not actively moving: if we have line of sight, just face target.
    // Re-check CanFollowPath because the teleport above may have changed AI state.
    //
    // The CanSeeTarget() check here is load-bearing: even when the mob is well inside melee range
    // (<2.0y) we keep verifying LOS, so a mob that has slid up against a thin wall with the target
    // on the other side won't sit there auto-attacking through the wall - it'll fall through to
    // the movement logic below and try to reposition for an actual line of sight.
    //
    // CanSeeTarget() does a raycast, so it is intentionally placed last in the && chain - the
    // cheap distance/state checks short-circuit it away in the common case.
    const bool inAttackRange = currentDistance <= attackRange;
    if (!PMob->PAI->CanFollowPath())
    {
        LookAtTarget();
        return;
    }

    if (inAttackRange && !isFollowingPath && CanSeeTargetCached())
    {
        // The mob has line of sight and is in melee range. Most ticks we just settle here and
        // attack. Two things can change that:
        //
        // 1. Mobs that aren't supposed to close (standback casters, leashed mobs, etc.) - we
        //    delegate to ShouldCloseToTarget for that decision.
        // 2. The navmesh path to the target is much longer than the straight-line distance -
        //    e.g. the target is across a thin gap we can see across but can't walk across. In
        //    that case we'd rather walk the long way around than auto-attack across the gap.
        //
        // Probing the second case requires actually building the path so we can measure it; we
        // skip the probe entirely for mobs that wouldn't follow it anyway (no speed / NO_MOVE,
        // or ShouldCloseToTarget says no), so we don't strand a path on a non-mobile mob.
        const bool canMove = PMob->GetSpeed() != 0 && PMob->getMobMod(MOBMOD_NO_MOVE) == 0 && m_Tick >= m_LastSpecialTime;
        if (!canMove || !ShouldCloseToTarget(currentDistance))
        {
            LookAtTarget();
            return;
        }

        // Probe whether the navmesh path to the target is direct (no long detour around a wall).
        // Re-run the probe only when the target entity changed or either party has moved far
        // enough that the result could differ. Settled melee mobs otherwise re-use the last
        // cached result so we don't pay a full findPath query every tick.
        const bool targetChanged = PTarget != lastDirectProbeTarget_;
        const bool mobMoved      = !isWithinDistance(lastDirectProbePos_, PMob->loc.p, 1.0f);
        const bool targetMoved   = !isWithinDistance(lastDirectProbeTargetPos_, PTarget->loc.p, 1.0f);
        if (targetChanged || mobMoved || targetMoved)
        {
            lastDirectProbeTarget_    = PTarget;
            lastDirectProbePos_       = PMob->loc.p;
            lastDirectProbeTargetPos_ = PTarget->loc.p;

            const auto projectedPosition = nearPosition(PTarget->loc.p, 0, rotationToRadian(worldAngle(PMob->loc.p, PTarget->loc.p)));
            PMob->PAI->PathFind->PathInRange(projectedPosition, closeDistance, PATHFLAG_RUN);
            lastDirectProbeWasDirect_ = PMob->PAI->PathFind->IsPathDirect();
            if (lastDirectProbeWasDirect_)
            {
                PMob->PAI->PathFind->Clear();
            }
        }

        // Direct path (or cached result from last probe): settle here and attack.
        // Non-direct: path is in place - fall through to FollowPath to walk the detour.
        if (lastDirectProbeWasDirect_)
        {
            LookAtTarget();
            return;
        }
    }

    // Movement is gated by speed, NO_MOVE, and special-action cooldowns.
    if (PMob->GetSpeed() == 0 || PMob->getMobMod(MOBMOD_NO_MOVE) != 0 || m_Tick < m_LastSpecialTime)
    {
        return;
    }

    // Teleport type 2: instant warp to target if within the skill's distance.
    if (PMob->getMobMod(MOBMOD_TELEPORT_TYPE) == 2)
    {
        if (const CMobSkill* teleportBegin = battleutils::GetMobSkill(PMob->getMobMod(MOBMOD_TELEPORT_START)))
        {
            if (currentDistance <= teleportBegin->getDistance())
            {
                MobSkill(PMob->targid, teleportBegin->getID(), std::nullopt);
                m_LastSpecialTime = m_Tick;
            }
        }
        return;
    }

    if (!ShouldCloseToTarget(currentDistance))
    {
        LookAtTarget();
        return;
    }

    // (Re)compute a path towards the target when needed.
    // - Already pathing: refresh if the destination has drifted from the target.
    //   (isWithinDistance compares against last frame's destination, so it can
    //    false-positive for where we want to be _now_.)
    // - Not pathing: build a path when out of range or LOS is lost. Rate-limited to avoid
    //   hammering findPath at 50 Hz when the mob is stuck at the navmesh boundary (path
    //   finished, target still out of reach). Allow immediate re-path if the target moved.
    //   After 2 consecutive cooldown-triggered failures to close range, teleport to the target
    //   so exploiters can't park mobs against unreachable terrain for free wins (~4s window).
    bool needNewPath   = false;
    bool isStuckRepath = false;
    if (isFollowingPath)
    {
        needNewPath = !isWithinDistance(PMob->PAI->PathFind->GetDestination(), PTarget->loc.p, kPathDestinationDriftThreshold);
    }
    else
    {
        const bool outOfRange   = currentDistance > attackRange;
        const bool lostLOS      = !CanSeeTargetCached();
        const bool targetMoved  = !isWithinDistance(lastRePathTarget_, PTarget->loc.p, kPathDestinationDriftThreshold);
        const bool cooldownDone = m_Tick >= rePathCooldownEnd_;
        needNewPath             = (outOfRange || lostLOS) && (targetMoved || cooldownDone);
        isStuckRepath           = needNewPath && !targetMoved && cooldownDone;
    }

    if (needNewPath)
    {
        lastRePathTarget_  = PTarget->loc.p;
        rePathCooldownEnd_ = m_Tick + 2s;

        if (isStuckRepath)
        {
            ++stuckRePathCount_;
        }
        else
        {
            stuckRePathCount_ = 0;
        }

        if (stuckRePathCount_ >= 2 && PMob->getMobMod(MOBMOD_NO_STUCK_TELEPORT) == 0)
        {
            PMob->PAI->PathFind->WarpTo(PTarget->loc.p, closeDistance);
            stuckRePathCount_  = 0;
            rePathCooldownEnd_ = timer::time_point::min();
        }
        else
        {
            const auto projectedPosition = nearPosition(PTarget->loc.p, 0, rotationToRadian(worldAngle(PMob->loc.p, PTarget->loc.p)));
            PMob->PAI->PathFind->PathInRange(projectedPosition, closeDistance, PATHFLAG_RUN);
        }
    }

    PMob->PAI->PathFind->FollowPath(m_Tick);

    if (PMob->PAI->PathFind->IsFollowingPath())
    {
        return;
    }

    // Arrived at the target. If another mob is stacked on top of us, shuffle aside.
    if (PTarget->objtype == TYPE_PC)
    {
        for (const auto& [_, PSpawnedMob] : static_cast<CCharEntity*>(PTarget)->SpawnMOBList)
        {
            if (PSpawnedMob == PMob ||
                PSpawnedMob->PAI->PathFind->IsFollowingPath() ||
                distance(PSpawnedMob->loc.p, PMob->loc.p) >= 1.0f)
            {
                continue;
            }

            const auto newPos = sidestepPosition(PMob->loc.p, PTarget->loc.p, 1.5f);
            if (PMob->PAI->PathFind->ValidPosition(newPos))
            {
                PMob->PAI->PathFind->PathTo(newPos, PATHFLAG_RUN);
                return;
            }
            break;
        }
    }

    // Corner case: mob attacking right at the ShouldCloseToTarget boundary - face target
    // so we don't end up turned away from them.
    LookAtTarget();
}

void CMobController::HandleEnmity()
{
    TracyZoneScoped;

    PMob->PEnmityContainer->DecayEnmity();
    auto* const PHighestEnmityTarget = PMob->PEnmityContainer->GetHighestEnmity();

    // SHARE_TARGET: copy the linked mob's battle target. Falls back to our own enmity list if the
    // share resolves to nothing.
    auto* const PShareSource = PMob->getMobMod(MOBMOD_SHARE_TARGET) > 0
                                   ? PMob->GetEntity(PMob->getMobMod(MOBMOD_SHARE_TARGET), TYPE_MOB)
                                   : nullptr;

    if (PShareSource)
    {
        ChangeTarget(static_cast<CMobEntity*>(PShareSource)->GetBattleTargetID());
    }
    if ((!PShareSource || !PMob->GetBattleTargetID()) && PHighestEnmityTarget)
    {
        ChangeTarget(PHighestEnmityTarget->targid);
    }

    // Bind special case: when bound and unable to reach our current target, retarget to the closest
    // attackable enmity owner instead.
    // TODO: do mobs with bind attack players *without* enmity if they are in the same party?
    // TODO: do jug pets do this?
    // TODO: this code assumes charmed mobs can do this -- they DO keep an enmity table, after all.
    const bool isBoundAndAttacking = PMob->objtype == TYPE_MOB &&
                                     PMob->StatusEffectContainer &&
                                     PMob->StatusEffectContainer->HasStatusEffect(EFFECT::EFFECT_BIND) &&
                                     PMob->PAI->IsCurrentState<CAttackState>();
    if (!isBoundAndAttacking)
    {
        return;
    }

    auto* const PClosestAttackable = [&]() -> CBattleEntity*
    {
        std::unique_ptr<CBasicPacket> errorMsg; // ignored

        if (!PTarget || PMob->CanAttack(PTarget, errorMsg) || !PMob->PEnmityContainer)
        {
            return nullptr;
        }

        CBattleEntity* PBest       = nullptr;
        float          minDistance = 999999.0f;
        int32          bestEnmity  = -1;

        for (const auto& [_, enmityObject] : *PMob->PEnmityContainer->GetEnmityList())
        {
            auto* const PEnmityOwner = enmityObject.PEnmityOwner;
            if (!PEnmityOwner)
            {
                continue;
            }

            const int32 totalEnmity = enmityObject.CE + enmityObject.VE;
            if (totalEnmity <= bestEnmity)
            {
                continue;
            }

            const float targetDistance = distance(PEnmityOwner->loc.p, PMob->loc.p);
            if (targetDistance >= minDistance || !PMob->CanAttack(PEnmityOwner, errorMsg))
            {
                continue;
            }

            PBest       = PEnmityOwner;
            minDistance = targetDistance;
            bestEnmity  = totalEnmity;
        }

        return PBest;
    }();

    if (PClosestAttackable)
    {
        ChangeTarget(PClosestAttackable->targid);
    }

    if (PTarget)
    {
        LookAtTarget(PTarget->targid);
    }
}

auto CMobController::DoRoamTick(timer::time_point tick) -> Task<void>
{
    TracyZoneScopedC(0x00FF00);

    const bool ignoreAggro = (PMob->m_roamFlags & ROAMFLAG_IGNORE) != 0;

    // Anyone on our enmity list pulls us straight into combat.
    if (auto* const PHighest = PMob->PEnmityContainer->GetHighestEnmity(); PHighest && !ignoreAggro)
    {
        Engage(PHighest->targid);
        co_return;
    }

    // I'm claimed by someone - engage them if they still exist.
    if (PMob->m_OwnerID.id != 0 && !ignoreAggro)
    {
        PTarget = static_cast<CBattleEntity*>(PMob->GetEntity(PMob->m_OwnerID.targid, TYPE_PC | TYPE_MOB | TYPE_PET | TYPE_TRUST));
        if (PTarget != nullptr)
        {
            Engage(PTarget->targid);
        }
        co_return;
    }

    // TODO: investigate
    if (PMob->GetDespawnTime() > timer::time_point::min() && PMob->GetDespawnTime() < m_Tick)
    {
        Despawn();
        co_return;
    }

    // Off-mesh guard: a mob that is off valid navmesh ground while IDLE should not exist. Two
    // exemptions:
    //   1) While it's following a path, do nothing - a path waypoint can momentarily read off-mesh on
    //      a poly seam (validPosition seam-strictness, not real clipping), and FollowPath will step it
    //      back on. Holding/despawning mid-path strands the mob: e.g. a long scripted pathTo whose
    //      chunk boundary lands on such a seam would freeze (or, before this guard honored NO_DESPAWN,
    //      despawn) at that chunk instead of continuing. A genuinely stuck mob still gets cleaned up:
    //      its chunked path eventually stalls and clears, after which this guard applies.
    //   2) NO_DESPAWN mobs are never auto-removed (matching the far-from-home branch below).
    // Arm a ~2-tick despawn timer otherwise.
    if (!PMob->PAI->PathFind->IsFollowingPath() && !PMob->PAI->PathFind->ValidPosition(PMob->loc.p))
    {
        const bool noDespawn = PMob->getMobMod(MOBMOD_NO_DESPAWN) != 0 || settings::get<bool>("map.MOB_NO_DESPAWN");
        if (!noDespawn && PMob->GetDespawnTime() == timer::time_point::min())
        {
            PMob->SetDespawnTime(200ms);
        }
        co_return;
    }

    // ROAMFLAG_IGNORE mobs never accept claim.
    if (ignoreAggro)
    {
        PMob->m_OwnerID.clean();
    }

    if (PFollowTarget != nullptr && m_followType == FollowType::Roam)
    {
        const float followRoamDistance = PMob->getMobMod(MOBMOD_FOLLOW_LEASH_RANGE) > 0 ? PMob->getMobMod(MOBMOD_FOLLOW_LEASH_RANGE) : 4.0f;

        // Only path to leader if they're moving
        if (distance(PMob->loc.p, PFollowTarget->loc.p) > followRoamDistance && PFollowTarget->PAI->PathFind->IsFollowingPath())
        {
            const float followStopRange = PMob->getMobMod(MOBMOD_FOLLOW_STOP_RANGE) > 0 ? PMob->getMobMod(MOBMOD_FOLLOW_STOP_RANGE) : 2.0f;

            PMob->PAI->PathFind->PathAround(PFollowTarget->loc.p, followStopRange, PATHFLAG_RUN);
        }

        if (!PMob->PAI->PathFind->IsFollowingPath())
        {
            co_return;
        }
    }

    // Recover 10% HP and lose TP every 10s while idle.
    if (m_Tick >= m_mobHealTime + 10s && PMob->getMobMod(MOBMOD_NO_REST) == 0 && PMob->CanRest())
    {
        if (PMob->Rest(0.1f))
        {
            PMob->updatemask |= UPDATE_HP;
        }

        // At full HP, clear "dirty" exp tracking so the next engagement starts fresh.
        if (PMob->GetHPP() == 100)
        {
            PMob->m_HiPCLvl     = 0;
            PMob->m_HiPartySize = 0;
            PMob->m_giveExp     = true;
            PMob->m_UsedSkillIds.clear();
        }
        m_mobHealTime = m_Tick;
    }

    //
    // Roam tick body
    //

    // Skip everything below until the wait timer elapses (e.g. after a special move).
    if (m_Tick < m_WaitTime)
    {
        if (m_Tick >= m_LastRoamScript + 3s)
        {
            PMob->PAI->EventHandler.triggerListener("ROAM_TICK", PMob);
            luautils::OnMobRoam(PMob);
            m_LastRoamScript = m_Tick;
        }
        co_return;
    }

    // Don't aggro for ~10s after disengaging.
    PMob->m_neutral = PMob->CanBeNeutral() && m_Tick <= m_NeutralTime + 10s;

    // If we already have a roam path going, just keep walking it.
    if (PMob->PAI->PathFind->IsFollowingPath())
    {
        FollowRoamPath();
    }
    else if (PMob->PAI->PathFind->IsPatrolling())
    {
        PMob->PAI->PathFind->ResumePatrol();
        FollowRoamPath();
    }
    else if (m_Tick >= m_LastActionTime + std::chrono::seconds(PMob->getMobMod(MOBMOD_ROAM_COOL)))
    {
        if (PMob->GetCallForHelpFlag())
        {
            PMob->SetCallForHelpFlag(false);
        }

        PMob->m_IsPathingHome = false;

        const bool wantsToHeadHome = !PMob->getMobMod(MOBMOD_DONT_ROAM_HOME) && PMob->IsFarFromHome();
        const bool noDespawn       = PMob->getMobMod(MOBMOD_NO_DESPAWN) != 0;

        // Walk home or despawn after wandering too far.
        if (wantsToHeadHome)
        {
            if (PMob->CanRoamHome())
            {
                PMob->m_IsPathingHome = true;

                if (!PMob->PAI->PathFind->IsFollowingPath() && !PMob->PAI->PathFind->PathTo(PMob->m_SpawnPoint))
                {
                    PMob->PAI->PathFind->PathInRange(PMob->m_SpawnPoint, PMob->m_maxRoamDistance, PATHFLAG_RUN);
                }

                // Cap the path so we re-evaluate every few seconds instead of bee-lining home.
                PMob->PAI->PathFind->LimitDistance(kRoamHomeStepDistance);
                FollowRoamPath();

                // Re-trigger the "head home" pulse roughly every 5 seconds.
                m_LastActionTime = m_Tick - (std::chrono::seconds(PMob->getMobMod(MOBMOD_ROAM_COOL)) + 10s);
            }
            else if (!noDespawn && !settings::get<bool>("map.MOB_NO_DESPAWN"))
            {
                PMob->PAI->Despawn();

                // Override CDespawnState's deaggro respawn timer (60s instead of default).
                PMob->loc.zone->spawnHandler()->registerForRespawn(PMob, 60s);
                co_return;
            }
        }
        // At/near home: despawn dead-master pets, otherwise pick an idle action.
        else if (!noDespawn && PMob->PMaster != nullptr && !PMob->PMaster->isAlive())
        {
            PMob->PAI->Despawn();
            co_return;
        }
        else
        {
            // Hiding mobs are now handled via mixin, so ROAMFLAG_AMBUSH is no longer special-cased here.
            const bool battlefieldIsOpen = PMob->PBattlefield && PMob->PBattlefield->GetStatus() == BATTLEFIELD_STATUS_OPEN;
            const bool wantsSummon       = !battlefieldIsOpen &&
                                     PMob->GetMJob() == JOB_SMN &&
                                     CanCastSpells(IgnoreRecastsAndCosts::No) &&
                                     PMob->SpellContainer->HasBuffSpells() &&
                                     m_Tick >= m_nextMagicTime;
            const bool wantsRandomBuff = CanCastSpells(IgnoreRecastsAndCosts::No) &&
                                         xirand::GetRandomNumber(10) < 3 &&
                                         PMob->SpellContainer->HasBuffSpells();

            if (IsSpecialSkillReady(0) && TrySpecialSkill())
            {
                // (Probably) spawned a pet via special skill.
            }
            else if (wantsSummon)
            {
                // Summon pet. The very first summoner-mob pet inside a battlefield is spawned via
                // battlefield.lua so the first player sees the action; once the battlefield locks,
                // pet summoning falls back to this normal path with no extra rng.
                TryCastSpell();
            }
            else if (wantsRandomBuff)
            {
                TryCastSpell();
            }
            else if (PMob->m_roamFlags & ROAMFLAG_SCRIPTED)
            {
                // TODO: What is this tag?
                // TODO: #AIToScript - let scripts handle the roam action entirely.
                PMob->PAI->EventHandler.triggerListener("ROAM_ACTION", PMob);
                luautils::OnMobRoamAction(PMob);
                m_LastActionTime = m_Tick;
            }
            else if (PMob->CanRoam())
            {
                // Worm: dive underground. Don't reset m_LastActionTime so we re-emerge promptly.
                const bool isWormSurfacing = (PMob->m_roamFlags & ROAMFLAG_WORM) && !PMob->IsNameHidden();
                if (isWormSurfacing && !PMob->PAI->IsCurrentState<CMagicState>())
                {
                    PMob->animationsub = 1;
                    PMob->HideName(true);
                    PMob->SetUntargetable(true);

                    // Sinking takes 2s; pad to 3s to let in-flight magic finish.
                    Wait(3s);
                    PMob->PAI->QueueAction(
                        queueAction_t(
                            3s,
                            false,
                            [](CBaseEntity* MobEntity)
                            {
                                MobEntity->status = STATUS_TYPE::INVISIBLE;
                            }));
                }
                else if (!isWormSurfacing &&
                         PMob->PAI->PathFind->RoamAround(PMob->m_SpawnPoint, PMob->GetRoamDistance(), static_cast<uint8>(PMob->getMobMod(MOBMOD_ROAM_TURNS)), PMob->m_roamFlags))
                {
                    if (PMob->m_roamFlags & ROAMFLAG_STEALTH)
                    {
                        PMob->HideName(true);
                        PMob->SetUntargetable(true);
                        PMob->updatemask |= UPDATE_HP;
                    }
                    else
                    {
                        FollowRoamPath();
                    }
                }
                else
                {
                    m_LastActionTime = m_Tick;
                }
            }
            else
            {
                m_LastActionTime = m_Tick;
            }
        }
    }

    if (m_Tick >= m_LastRoamScript + 3s)
    {
        PMob->PAI->EventHandler.triggerListener("ROAM_TICK", PMob);
        luautils::OnMobRoam(PMob);
        m_LastRoamScript = m_Tick;
    }

    co_return;
}

void CMobController::Wait(timer::duration duration)
{
    if (m_Tick > m_WaitTime)
    {
        m_WaitTime = m_Tick += duration;
    }
    else
    {
        m_WaitTime += duration;
    }
}

void CMobController::FollowRoamPath()
{
    TracyZoneScoped;

    if (!PMob->PAI->CanFollowPath())
    {
        return;
    }

    PMob->PAI->PathFind->FollowPath(m_Tick);

    // Pets shadow their roaming master at ~2.1y directly behind.
    auto* const PPet = PMob->PPet;
    if (PPet != nullptr && PPet->PAI->IsSpawned() && !PPet->PAI->IsEngaged())
    {
        const auto targetPoint = nearPosition(PMob->loc.p, 2.1f, static_cast<float>(M_PI));
        PPet->PAI->PathFind->PathTo(targetPoint);
    }

    // Path just finished this tick: schedule the next wander and handle worm/spawn-rotation cases.
    if (!PMob->PAI->PathFind->IsFollowingPath())
    {
        const uint32 roamRandomness = std::clamp<uint32>(static_cast<uint16>(PMob->getMobMod(MOBMOD_ROAM_COOL) * 1000 / PMob->GetRoamRate()), 0, 120 * 1000);
        m_LastActionTime            = m_Tick - std::chrono::milliseconds(xirand::GetRandomNumber(roamRandomness));

        // Worm finished its underground roam - pop back up.
        if ((PMob->m_roamFlags & ROAMFLAG_WORM) && PMob->PAI->IsUntargetable())
        {
            // Send a final position update before emerging so we don't visibly snap.
            PMob->loc.zone->UpdateEntityPacket(PMob, ENTITY_UPDATE, UPDATE_POS);

            // Lock further roaming until emerge animation completes.
            PMob->status = STATUS_TYPE::UPDATE;
            PMob->SetUntargetable(false);
            Wait(2s);
            PMob->PAI->QueueAction(
                queueAction_t(
                    2s,
                    false,
                    [](CBaseEntity* MobEntity)
                    {
                        MobEntity->animationsub = 0;
                        MobEntity->HideName(false);
                    }));
        }

        // Snap to spawn rotation when we finish a path back near the spawn point. Used by dynamis /
        // BCNM mobs that should always face a fixed direction at their spawn.
        if (PMob->getMobMod(MOBMOD_ROAM_RESET_FACING) && distance(PMob->loc.p, PMob->m_SpawnPoint) <= PMob->m_maxRoamDistance)
        {
            PMob->loc.p.rotation = PMob->m_SpawnPoint.rotation;
        }
    }

    if (PMob->PAI->PathFind->OnPoint())
    {
        PMob->PAI->EventHandler.triggerListener("PATH", PMob);
        luautils::OnPath(PMob);
    }
}

void CMobController::Despawn()
{
    TracyZoneScoped;

    if (PMob)
    {
        PMob->PAI->Internal_Despawn();
    }
}

void CMobController::Reset()
{
    TracyZoneScoped;

    // Wait a little before roaming / casting spell / spawning pet
    m_LastActionTime = m_Tick - std::chrono::seconds(xirand::GetRandomNumber(PMob->getMobMod(MOBMOD_ROAM_COOL)));

    // Don't attack player right off of spawn
    PMob->m_neutral = true;
    m_NeutralTime   = m_Tick;

    PTarget = nullptr;
    ClearFollowTarget();

    // Clear pathing state so a respawned mob doesn't inherit stale re-path / direct-probe caches.
    rePathCooldownEnd_ = timer::time_point::min();
    lastRePathTarget_  = {};
    stuckRePathCount_  = 0;

    lastDirectProbeTarget_    = nullptr;
    lastDirectProbePos_       = {};
    lastDirectProbeTargetPos_ = {};
    lastDirectProbeWasDirect_ = true;
}

auto CMobController::MobSkill(const uint16 targid, uint16 wsid, Maybe<timer::duration> castTimeOverride) -> bool
{
    TracyZoneScoped;

    if (!POwner)
    {
        return false;
    }

    LookAtTarget(targid);
    PMob->PAI->EventHandler.triggerListener("WEAPONSKILL_BEFORE_USE", PMob, wsid);
    return POwner->PAI->Internal_MobSkill(targid, wsid, castTimeOverride);
}

auto CMobController::Disengage() -> bool
{
    TracyZoneScoped;

    // this will let me decide to walk home or despawn
    m_LastActionTime = m_Tick - std::chrono::seconds(PMob->getMobMod(MOBMOD_ROAM_COOL)) + 10s;
    PMob->m_neutral  = true;
    m_NeutralTime    = m_Tick;

    rePathCooldownEnd_ = timer::time_point::min();
    lastRePathTarget_  = {};
    stuckRePathCount_  = 0;

    lastDirectProbeTarget_    = nullptr;
    lastDirectProbePos_       = {};
    lastDirectProbeTargetPos_ = {};
    lastDirectProbeWasDirect_ = true;

    PMob->PAI->PathFind->Clear();
    PMob->PEnmityContainer->Clear();

    if (PMob->getMobMod(MOBMOD_IDLE_DESPAWN))
    {
        PMob->SetDespawnTime(std::chrono::seconds(PMob->getMobMod(MOBMOD_IDLE_DESPAWN)));
    }

    PMob->m_OwnerID.clean();
    PMob->updatemask |= (UPDATE_STATUS | UPDATE_HP);
    PMob->SetCallForHelpFlag(false);
    PMob->animation = ANIMATION_NONE;
    // https://www.bluegartr.com/threads/108198-Random-Facts-Thread-Traits-and-Stats-(Player-and-Monster)?p=5670209&viewfull=1#post5670209
    PMob->m_THLvl          = 0;
    PMob->m_GilfinderLevel = 0; // Assumed to work like TH
    m_mobHealTime          = m_Tick;
    return CController::Disengage();
}

auto CMobController::Engage(const uint16 targid) -> bool
{
    TracyZoneScoped;

    const bool engaged = CController::Engage(targid);
    if (!engaged)
    {
        return false;
    }

    m_firstSpell        = true;
    rePathCooldownEnd_ = timer::time_point::min();
    lastRePathTarget_  = {};
    stuckRePathCount_  = 0;

    lastDirectProbeTarget_    = nullptr;
    lastDirectProbePos_       = {};
    lastDirectProbeTargetPos_ = {};
    lastDirectProbeWasDirect_ = true;

    if (PFollowTarget != nullptr && m_followType == FollowType::Roam)
    {
        ClearFollowTarget();
    }

    // Optional opening delays so we don't immediately cast / use a special ability on engage.
    if (PMob->getMobMod(MOBMOD_MAGIC_DELAY) != 0)
    {
        m_nextMagicTime = m_Tick + std::chrono::seconds(PMob->getMobMod(MOBMOD_MAGIC_COOL) + xirand::GetRandomNumber(PMob->getMobMod(MOBMOD_MAGIC_DELAY)));
    }

    if (PMob->getMobMod(MOBMOD_SPECIAL_DELAY) != 0)
    {
        m_LastSpecialTime = m_Tick - std::chrono::seconds(PMob->getMobMod(MOBMOD_SPECIAL_COOL) + xirand::GetRandomNumber(PMob->getMobMod(MOBMOD_SPECIAL_DELAY)));
    }

    m_tpThreshold = xirand::GetRandomNumber(1000, 3000);

    // Pet engages the same target.
    if (PMob->PPet && !PMob->PPet->PAI->IsEngaged())
    {
        PMob->PPet->PAI->Engage(targid);
    }

    return true;
}

auto CMobController::CanFollowTarget(CBattleEntity* PTarget) const -> bool
{
    return !PMob->m_neutral && (PMob->m_roamFlags & ROAMFLAG_FOLLOW) && PFollowTarget == nullptr && m_followType == FollowType::None && CanAggroTarget(PTarget);
}

auto CMobController::CanAggroTarget(CBattleEntity* PTarget) const -> bool
{
    TracyZoneScoped;
    TracyZoneString(PMob->getName());

    if (!PTarget)
    {
        return false;
    }
    TracyZoneString(PTarget->getName());

    if (PMob->getBattleID() != PTarget->getBattleID())
    {
        return false;
    }

    // I'm not in an aggressive state.
    const bool nonAggressive = (PMob->getMobMod(MOBMOD_ALWAYS_AGGRO) == 0 && !PMob->m_Aggro) || PMob->m_neutral || PMob->isDead();
    if (nonAggressive)
    {
        return false;
    }

    if (PMob->getMobMod(MOBMOD_NO_AGGRO) > 0)
    {
        return false;
    }

    // CoP Fomors only aggro players with sufficient FOMOR_HATE; NMs ignore this and always aggro.
    const bool isCopFomorZone = PMob->m_Family == 172 &&
                                !(PMob->m_Type & MOBTYPE_NOTORIOUS) &&
                                PMob->getZone() >= ZONE_LUFAISE_MEADOWS &&
                                PMob->getZone() <= ZONE_SACRARIUM;
    if (isCopFomorZone && PTarget->objtype == TYPE_PC && static_cast<CCharEntity*>(PTarget)->getCharVar("FOMOR_HATE") < 8)
    {
        return false;
    }

    // Worms underground can't aggro anything.
    if ((PMob->m_roamFlags & ROAMFLAG_WORM) && PMob->IsNameHidden())
    {
        return false;
    }

    if (PTarget->isDead() || PTarget->isMounted())
    {
        return false;
    }

    return PMob->PMaster == nullptr && PMob->PAI->IsSpawned() && !PMob->PAI->IsEngaged() && CanDetectTarget(PTarget);
}

void CMobController::TapDeaggroTime()
{
    m_DeaggroTime = m_Tick;
}

void CMobController::TapDeclaimTime()
{
    m_DeclaimTime = m_Tick;
}

auto CMobController::Cast(const uint16 targid, const SpellID spellid) -> bool
{
    TracyZoneScoped;

    LookAtTarget(targid);
    return CController::Cast(targid, spellid);
}

void CMobController::SetFollowTarget(CBaseEntity* PTarget, const FollowType followType)
{
    if (PFollowTarget == PTarget && m_followType == followType)
    {
        return;
    }

    if (PTarget != nullptr)
    {
        luautils::OnMobFollow(PMob, PTarget);
    }
    else if (m_followType == FollowType::Roam)
    {
        PMob->m_neutral = true;
        m_NeutralTime   = m_Tick + 30s;
        luautils::OnMobUnfollow(PMob, PFollowTarget);
        if (PMob->health.hp == PMob->GetMaxHP())
        {
            PMob->m_OwnerID.clean();
            PMob->PEnmityContainer->Clear();
        }
    }

    PFollowTarget = PTarget;
    m_followType  = followType;
}

auto CMobController::HasFollowTarget() const -> bool
{
    return PFollowTarget != nullptr && m_followType != FollowType::None;
}

void CMobController::ClearFollowTarget()
{
    PFollowTarget = nullptr;
    m_followType  = FollowType::None;
}

void CMobController::OnCastStopped(CMagicState& state, action_t& action)
{
    const int32 magicCool = PMob->getMobMod(MOBMOD_MAGIC_COOL);
    m_nextMagicTime       = m_Tick + std::chrono::seconds(xirand::GetRandomNumber(magicCool / 2, magicCool));
}

auto CMobController::ShouldCloseToTarget(const float currentDistance) -> bool
{
    TracyZoneScoped;

    // Each LOS check below routes through CanSeeTargetCached() and is intentionally placed last
    // in its && / || chain so the cheap distance/state predicates short-circuit it away in the
    // common case. When the cache does fire, it shares a single raycast with the rest of the
    // tick (e.g. Move()'s callsites).

    const auto standbackRangeMod            = PMob->getMobMod(MOBMOD_STANDBACK_RANGE);
    const auto standbackHpThreshold         = PMob->getMobMod(MOBMOD_HP_STANDBACK);
    const auto standbackRange               = standbackRangeMod > 0 ? static_cast<uint16>(standbackRangeMod) : uint16{ 20 };
    const bool isClosingToRangedAttackRange = IsRangedAttackEnabled() && currentDistance > PMob->GetRangedAttackRange();
    const bool isInsideStandbackRange       = !isClosingToRangedAttackRange && currentDistance < standbackRange;

    // Behavior-flag standback: hold position while we have line of sight to the target.
    if (isInsideStandbackRange && (PMob->m_Behavior & BEHAVIOR_STANDBACK) && CanSeeTargetCached())
    {
        return false;
    }

    // HP/MP-threshold standback: a healthy caster mob prefers to stay back and cast.
    const bool wantsHealthStandback = isInsideStandbackRange &&
                                      standbackHpThreshold > 0 &&
                                      PMob->getMobMod(MOBMOD_NO_STANDBACK) == 0 &&
                                      PMob->GetHPP() >= standbackHpThreshold &&
                                      (PMob->GetMaxMP() == 0 || PMob->GetMPP() >= standbackHpThreshold);
    if (wantsHealthStandback)
    {
        // Excluding NINs, mobs should not stand back if they can't actually cast something useful.
        return PMob->GetMJob() != JOB_NIN && PMob->SpellContainer->HasSpells() && !CanCastSpells(IgnoreRecastsAndCosts::Yes);
    }

    // Lost line of sight: close in regardless of leash.
    if (PTarget && !CanSeeTargetCached())
    {
        return true;
    }

    // Spawn leash: don't chase past the configured tether distance.
    if (PMob->getMobMod(MOBMOD_SPAWN_LEASH) > 0 && distance(PMob->loc.p, PMob->m_SpawnPoint) > PMob->getMobMod(MOBMOD_SPAWN_LEASH))
    {
        return false;
    }

    return true;
}

auto CMobController::CanSeeTargetCached() -> bool
{
    // No target -> no LOS. We also avoid emplacing the cache for a null target so the next
    // tick's first call against a real target establishes a fresh entry.
    if (!PTarget)
    {
        return false;
    }

    // If the cached entry is for a different target (e.g. retargeting mid-tick), wipe both
    // fields together via the wrapping Maybe so we never serve stale data.
    if (!targetLosCache_.has_value() || targetLosCache_->target != PTarget)
    {
        targetLosCache_.emplace(TargetLOSCache{ PTarget, {} });
    }

    return targetLosCache_->canSeeTarget.getOrCompute(
        [&]()
        {
            return PMob->CanSeeTarget(PTarget);
        });
}

auto CMobController::IsSpecialSkillReady(const float currentDistance) const -> bool
{
    TracyZoneScoped;

    if (PMob->getMobMod(MOBMOD_SPECIAL_SKILL) == 0)
    {
        return false;
    }

    if (PMob->StatusEffectContainer->HasStatusEffect(EFFECT_CHAINSPELL))
    {
        return false;
    }

    // Mobs use ranged attacks quicker when standing back.
    const int32 bonusTime = currentDistance > 5 ? PMob->getMobMod(MOBMOD_STANDBACK_COOL) : 0;

    return m_Tick >= m_LastSpecialTime + std::chrono::seconds(PMob->getMobMod(MOBMOD_SPECIAL_COOL) - bonusTime);
}

auto CMobController::IsSpellReady(const float& currentDistance, const float& meleeRange) const -> bool
{
    TracyZoneScoped;

    if (PMob->StatusEffectContainer->HasStatusEffect({ EFFECT_CHAINSPELL, EFFECT_MANAFONT }))
    {
        return true;
    }

    // Worms don't cast in melee range (typically.) The edge cases can be scripted.
    if (PMob->m_roamFlags & ROAMFLAG_WORM && currentDistance <= meleeRange)
    {
        return false;
    }

    if (currentDistance > 5 && (PMob->m_roamFlags & ROAMFLAG_WORM) == 0)
    {
        // Mobs use magic quicker when standing back
        return m_Tick >= (m_nextMagicTime - std::chrono::seconds(PMob->getMobMod(MOBMOD_STANDBACK_COOL)));
    }

    return m_Tick >= m_nextMagicTime;
}
