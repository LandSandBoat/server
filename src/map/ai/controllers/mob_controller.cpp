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
#include "data/enums/detects.h"
#include "data/enums/mob_mod.h"
#include "enmity_container.h"
#include "entities/mob_entity.h"
#include "mob_spell_container.h"
#include "mobskill.h"
#include "party.h"
#include "recast_container.h"
#include "roam_region.h"
#include "spawn_handler.h"
#include "status_effect_container.h"
#include "utils/battleutils.h"
#include "utils/petutils.h"
#include "zone.h"

namespace
{

// Distance walked toward spawn per roam-home tick before re-evaluating.
constexpr float kRoamHomeStepDistance = 10.0f;

// A mob notices nobody for this long after spawning or losing its target.
constexpr auto kNeutralDuration = 15s;

} // namespace

CMobController::CMobController(CMobEntity* PEntity)
: CController(PEntity)
, PMob(PEntity)
{
}

auto CMobController::target() const -> EntityId
{
    return target_;
}

void CMobController::setTarget(CBaseEntity* PTarget)
{
    target_ = EntityId(PTarget);
}

auto CMobController::followTarget() const -> CBaseEntity*
{
    return followTarget_.resolve();
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
    else if (!PMob->isDead())
    {
        if (PMob->SpellContainer->HasSpells() && !PMob->PAI->PathFind->IsPatrolling() && DoBuffTick())
        {
            co_return;
        }

        co_await DoRoamTick(tick);
    }

    co_return;
}

auto CMobController::Disengage() -> bool
{
    TracyZoneScoped;

    // this will let me decide to walk home or despawn
    m_LastActionTime = m_Tick - std::chrono::seconds(PMob->getMobMod(xi::MobMod::RoamCool)) + 10s;
    PMob->m_neutral  = true;
    m_NeutralTime    = m_Tick;

    rePathCooldownEnd_ = timer::time_point::min();
    lastRePathTarget_  = {};
    stuckRePathCount_  = 0;

    lastDirectProbeTarget_.clean();
    lastDirectProbePos_       = {};
    lastDirectProbeTargetPos_ = {};
    lastDirectProbeWasDirect_ = true;

    PMob->PAI->PathFind->Clear();
    PMob->PEnmityContainer->Clear();

    if (PMob->getMobMod(xi::MobMod::IdleDespawn))
    {
        PMob->SetDespawnTime(std::chrono::seconds(PMob->getMobMod(xi::MobMod::IdleDespawn)));
    }

    PMob->m_OwnerID.clean();
    PMob->updatemask |= (UPDATE_STATUS | UPDATE_HP);
    PMob->SetCallForHelpFlag(false);
    PMob->animation = xi::Animation::None;
    // https://www.bluegartr.com/threads/108198-Random-Facts-Thread-Traits-and-Stats-(Player-and-Monster)?p=5670209&viewfull=1#post5670209
    PMob->m_THLvl          = 0;
    PMob->m_GilfinderLevel = 0; // Assumed to work like TH
    m_mobHealTime          = m_Tick;
    return CController::Disengage();
}

auto CMobController::Engage(const EntityId& target) -> bool
{
    TracyZoneScoped;

    auto* PFollowTarget = followTarget();

    const bool engaged = CController::Engage(target);
    if (!engaged)
    {
        return false;
    }

    m_firstSpell       = true;
    rePathCooldownEnd_ = timer::time_point::min();
    lastRePathTarget_  = {};
    stuckRePathCount_  = 0;

    lastDirectProbeTarget_.clean();
    lastDirectProbePos_       = {};
    lastDirectProbeTargetPos_ = {};
    lastDirectProbeWasDirect_ = true;

    if (PFollowTarget != nullptr && m_followType == FollowType::Roam)
    {
        ClearFollowTarget();
    }

    // Optional opening delays so we don't immediately cast / use a special ability on engage.
    if (PMob->getMobMod(xi::MobMod::MagicDelay) != 0)
    {
        m_nextMagicTime = m_Tick + std::chrono::seconds(PMob->getMobMod(xi::MobMod::MagicCool) + xirand::GetRandomNumber(PMob->getMobMod(xi::MobMod::MagicDelay)));
    }

    if (PMob->getMobMod(xi::MobMod::SpecialDelay) != 0)
    {
        m_LastSpecialTime = m_Tick - std::chrono::seconds(PMob->getMobMod(xi::MobMod::SpecialCool) + xirand::GetRandomNumber(PMob->getMobMod(xi::MobMod::SpecialDelay)));
    }

    m_tpThreshold = xirand::GetRandomNumber(1000, 3000);

    // Pet engages the same target.
    if (PMob->PPet && !PMob->PPet->PAI->IsEngaged())
    {
        PMob->PPet->PAI->Engage(target);
    }

    return true;
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

    // Wait a little while before roaming again.
    m_LastActionTime = m_Tick - std::chrono::seconds(xirand::GetRandomNumber(PMob->getMobMod(xi::MobMod::RoamCool)));

    // Don't attack player right off of spawn
    PMob->m_neutral = true;
    m_NeutralTime   = m_Tick;

    setTarget(nullptr);
    ClearFollowTarget();

    // Clear pathing state so a respawned mob doesn't inherit stale re-path / direct-probe caches.
    rePathCooldownEnd_ = timer::time_point::min();
    lastRePathTarget_  = {};
    stuckRePathCount_  = 0;

    lastDirectProbeTarget_.clean();
    lastDirectProbePos_       = {};
    lastDirectProbeTargetPos_ = {};
    lastDirectProbeWasDirect_ = true;
}

auto CMobController::MobSkill(const EntityId target, uint16 wsid, const Maybe<timer::duration> castTimeOverride) -> bool
{
    TracyZoneScoped;

    if (!POwner)
    {
        return false;
    }

    FaceTarget(target);
    PMob->PAI->EventHandler.triggerListener("WEAPONSKILL_BEFORE_USE", PMob, wsid);
    return POwner->PAI->Internal_MobSkill(target, wsid, castTimeOverride);
}

