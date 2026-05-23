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

#include "trust_controller.h"

#include "ability.h"
#include "ai/helpers/gambits_container.h"
#include "ai/states/despawn_state.h"
#include "ai/states/magic_state.h"
#include "ai/states/range_state.h"
#include "enmity_container.h"
#include "entities/charentity.h"
#include "entities/trustentity.h"
#include "items/item_weapon.h"
#include "mob_modifier.h"
#include "mob_spell_container.h"
#include "player_controller.h"
#include "recast_container.h"
#include "status_effect_container.h"
#include "utils/charutils.h"

namespace
{

enum TRUST_MOVEMENT_TYPE : int8
{
    // NOTE: If you need to add special movement types, add descending into the minus values.
    //     : All of the positive values are taken for the ranged movement range.
    // NOTE: You can use any positive value as a distance, and it will act as MID_RANGE or LONG_RANGE, but with the value you've provided.
    //     : For example:
    //     :     mob:setMobMod(xi.mobMod.TRUST_DISTANCE, 20)
    //     : Will set the combat distance the trust tries to stick to to 20'
    // NOTE: If a Trust doesn't immediately sprint to a certain distance at the start of battle, it's probably NO_MOVE or MELEE.
    NO_MOVE    = -1, // Will stand still providing they're within casting distance of their master and target when the fight starts. Otherwise will reposition to be within 9.0' of both
    NON_COMBAT = -2, // Will follow the master if first trust in party and will follow the trust in front if lower in the list.
    MELEE      = 0,  // Default: will continually reposition to stay within melee range of the target
    MID_RANGE  = 6,  // Will path at the start of battle to 6' away from the target, and try to stay at that distance
    LONG_RANGE = 12, // Will path at the start of battle to 12' away from the target, and try to stay at that distance
};

} // namespace

CTrustController::CTrustController(CCharEntity* PChar, CTrustEntity* PTrust)
: CMobController(PTrust)
, m_GambitsContainer(std::make_unique<gambits::CGambitsContainer>(PTrust))
, m_LastTopEnmity(nullptr)
, m_failedRepositionAttempts(0)
, m_InTransit(false)
{
}

CTrustController::~CTrustController()
{
    if (POwner->PAI->IsEngaged())
    {
        POwner->PAI->Internal_Disengage();
    }
    POwner->PAI->PathFind.reset();
    POwner->allegiance = ALLEGIANCE_TYPE::PLAYER;
    POwner->status     = STATUS_TYPE::DISAPPEAR;
    m_LastTopEnmity    = nullptr;
}

void CTrustController::Despawn()
{
    POwner->PMaster   = nullptr;
    POwner->animation = ANIMATION_DESPAWN;
    CMobController::Despawn();
}

auto CTrustController::Tick(timer::time_point tick) -> Task<void>
{
    TracyZoneScoped;
    TracyZoneString(POwner->getName());

    m_Tick = tick;

    auto* PTrust = static_cast<CTrustEntity*>(POwner);

    if (!PTrust->PMaster)
    {
        co_return;
    }

    if (PTrust->PMaster->isCharmed)
    {
        this->Despawn();
        co_return;
    }

    const bool nonCombatFollowTrust = PTrust->getMobMod(MOBMOD_TRUST_DISTANCE) == TRUST_MOVEMENT_TYPE::NON_COMBAT;

    if (PTrust->PMaster->PAI->IsEngaged() && nonCombatFollowTrust)
    {
        co_await DoNonCombatTick(tick);
    }
    else if (POwner->PAI->IsEngaged())
    {
        co_await DoCombatTick(tick);
    }
    else if (!POwner->isDead())
    {
        co_await DoRoamTick(tick);
    }
}

