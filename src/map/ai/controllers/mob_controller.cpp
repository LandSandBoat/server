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
#include "status_effect_container.h"
#include "utils/battleutils.h"
#include "utils/petutils.h"

CMobController::CMobController(CMobEntity* PEntity)
: CController(PEntity)
, PMob(PEntity)
{
}

void CMobController::Tick(const timer::time_point tick)
{
    TracyZoneScoped;
    TracyZoneString(PMob->getName());

    m_Tick = tick;

    if (PMob->isAlive())
    {
        if (PMob->PAI->IsEngaged())
        {
            DoCombatTick(tick);
        }
        else if (!PMob->isDead())
        {
            DoRoamTick(tick);
        }
    }
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

auto CMobController::CanPursueTarget(const CBattleEntity* PTarget) const -> bool
{
    TracyZoneScoped;
    if (PMob->getMobMod(MOBMOD_DETECTION) & DETECT_SCENT)
    {
        // if mob is in water it will instant deaggro if target cannot be detected
        if (!PMob->PAI->PathFind->InWater() && PTarget && !PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_DEODORIZE))
        {
            // certain weather / deodorize will turn on time deaggro
            return !PMob->m_disableScent;
        }
    }
    return false;
}

auto CMobController::CheckHide(const CBattleEntity* PTarget) const -> bool
{
    TracyZoneScoped;
    if (PTarget && PTarget->GetMJob() == JOB_THF && PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_HIDE))
    {
        return !CanPursueTarget(PTarget) && !PMob->m_TrueDetection && !(PMob->getMobMod(MOBMOD_DETECTION) & DETECT_HEARING);
    }
    return false;
}

auto CMobController::CheckLock(CBattleEntity* PTarget) const -> bool
{
    TracyZoneScoped;
    if (PTarget)
    {
        if (PTarget->objtype == TYPE_PC)
        {
            const CCharEntity* PChar = dynamic_cast<CCharEntity*>(PTarget);
            if (PChar->m_Locked)
            {
                return !CanPursueTarget(PTarget);
            }
        }
        else if (PTarget->objtype == TYPE_PET)
        {
            const CPetEntity*  PPet  = dynamic_cast<CPetEntity*>(PTarget);
            const CCharEntity* PChar = dynamic_cast<CCharEntity*>(PPet->PMaster);

            if (PChar == nullptr)
            {
                return false;
            }

            if (PChar->m_Locked)
            {
                return !CanPursueTarget(PTarget);
            }
        }
    }
    return false;
}

auto CMobController::CheckDetection(CBattleEntity* PTarget) -> bool
{
    TracyZoneScoped;
    if (CanPursueTarget(PTarget) || CanDetectTarget(PTarget) ||
        PMob->StatusEffectContainer->HasStatusEffect({ EFFECT_BIND, EFFECT_SLEEP, EFFECT_SLEEP_II, EFFECT_LULLABY, EFFECT_PETRIFICATION }))
    {
        TapDeaggroTime();
    }

    const auto additionalDeaggroTime = PMob->m_roamFlags & ROAMFLAG_WORM ? std::chrono::seconds(0) : std::chrono::seconds(settings::get<uint32>("map.MOB_ADDITIONAL_TIME_TO_DEAGGRO"));
    return PMob->CanDeaggro() && (m_Tick >= m_DeaggroTime + 25s + additionalDeaggroTime);
}