auto CMobController::Ability(const EntityId target, uint16 abilityid) -> bool
{
    if (PMob->PRecastContainer->HasRecast(RECAST_ABILITY, static_cast<Recast>(abilityid), 0s))
    {
        return false;
    }

    if (!POwner->PAI->CanChangeState())
    {
        return false;
    }

    return POwner->PAI->Internal_Ability(target, abilityid);
}

auto CMobController::MobSkill(int listId) -> bool
{
    TracyZoneScoped;

    auto* PTarget = target().resolve<CBattleEntity>();

    if (!PTarget)
    {
        return false;
    }

    // Fall back to the mob's default skill list if the caller didn't pick one.
    const auto resolvedListId = [&]() -> int
    {
        if (listId != 0)
        {
            return listId;
        }

        return PMob->getMobMod(xi::MobMod::SkillList);
    }();

    auto skillList = battleutils::GetMobSkillList(resolvedListId);
    std::erase_if(skillList,
                  [&](const uint16 skillId)
                  {
                      if (battleutils::GetMobSkill(skillId) != nullptr)
                      {
                          return false;
                      }
                      ShowError("Mobskill with ID (%i) [called from skill-list ID (%i)] isn't properly defined in mob_skills.sql", skillId, resolvedListId);
                      return true;
                  });
    if (skillList.empty())
    {
        return false;
    }
    std::shuffle(skillList.begin(), skillList.end(), xirand::rng());

    // Lua may override the skill
    // We used that isntead of the shuffled list
    const auto overrideSkill = luautils::OnMobMobskillChoose(PMob, PTarget, skillList.front());
    if (overrideSkill > 0)
    {
        return TryMobSkill(overrideSkill, PTarget);
    }

    // Start at the top of the list after the shuffle, first one that returns 0 wins
    for (const auto skillId : skillList)
    {
        if (TryMobSkill(skillId, PTarget))
        {
            return true;
        }
    }

    return false;
}

// Try to use the given skill on the target
auto CMobController::TryMobSkill(const uint16 skillId, CBattleEntity* PTarget) -> bool
{
    auto* PMobSkill = battleutils::GetMobSkill(skillId);
    if (!PMobSkill || PMobSkill->isAstralFlow())
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

    if (!PActionTarget)
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

    const auto mobSkillReadyTime = luautils::OnMobSkillReadyTime(PActionTarget, PMob, PMobSkill);

    return MobSkill(PActionTarget->entityId(), PMobSkill->getID(), mobSkillReadyTime);
}

auto CMobController::TryCastSpell() -> bool
{
    TracyZoneScoped;

    auto* PTarget = target().resolve<CBattleEntity>();

    if (!CanCastSpells(IgnoreRecastsAndCosts::No))
    {
        return false; // Can't cast spells.
    }

    // Initial spell candidate; OnMobSpellChoose may override it below.
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

    // Cast target: Lua override wins, else self for self-targeted spells, else PTarget.
    auto* const PCastTarget = maybeTargetOverride.value_or((PSpell->getValidTarget() & TARGET_SELF) ? PMob : PTarget);
    if (PCastTarget && distance(PMob->loc.p, PCastTarget->loc.p) > PSpell->getRange() + PMob->modelHitboxSize + PCastTarget->modelHitboxSize)
    {
        return false; // Target out of range.
    }

    // Perform cast. If there is a valid target override, cast at that target, otherwise cast normally.
    // We need this because CastSpell has its own targetfind and PCastTarget is not used for it.
    if (maybeTargetOverride.has_value() && PCastTarget)
    {
        Cast(PCastTarget->entityId(), chosenSpellId.value());
    }
    else
    {
        CastSpell(chosenSpellId.value());
    }
    return true;
}