auto CTrustController::DoCombatTick(timer::time_point tick) -> Task<void>
{
    TracyZoneScoped;

    CTrustEntity* PTrust  = static_cast<CTrustEntity*>(POwner);
    CCharEntity*  PMaster = static_cast<CCharEntity*>(POwner->PMaster);
    CMobEntity*   PMob    = dynamic_cast<CMobEntity*>(PMaster->GetBattleTarget());
    PTarget               = POwner->GetBattleTarget();

    if (!PMaster->PAI->IsEngaged())
    {
        PTrust->PAI->Internal_Disengage();
        m_LastTopEnmity = nullptr;
        m_CombatEndTime = m_Tick;
    }

    if (PMaster && PMob && PTrust->GetBattleTargetID() != PMaster->GetBattleTargetID())
    {
        auto  masterID   = PMaster->id;
        auto* enmityList = PMob->PEnmityContainer->GetEnmityList();
        bool  hasEnmity  = false;

        if (auto it = enmityList->find(masterID); it != enmityList->end())
        {
            const EnmityObject_t& entry = it->second;
            // Only treat as "has enmity" if:
            // the entry is active,
            // the CE+VE is positive,
            // and the master is within enmity range (same checks used when adding enmity).
            if (entry.active && (entry.CE + entry.VE) > 0)
            {
                hasEnmity = true;
            }
        }

        if (hasEnmity)
        {
            PTrust->PAI->Internal_ChangeTarget(PMaster->GetBattleTargetID());
            m_LastTopEnmity = nullptr;
        }
    }

    // If busy, don't run around!
    if (PTrust->PAI->IsCurrentState<CMagicState>() || PTrust->PAI->IsCurrentState<CRangeState>())
    {
        co_return;
    }

    if (PTarget)
    {
        if (PTrust->PAI->CanFollowPath() && PTrust->GetSpeed() > 0)
        {
            float currentDistanceToTarget = distance(PTrust->loc.p, PTarget->loc.p);
            float currentDistanceToMaster = distance(PTrust->loc.p, PMaster->loc.p);

            if (!PMaster->PAI->IsEngaged() && currentDistanceToTarget > WarpDistance)
            {
                PTrust->PAI->PathFind->WarpTo(PTarget->loc.p);
            }

            PTrust->PAI->PathFind->LookAt(PTarget->loc.p);

            int16 movementDistance = PTrust->getMobMod(MOBMOD_TRUST_DISTANCE);

            switch (movementDistance)
            {
                case TRUST_MOVEMENT_TYPE::NO_MOVE:
                {
                    if (currentDistanceToMaster > CastingDistance)
                    {
                        PathOutToDistance(PTarget, 9.0f);
                    }
                    else if (currentDistanceToTarget > CastingDistance)
                    {
                        PathOutToDistance(PTarget, 9.0f);
                    }
                    break;
                }
                case TRUST_MOVEMENT_TYPE::NON_COMBAT:
                {
                    // Non-combat followers should not use target-distance positioning.
                    break;
                }
                case TRUST_MOVEMENT_TYPE::MELEE:
                {
                    std::unique_ptr<CBasicPacket> err;
                    if (!PTrust->CanAttack(PTarget, err) && PTrust->GetSpeed() > 0)
                    {
                        if (currentDistanceToTarget > RoamDistance)
                        {
                            if (currentDistanceToTarget < RoamDistance * 3.0f &&
                                PTrust->PAI->PathFind->PathAround(PTarget->loc.p, RoamDistance, PATHFLAG_RUN | PATHFLAG_WALLHACK))
                            {
                                PTrust->PAI->PathFind->FollowPath(m_Tick);
                            }
                            else if (PTrust->GetSpeed() > 0)
                            {
                                PTrust->PAI->PathFind->StepTo(PTarget->loc.p, true);
                            }
                        }
                    }
                    break;
                }
                case TRUST_MOVEMENT_TYPE::MID_RANGE:
                    [[fallthrough]];
                case TRUST_MOVEMENT_TYPE::LONG_RANGE:
                    [[fallthrough]];
                default: // Using the positive-non-zero movementDistance mobMod value
                {
                    PathOutToDistance(PTarget, static_cast<float>(movementDistance));
                    break;
                }
            }

            if (!PTrust->PAI->PathFind->IsFollowingPath())
            {
                Declump(PMaster, PTarget);
            }
        }

        if (!m_InTransit)
        {
            PTrust->PAI->PathFind->FollowPath(m_Tick);
        }

        co_await m_GambitsContainer->Tick(tick);

        PTrust->PAI->EventHandler.triggerListener("COMBAT_TICK", PTrust, PMaster, PTarget);
    }
}