void CMobController::TryLink()
{
    TracyZoneScoped;
    if (PTarget == nullptr)
    {
        return;
    }

    // handle pet behavior on the targets behalf (faster than in ai_pet_dummy)
    // Avatars defend masters by attacking mobs if the avatar isn't attacking anything currently (bodyguard behavior)
    // Alexander and Odin are passive and do not protect the master.
    if (PTarget->PPet != nullptr && PTarget->PPet->GetBattleTargetID() == 0)
    {
        if (PTarget->PPet->objtype == TYPE_PET)
        {
            const auto PPetEntity = static_cast<CPetEntity*>(PTarget->PPet);
            if (PPetEntity->getPetType() == PET_TYPE::AVATAR &&
                PPetEntity->m_PetID != PETID_ALEXANDER &&
                PPetEntity->m_PetID != PETID_ODIN)
            {
                if (PTarget->objtype == TYPE_PC)
                {
                    auto* PChar = dynamic_cast<CCharEntity*>(PTarget);
                    if (PChar && PChar->IsMobOwner(PMob))
                    {
                        petutils::AttackTarget(PTarget, PMob);
                    }
                }
                else
                {
                    petutils::AttackTarget(PTarget, PMob);
                }
            }
        }
    }

    // my pet should help as well
    if (PMob->PPet != nullptr && PMob->PPet->PAI->IsRoaming())
    {
        PMob->PPet->PAI->Engage(PTarget->targid);
    }

    // Handle monster linking if they are close enough
    if (PMob->PParty != nullptr && !PMob->getMobMod(MOBMOD_ONE_WAY_LINKING))
    {
        for (auto& member : PMob->PParty->members)
        {
            auto* PPartyMember = dynamic_cast<CMobEntity*>(member);
            // Note if the mob to link with this one is a pet then do not link
            // Pets only link with their masters
            if (!PPartyMember || PPartyMember->PMaster)
            {
                continue;
            }

            // Handle the case where a mob doesn't link with its own family but has a sublink
            // This is needed because the sublink will cause like family members to be in the same
            // party so that they are linked with sublinked families.
            if (!PMob->ShouldForceLink() && !PMob->m_Link && PMob->m_Family == PPartyMember->m_Family)
            {
                continue;
            }

            if (PPartyMember->PAI->IsRoaming() && PPartyMember->CanLink(&PMob->loc.p, PMob->getMobMod(MOBMOD_SUPERLINK)))
            {
                PPartyMember->PAI->Engage(PTarget->targid);
            }
        }
    }

    // ask my master for help
    if (PMob->PMaster != nullptr && PMob->PMaster->PAI->IsRoaming())
    {
        auto* PMaster = static_cast<CMobEntity*>(PMob->PMaster);

        if (PMaster->PAI->IsRoaming() && PMaster->CanLink(&PMob->loc.p, PMob->getMobMod(MOBMOD_SUPERLINK)))
        {
            PMaster->PAI->Engage(PTarget->targid);
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

    const auto detects         = PMob->getMobMod(MOBMOD_DETECTION);
    const auto currentDistance = distance(PTarget->loc.p, PMob->loc.p) + PTarget->getMod(Mod::STEALTH);

    const bool detectSight  = (detects & DETECT_SIGHT) || forceSight;
    bool       hasInvisible = false;
    bool       hasSneak     = false;

    if (!PMob->m_TrueDetection)
    {
        hasInvisible = PTarget->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_INVISIBLE);
        hasSneak     = PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_SNEAK);
    }

    // Illusion effect seems to ignore true detection (true sound Porrogos don't aggro with Illusion up)
    // Additionally, mobs that would normally aggro you via sound that also ignore illusion must also ignore you with illusion if you have sneak up,
    // Fish in Mamook will see you through Illusion but not if you have sneak up
    if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_ILLUSION))
    {
        if (!PMob->getMobMod(MOBMOD_SEES_THROUGH_ILLUSION))
        {
            hasInvisible = true;
            hasSneak     = true;
        }
    }

    const bool isTargetAndInRange = PMob->GetBattleTargetID() == PTarget->targid && currentDistance <= PMob->GetMeleeRange();

    if (detectSight && !hasInvisible && currentDistance < PMob->getMobMod(MOBMOD_SIGHT_RANGE) && facing(PMob->loc.p, PTarget->loc.p, 64))
    {
        return isTargetAndInRange || PMob->CanSeeTarget(PTarget);
    }

    if ((PMob->m_Behavior & BEHAVIOR_AGGRO_AMBUSH) && currentDistance < 3 && !hasSneak)
    {
        return true;
    }

    if ((detects & DETECT_HEARING) && currentDistance < PMob->getMobMod(MOBMOD_SOUND_RANGE) && !hasSneak)
    {
        return isTargetAndInRange || PMob->CanSeeTarget(PTarget);
    }

    if ((detects & DETECT_MAGIC) && currentDistance < PMob->getMobMod(MOBMOD_MAGIC_RANGE) &&
        PTarget->PAI->IsCurrentState<CMagicState>() && static_cast<CMagicState*>(PTarget->PAI->GetCurrentState())->GetSpell()->hasMPCost())
    {
        return isTargetAndInRange || PMob->CanSeeTarget(PTarget);
    }

    // everything below require distance to be below 20
    if (currentDistance > 20)
    {
        return false;
    }

    if ((detects & DETECT_LOWHP) && PTarget->GetHPP() < 75)
    {
        return isTargetAndInRange || PMob->CanSeeTarget(PTarget);
    }

    if ((detects & DETECT_WEAPONSKILL) && PTarget->PAI->IsCurrentState<CWeaponSkillState>())
    {
        return isTargetAndInRange || PMob->CanSeeTarget(PTarget);
    }

    if ((detects & DETECT_JOBABILITY) && PTarget->PAI->IsCurrentState<CAbilityState>())
    {
        return isTargetAndInRange || PMob->CanSeeTarget(PTarget);
    }

    return false;
}

auto CMobController::MobSkill(int listId) -> bool
{
    TracyZoneScoped;

    if (PTarget)
    {
        /* #TODO: mob 2 hours, etc */
        if (!listId)
        {
            listId = PMob->getMobMod(MOBMOD_SKILL_LIST);
        }

        auto skillList{ battleutils::GetMobSkillList(listId) };

        if (auto overrideSkill = luautils::OnMobWeaponSkillPrepare(PMob, PTarget); overrideSkill > 0)
        {
            skillList = { overrideSkill };
        }

        if (skillList.empty())
        {
            return false;
        }

        std::shuffle(skillList.begin(), skillList.end(), xirand::rng());
        CBattleEntity* PActionTarget{ nullptr };

        for (const auto skillid : skillList)
        {
            auto* PMobSkill{ battleutils::GetMobSkill(skillid) };
            if (!PMobSkill)
            {
                continue;
            }

            if (PMobSkill->getValidTargets() & TARGET_ENEMY) // enemy
            {
                PActionTarget = PTarget;
            }
            else if (PMobSkill->getValidTargets() & TARGET_SELF) // self
            {
                PActionTarget = PMob;
            }
            else
            {
                continue;
            }

            PActionTarget = luautils::OnMobSkillTarget(PActionTarget, PMob, PMobSkill);

            if (PActionTarget && !PMobSkill->isAstralFlow() && luautils::OnMobSkillCheck(PActionTarget, PMob, PMobSkill) == 0) // A script says that the move in question is valid
            {
                const float currentDistance = distance(PMob->loc.p, PActionTarget->loc.p);

                if (currentDistance <= PMobSkill->getDistance())
                {
                    return MobSkill(PActionTarget->targid, PMobSkill->getID(), std::nullopt);
                }
            }
        }
    }

    return false;
}