auto CMobController::TrySpecialSkill() -> bool
{
    TracyZoneScoped;

    auto* PTarget = target().resolve<CBattleEntity>();

    auto* const PSpecialSkill = battleutils::GetMobSkill(PMob->getMobMod(xi::MobMod::SpecialSkill));
    if (PSpecialSkill == nullptr)
    {
        ShowError("CAIMobDummy::ActionSpawn Special skill was set but not found! (%d)", PMob->getMobMod(xi::MobMod::SpecialSkill));
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

    // Ability target: self-targeted skills hit the mob, otherwise PTarget must be in range.
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

    if (!MobSkill(PAbilityTarget->entityId(), PSpecialSkill->getID(), std::nullopt))
    {
        return false;
    }

    m_LastSpecialTime = m_Tick;
    return true;
}

auto CMobController::CanFollowTarget(CBattleEntity* PTarget) const -> bool
{
    auto* PFollowTarget = followTarget();

    return !PMob->m_neutral && ((PMob->m_roamFlags & xi::RoamFlag::Follow) != xi::RoamFlag::None) && PFollowTarget == nullptr && m_followType == FollowType::None && CanAggroTarget(PTarget);
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
    const bool nonAggressive = (PMob->getMobMod(xi::MobMod::AlwaysAggro) == 0 && !PMob->m_Aggro) || PMob->m_neutral || PMob->isDead();
    if (nonAggressive)
    {
        return false;
    }

    if (PMob->getMobMod(xi::MobMod::NoAggro) > 0)
    {
        return false;
    }

    // CoP Fomors only aggro players with sufficient FOMOR_HATE; NMs ignore this and always aggro.
    const bool isCopFomorZone = PMob->m_Family == 172 &&
                                ((PMob->m_Type & xi::MobType::Notorious) == xi::MobType::Normal) &&
                                PMob->getZone() >= xi::ZoneId::LufaiseMeadows &&
                                PMob->getZone() <= xi::ZoneId::Sacrarium;
    if (isCopFomorZone && PTarget->objtype == TYPE_PC && static_cast<CCharEntity*>(PTarget)->getCharVar("FOMOR_HATE") < 8)
    {
        return false;
    }

    // Worms underground can't aggro anything.
    if (((PMob->m_roamFlags & xi::RoamFlag::Worm) != xi::RoamFlag::None) && PMob->IsNameHidden())
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

auto CMobController::Cast(const EntityId target, const SpellID spellid) -> bool
{
    TracyZoneScoped;

    FaceTarget(target);
    return CController::Cast(target, spellid);
}

void CMobController::SetFollowTarget(CBaseEntity* PTarget, const FollowType followType)
{
    auto* PFollowTarget = followTarget();

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

    followTarget_ = EntityId(PTarget);
    m_followType  = followType;
}

auto CMobController::HasFollowTarget() const -> bool
{
    auto* PFollowTarget = followTarget();

    return PFollowTarget != nullptr && m_followType != FollowType::None;
}

void CMobController::ClearFollowTarget()
{
    followTarget_.clean();
    m_followType = FollowType::None;
}

auto CMobController::CheckHide(const CBattleEntity* PTarget) const -> bool
{
    TracyZoneScoped;

    if (!PTarget || PTarget->GetMJob() != xi::Job::THF || !PTarget->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::Hide))
    {
        return false;
    }

    return !CanTrackByScent(PTarget) && !PMob->m_TrueDetection && (static_cast<xi::Detects>(PMob->getMobMod(xi::MobMod::Detection)) & xi::Detects::Hearing) == xi::Detects::None;
}

void CMobController::OnCastStopped(CMagicState& state, action_t& action)
{
    const int32 magicCool = PMob->getMobMod(xi::MobMod::MagicCool);
    m_nextMagicTime       = m_Tick + std::chrono::seconds(xirand::GetRandomNumber(magicCool / 2, magicCool));
}

auto CMobController::ShouldCloseToTarget(const float currentDistance) -> bool
{
    TracyZoneScoped;

    auto* PTarget = target().resolve<CBattleEntity>();

    // Each LOS check sits last in its chain so cheaper predicates short-circuit the shared raycast away.

    const auto standbackRangeMod    = PMob->getMobMod(xi::MobMod::StandbackRange);
    const auto standbackHpThreshold = PMob->getMobMod(xi::MobMod::HpStandback);
    const auto standbackRange       = [&]() -> uint16
    {
        if (standbackRangeMod > 0)
        {
            return static_cast<uint16>(standbackRangeMod);
        }

        return 20;
    }();
    const bool isClosingToRangedAttackRange = IsRangedAttackEnabled() && currentDistance > PMob->GetRangedAttackRange();
    const bool isInsideStandbackRange       = !isClosingToRangedAttackRange && currentDistance < standbackRange;

    // Behavior-flag standback: hold position while we have line of sight to the target.
    if (isInsideStandbackRange && ((PMob->m_Behavior & xi::Behavior::Standback) != xi::Behavior::None) && CanSeeTargetCached())
    {
        return false;
    }

    // HP/MP-threshold standback: a healthy caster mob prefers to stay back and cast.
    const bool wantsHealthStandback = isInsideStandbackRange &&
                                      standbackHpThreshold > 0 &&
                                      PMob->getMobMod(xi::MobMod::NoStandback) == 0 &&
                                      PMob->GetHPP() >= standbackHpThreshold &&
                                      (PMob->GetMaxMP() == 0 || PMob->GetMPP() >= standbackHpThreshold);
    if (wantsHealthStandback)
    {
        // Excluding NINs, mobs should not stand back if they can't actually cast something useful.
        return PMob->GetMJob() != xi::Job::NIN && PMob->SpellContainer->HasSpells() && !CanCastSpells(IgnoreRecastsAndCosts::Yes);
    }

    // Lost line of sight: close in regardless of leash.
    if (PTarget && !CanSeeTargetCached())
    {
        return true;
    }

    // Spawn leash: don't chase past the configured tether distance.
    if (PMob->getMobMod(xi::MobMod::SpawnLeash) > 0 && PMob->DistanceFromHome() > PMob->getMobMod(xi::MobMod::SpawnLeash))
    {
        return false;
    }

    return true;
}

auto CMobController::CanSeeTargetCached() -> bool
{
    auto* PTarget = target().resolve<CBattleEntity>();

    // No target means no LOS, and caching nothing lets the next real target start fresh.
    if (!PTarget)
    {
        return false;
    }

    // A different target wipes both cache fields at once, so we never serve a stale raycast.
    if (!targetLosCache_.has_value() || targetLosCache_->target != PTarget)
    {
        targetLosCache_.emplace(TargetLOSCache{ EntityId(PTarget), {} });
    }

    return targetLosCache_->canSeeTarget.getOrCompute(
        [&]()
        {
            return PMob->CanSeeTarget(PTarget);
        });
}

auto CMobController::TryDeaggro() -> bool
{
    TracyZoneScoped;

    auto* PTarget = target().resolve<CBattleEntity>();

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
        setTarget(PTarget);
        if (PTarget)
        {
            PMob->setBattleTarget(PTarget->entityId());
            // Reset deaggro time so that the mob is given time to actually try to path towards the new highest enmity target
            TapDeaggroTime();
        }
        else
        {
            PMob->setBattleTarget(std::nullopt);
        }

        return TryDeaggro();
    }

    return false;
}

auto CMobController::CanTrackByScent(const CBattleEntity* PTarget) const -> bool
{
    TracyZoneScoped;

    if ((static_cast<xi::Detects>(PMob->getMobMod(xi::MobMod::Detection)) & xi::Detects::Scent) == xi::Detects::None)
    {
        return false;
    }

    // Mobs underwater instantly deaggro if scent fails (deodorize / no target).
    if (PMob->PAI->PathFind->InWater() || !PTarget || PTarget->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::Deodorize))
    {
        return false;
    }

    // Certain weather / deodorize will turn on time deaggro.
    return !PMob->m_disableScent;
}