auto CTrustController::DoNonCombatTick(timer::time_point tick) -> Task<void>
{
    TracyZoneScoped;

    auto* PTrust  = static_cast<CTrustEntity*>(POwner);
    auto* PMaster = static_cast<CCharEntity*>(POwner->PMaster);

    if (!PMaster)
    {
        co_return;
    }

    // Keep COMBAT_TICK target valid for listeners/gambits.
    PTarget = PMaster->GetBattleTarget();

    // Non-combat trust follow order:
    // - first trust follows master
    // - others follow the trust directly in front of them
    uint8 currentPartyPos = GetPartyPosition();

    CBattleEntity* PFollowTarget = PMaster;
    if (currentPartyPos > 0 && static_cast<size_t>(currentPartyPos - 1) < PMaster->PTrusts.size())
    {
        if (auto* PLeadTrust = PMaster->PTrusts.at(currentPartyPos - 1); PLeadTrust && PLeadTrust != PTrust)
        {
            PFollowTarget = PLeadTrust;
        }
    }

    // First trust keeps a bit more space from master.
    constexpr float FirstTrustFollowDistance = 3.0f; // tune as needed
    const float     desiredFollowDistance    = (currentPartyPos == 0) ? FirstTrustFollowDistance : RoamDistance;

    float currentDistance = distance(PTrust->loc.p, PFollowTarget->loc.p);

    // Simple declump so non-combat trusts don't stack on each other.
    for (auto* POtherTrust : PMaster->PTrusts)
    {
        if (POtherTrust != PTrust &&
            distance(POtherTrust->loc.p, PTrust->loc.p) < 1.0f &&
            !PTrust->PAI->PathFind->IsFollowingPath())
        {
            auto diff_angle = worldAngle(PTrust->loc.p, POtherTrust->loc.p) + 64;
            auto amount     = (currentPartyPos % 2) ? 1.0f : -1.0f;

            position_t new_pos = {
                PTrust->loc.p.x - (cosf(rotationToRadian(diff_angle)) * amount),
                POtherTrust->loc.p.y,
                PTrust->loc.p.z + (sinf(rotationToRadian(diff_angle)) * amount),
                0,
                0,
            };

            if (PTrust->PAI->PathFind->ValidPosition(new_pos) &&
                PTrust->PAI->PathFind->PathAround(new_pos, desiredFollowDistance, PATHFLAG_RUN | PATHFLAG_WALLHACK))
            {
                PTrust->PAI->PathFind->FollowPath(m_Tick);
            }
            break;
        }
    }

    if (currentDistance > WarpDistance)
    {
        PTrust->PAI->PathFind->WarpTo(PFollowTarget->loc.p);
    }
    else if (currentDistance > desiredFollowDistance)
    {
        if (currentDistance < desiredFollowDistance * 3.0f &&
            PTrust->PAI->PathFind->PathAround(PFollowTarget->loc.p, desiredFollowDistance, PATHFLAG_RUN | PATHFLAG_WALLHACK))
        {
            PTrust->PAI->PathFind->FollowPath(m_Tick);
        }
        else if (PTrust->GetSpeed() > 0)
        {
            PTrust->PAI->PathFind->StepTo(PFollowTarget->loc.p, true);
        }
    }

    if (PTrust->PAI->PathFind->IsFollowingPath())
    {
        PTrust->PAI->PathFind->FollowPath(m_Tick);
    }

    // Keep gambits active in combat, but only while stationary.
    if (PMaster->PAI->IsEngaged() && !PTrust->PAI->PathFind->IsFollowingPath())
    {
        co_await m_GambitsContainer->Tick(tick);
        PTrust->PAI->EventHandler.triggerListener("COMBAT_TICK", PTrust, PMaster, PTarget);
    }

    co_return;
}