auto CMobController::TrySpecialSkill() -> bool
{
    TracyZoneScoped;
    // get my special skill
    CMobSkill*     PSpecialSkill  = battleutils::GetMobSkill(PMob->getMobMod(MOBMOD_SPECIAL_SKILL));
    CBattleEntity* PAbilityTarget = nullptr;

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

    if (PSpecialSkill->getValidTargets() & TARGET_SELF)
    {
        PAbilityTarget = PMob;
    }
    else if (PTarget != nullptr)
    {
        // distance check for special skill
        float currentDistance = distance(PMob->loc.p, PTarget->loc.p);

        if (currentDistance <= PSpecialSkill->getDistance())
        {
            PAbilityTarget = PTarget;
        }
        else
        {
            return false;
        }
    }
    else
    {
        return false;
    }

    if (luautils::OnMobSkillCheck(PAbilityTarget, PMob, PSpecialSkill) == 0)
    {
        if (MobSkill(PAbilityTarget->targid, PSpecialSkill->getID(), std::nullopt))
        {
            m_LastSpecialTime = m_Tick;
            return true;
        }
    }

    return false;
}

auto CMobController::TryCastSpell() -> bool
{
    TracyZoneScoped;
    if (!CanCastSpells())
    {
        return false;
    }

    // Find random spell from list
    std::optional<SpellID> chosenSpellId;
    if (!PMob->PAI->IsEngaged())
    {
        if (PMob->SpellContainer->HasBuffSpells())
        {
            chosenSpellId = PMob->SpellContainer->GetBuffSpell();
        }
        else
        {
            // is this even possible to have a valid target?
            chosenSpellId = PMob->SpellContainer->GetSpell();
        }
    }
    else if (m_firstSpell)
    {
        // mobs first combat spell, should be aggro spell
        chosenSpellId = PMob->SpellContainer->GetAggroSpell();
        m_firstSpell  = false;
    }
    else
    {
        chosenSpellId = PMob->SpellContainer->GetSpell();
    }

    // Try to get an override spell from the script (if available)
    auto PSpellTarget            = PTarget ? PTarget : PMob;
    auto possibleOverriddenSpell = luautils::OnMobMagicPrepare(PMob, PSpellTarget, chosenSpellId);
    if (possibleOverriddenSpell.has_value())
    {
        chosenSpellId = possibleOverriddenSpell;
    }

    if (chosenSpellId.has_value())
    {
        // Check if we can actually cast this spell before committing to it
        CSpell* PSpell = spell::GetSpell(chosenSpellId.value());
        if (!PSpell)
        {
            ShowWarning("CMobController::TryCastSpell: SpellId <%i> is not found", static_cast<uint16>(chosenSpellId.value()));
            return false;
        }
        else
        {
            CBattleEntity* PCastTarget = nullptr;
            if (PSpell->getValidTarget() & TARGET_SELF)
            {
                PCastTarget = PMob;
            }
            else
            {
                PCastTarget = PTarget;
            }

            // Check if target is in range before attempting to cast
            if (PCastTarget && distance(PMob->loc.p, PCastTarget->loc.p) > PSpell->getRange())
            {
                return false;
            }

            // Check if mob can afford to cast this spell
            if (!battleutils::CanAffordSpell(PMob, PSpell, PSpell->getFlag()))
            {
                return false;
            }
        }

        CastSpell(chosenSpellId.value());
        return true;
    }

    return false;
}

auto CMobController::CanCastSpells() -> bool
{
    TracyZoneScoped;
    if (!PMob->SpellContainer->HasSpells())
    {
        return false;
    }

    // check for spell blockers e.g. silence
    if (PMob->StatusEffectContainer->HasStatusEffect({ EFFECT_SILENCE, EFFECT_MUTE }))
    {
        return false;
    }

    // smn can only cast spells if it has no pet
    if (PMob->GetMJob() == JOB_SMN)
    {
        if (PMob->PPet && !PMob->PPet->isDead())
        {
            return false;
        }
    }

    return IsMagicCastingEnabled();
}

void CMobController::CastSpell(SpellID spellid)
{
    TracyZoneScoped;
    const CSpell* PSpell = spell::GetSpell(spellid);
    if (PSpell == nullptr)
    {
        ShowWarning("ai_mob_dummy::CastSpell: SpellId <%i> is not found", static_cast<uint16>(spellid));
    }
    else
    {
        CBattleEntity* PCastTarget = nullptr;
        // check valid targets
        if (PSpell->getValidTarget() & TARGET_SELF)
        {
            PCastTarget = PMob;

            // only buff other targets if i'm roaming
            if ((PSpell->getValidTarget() & TARGET_PLAYER_PARTY))
            {
                // chance to target my master
                if (PMob->PMaster != nullptr && xirand::GetRandomNumber(2) == 0)
                {
                    // target my master
                    PCastTarget = PMob->PMaster;
                }
                else if (xirand::GetRandomNumber(2) == 0)
                {
                    // chance to target party
                    PMob->PAI->TargetFind->reset();
                    PMob->PAI->TargetFind->findWithinArea(PMob, AOE_RADIUS::ATTACKER, PSpell->getRange(), FINDFLAGS_NONE, TARGET_NONE);

                    if (!PMob->PAI->TargetFind->m_targets.empty())
                    {
                        // randomly select a target
                        PCastTarget = PMob->PAI->TargetFind->m_targets[xirand::GetRandomNumber(PMob->PAI->TargetFind->m_targets.size())];

                        // revert target to self if not on same action
                        // TODO can engaged mobs buff idle mobs?
                        if (PMob->PAI->IsEngaged() != PCastTarget->PAI->IsEngaged())
                        {
                            PCastTarget = PMob;
                        }
                    }
                }
            }
        }
        else
        {
            PCastTarget = PTarget;
        }

        if (PCastTarget)
        {
            Cast(PCastTarget->targid, spellid);
        }
    }
}

