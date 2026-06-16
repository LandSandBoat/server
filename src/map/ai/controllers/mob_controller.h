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

#include "controller.h"

#include "common/types/cached.h"
#include "common/types/maybe.h"

enum class FollowType : uint8
{
    None,
    Roam,
    RunAway,
};

class CMobEntity;
class CMobController : public CController
{
public:
    CMobController(CMobEntity* PEntity);

    virtual auto Tick(timer::time_point tick) -> Task<void> override;
    virtual auto Disengage() -> bool override;
    virtual auto Engage(uint16 targid) -> bool override;
    virtual void Despawn() override;
    virtual void Reset() override;

    virtual auto MobSkill(uint16 targid, uint16 wsid, Maybe<timer::duration> castTimeOverride) -> bool;
    virtual auto Ability(uint16 targid, uint16 abilityid) -> bool override;
    auto         MobSkill(int listId = 0) -> bool;
    auto         TryCastSpell() -> bool;
    auto         TrySpecialSkill() -> bool;

    auto         CanFollowTarget(CBattleEntity*) const -> bool;
    auto         CanAggroTarget(CBattleEntity*) const -> bool;
    void         TapDeaggroTime();
    void         TapDeclaimTime();
    virtual auto Cast(uint16 targid, SpellID spellid) -> bool override;
    void         SetFollowTarget(CBaseEntity* PTarget, FollowType followType);
    auto         HasFollowTarget() const -> bool;
    void         ClearFollowTarget();
    auto         CheckHide(const CBattleEntity* PTarget) const -> bool;

    void OnCastStopped(CMagicState& state, action_t& action);

protected:
    virtual auto TryDeaggro() -> bool;

    virtual void TryLink();
    auto         CanDetectTarget(CBattleEntity* PTarget, bool forceSight = false) const -> bool;
    auto         CanTrackByScent(const CBattleEntity* PTarget) const -> bool;
    auto         CheckLock(CBattleEntity* PTarget) const -> bool;
    auto         CheckDetection(CBattleEntity* PTarget) -> bool;
    virtual auto CanCastSpells(IgnoreRecastsAndCosts ignoreRecastsAndCosts) -> bool;
    void         CastSpell(SpellID spellid);
    virtual void Move();

    virtual auto DoCombatTick(timer::time_point tick) -> Task<void>;
    void         LookAtTarget(uint16 targid = 0) const;
    virtual void HandleEnmity();

    virtual auto DoRoamTick(timer::time_point tick) -> Task<void>;
    void         Wait(timer::duration duration);
    void         FollowRoamPath();
    auto         ShouldCloseToTarget(float currentDistance) -> bool;

    // Per-tick line-of-sight cache. CanSeeTarget() is a navmesh raycast and several call sites
    // in a single Move() tick may need the answer (in-range face check, ShouldCloseToTarget's
    // standback / lost-LOS branches, the needNewPath check). Wrapping the cache *together with*
    // its target in a Maybe lets us wipe both at once whenever the target swaps - we never serve
    // a cached raycast for the wrong target. The whole thing is also reset at the start of each
    // Tick() so cached values are never staler than one frame.
    struct TargetLOSCache
    {
        CBattleEntity* target;
        Cached<bool>   canSeeTarget;
    };
    Maybe<TargetLOSCache> targetLosCache_;

    auto CanSeeTargetCached() -> bool;
    auto         IsSpecialSkillReady(float currentDistance) const -> bool;
    auto         IsSpellReady(const float& currentDistance, const float& meleeRange) const -> bool;

    CBattleEntity* PTarget{ nullptr };

    static constexpr float FollowRoamDistance{ 4.0f };
    static constexpr float FollowRunAwayDistance{ 4.0f };

    CBaseEntity* PFollowTarget{ nullptr };

private:
    CMobEntity* const PMob;

    timer::time_point m_LastActionTime;
    timer::time_point m_nextMagicTime;
    timer::time_point m_LastMobSkillTime;
    timer::time_point m_LastSpecialTime;
    timer::time_point m_DeaggroTime;
    timer::time_point m_DeclaimTime;
    timer::time_point m_NeutralTime;
    timer::time_point m_WaitTime;
    timer::time_point m_mobHealTime;
    FollowType        m_followType = FollowType::None;

    bool              m_firstSpell{ true };
    timer::time_point m_LastRoamScript{ timer::time_point::min() };
    uint16_t          m_tpThreshold{ 1000 };

    // Re-path thrashing guard: when a mob is stuck at the navmesh boundary (path finished but
    // target is still out of attack range), rate-limit PathInRange calls so we don't hammer
    // findPath. Allow an immediate re-path when the target moves significantly.
    // After 2 consecutive cooldown-triggered re-paths that don't progress, teleport the mob
    // to the target so players can't exploit unreachable terrain for free wins.
    timer::time_point rePathCooldownEnd_{ timer::time_point::min() };
    position_t        lastRePathTarget_{};
    uint8_t           stuckRePathCount_{ 0 };

    // In-range LOS probe cache. When a mob is settled in melee range, the directness probe
    // (PathInRange + IsPathDirect) is only re-run when the target entity changes or either
    // party has moved enough that the result could differ. Avoids a navmesh query every tick
    // for every engaged melee mob standing next to their target.
    CBattleEntity* lastDirectProbeTarget_{ nullptr };
    position_t     lastDirectProbePos_{};
    position_t     lastDirectProbeTargetPos_{};
    bool           lastDirectProbeWasDirect_{ true };
};