auto CTrustController::DoRoamTick(timer::time_point tick) -> Task<void>
{
    TracyZoneScoped;

    auto* PMaster              = static_cast<CCharEntity*>(POwner->PMaster);
    auto  masterLastAttackTime = static_cast<CPlayerController*>(PMaster->PAI->GetController())->getLastAttackTime();
    bool  masterMeleeSwing     = masterLastAttackTime > timer::now() - 1s;

    bool trustEngageCondition = false;
    // NOTE: charvars are now cached, this is essentially a localvar read now.
    switch (charutils::GetCharVar(PMaster, "TrustEngageType"))
    {
        case 1: // Master engages a monster, no melee swing required
        {
            trustEngageCondition = PMaster->GetBattleTarget();
            break;
        }
        case 0: // Nothing set
            [[fallthrough]];
        default: // Something invalid set
        {
            // Default retail behavior: Master engages a monster and executes a melee swing
            trustEngageCondition = PMaster->GetBattleTarget() && masterMeleeSwing;
            break;
        }
    }

    const uint16 modelID_Cornelia = 3119; // Cornielia does not have an Attack Schedule so do not engage.

    if (PMaster->PAI->IsEngaged() && trustEngageCondition && POwner->GetModelId() != modelID_Cornelia)
    {
        POwner->PAI->Internal_Engage(PMaster->GetBattleTargetID());
    }

    uint8          currentPartyPos = GetPartyPosition();
    CBattleEntity* PFollowTarget   = (GetPartyPosition() > 0) ? (CBattleEntity*)PMaster->PTrusts.at(currentPartyPos - 1) : POwner->PMaster;
    float          currentDistance = distance(POwner->loc.p, PFollowTarget->loc.p);

    // Formation following thresholds (in yalms)
    // First trust follows master more closely than other trusts follow each other
    bool isFirstTrust = (currentPartyPos == 0);

    float declumpDistance = isFirstTrust ? 1.0f : 1.5f; // Too close, need to move away
    float followMax       = isFirstTrust ? 2.0f : 3.5f; // Maximum follow distance before moving closer
    float followTarget    = isFirstTrust ? 1.5f : 3.0f; // Ideal follow distance

    // Handle formation movement based on distance thresholds
    if (currentDistance < declumpDistance)
    {
        // Too close to follow target - push away to maintain formation spacing
        if (PFollowTarget && POwner->PAI->PathFind->PathAround(PFollowTarget->loc.p, followTarget + 0.5f, PATHFLAG_RUN | PATHFLAG_WALLHACK))
        {
            POwner->PAI->PathFind->FollowPath(m_Tick);
        }
    }
    else if (currentDistance > followMax)
    {
        // Too far from follow target - move closer to maintain formation
        if (currentDistance > WarpDistance)
        {
            // Warp if extremely too far
            POwner->PAI->PathFind->WarpTo(PFollowTarget->loc.p);
        }
        else
        {
            // Path or step closer to follow target
            if (currentDistance < RoamDistance * 3.0f && POwner->PAI->PathFind->PathAround(PFollowTarget->loc.p, followTarget, PATHFLAG_RUN | PATHFLAG_WALLHACK))
            {
                POwner->PAI->PathFind->FollowPath(m_Tick);
            }
            else if (POwner->GetSpeed() > 0)
            {
                POwner->PAI->PathFind->StepTo(PFollowTarget->loc.p, true);
            }
        }
    }
    else
    {
        // In formation range - stop pathfinding to prevent circling
        if (POwner->PAI->PathFind->IsFollowingPath())
        {
            POwner->PAI->PathFind->Clear();
        }
    }

    if (POwner->CanRest() && m_Tick - POwner->LastAttacked > m_tickDelays.at(0) && m_Tick - m_CombatEndTime > m_tickDelays.at(0) &&
        m_Tick - m_LastHealTickTime > m_tickDelays.at(m_NumHealingTicks))
    {
        if (POwner->health.hp != POwner->health.maxhp || POwner->health.mp != POwner->health.maxmp)
        {
            // recover 5% HP & MP
            uint32 recoverHP = (uint32)(POwner->health.maxhp * 0.05);
            uint32 recoverMP = (uint32)(POwner->health.maxmp * 0.05);
            POwner->addHP(recoverHP);
            POwner->addMP(recoverMP);
            m_LastHealTickTime = m_Tick;
            POwner->updatemask |= UPDATE_HP;
            m_NumHealingTicks = std::clamp(m_NumHealingTicks + 1, static_cast<std::size_t>(0U), m_tickDelays.size() - 1U);
        }
    }

    co_return;
}