void CMobController::DoCombatTick(timer::time_point tick)
{
    TracyZoneScopedC(0xFF0000);
    if (PMob->m_OwnerID.targid != 0 && static_cast<CCharEntity*>(PMob->GetEntity(PMob->m_OwnerID.targid))->PClaimedMob != static_cast<CBattleEntity*>(PMob))
    {
        if (m_Tick >= m_DeclaimTime + 3s)
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
        return;
    }

    TryLink();

    PMob->PAI->EventHandler.triggerListener("COMBAT_TICK", PMob);
    luautils::OnMobFight(PMob, PTarget);

    if (PMob->PAI->IsCurrentState<CInactiveState>() || !PMob->PAI->CanChangeState())
    {
        return;
    }

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
        return;
    }

    if (PTarget)
    {
        const float currentDistance = distance(PMob->loc.p, PTarget->loc.p);

        if (IsSpecialSkillReady(currentDistance) && TrySpecialSkill())
        {
            return;
        }

        if (IsSpellReady(currentDistance) && TryCastSpell()) // Try to spellcast (this is done first so things like Chainspell spam is prioritised over TP moves etc.
        {
            return;
        }

        if (m_Tick >= m_LastMobSkillTime && (1 + xirand::GetRandomNumber(10000)) <= PMob->TPUseChance() && MobSkill())
        {
            return;
        }
    }

    Move();
}

void CMobController::FaceTarget(const uint16 targid) const
{
    TracyZoneScoped;
    const CBaseEntity* targ = PTarget;
    if (targid != 0 && ((targ && targid != targ->targid) || !targ))
    {
        targ = PMob->GetEntity(targid);
    }
    if (!(PMob->m_Behavior & BEHAVIOR_NO_TURN) && targ)
    {
        PMob->PAI->PathFind->LookAt(targ->loc.p);
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
    if (PMob->PAI->PathFind->IsFollowingScriptedPath() && PMob->PAI->CanFollowPath())
    {
        PMob->PAI->PathFind->FollowPath(m_Tick);
        return;
    }

    const bool  move          = PMob->PAI->PathFind->IsFollowingPath();
    float       attack_range  = PMob->GetMeleeRange();
    const int16 offsetMod     = PMob->getMobMod(MOBMOD_TARGET_DISTANCE_OFFSET);
    const float offset        = static_cast<float>(offsetMod) / 10.0f;
    float       closeDistance = (attack_range - (offsetMod == 0 ? 0.2f : offset)) / 2;

    // No going negative on the final value.
    if (closeDistance < 0.0f)
    {
        closeDistance = 0.0f;
    }

    if (PMob->getMobMod(MOBMOD_ATTACK_SKILL_LIST) > 0)
    {
        const auto skillList{ battleutils::GetMobSkillList(PMob->getMobMod(MOBMOD_ATTACK_SKILL_LIST)) };

        if (!skillList.empty())
        {
            const auto* skill{ battleutils::GetMobSkill(skillList.front()) };
            if (skill)
            {
                attack_range = skill->getDistance();
            }
        }
    }

    if (PMob->getMobMod(MOBMOD_SHARE_POS) > 0)
    {
        const auto* posShare = static_cast<CMobEntity*>(PMob->GetEntity(PMob->getMobMod(MOBMOD_SHARE_POS) + PMob->targid, TYPE_MOB));
        if (posShare)
        {
            PMob->loc = posShare->loc;
        }
        else
        {
            ShowWarning("CMobController::Move() failed to get mob for MOBMOD_SHARE_POS");
        }
    }
    else if (PTarget)
    {
        float currentDistance = distance(PMob->loc.p, PTarget->loc.p);

        // attempt to teleport (type 1) if target is out of melee range but within 30 distance
        if (PMob->getMobMod(MOBMOD_TELEPORT_TYPE) == 1 && currentDistance > attack_range && currentDistance <= 30.0f)
        {
            if (m_Tick >= m_LastSpecialTime + std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_TELEPORT_CD)))
            {
                if (const CMobSkill* teleportBegin = battleutils::GetMobSkill(PMob->getMobMod(MOBMOD_TELEPORT_START)))
                {
                    m_LastSpecialTime = m_Tick;
                    MobSkill(PMob->targid, teleportBegin->getID(), std::nullopt);
                }
            }
        }

        if (((currentDistance > closeDistance) || move) && PMob->PAI->CanFollowPath())
        {
            if (PMob->GetSpeed() != 0 && PMob->getMobMod(MOBMOD_NO_MOVE) == 0 && m_Tick >= m_LastSpecialTime)
            {
                // attempt to teleport to target (if in range)
                if (PMob->getMobMod(MOBMOD_TELEPORT_TYPE) == 2)
                {
                    CMobSkill* teleportBegin = battleutils::GetMobSkill(PMob->getMobMod(MOBMOD_TELEPORT_START));

                    if (teleportBegin && currentDistance <= teleportBegin->getDistance())
                    {
                        MobSkill(PMob->targid, teleportBegin->getID(), std::nullopt);
                        m_LastSpecialTime = m_Tick;
                        return;
                    }
                }
                else if (CanMoveForward(currentDistance))
                {
                    if (!PMob->PAI->PathFind->IsFollowingPath())
                    {
                        // out of melee range, try to path towards
                        if (currentDistance > closeDistance)
                        {
                            // try to find path towards target
                            PMob->PAI->PathFind->PathInRange(PTarget->loc.p, closeDistance, PATHFLAG_WALLHACK | PATHFLAG_RUN);
                        }
                    }
                    else if (!isWithinDistance(PMob->PAI->PathFind->GetDestination(), PTarget->loc.p, 2.5f))
                    {
                        // try to find path towards target
                        PMob->PAI->PathFind->PathInRange(PTarget->loc.p, closeDistance, PATHFLAG_WALLHACK | PATHFLAG_RUN);
                    }

                    PMob->PAI->PathFind->FollowPath(m_Tick);

                    if (!PMob->PAI->PathFind->IsFollowingPath())
                    {
                        bool needToMove = false;

                        // arrived at target - move if there is another mob under me
                        if (PTarget->objtype == TYPE_PC)
                        {
                            for (auto PSpawnedMob : static_cast<CCharEntity*>(PTarget)->SpawnMOBList)
                            {
                                if (PSpawnedMob.second != PMob && !PSpawnedMob.second->PAI->PathFind->IsFollowingPath() &&
                                    distance(PSpawnedMob.second->loc.p, PMob->loc.p) < 1.0f)
                                {
                                    auto angle = worldAngle(PMob->loc.p, PTarget->loc.p) + 64;

                                    // clang-format off
                                position_t new_pos
                                {
                                    PMob->loc.p.x - (cosf(rotationToRadian(angle)) * 1.5f),
                                    PTarget->loc.p.y,
                                    PMob->loc.p.z + (sinf(rotationToRadian(angle)) * 1.5f),
                                    0,
                                    0
                                };
                                    // clang-format on

                                    if (PMob->PAI->PathFind->ValidPosition(new_pos))
                                    {
                                        PMob->PAI->PathFind->PathTo(new_pos, PATHFLAG_WALLHACK | PATHFLAG_RUN);
                                        needToMove = true;
                                    }
                                    break;
                                }
                            }
                        }

                        // Fix corner case where mob is attacking target at essentially exactly the distance that canMoveForward returns true at.
                        // where the mob doesn't rotate to face their target.
                        if (!needToMove)
                        {
                            FaceTarget();
                        }
                    }
                }
                else
                {
                    FaceTarget();
                }
            }
        }
        else
        {
            FaceTarget();
        }
    }
    else
    {
        FaceTarget();
    }
}