void CMobController::TryLink()
{
    TracyZoneScoped;

    auto* PTarget = target().resolve<CBattleEntity>();

    if (PTarget == nullptr)
    {
        return;
    }

    // Avatar pets defend their master, except Alexander, Odin and Atomos.
    const auto tryAvatarBodyguard = [&]()
    {
        if (PTarget->PPet == nullptr || PTarget->PPet->battleTarget().isSet() || PTarget->PPet->objtype != TYPE_PET)
        {
            return;
        }

        const auto* PPetEntity         = static_cast<CPetEntity*>(PTarget->PPet);
        const bool  isProtectiveAvatar = PPetEntity->getPetType() == PET_TYPE::AVATAR &&
                                         PPetEntity->petID() != PETID_ALEXANDER &&
                                         PPetEntity->petID() != PETID_ODIN &&
                                         PPetEntity->petID() != PETID_ATOMOS;
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
            else
            {
                petutils::AttackTarget(PTarget, PMob);
            }
        }

        petutils::AttackTarget(PTarget, PMob);
    };
    tryAvatarBodyguard();

    // My pet should help as well.
    if (PMob->PPet != nullptr && PMob->PPet->PAI->IsRoaming())
    {
        PMob->PPet->PAI->Engage(PTarget->entityId());
    }

    // Throttle the party scan to every other tick; it is the hot part of TryLink.
    linkScanThisTick_ = !linkScanThisTick_;
    if (linkScanThisTick_ &&
        PMob->PParty != nullptr &&
        PMob->PParty->members.size() > 1 &&
        !PMob->getMobMod(xi::MobMod::OneWayLinking))
    {
        for (auto* member : PMob->PParty->members)
        {
            // Mob link parties only contain mobs; objtype-gate then static_cast to avoid a
            // per-member dynamic_cast in this hot loop.
            if (member->objtype != TYPE_MOB)
            {
                continue;
            }
            auto* PPartyMember = static_cast<CMobEntity*>(member);

            // Pets only link with their masters, never with the rest of the party.
            if (PPartyMember->PMaster || PPartyMember->isDead())
            {
                continue;
            }

            // Skip same-family party members unless this mob wants to link with kin.
            const bool sameFamilyButNoSelfLink = PMob->m_Family == PPartyMember->m_Family && !PMob->ShouldForceLink() && !PMob->m_Link;
            if (sameFamilyButNoSelfLink)
            {
                continue;
            }

            if (PPartyMember->PAI->IsRoaming() && PPartyMember->CanLink(&PMob->loc.p, PMob->getMobMod(xi::MobMod::Superlink)))
            {
                PPartyMember->PAI->Engage(PTarget->entityId());
            }
        }
    }

    // Ask my master for help.
    if (PMob->PMaster != nullptr && PMob->PMaster->PAI->IsRoaming())
    {
        auto* PMaster = static_cast<CMobEntity*>(PMob->PMaster);
        if (PMaster->CanLink(&PMob->loc.p, PMob->getMobMod(xi::MobMod::Superlink)))
        {
            PMaster->PAI->Engage(PTarget->entityId());
        }
    }
}

/**
 * Checks if the mob can detect the target using it's detection (sight, sound, etc)
 * This is used to aggro and deaggro (Mobs start to deaggro after failing to detect target).
 **/
auto CMobController::CanDetectTarget(CBattleEntity* PTarget, const bool forceSight) const -> bool
{
    TracyZoneScoped;

    if (!PTarget || PTarget->isDead() || PTarget->isMounted())
    {
        return false;
    }

    const auto detects         = static_cast<xi::Detects>(PMob->getMobMod(xi::MobMod::Detection));
    const auto currentDistance = distance(PTarget->loc.p, PMob->loc.p);
    const bool detectSight     = ((detects & xi::Detects::Sight) != xi::Detects::None) || forceSight;

    // Illusion overrides true detection, but mobs that see through it still respect real sneak.
    const auto [hasInvisible, hasSneak] = [&]() -> std::pair<bool, bool>
    {
        bool invisible = false;
        bool sneak     = false;

        if (!PMob->m_TrueDetection)
        {
            invisible = PTarget->StatusEffectContainer->HasStatusEffectByFlag(xi::StatusEffectFlag::Invisible);
            sneak     = PTarget->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::Sneak);
        }

        const bool hasIllusion = PTarget->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::Illusion);
        if (hasIllusion && !PMob->getMobMod(xi::MobMod::SeesThroughIllusion))
        {
            invisible = true;
            sneak     = true;
        }

        return { invisible, sneak };
    }();

    // If this is already our battle target and we're in melee range, detection bypasses LOS.
    const bool isTargetAndInRange = PMob->battleTarget() == PTarget && currentDistance <= PMob->GetMeleeRange(PTarget);

    const auto detected = [&]() -> bool
    {
        return isTargetAndInRange || PMob->CanSeeTarget(PTarget);
    };

    if (detectSight && !hasInvisible && currentDistance < PMob->getMobMod(xi::MobMod::SightRange) && facing(PMob->loc.p, PTarget->loc.p, 64))
    {
        return detected();
    }

    if (((PMob->m_Behavior & xi::Behavior::AggroAmbush) != xi::Behavior::None) && currentDistance < 3 && !hasSneak)
    {
        return true;
    }

    if (((detects & xi::Detects::Hearing) != xi::Detects::None) && currentDistance < PMob->getMobMod(xi::MobMod::SoundRange) && !hasSneak)
    {
        return detected();
    }

    const bool detectMagicCast = ((detects & xi::Detects::Magic) != xi::Detects::None) &&
                                 currentDistance < PMob->getMobMod(xi::MobMod::MagicRange) &&
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

    if (((detects & xi::Detects::Lowhp) != xi::Detects::None) && PTarget->GetHPP() < 75)
    {
        return detected();
    }

    if (((detects & xi::Detects::Ability) != xi::Detects::None) &&
        (PTarget->PAI->IsCurrentState<CWeaponSkillState>() || PTarget->PAI->IsCurrentState<CAbilityState>()))
    {
        return detected();
    }

    return false;
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

    const bool isImmobilised = PMob->StatusEffectContainer->HasStatusEffect({ xi::StatusEffect::Bind, xi::StatusEffect::SleepI, xi::StatusEffect::SleepIi, xi::StatusEffect::Lullaby, xi::StatusEffect::Petrification });
    if (CanTrackByScent(PTarget) || CanDetectTarget(PTarget) || isImmobilised)
    {
        TapDeaggroTime();
    }

    const auto additionalDeaggroTime = [&]() -> std::chrono::seconds
    {
        if ((PMob->m_roamFlags & xi::RoamFlag::Worm) != xi::RoamFlag::None)
        {
            return std::chrono::seconds(0);
        }
        return std::chrono::seconds(settings::get<uint32>("map.MOB_ADDITIONAL_TIME_TO_DEAGGRO"));
    }();

    return PMob->CanDeaggro() && (m_Tick >= m_DeaggroTime + 25s + additionalDeaggroTime);
}