void CTrustController::Declump(CCharEntity* PMaster, CBattleEntity* PTarget)
{
    TracyZoneScoped;

    uint8 currentPartyPos = GetPartyPosition();
    for (auto* POtherTrust : PMaster->PTrusts)
    {
        if (POtherTrust != POwner && !POtherTrust->PAI->PathFind->IsFollowingPath() && distance(POtherTrust->loc.p, POwner->loc.p) < 1.5f)
        {
            auto diffAngle  = worldAngle(POwner->loc.p, PTarget->loc.p) + 64;
            auto moveAmount = xirand::GetRandomNumber(0.0f, 1.5f) * ((currentPartyPos % 2) ? 1.0f : -1.0f);

            // clang-format off
            position_t newPos =
            {
                POwner->loc.p.x - (cosf(rotationToRadian(diffAngle)) * moveAmount),
                PTarget->loc.p.y,
                POwner->loc.p.z + (sinf(rotationToRadian(diffAngle)) * moveAmount),
                0,
                0,
            };
            // clang-format on

            if (POwner->PAI->PathFind->ValidPosition(newPos))
            {
                POwner->PAI->PathFind->PathTo(newPos, PATHFLAG_RUN | PATHFLAG_WALLHACK);
            }
            break;
        }
    }
}

void CTrustController::PathOutToDistance(CBattleEntity* PTarget, float amount)
{
    TracyZoneScoped;

    float      currentDistanceToTarget = distance(POwner->loc.p, PTarget->loc.p);
    position_t target_position         = POwner->loc.p;

    if (GetTopEnmity() == POwner)
    {
        ++m_failedRepositionAttempts;
    }
    else
    {
        m_failedRepositionAttempts = 0;
    }

    // Invalidate position and pick new one (limit: every 3s)
    if ((currentDistanceToTarget < amount - 2.5f || currentDistanceToTarget > amount + 2.5f || !POwner->PAI->PathFind->ValidPosition(POwner->loc.p)) &&
        m_Tick - m_LastRepositionTime > 3s && !m_InTransit)
    {
        std::vector<position_t> positions(5);
        for (auto& position : positions)
        {
            int        random_angle       = xirand::GetRandomNumber(256);
            position_t potential_position = {
                PTarget->loc.p.x - (cosf(rotationToRadian(random_angle)) * amount),
                PTarget->loc.p.y,
                PTarget->loc.p.z + (sinf(rotationToRadian(random_angle)) * amount),
                0,
                0,
            };
            position = potential_position;
        }

        bool position_found = false;
        for (auto& potential_position : positions)
        {
            // Validate position
            if (!position_found &&
                POwner->PAI->PathFind->ValidPosition(potential_position) &&
                POwner->CanSeeTarget(potential_position))
            {
                position_found  = true;
                target_position = potential_position;
                m_InTransit     = true;
            }
        }

        m_LastRepositionTime = m_Tick;
    }

    // Get somewhat close to the target destination
    if (distance(POwner->loc.p, target_position) > 2.0f && m_failedRepositionAttempts < 3)
    {
        POwner->PAI->PathFind->PathTo(target_position, PATHFLAG_RUN | PATHFLAG_WALLHACK);
    }
    else
    {
        FaceTarget(PTarget->targid);
        m_InTransit = false;
    }
}