void CMobController::HandleEnmity()
{
    TracyZoneScoped;
    PMob->PEnmityContainer->DecayEnmity();
    auto* PHighestEnmityTarget{ PMob->PEnmityContainer->GetHighestEnmity() };

    if (PMob->getMobMod(MOBMOD_SHARE_TARGET) > 0 && PMob->GetEntity(PMob->getMobMod(MOBMOD_SHARE_TARGET), TYPE_MOB))
    {
        ChangeTarget(static_cast<CMobEntity*>(PMob->GetEntity(PMob->getMobMod(MOBMOD_SHARE_TARGET), TYPE_MOB))->GetBattleTargetID());

        if (!PMob->GetBattleTargetID())
        {
            if (PHighestEnmityTarget)
            {
                ChangeTarget(PHighestEnmityTarget->targid);
            }
        }
    }
    else
    {
        if (PHighestEnmityTarget)
        {
            ChangeTarget(PHighestEnmityTarget->targid);
        }
    }

    // Bind special case
    // Target the closest person on hate list with enmity
    // TODO: do mobs with bind attack players *without* enmity if they are in the same party?
    // TODO: do jug pets do this?
    // TODO: This code is assuming charmed mobs can do this -- they DO keep an enmity table, after all..
    if (PMob->objtype == TYPE_MOB && PMob->StatusEffectContainer && PMob->StatusEffectContainer->HasStatusEffect(EFFECT::EFFECT_BIND) && PMob->PAI->IsCurrentState<CAttackState>())
    {
        CBattleEntity*                PNewTarget = nullptr;
        std::unique_ptr<CBasicPacket> m_errorMsg; // Ignored
        if (PTarget && !PMob->CanAttack(PTarget, m_errorMsg) && PMob->PEnmityContainer)
        {
            float minDistance = 999999;
            int32 totalEnmity = -1;

            auto enmityList = PMob->PEnmityContainer->GetEnmityList();
            for (auto enmityItem : *enmityList)
            {
                const EnmityObject_t& enmityObject = enmityItem.second;
                CBattleEntity*        PEnmityOwner = enmityObject.PEnmityOwner;

                // Check total enmity first
                if (PEnmityOwner && (enmityObject.CE + enmityObject.VE) > totalEnmity)
                {
                    float targetDistance = distance(PEnmityOwner->loc.p, PMob->loc.p);

                    if (targetDistance < minDistance && PMob->CanAttack(PEnmityOwner, m_errorMsg))
                    {
                        minDistance = targetDistance;
                        totalEnmity = enmityObject.CE + enmityObject.VE;
                        PNewTarget  = PEnmityOwner;
                    }
                }
            }
        }

        if (PNewTarget)
        {
            ChangeTarget(PNewTarget->targid);
        }

        if (PTarget)
        {
            FaceTarget(PTarget->targid);
        }
    }
}