auto CMobController::CanCastSpells(IgnoreRecastsAndCosts ignoreRecastsAndCosts) -> bool
{
    TracyZoneScoped;

    if (!PMob->SpellContainer->HasSpells())
    {
        return false;
    }

    // Spell blockers (silence, mute).
    if (PMob->StatusEffectContainer->HasStatusEffect({ xi::StatusEffect::Silence, xi::StatusEffect::Mute }))
    {
        return false;
    }

    // SMN can only cast while pet-less.
    const bool smnHasLivePet = PMob->GetMJob() == xi::Job::SMN && PMob->PPet && !PMob->PPet->isDead();
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

    auto* PTarget = target().resolve<CBattleEntity>();

    const auto* const PSpell = spell::GetSpell(spellid);
    if (PSpell == nullptr)
    {
        ShowWarning("ai_mob_dummy::CastSpell: SpellId <%i> is not found", static_cast<uint16>(spellid));
        return;
    }

    // Self-targeted party buffs may redirect to the master or an ally in the same engaged state.
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
        Cast(PCastTarget->entityId(), spellid);
    }
}

void CMobController::Move()
{
    TracyZoneScoped;

    auto* PTarget = target().resolve<CBattleEntity>();

    if (!PMob->PAI->CanFollowPath())
    {
        return;
    }

    if (PMob->PAI->PathFind->IsFollowingScriptedPath())
    {
        PMob->PAI->PathFind->FollowPath(m_Tick);
        return;
    }

    // Ranged attack range wins over skill-list ranges, which are not fully audited.
    const auto attackRange = [&]() -> float
    {
        if (IsRangedAttackEnabled())
        {
            return PMob->GetRangedAttackRange();
        }

        if (PMob->getMobMod(xi::MobMod::AttackSkillList) > 0)
        {
            const auto& skillList = battleutils::GetMobSkillList(PMob->getMobMod(xi::MobMod::AttackSkillList));
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

    // Where the stuck-repath teleport lands: attackRange less 0.4y, tunable per mob via xi::MobMod::TargetDistanceOffset.
    const float closeDistance = [&]() -> float
    {
        const int16 offsetMod = PMob->getMobMod(xi::MobMod::TargetDistanceOffset);
        const float offset    = offsetMod == 0 ? 0.4f : static_cast<float>(offsetMod) / 10.0f;
        return std::max(0.0f, attackRange - offset);
    }();

    // Position-share mobs mirror their leader and skip all other movement logic.
    if (PMob->getMobMod(xi::MobMod::SharePos) > 0)
    {
        if (const auto* posShare = static_cast<CMobEntity*>(PMob->GetEntity(PMob->getMobMod(xi::MobMod::SharePos) + PMob->targid, TYPE_MOB)))
        {
            PMob->loc = posShare->loc;
        }
        else
        {
            ShowWarning("CMobController::Move() failed to get mob for xi::MobMod::SharePos");
        }

        return;
    }

    if (!PTarget)
    {
        FaceTarget();
        return;
    }

    const float currentDistance = distance(PMob->loc.p, PTarget->loc.p);
    const bool  isFollowingPath = PMob->PAI->PathFind->IsFollowingPath();

    // Teleport type 1: jump in if out of melee range but within 30y and off cooldown.
    if (PMob->getMobMod(xi::MobMod::TeleportType) == 1 &&
        currentDistance > attackRange &&
        currentDistance <= 30.0f &&
        m_Tick >= m_LastSpecialTime + std::chrono::seconds(PMob->getMobMod(xi::MobMod::TeleportCd)))
    {
        if (const CMobSkill* teleportBegin = battleutils::GetMobSkill(PMob->getMobMod(xi::MobMod::TeleportStart)))
        {
            m_LastSpecialTime = m_Tick;
            MobSkill(PMob->entityId(), teleportBegin->getID(), std::nullopt);
        }
    }

    // In range and stationary: face the target, but keep checking LOS so a mob cannot attack through a thin wall.
    const bool inAttackRange = currentDistance <= attackRange;
    if (!PMob->PAI->CanFollowPath())
    {
        FaceTarget();
        return;
    }

    if (inAttackRange && !isFollowingPath && CanSeeTargetCached())
    {
        // Settle and attack unless the mob must not close, or the navmesh route is a detour worth walking instead.
        const bool canMove = PMob->GetSpeed() != 0 && PMob->getMobMod(xi::MobMod::NoMove) == 0 && m_Tick >= m_LastSpecialTime;
        if (!canMove || !ShouldCloseToTarget(currentDistance))
        {
            FaceTarget();
            return;
        }

        // Re-probe directness only when the target changed or either side moved, to avoid a findPath every tick.
        const bool targetChanged = lastDirectProbeTarget_ != PTarget;
        const bool mobMoved      = !isWithinDistance(lastDirectProbePos_, PMob->loc.p, 1.0f);
        const bool targetMoved   = !isWithinDistance(lastDirectProbeTargetPos_, PTarget->loc.p, 1.0f);
        if (targetChanged || mobMoved || targetMoved)
        {
            lastDirectProbeTarget_    = EntityId(PTarget);
            lastDirectProbePos_       = PMob->loc.p;
            lastDirectProbeTargetPos_ = PTarget->loc.p;

            const auto projectedPosition = nearPosition(PTarget->loc.p, 0, rotationToRadian(worldAngle(PMob->loc.p, PTarget->loc.p)));
            PMob->PAI->PathFind->PathTo(projectedPosition, PATHFLAG_RUN);
            lastDirectProbeWasDirect_ = PMob->PAI->PathFind->IsPathDirect();
            if (lastDirectProbeWasDirect_)
            {
                PMob->PAI->PathFind->Clear();
            }
        }

        // A direct path settles here; a detour falls through to FollowPath.
        if (lastDirectProbeWasDirect_)
        {
            FaceTarget();
            return;
        }
    }

    // Movement is gated by speed, NO_MOVE, and special-action cooldowns.
    if (PMob->GetSpeed() == 0 || PMob->getMobMod(xi::MobMod::NoMove) != 0 || m_Tick < m_LastSpecialTime)
    {
        return;
    }

    // Teleport type 2: instant warp to target if within the skill's distance.
    if (PMob->getMobMod(xi::MobMod::TeleportType) == 2)
    {
        if (const CMobSkill* teleportBegin = battleutils::GetMobSkill(PMob->getMobMod(xi::MobMod::TeleportStart)))
        {
            if (currentDistance <= teleportBegin->getDistance())
            {
                MobSkill(PMob->entityId(), teleportBegin->getID(), std::nullopt);
                m_LastSpecialTime = m_Tick;
            }
        }
        return;
    }

    if (!ShouldCloseToTarget(currentDistance))
    {
        FaceTarget();
        return;
    }

    // Re-path against attackRange, with lost sight on its own short leash so the mob keeps trying without hammering findPath.
    bool needNewPath   = false;
    bool isStuckRepath = false;
    bool targetMoved   = false;
    if (isFollowingPath)
    {
        needNewPath = !isWithinDistance(PMob->PAI->PathFind->GetDestination(), PTarget->loc.p, attackRange);
    }
    else
    {
        const bool outOfRange      = currentDistance > attackRange;
        const bool lostLOS         = !CanSeeTargetCached();
        const bool cooldownDone    = m_Tick >= rePathCooldownEnd_;
        const bool losCooldownDone = m_Tick >= lostSightRePathCooldownEnd_;

        targetMoved   = !isWithinDistance(lastRePathTarget_, PTarget->loc.p, attackRange);
        needNewPath   = (outOfRange && (targetMoved || cooldownDone)) || (lostLOS && (targetMoved || losCooldownDone));
        isStuckRepath = needNewPath && !targetMoved && cooldownDone;
    }

    if (needNewPath)
    {
        lastRePathTarget_           = PTarget->loc.p;
        rePathCooldownEnd_          = m_Tick + kRePathCooldown;
        lostSightRePathCooldownEnd_ = m_Tick + kLostSightRePathCooldown;

        // Only clear the stuck counter when the target moved, or the teleport below is unreachable while sight is lost.
        if (isStuckRepath)
        {
            ++stuckRePathCount_;
        }
        else if (targetMoved)
        {
            stuckRePathCount_ = 0;
        }

        if (stuckRePathCount_ >= 2 && PMob->getMobMod(xi::MobMod::NoStuckTeleport) == 0)
        {
            PMob->PAI->PathFind->WarpTo(PTarget->loc.p, closeDistance);
            stuckRePathCount_  = 0;
            rePathCooldownEnd_ = timer::time_point::min();
        }
        else
        {
            const auto projectedPosition = nearPosition(PTarget->loc.p, 0, rotationToRadian(worldAngle(PMob->loc.p, PTarget->loc.p)));
            PMob->PAI->PathFind->PathTo(projectedPosition, PATHFLAG_RUN);
        }
    }

    PMob->PAI->PathFind->FollowPath(m_Tick);

    if (PMob->PAI->PathFind->IsFollowingPath())
    {
        return;
    }

    // Arrived: shuffle aside if another mob is stacked on us.
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

    // Face the target when attacking right at the ShouldCloseToTarget boundary.
    FaceTarget();
}

auto CMobController::DoCombatTick(timer::time_point tick) -> Task<void>
{
    auto* PTarget       = target().resolve<CBattleEntity>();
    auto* PFollowTarget = followTarget();

    TracyZoneScopedC(0xFF0000);

    // Drop a claim the owner abandoned more than 3s ago so somebody else can engage.
    if (PMob->m_OwnerID.isSet())
    {
        const auto* const POwnerChar = PMob->m_OwnerID.resolve<CCharEntity>();
        const bool        claimStale = POwnerChar && POwnerChar->PClaimedMob != static_cast<CBattleEntity*>(PMob) && m_Tick >= m_DeclaimTime + 3s;
        if (claimStale)
        {
            PMob->m_OwnerID.clean();
            PMob->updatemask |= UPDATE_STATUS;
        }
    }

    HandleEnmity();
    setTarget(PMob->battleTarget().resolve<CBattleEntity>());
    PTarget = target().resolve<CBattleEntity>();

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

    // Try special, spell, TP and ranged actions in order; the first to act ends the tick.
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
            FaceTarget(PTarget->entityId());
            if (POwner->PAI->Internal_RangedAttack(PTarget->entityId()))
            {
                TapDeaggroTime();
                PMob->m_LastRangedAttackTime = m_Tick;
                co_return;
            }
        }
    }

    Move();
}