bool CTrustController::Ability(uint16 targid, uint16 abilityid)
{
    TracyZoneScoped;

    if (static_cast<CMobEntity*>(POwner)->PRecastContainer->HasRecast(RECAST_ABILITY, static_cast<Recast>(abilityid), 0s))
    {
        return false;
    }

    if (POwner->PAI->CanChangeState())
    {
        return POwner->PAI->Internal_Ability(targid, abilityid);
    }

    return false;
}

bool CTrustController::RangedAttack(uint16 targid)
{
    TracyZoneScoped;

    timer::duration rangedDelay = 10s;
    if (CItemWeapon* PRange = dynamic_cast<CItemWeapon*>(POwner->m_Weapons[SLOT_RANGED]))
    {
        rangedDelay = std::chrono::milliseconds(PRange->getDelay());
    }

    if (m_Tick - m_LastRangedAttackTime > rangedDelay && !m_InTransit)
    {
        FaceTarget(PTarget->targid);
        if (POwner->PAI->CanChangeState() && POwner->PAI->Internal_RangedAttack(targid))
        {
            m_LastRangedAttackTime = m_Tick;
        }
        return true;
    }
    return false;
}

bool CTrustController::Cast(uint16 targid, SpellID spellid)
{
    TracyZoneScoped;

    FaceTarget(targid);

    if (static_cast<CMobEntity*>(POwner)->PRecastContainer->Has(RECAST_MAGIC, static_cast<Recast>(spellid)))
    {
        return false;
    }

    auto* PSpell = spell::GetSpell(spellid);
    if (PSpell->getValidTarget() == TARGET_SELF)
    {
        targid = POwner->targid;
    }

    auto PTarget      = (CBattleEntity*)POwner->GetEntity(targid, TYPE_MOB | TYPE_PC | TYPE_PET | TYPE_TRUST);
    auto PSpellFamily = PSpell->getSpellFamily();
    bool canCast      = true;

    // clang-format off
    static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
    {
        if (PMember->objtype == TYPE_TRUST && PMember->PAI->IsCurrentState<CMagicState>())
        {
            auto MState = static_cast<CMagicState*>(PMember->PAI->GetCurrentState());

            if (MState)
            {
                auto MSpell       = MState->GetSpell();
                auto MTarget      = MState->GetTarget();
                auto MSpellFamily = MSpell->getSpellFamily();
                auto MSpellID     = MSpell->getID();

                if (PSpell->isBuff())
                {
                    if (PSpellFamily == MSpellFamily && spellid <= MSpellID)
                    {
                        canCast = false;
                    }
                }
                if (PSpell->isCure())
                {
                    if (PTarget == MTarget && PTarget->GetHPP() > 50)
                    {
                        canCast = false;
                    }
                }
                if (PSpell->isDebuff())
                {
                    if (PSpellFamily == MSpellFamily && spellid <= MSpellID)
                    {
                        canCast = false;
                    }
                }
                if (PSpell->isNa())
                {
                    if (PSpellFamily == MSpellFamily && spellid == MSpellID)
                    {
                        canCast = false;
                    }
                }
            }
        }
    });
    // clang-format on

    if (!canCast)
    {
        return false;
    }

    return CMobController::Cast(targid, spellid);
}

CBattleEntity* CTrustController::GetTopEnmity()
{
    TracyZoneScoped;

    CBattleEntity* PEntity = nullptr;
    if (auto* PMob = dynamic_cast<CMobEntity*>(POwner->PMaster->GetBattleTarget()))
    {
        return PMob->PEnmityContainer->GetHighestEnmity();
    }
    return PEntity;
}

uint8 CTrustController::GetPartyPosition()
{
    TracyZoneScoped;

    auto& trustList = static_cast<CCharEntity*>(POwner->PMaster)->PTrusts;
    for (std::size_t i = 0; i < trustList.size(); ++i)
    {
        if (trustList.at(i)->id == POwner->id)
        {
            return static_cast<uint8>(i);
        }
    }
    return 0;
}