void CMobController::DoRoamTick(timer::time_point tick)
{
    TracyZoneScopedC(0x00FF00);
    // If there's someone on our enmity list, go from roaming -> engaging
    if (PMob->PEnmityContainer->GetHighestEnmity() != nullptr && !(PMob->m_roamFlags & ROAMFLAG_IGNORE))
    {
        Engage(PMob->PEnmityContainer->GetHighestEnmity()->targid);
        return;
    }
    else if (PMob->m_OwnerID.id != 0 && !(PMob->m_roamFlags & ROAMFLAG_IGNORE))
    {
        // i'm claimed by someone and want to be fighting them
        PTarget = static_cast<CBattleEntity*>(PMob->GetEntity(PMob->m_OwnerID.targid, TYPE_PC | TYPE_MOB | TYPE_PET | TYPE_TRUST));

        if (PTarget != nullptr)
        {
            Engage(PTarget->targid);
        }

        return;
    }
    // TODO
    else if (PMob->GetDespawnTime() > timer::time_point::min() && PMob->GetDespawnTime() < m_Tick)
    {
        Despawn();
        return;
    }

    if (PMob->m_roamFlags & ROAMFLAG_IGNORE)
    {
        // don't claim me if I ignore
        PMob->m_OwnerID.clean();
    }

    if (PFollowTarget != nullptr && m_followType == FollowType::Roam && distance(PMob->loc.p, PFollowTarget->loc.p) > FollowRoamDistance)
    {
        PMob->PAI->PathFind->PathAround(PFollowTarget->loc.p, 2.0f, PATHFLAG_RUN | PATHFLAG_WALLHACK);
        PMob->PAI->PathFind->FollowPath(m_Tick);
    }

    if (m_Tick >= m_mobHealTime + 10s && PMob->getMobMod(MOBMOD_NO_REST) == 0 && PMob->CanRest())
    {
        // recover 10% health and lose tp
        if (PMob->Rest(0.1f))
        {
            // health updated
            PMob->updatemask |= UPDATE_HP;
        }

        if (PMob->GetHPP() == 100)
        {
            // at max health undirty exp
            PMob->m_HiPCLvl     = 0;
            PMob->m_HiPartySize = 0;
            PMob->m_giveExp     = true;
            PMob->m_UsedSkillIds.clear();
        }
        m_mobHealTime = m_Tick;
    }

    // skip roaming if waiting
    if (m_Tick >= m_WaitTime)
    {
        // don't aggro a little bit after I just disengaged
        PMob->m_neutral = PMob->CanBeNeutral() && m_Tick <= m_NeutralTime + 10s;

        if (PMob->PAI->PathFind->IsFollowingPath())
        {
            FollowRoamPath();
        }
        else if (PMob->PAI->PathFind->IsPatrolling())
        {
            PMob->PAI->PathFind->ResumePatrol();
            FollowRoamPath();
        }
        else if (m_Tick >= m_LastActionTime + std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_ROAM_COOL)))
        {
            // lets buff up or move around
            if (PMob->GetCallForHelpFlag())
            {
                PMob->SetCallForHelpFlag(false);
            }

            // if I just disengaged check if I should despawn
            PMob->m_IsPathingHome = false;
            if (!PMob->getMobMod(MOBMOD_DONT_ROAM_HOME) && PMob->IsFarFromHome())
            {
                if (PMob->CanRoamHome())
                {
                    PMob->m_IsPathingHome = true;
                    // walk back to spawn if too far away
                    if (!PMob->PAI->PathFind->IsFollowingPath() && !PMob->PAI->PathFind->PathTo(PMob->m_SpawnPoint))
                    {
                        PMob->PAI->PathFind->PathInRange(PMob->m_SpawnPoint, PMob->m_maxRoamDistance, PATHFLAG_RUN | PATHFLAG_WALLHACK);
                    }

                    // limit total path to just 10 or
                    // else we'll move straight back to spawn
                    PMob->PAI->PathFind->LimitDistance(10.0f);

                    FollowRoamPath();

                    // move back every 5 seconds
                    m_LastActionTime = m_Tick - (std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_ROAM_COOL)) + 10s);
                }
                else if (!(PMob->getMobMod(MOBMOD_NO_DESPAWN) != 0) && !settings::get<bool>("map.MOB_NO_DESPAWN"))
                {
                    PMob->PAI->Despawn();
                    return;
                }
            }
            else
            {
                if (!(PMob->getMobMod(MOBMOD_NO_DESPAWN) != 0) && PMob->PMaster != nullptr && !PMob->PMaster->isAlive())
                {
                    // despawn pets if they are disengaged and master is dead
                    PMob->PAI->Despawn();
                    return;
                }

                // No longer including conditional for ROAMFLAG_AMBUSH now that using mixin to handle mob hiding
                if (IsSpecialSkillReady(0) && TrySpecialSkill())
                {
                    // I spawned a pet
                }
                else if (
                    (!PMob->PBattlefield || PMob->PBattlefield->GetStatus() != BATTLEFIELD_STATUS_OPEN) &&
                    PMob->GetMJob() == JOB_SMN && CanCastSpells() &&
                    PMob->SpellContainer->HasBuffSpells() && m_Tick >= m_nextMagicTime)
                {
                    // summon pet
                    // - initial summoner-mob pets in battlefields will happen via battlefield.lua, so the first player sees the action
                    // - Once battlefield is locked, behavior is back to normal with no rng added to pet summoning
                    TryCastSpell();
                }
                else if (CanCastSpells() && xirand::GetRandomNumber(10) < 3 && PMob->SpellContainer->HasBuffSpells())
                {
                    // cast buff
                    TryCastSpell();
                }
                else if (PMob->m_roamFlags & ROAMFLAG_SCRIPTED)
                {
                    // allow custom event action
                    PMob->PAI->EventHandler.triggerListener("ROAM_ACTION", PMob);
                    luautils::OnMobRoamAction(PMob);
                    m_LastActionTime = m_Tick;
                }
                else if (PMob->CanRoam())
                {
                    // TODO: #AIToScript (event probably)
                    if (PMob->m_roamFlags & ROAMFLAG_WORM && !PMob->IsNameHidden())
                    {
                        // don't reset m_LastActionTime until the roaming commences
                        if (!PMob->PAI->IsCurrentState<CMagicState>())
                        {
                            // move down
                            PMob->animationsub = 1;
                            PMob->HideName(true);
                            PMob->SetUntargetable(true);

                            // don't move around until i'm fully in the ground
                            // Transition underground takes 2s, allow extra time for any magic effect to finish
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
                    }
                    else if (PMob->PAI->PathFind->RoamAround(PMob->m_SpawnPoint, PMob->GetRoamDistance(), static_cast<uint8>(PMob->getMobMod(MOBMOD_ROAM_TURNS)), PMob->m_roamFlags))
                    {
                        if ((PMob->m_roamFlags & ROAMFLAG_STEALTH))
                        {
                            // hidden name
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
    }
    if (m_Tick >= m_LastRoamScript + 3s)
    {
        PMob->PAI->EventHandler.triggerListener("ROAM_TICK", PMob);
        luautils::OnMobRoam(PMob);
        m_LastRoamScript = m_Tick;
    }
}

void CMobController::Wait(timer::duration _duration)
{
    if (m_Tick > m_WaitTime)
    {
        m_WaitTime = m_Tick += _duration;
    }
    else
    {
        m_WaitTime += _duration;
    }
}

void CMobController::FollowRoamPath()
{
    TracyZoneScoped;
    if (PMob->PAI->CanFollowPath())
    {
        PMob->PAI->PathFind->FollowPath(m_Tick);

        CBattleEntity* PPet = PMob->PPet;
        if (PPet != nullptr && PPet->PAI->IsSpawned() && !PPet->PAI->IsEngaged())
        {
            // pet should follow me if roaming
            position_t targetPoint = nearPosition(PMob->loc.p, 2.1f, (float)M_PI);

            PPet->PAI->PathFind->PathTo(targetPoint);
        }

        // if I just finished reset my last action time
        if (!PMob->PAI->PathFind->IsFollowingPath())
        {
            const uint16 roamRandomness = static_cast<uint16>(PMob->getBigMobMod(MOBMOD_ROAM_COOL) / PMob->GetRoamRate());
            m_LastActionTime            = m_Tick - std::chrono::milliseconds(xirand::GetRandomNumber(roamRandomness));

            // i'm a worm pop back up
            if (PMob->m_roamFlags & ROAMFLAG_WORM && PMob->PAI->IsUntargetable())
            {
                // send a final position update before coming out of the ground to avoid a slight movement as it emerges
                PMob->loc.zone->UpdateEntityPacket(PMob, ENTITY_UPDATE, UPDATE_POS);

                // don't re-enter this block, but don't roam until emerging
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

            // face spawn rotation if I just moved back to spawn
            // used by dynamis mobs, bcnm mobs etc
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
    m_LastActionTime = m_Tick - std::chrono::milliseconds(xirand::GetRandomNumber(PMob->getBigMobMod(MOBMOD_ROAM_COOL)));

    // Don't attack player right off of spawn
    PMob->m_neutral = true;
    m_NeutralTime   = m_Tick;

    PTarget = nullptr;
    ClearFollowTarget();
}

auto CMobController::MobSkill(const uint16 targid, uint16 wsid, std::optional<timer::duration> castTimeOverride) -> bool
{
    TracyZoneScoped;
    if (POwner)
    {
        FaceTarget(targid);
        PMob->PAI->EventHandler.triggerListener("WEAPONSKILL_BEFORE_USE", PMob, wsid);
        return POwner->PAI->Internal_MobSkill(targid, wsid, castTimeOverride);
    }

    return false;
}

auto CMobController::Disengage() -> bool
{
    TracyZoneScoped;
    // this will let me decide to walk home or despawn
    m_LastActionTime = m_Tick - std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_ROAM_COOL)) + 10s;
    PMob->m_neutral  = true;
    m_NeutralTime    = m_Tick;

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
    auto ret = CController::Engage(targid);
    if (ret)
    {
        m_firstSpell = true;

        if (PFollowTarget != nullptr && m_followType == FollowType::Roam)
        {
            ClearFollowTarget();
        }

        // Don't cast magic or use special ability right away
        if (PMob->getBigMobMod(MOBMOD_MAGIC_DELAY) != 0)
        {
            m_nextMagicTime =
                m_Tick + std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_MAGIC_COOL) + xirand::GetRandomNumber(PMob->getBigMobMod(MOBMOD_MAGIC_DELAY)));
        }

        if (PMob->getBigMobMod(MOBMOD_SPECIAL_DELAY) != 0)
        {
            m_LastSpecialTime = m_Tick - std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_SPECIAL_COOL) +
                                                                   xirand::GetRandomNumber(PMob->getBigMobMod(MOBMOD_SPECIAL_DELAY)));
        }

        // Pet should also fight the target if they can
        if (PMob->PPet && !PMob->PPet->PAI->IsEngaged())
        {
            PMob->PPet->PAI->Engage(targid);
        }
    }
    return ret;
}