auto CMobController::DoBuffTick() -> bool
{
    TracyZoneScoped;

    if (PMob->PAI->IsCurrentState<CMagicState>())
    {
        return true;
    }

    if (!IsSpellReady(0, 0) || !PMob->SpellContainer->HasBuffSpells())
    {
        return false;
    }

    return TryCastSpell();
}

void CMobController::FaceTarget(const EntityId& target) const
{
    TracyZoneScoped;

    const auto* const maybeTarget = target.isSet() ? target.resolve() : PMob->GetBattleTarget();

    if (maybeTarget && ((PMob->m_Behavior & xi::Behavior::NoTurn) == xi::Behavior::None))
    {
        PMob->PAI->PathFind->LookAt(maybeTarget->loc.p);
    }

    PMob->UpdateSpeed();
}

void CMobController::HandleEnmity()
{
    TracyZoneScoped;

    auto* PTarget = target().resolve<CBattleEntity>();

    PMob->PEnmityContainer->DecayEnmity();
    auto* const PHighestEnmityTarget = PMob->PEnmityContainer->GetHighestEnmity();

    // xi::MobMod::ShareTarget copies the linked mob's target, falling back to our own enmity list.
    auto* const PShareSource = PMob->getMobMod(xi::MobMod::ShareTarget) > 0
                                   ? PMob->GetEntity(PMob->getMobMod(xi::MobMod::ShareTarget), TYPE_MOB)
                                   : nullptr;

    if (PShareSource)
    {
        ChangeTarget(static_cast<CMobEntity*>(PShareSource)->battleTarget());
    }
    if ((!PShareSource || !PMob->battleTarget().isSet()) && PHighestEnmityTarget)
    {
        ChangeTarget(PHighestEnmityTarget->entityId());
    }

    // When bound and unable to reach the current target, retarget the closest attackable enmity owner.
    // TODO: do mobs with bind attack players *without* enmity if they are in the same party?
    // TODO: do jug pets do this?
    // TODO: this code assumes charmed mobs can do this -- they DO keep an enmity table, after all.
    const bool isBoundAndAttacking = PMob->objtype == TYPE_MOB &&
                                     PMob->StatusEffectContainer &&
                                     PMob->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::Bind) &&
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
        ChangeTarget(PClosestAttackable->entityId());
    }

    if (PTarget)
    {
        FaceTarget(PTarget->entityId());
    }
}

auto CMobController::DoRoamTick(timer::time_point tick) -> Task<void>
{
    auto* PTarget       = target().resolve<CBattleEntity>();
    auto* PFollowTarget = followTarget();

    TracyZoneScopedC(0x00FF00);

    const bool ignoreAggro = ((PMob->m_roamFlags & xi::RoamFlag::Ignore) != xi::RoamFlag::None);

    // Anyone on our enmity list pulls us straight into combat.
    if (auto* const PHighest = PMob->PEnmityContainer->GetHighestEnmity(); PHighest && !ignoreAggro)
    {
        Engage(PHighest->entityId());
        co_return;
    }

    // I'm claimed by someone - engage them if they still exist.
    if (PMob->m_OwnerID.isSet() && !ignoreAggro)
    {
        setTarget(PMob->m_OwnerID.resolve<CBattleEntity>());
        PTarget = target().resolve<CBattleEntity>();
        if (PTarget != nullptr)
        {
            Engage(PTarget->entityId());
        }
        co_return;
    }

    // TODO: investigate
    if (PMob->GetDespawnTime() > timer::time_point::min() && PMob->GetDespawnTime() < m_Tick)
    {
        Despawn();
        co_return;
    }

    // An idle mob with no walkable ground anywhere near it is despawned after ~2 ticks.
    // Pathing mobs are exempt (a waypoint can read off-mesh on a poly seam), as are NO_DESPAWN mobs.
    if (!PMob->PAI->PathFind->IsFollowingPath() && !PMob->PAI->PathFind->ValidPosition(PMob->loc.p))
    {
        const bool noDespawn = PMob->getMobMod(xi::MobMod::NoDespawn) != 0 || settings::get<bool>("map.MOB_NO_DESPAWN");
        if (!noDespawn && PMob->GetDespawnTime() == timer::time_point::min() && !PMob->PAI->PathFind->NearValidPosition(PMob->loc.p))
        {
            PMob->SetDespawnTime(200ms);
        }
        co_return;
    }

    // xi::RoamFlag::Ignore mobs never accept claim.
    if (ignoreAggro)
    {
        PMob->m_OwnerID.clean();
    }

    if (PFollowTarget != nullptr && m_followType == FollowType::Roam)
    {
        const float followRoamDistance = PMob->getMobMod(xi::MobMod::FollowLeashRange) > 0 ? PMob->getMobMod(xi::MobMod::FollowLeashRange) : 4.0f;

        // Only path to leader if they're moving
        if (distance(PMob->loc.p, PFollowTarget->loc.p) > followRoamDistance && PFollowTarget->PAI->PathFind->IsFollowingPath())
        {
            const float followStopRange = PMob->getMobMod(xi::MobMod::FollowStopRange) > 0 ? PMob->getMobMod(xi::MobMod::FollowStopRange) : 2.0f;

            PMob->PAI->PathFind->PathAround(PFollowTarget->loc.p, followStopRange, PATHFLAG_RUN);
        }

        if (!PMob->PAI->PathFind->IsFollowingPath())
        {
            co_return;
        }
    }

    // Recover 10% HP and lose TP every 10s while idle.
    if (m_Tick >= m_mobHealTime + 10s && PMob->getMobMod(xi::MobMod::NoRest) == 0 && PMob->CanRest())
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

    // Roam tick body

    // Wait out the timer first (e.g. after a special move).
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

    // Don't aggro for a moment after disengaging.
    PMob->m_neutral = m_Tick <= m_NeutralTime + kNeutralDuration;

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
    else if (m_Tick >= m_LastActionTime + std::chrono::seconds(PMob->getMobMod(xi::MobMod::RoamCool)))
    {
        if (PMob->GetCallForHelpFlag())
        {
            PMob->SetCallForHelpFlag(false);
        }

        PMob->m_IsPathingHome = false;

        const bool wantsToHeadHome = !PMob->getMobMod(xi::MobMod::DontRoamHome) && PMob->IsFarFromHome();
        const bool noDespawn       = PMob->getMobMod(xi::MobMod::NoDespawn) != 0;

        // Walk home or despawn after wandering too far.
        if (wantsToHeadHome)
        {
            if (PMob->CanRoamHome())
            {
                PMob->m_IsPathingHome = true;

                // heading home means the nearest edge of the region, not the spot it happened to spawn on
                const auto homePoint = [&]
                {
                    if (PMob->roamRegion())
                    {
                        return PMob->roamRegion()->closestPoint(PMob->loc.p);
                    }

                    return PMob->m_SpawnPoint;
                }();

                if (!PMob->PAI->PathFind->IsFollowingPath() && !PMob->PAI->PathFind->PathTo(homePoint))
                {
                    PMob->PAI->PathFind->PathInRange(homePoint, PMob->m_maxRoamDistance, PATHFLAG_RUN);
                }

                // Cap the path so we re-evaluate every few seconds instead of bee-lining home.
                PMob->PAI->PathFind->LimitDistance(kRoamHomeStepDistance);
                FollowRoamPath();

                // Re-trigger the "head home" pulse roughly every 5 seconds.
                m_LastActionTime = m_Tick - (std::chrono::seconds(PMob->getMobMod(xi::MobMod::RoamCool)) + 10s);
            }
            else if (!noDespawn && !settings::get<bool>("map.MOB_NO_DESPAWN"))
            {
                PMob->PAI->Despawn();

                // Override CDespawnState's deaggro respawn timer (60s instead of default).
                PMob->loc.zone->spawnHandler().registerForRespawn(PMob, 60s);
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
            // Hiding mobs are now handled via mixin, so xi::RoamFlag::Ambush is no longer special-cased here.
            const bool battlefieldIsOpen = PMob->PBattlefield && PMob->PBattlefield->GetStatus() == BATTLEFIELD_STATUS_OPEN;

            const auto wantsSummon = [&]
            {
                return !battlefieldIsOpen &&
                       PMob->GetMJob() == xi::Job::SMN &&
                       m_Tick >= m_nextMagicTime &&
                       CanCastSpells(IgnoreRecastsAndCosts::No) &&
                       PMob->SpellContainer->HasBuffSpells();
            };

            const auto wantsRandomBuff = [&]
            {
                return CanCastSpells(IgnoreRecastsAndCosts::No) &&
                       xirand::GetRandomNumber(10) < 3 &&
                       PMob->SpellContainer->HasBuffSpells();
            };

            if (IsSpecialSkillReady(0) && TrySpecialSkill())
            {
                // (Probably) spawned a pet via special skill.
            }
            else if (wantsSummon())
            {
                // battlefield.lua summons the first pet so the first player sees it; later summons come through here.
                TryCastSpell();
            }
            else if (wantsRandomBuff())
            {
                TryCastSpell();
            }
            else if ((PMob->m_roamFlags & xi::RoamFlag::Scripted) != xi::RoamFlag::None)
            {
                // TODO: What is this tag?
                // TODO: #AIToScript - let scripts handle the roam action entirely.
                PMob->PAI->EventHandler.triggerListener("ROAM_ACTION", PMob);
                luautils::OnMobRoamAction(PMob);
                m_LastActionTime = m_Tick;
            }
            else if (PMob->CanRoam())
            {
                // Worm dives underground; leave m_LastActionTime alone so it re-emerges promptly.
                const bool isWormSurfacing = ((PMob->m_roamFlags & xi::RoamFlag::Worm) != xi::RoamFlag::None) && !PMob->IsNameHidden();
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
                                MobEntity->status = xi::Status::Invisible;
                            }));
                }
                else if ((PMob->m_roamFlags & xi::RoamFlag::Scripted) != xi::RoamFlag::None)
                {
                    // allow custom event action
                    PMob->PAI->EventHandler.triggerListener("ROAM_ACTION", PMob);
                    luautils::OnMobRoamAction(PMob);
                    m_LastActionTime = m_Tick;
                }
                else if (!isWormSurfacing && PMob->PAI->PathFind->RoamAround(PMob->GetRoamAnchor(), PMob->GetRoamDistance(), static_cast<uint8>(PMob->getMobMod(xi::MobMod::RoamTurns)), PMob->m_roamFlags, PMob->roamRegion()))
                {
                    if ((PMob->m_roamFlags & xi::RoamFlag::Stealth) != xi::RoamFlag::None)
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
        const uint32 roamRandomness = std::clamp<uint32>(static_cast<uint16>(PMob->getMobMod(xi::MobMod::RoamCool) * 1000 / PMob->GetRoamRate()), 0, 120 * 1000);
        m_LastActionTime            = m_Tick - std::chrono::milliseconds(xirand::GetRandomNumber(roamRandomness));

        // Worm finished its underground roam - pop back up.
        if (((PMob->m_roamFlags & xi::RoamFlag::Worm) != xi::RoamFlag::None) && PMob->PAI->IsUntargetable())
        {
            // Send a final position update before emerging so we don't visibly snap.
            PMob->loc.zone->UpdateEntityPacket(PMob, ENTITY_UPDATE, UPDATE_POS);

            // Lock further roaming until emerge animation completes.
            PMob->status = xi::Status::Update;
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

        // Snap to spawn rotation after pathing home, for mobs that must face a fixed direction.
        if (PMob->getMobMod(xi::MobMod::RoamResetFacing) && PMob->DistanceFromHome() <= PMob->m_maxRoamDistance)
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

auto CMobController::IsSpecialSkillReady(const float currentDistance) const -> bool
{
    TracyZoneScoped;

    if (PMob->getMobMod(xi::MobMod::SpecialSkill) == 0)
    {
        return false;
    }

    if (PMob->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::Chainspell))
    {
        return false;
    }

    // Mobs use ranged attacks quicker when standing back.
    const int32 bonusTime = currentDistance > 5 ? PMob->getMobMod(xi::MobMod::StandbackCool) : 0;

    return m_Tick >= m_LastSpecialTime + std::chrono::seconds(PMob->getMobMod(xi::MobMod::SpecialCool) - bonusTime);
}

auto CMobController::IsSpellReady(const float& currentDistance, const float& meleeRange) const -> bool
{
    TracyZoneScoped;

    if (PMob->StatusEffectContainer->HasStatusEffect({ xi::StatusEffect::Chainspell, xi::StatusEffect::Manafont }))
    {
        return true;
    }

    // Worms don't cast in melee range (typically.) The edge cases can be scripted.
    if ((PMob->m_roamFlags & xi::RoamFlag::Worm) != xi::RoamFlag::None && currentDistance <= meleeRange)
    {
        return false;
    }

    if (currentDistance > 5 && ((PMob->m_roamFlags & xi::RoamFlag::Worm) != xi::RoamFlag::None) == 0)
    {
        // Mobs use magic quicker when standing back
        return m_Tick >= (m_nextMagicTime - std::chrono::seconds(PMob->getMobMod(xi::MobMod::StandbackCool)));
    }

    return m_Tick >= m_nextMagicTime;
}