auto CMobController::CanFollowTarget(CBattleEntity* PTarget) const -> bool
{
    return !PMob->m_neutral && (PMob->m_roamFlags & ROAMFLAG_FOLLOW) && PFollowTarget == nullptr && m_followType == FollowType::None && CanAggroTarget(PTarget);
}

auto CMobController::CanAggroTarget(CBattleEntity* PTarget) const -> bool
{
    TracyZoneScoped;
    TracyZoneString(PMob->getName());
    if (PTarget)
    {
        TracyZoneString(PTarget->getName());

        if (PMob->getBattleID() != PTarget->getBattleID())
        {
            return false;
        }

        // Don't aggro I'm neutral
        if ((PMob->getMobMod(MOBMOD_ALWAYS_AGGRO) == 0 && !PMob->m_Aggro) || PMob->m_neutral || PMob->isDead())
        {
            return false;
        }

        // Don't aggro I'm special
        if (PMob->getMobMod(MOBMOD_NO_AGGRO) > 0)
        {
            return false;
        }

        // Do not aggro if a normal CoP Fomor and the player has low enough fomor hate
        if (PMob->m_Family == 115 && !(PMob->m_Type & MOBTYPE_NOTORIOUS) &&
            (PMob->getZone() >= ZONE_LUFAISE_MEADOWS && PMob->getZone() <= ZONE_SACRARIUM) &&
            PTarget->objtype == TYPE_PC)
        {
            if (static_cast<CCharEntity*>(PTarget)->getCharVar("FOMOR_HATE") < 8)
            {
                return false;
            }
        }

        // Don't aggro I'm an underground worm
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

    return false;
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
    FaceTarget(targid);
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
    if (PFollowTarget && m_followType != FollowType::None)
    {
        return true;
    }

    return false;
}

void CMobController::ClearFollowTarget()
{
    PFollowTarget = nullptr;
    m_followType  = FollowType::None;
}

void CMobController::OnCastStopped(CMagicState& state, action_t& action)
{
    int32 magicCool = PMob->getBigMobMod(MOBMOD_MAGIC_COOL);
    m_nextMagicTime = m_Tick + std::chrono::milliseconds(xirand::GetRandomNumber(magicCool / 2, magicCool));
}

auto CMobController::CanMoveForward(const float currentDistance) -> bool
{
    TracyZoneScoped;

    uint16 standbackRange = 20;

    if (PMob->getMobMod(MOBMOD_STANDBACK_RANGE) > 0)
    {
        standbackRange = PMob->getMobMod(MOBMOD_STANDBACK_RANGE);
    }

    if (PMob->m_Behavior & BEHAVIOR_STANDBACK && currentDistance < standbackRange && PMob->CanSeeTarget(PTarget))
    {
        return false;
    }

    auto standbackThreshold = PMob->getMobMod(MOBMOD_HP_STANDBACK);
    if (currentDistance < standbackRange &&
        standbackThreshold > 0 &&
        PMob->getMobMod(MOBMOD_NO_STANDBACK) == 0 &&
        PMob->GetHPP() >= standbackThreshold &&
        (PMob->GetMaxMP() == 0 || PMob->GetMPP() >= standbackThreshold))
    {
        // Excluding Nins, mobs should not standback if can't cast magic
        return PMob->GetMJob() != JOB_NIN && PMob->SpellContainer->HasSpells() && !CanCastSpells();
    }

    if (PTarget && !PMob->CanSeeTarget(PTarget))
    {
        return true;
    }

    if (PMob->getMobMod(MOBMOD_SPAWN_LEASH) > 0 && distance(PMob->loc.p, PMob->m_SpawnPoint) > PMob->getMobMod(MOBMOD_SPAWN_LEASH))
    {
        return false;
    }

    return true;
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

    int32 bonusTime = 0;
    if (currentDistance > 5)
    {
        // Mobs use ranged attacks quicker when standing back
        bonusTime = PMob->getBigMobMod(MOBMOD_STANDBACK_COOL);
    }

    return m_Tick >= m_LastSpecialTime + std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_SPECIAL_COOL) - bonusTime);
}

auto CMobController::IsSpellReady(const float currentDistance) const -> bool
{
    TracyZoneScoped;

    if (PMob->StatusEffectContainer->HasStatusEffect({ EFFECT_CHAINSPELL, EFFECT_MANAFONT }))
    {
        return true;
    }

    if (currentDistance > 5)
    {
        // Mobs use magic quicker when standing back
        return m_Tick >= (m_nextMagicTime - std::chrono::milliseconds(PMob->getBigMobMod(MOBMOD_STANDBACK_COOL)));
    }

    return m_Tick >= m_nextMagicTime;
}
