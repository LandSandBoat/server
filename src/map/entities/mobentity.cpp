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

#include "mobentity.h"

#include "../ability.h"
#include "../ai/ai_container.h"
#include "../ai/controllers/mob_controller.h"
#include "../ai/helpers/pathfind.h"
#include "../ai/helpers/targetfind.h"
#include "../ai/states/attack_state.h"
#include "../ai/states/mobskill_state.h"
#include "../ai/states/weaponskill_state.h"
#include "../battlefield.h"
#include "../conquest_system.h"
#include "../enmity_container.h"
#include "../entities/charentity.h"
#include "../lua/lua_loot.h"
#include "../mob_modifier.h"
#include "../mob_spell_container.h"
#include "../mob_spell_list.h"
#include "../mobskill.h"
#include "../packets/action.h"
#include "../packets/entity_update.h"
#include "../packets/pet_sync.h"
#include "../roe.h"
#include "../status_effect_container.h"
#include "../treasure_pool.h"
#include "../utils/battleutils.h"
#include "../utils/blueutils.h"
#include "../utils/charutils.h"
#include "../utils/itemutils.h"
#include "../utils/mobutils.h"
#include "../utils/petutils.h"
#include "../utils/zoneutils.h"
#include "../weapon_skill.h"
#include "common/timer.h"
#include "common/utils.h"

#include <algorithm>
#include <cstring>
#include <random>

CMobEntity::CMobEntity()
{
    TracyZoneScoped;
    objtype = TYPE_MOB;

    m_DropID = 0;

    m_minLevel = 1;
    m_maxLevel = 1;

    HPscale = 1.0;
    MPscale = 1.0;
    m_flags = 0;

    m_unk0 = 0;
    m_unk1 = 8;
    m_unk2 = 0;

    m_CallForHelpBlocked = false;

    allegiance = ALLEGIANCE_TYPE::MOB;

    // default to normal roaming
    m_roamFlags    = ROAMFLAG_NONE;
    m_specialFlags = SPECIALFLAG_NONE;
    m_name_prefix  = 0;
    m_MobSkillList = 0;

    m_AllowRespawn = false;
    m_DropItemTime = 0;
    m_Family       = 0;
    m_SuperFamily  = 0;
    m_Type         = MOBTYPE_NORMAL;
    m_Behaviour    = BEHAVIOUR_NONE;
    m_SpawnType    = SPAWNTYPE_NORMAL;
    m_EcoSystem    = ECOSYSTEM::UNCLASSIFIED;
    m_Element      = 0;
    m_HiPCLvl      = 0;
    m_HiPartySize  = 0;
    m_THLvl        = 0;
    m_ItemStolen   = false;

    HPmodifier = 0;
    MPmodifier = 0;

    strRank = 3;
    vitRank = 3;
    dexRank = 3;
    agiRank = 3;
    intRank = 3;
    mndRank = 3;
    chrRank = 3;
    attRank = 3;
    defRank = 3;
    accRank = 3;
    evaRank = 3;

    m_spawnSet = 0;

    m_dmgMult = 100;

    m_giveExp       = false;
    m_ExpPenalty    = 0;
    m_neutral       = false;
    m_Aggro         = false;
    m_TrueDetection = false;
    m_Link          = 0;
    m_isAggroable   = false;
    m_battlefieldID = 0;
    m_bcnmID        = 0;

    m_maxRoamDistance = 50.0f;
    m_disableScent    = false;

    m_Pool        = 0;
    m_RespawnTime = 300;

    m_SpellListContainer = nullptr;
    PEnmityContainer     = new CEnmityContainer(this);
    SpellContainer       = new CMobSpellContainer(this);

    // For Dyna Stats
    m_StatPoppedMobs = false;

    m_IsClaimable = true;

    PAI = std::make_unique<CAIContainer>(this, std::make_unique<CPathFind>(this), std::make_unique<CMobController>(this), std::make_unique<CTargetFind>(this));
}

uint32 CMobEntity::getEntityFlags() const
{
    return m_flags;
}

void CMobEntity::setEntityFlags(uint32 EntityFlags)
{
    m_flags = EntityFlags;
}

CMobEntity::~CMobEntity()
{
    destroy(PEnmityContainer);
    destroy(SpellContainer);
}

/************************************************************************
 *                                                                       *
 *  Время исчезновения монстра в секундах                                *
 *                                                                       *
 ************************************************************************/

time_point CMobEntity::GetDespawnTime()
{
    return m_DespawnTimer;
}

void CMobEntity::SetDespawnTime(duration _duration)
{
    if (_duration > 0s)
    {
        m_DespawnTimer = server_clock::now() + _duration;
    }
    else
    {
        m_DespawnTimer = time_point::min();
    }
}

uint32 CMobEntity::GetRandomGil()
{
    int16 min = getMobMod(MOBMOD_GIL_MIN);
    int16 max = getMobMod(MOBMOD_GIL_MAX);

    if (min && max)
    {
        // make sure divide won't crash server
        if (max <= min)
        {
            max = min + 2;
        }

        if (max - min < 2)
        {
            max = min + 2;
            ShowWarning("CMobEntity::GetRandomGil Max value is set too low, defauting");
        }

        return xirand::GetRandomNumber(min, max);
    }

    float gil = (float)pow(GetMLevel(), 1.05f);

    if (gil < 1)
    {
        gil = 1;
    }

    uint16 highGil = (uint16)(gil / 3 + 4);

    if (max)
    {
        highGil = max;
    }

    if (highGil < 2)
    {
        highGil = 2;
    }

    // randomize it
    gil += xirand::GetRandomNumber(highGil);

    if (min && gil < min)
    {
        gil = min;
    }

    if (getMobMod(MOBMOD_GIL_BONUS) != 0)
    {
        gil *= (getMobMod(MOBMOD_GIL_BONUS) / 100.0f);
    }

    return (uint32)gil;
}

bool CMobEntity::CanDropGil()
{
    // smaller than 0 means drop no gil
    if (getMobMod(MOBMOD_GIL_MAX) < 0)
    {
        return false;
    }

    if (getMobMod(MOBMOD_GIL_MIN) > 0 || getMobMod(MOBMOD_GIL_MAX))
    {
        return true;
    }

    return getMobMod(MOBMOD_GIL_BONUS) > 0;
}

bool CMobEntity::CanStealGil()
{
    // TODO: Some mobs cannot be mugged
    return CanDropGil();
}

void CMobEntity::ResetGilPurse()
{
    uint32 purse = GetRandomGil() / ((xirand::GetRandomNumber(4, 7)));
    if (purse == 0)
    {
        purse = GetRandomGil();
    }
    setMobMod(MOBMOD_MUG_GIL, purse);
}

bool CMobEntity::CanRoamHome()
{
    if ((speed == 0 && !(m_roamFlags & ROAMFLAG_WORM)) || getMobMod(MOBMOD_NO_MOVE) > 0)
    {
        return false;
    }

    if (getMobMod(MOBMOD_NO_DESPAWN) != 0 || settings::get<bool>("map.MOB_NO_DESPAWN"))
    {
        return true;
    }

    return distance(m_SpawnPoint, loc.p) < roam_home_distance;
}

bool CMobEntity::CanRoam()
{
    return !(m_roamFlags & ROAMFLAG_SCRIPTED) && PMaster == nullptr && (speed > 0 || (m_roamFlags & ROAMFLAG_WORM)) && getMobMod(MOBMOD_NO_MOVE) == 0;
}

void CMobEntity::TapDeaggroTime()
{
    CMobController* mobController = dynamic_cast<CMobController*>(PAI->GetController());

    if (mobController)
    {
        mobController->TapDeaggroTime();
    }
}

bool CMobEntity::CanLink(position_t* pos, int16 superLink)
{
    TracyZoneScoped;

    if (loc.zone->HasReducedVerticalAggro())
    {
        float verticalDistance = abs(loc.p.y - (*pos).y);
        if (verticalDistance > 3.5f)
        {
            return false;
        }
    }

    // handle super linking
    if (superLink && getMobMod(MOBMOD_SUPERLINK) == superLink)
    {
        return true;
    }

    // can't link right now
    if (m_neutral)
    {
        return false;
    }

    // Don't link I'm an underground worm
    if ((m_roamFlags & ROAMFLAG_WORM) && IsNameHidden())
    {
        return false;
    }

    // Don't link I'm an underground antlion
    if ((m_roamFlags & ROAMFLAG_AMBUSH) && IsNameHidden())
    {
        return false;
    }

    // Link if can see mob
    if (getMobMod(MOBMOD_DETECTION) & DETECT_SIGHT && !facing(loc.p, *pos, 64))
    {
        return false;
    }

    if (distance(loc.p, *pos) > getMobMod(MOBMOD_LINK_RADIUS))
    {
        return false;
    }

    if (getMobMod(MOBMOD_NO_LINK) > 0)
    {
        return false;
    }

    if (!PAI->PathFind->CanSeePoint(*pos))
    {
        return false;
    }
    return true;
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

bool CMobEntity::CanDeaggro() const
{
    return !(m_Type & MOBTYPE_NOTORIOUS || m_Type & MOBTYPE_BATTLEFIELD);
}

bool CMobEntity::IsFarFromHome()
{
    return distance(loc.p, m_SpawnPoint) > m_maxRoamDistance;
}

bool CMobEntity::CanBeNeutral() const
{
    return !(m_Type & MOBTYPE_NOTORIOUS);
}

uint16 CMobEntity::TPUseChance()
{
    const auto& MobSkillList = battleutils::GetMobSkillList(getMobMod(MOBMOD_SKILL_LIST));

    if (health.tp < 1000 || MobSkillList.empty() || !static_cast<CMobController*>(PAI->GetController())->IsWeaponSkillEnabled())
    {
        return 0;
    }

    if (health.tp == 3000 || (GetHPP() <= 50 && health.tp >= 2000) || (GetHPP() <= 25 && health.tp >= 1000))
    {
        return 10000;
    }

    return (uint16)getMobMod(MOBMOD_TP_USE_CHANCE);
}

void CMobEntity::setMobMod(uint16 type, int16 value)
{
    m_mobModStat[type] = value;
}

int16 CMobEntity::getMobMod(uint16 type)
{
    return m_mobModStat[type];
}

void CMobEntity::addMobMod(uint16 type, int16 value)
{
    m_mobModStat[type] += value;
}

void CMobEntity::defaultMobMod(uint16 type, int16 value)
{
    if (m_mobModStat[type] == 0)
    {
        m_mobModStat[type] = value;
    }
}

void CMobEntity::resetMobMod(uint16 type)
{
    m_mobModStat[type] = m_mobModStatSave[type];
}

int32 CMobEntity::getBigMobMod(uint16 type)
{
    return getMobMod(type) * 1000;
}

void CMobEntity::saveMobModifiers()
{
    m_mobModStatSave = m_mobModStat;
}

void CMobEntity::restoreMobModifiers()
{
    m_mobModStat = m_mobModStatSave;
}

void CMobEntity::HideHP(bool hide)
{
    if (hide)
    {
        m_flags |= FLAG_HIDE_HP;
    }
    else
    {
        m_flags &= ~FLAG_HIDE_HP;
    }
    updatemask |= UPDATE_HP;
}

bool CMobEntity::IsHPHidden() const
{
    return m_flags & FLAG_HIDE_HP;
}

void CMobEntity::SetCallForHelpFlag(bool call)
{
    if (call)
    {
        m_flags |= FLAG_CALL_FOR_HELP;
        m_OwnerID.clean();
    }
    else
    {
        m_flags &= ~FLAG_CALL_FOR_HELP;
    }
    updatemask |= UPDATE_COMBAT;
}

bool CMobEntity::GetCallForHelpFlag() const
{
    return m_flags & FLAG_CALL_FOR_HELP;
}

void CMobEntity::SetUntargetable(bool untargetable)
{
    if (untargetable)
    {
        m_flags |= FLAG_UNTARGETABLE;
    }
    else
    {
        m_flags &= ~FLAG_UNTARGETABLE;
    }
    updatemask |= UPDATE_HP;
}

bool CMobEntity::GetUntargetable() const
{
    return m_flags & FLAG_UNTARGETABLE;
}

void CMobEntity::PostTick()
{
    CBattleEntity::PostTick();
    std::chrono::steady_clock::time_point now = std::chrono::steady_clock::now();
    if (loc.zone && updatemask && now > m_nextUpdateTimer)
    {
        m_nextUpdateTimer = now + 250ms;
        loc.zone->UpdateEntityPacket(this, ENTITY_UPDATE, updatemask);

        // If this mob is charmed, it should sync with its master
        if (PMaster && PMaster->PPet == this && PMaster->objtype == TYPE_PC)
        {
            ((CCharEntity*)PMaster)->pushPacket(new CPetSyncPacket((CCharEntity*)PMaster));
        }

        updatemask = 0;
    }
}

float CMobEntity::GetRoamDistance()
{
    return (float)getMobMod(MOBMOD_ROAM_DISTANCE) / 10.0f;
}

float CMobEntity::GetRoamRate()
{
    return (float)getMobMod(MOBMOD_ROAM_RATE) / 10.0f;
}

bool CMobEntity::ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags)
{
    TracyZoneScoped;
    if (StatusEffectContainer->GetConfrontationEffect() != PInitiator->StatusEffectContainer->GetConfrontationEffect())
    {
        return false;
    }

    if (targetFlags & TARGET_PLAYER_PARTY)
    {
        if (!isDead())
        {
            if (allegiance == ALLEGIANCE_TYPE::MOB && PInitiator->allegiance == ALLEGIANCE_TYPE::MOB && allegiance == PInitiator->allegiance)
            {
                return true;
            }
        }
    }

    if (CBattleEntity::ValidTarget(PInitiator, targetFlags))
    {
        return true;
    }

    if (targetFlags & TARGET_PLAYER_DEAD && (m_Behaviour & BEHAVIOUR_RAISABLE) && isDead())
    {
        return true;
    }

    if ((targetFlags & TARGET_PLAYER) && allegiance == PInitiator->allegiance && !isCharmed)
    {
        return true;
    }

    if (targetFlags & TARGET_NPC)
    {
        if (allegiance == PInitiator->allegiance && !(m_Behaviour & BEHAVIOUR_NOHELP) && !isCharmed)
        {
            return true;
        }
    }

    return false;
}

bool CMobEntity::CanSpawnFromGroup()
{
    /********************************************
     * Returns true if:
     *  1.  The mob is a grouped (shared-ph) mob and
     *  2.  Is selected by its spawn group to be spawned
     * (Returns true also if not a spawn group member)
     ********************************************/
    if (!this->m_spawnSet || !this->loc.zone)
    {
        return true;
    }

    spawnGroup_t* spawngp = &this->loc.zone->m_SpawnGroups[this->m_spawnSet];

    if (spawngp->isReady(this))
    {
        return true;
    }

    return false;
}

void CMobEntity::Spawn()
{
    TracyZoneScoped;
    CBattleEntity::Spawn();
    m_giveExp           = true;
    m_ExpPenalty        = 0;
    m_HiPCLvl           = 0;
    m_HiPartySize       = 0;
    m_THLvl             = 0;
    m_ItemStolen        = false;
    m_DropItemTime      = 1000;
    m_pathFindDisengage = 0;
    animationsub        = (uint8)getMobMod(MOBMOD_SPAWN_ANIMATIONSUB);
    SetCallForHelpFlag(false);

    PEnmityContainer->Clear();
    PAI->ClearStateStack();

    // The underlying function in GetRandomNumber doesn't accept uint8 as <T> so use uint32
    // https://stackoverflow.com/questions/31460733/why-arent-stduniform-int-distributionuint8-t-and-stduniform-int-distri
    uint8 level = static_cast<uint8>(xirand::GetRandomNumber<uint32>(m_minLevel, m_maxLevel + 1));

    TraitList.clear(); // Clear traits just in case from random levels. Traits are recalculated in mobutils::CalculateMobStat().
                       // Note: Traits are NOT stored on DB load as of writing, so mobs won't gradually get stronger on respawn from restoreModifiers()
    SetMLevel(level);
    SetSLevel(level); // subjob calculated in function as appropriate

    mobutils::CalculateMobStats(this);
    mobutils::GetAvailableSpells(this);

    // spawn somewhere around my point
    loc.p = m_SpawnPoint;

    if (m_roamFlags & ROAMFLAG_STEALTH)
    {
        HideName(true);
        SetUntargetable(true);
    }

    // add people to my posse
    if (getMobMod(MOBMOD_ASSIST))
    {
        for (int32 i = 1; i < getMobMod(MOBMOD_ASSIST) + 1; i++)
        {
            CMobEntity* PMob = (CMobEntity*)GetEntity(targid + i, TYPE_MOB);

            if (PMob != nullptr)
            {
                PMob->setMobMod(MOBMOD_SUPERLINK, targid);
            }
        }
    }

    if (getMobMod(MOBMOD_IDLE_DESPAWN))
    {
        this->SetDespawnTime(std::chrono::seconds(getMobMod(MOBMOD_IDLE_DESPAWN)));
    }
    else
    {
        m_DespawnTimer = time_point::min();
    }
    luautils::OnMobSpawn(this);
}

void CMobEntity::OnWeaponSkillFinished(CWeaponSkillState& state, action_t& action)
{
    TracyZoneScoped;
    CBattleEntity::OnWeaponSkillFinished(state, action);

    TapDeaggroTime();
}

void CMobEntity::OnMobSkillFinished(CMobSkillState& state, action_t& action)
{
    TracyZoneScoped;
    auto* PSkill  = state.GetSkill();
    auto* PTarget = dynamic_cast<CBattleEntity*>(state.GetTarget());

    if (PTarget == nullptr)
    {
        ShowWarning("CMobEntity::OnMobSkillFinished: PTarget is null");
        return;
    }

    TapDeaggroTime();

    // store the skill used
    m_UsedSkillIds[PSkill->getID()] = GetMLevel();

    PAI->TargetFind->reset();

    float distance  = PSkill->getDistance();
    uint8 findFlags = 0;
    if (PSkill->getFlag() & SKILLFLAG_HIT_ALL)
    {
        findFlags |= FINDFLAGS_HIT_ALL;
    }

    // Mob buff abilities also hit monster's pets
    if (PSkill->getValidTargets() == TARGET_SELF)
    {
        findFlags |= FINDFLAGS_PET;
    }

    if ((PSkill->getValidTargets() & TARGET_IGNORE_BATTLEID) == TARGET_IGNORE_BATTLEID)
    {
        findFlags |= FINDFLAGS_IGNORE_BATTLEID;
    }

    action.id = id;
    if (objtype == TYPE_PET && static_cast<CPetEntity*>(this)->getPetType() == PET_TYPE::AVATAR)
    {
        action.actiontype = ACTION_PET_MOBABILITY_FINISH;
    }
    // Damaging mob abilities to use proper humanoid animnation IDs
    else if (PSkill->getID() < 256 || PSkill->getID() == 1431 || PSkill->getID() == 1432 || PSkill->getID() == 1437)
    {
        action.actiontype = ACTION_WEAPONSKILL_FINISH;
    }
    // Non-damaging mob abilities to use proper humanoid animation IDs
    else if (PSkill->getID() == 1428 || PSkill->getID() == 1429 || (PSkill->getID() >= 1433 && PSkill->getID() <= 1436) || PSkill->getID() == 1438 ||
             (PSkill->getID() >= 1992 && PSkill->getID() >= 1997))
    {
        action.actiontype = ACTION_JOBABILITY_FINISH;
    }
    else
    {
        action.actiontype = ACTION_MOBABILITY_FINISH;
    }
    action.actionid = PSkill->getID();

    if (PAI->TargetFind->isWithinRange(&PTarget->loc.p, distance) && !this->StatusEffectContainer->HasStatusEffect(EFFECT_HYSTERIA))
    {
        if (PSkill->isAoE())
        {
            PAI->TargetFind->findWithinArea(PTarget, static_cast<AOE_RADIUS>(PSkill->getAoe()), PSkill->getRadius(), findFlags);
        }
        else if (PSkill->isConal())
        {
            float angle = 0.0f;
            if (this->m_Family == 62 || this->m_Family == 164) // Cerb and Hydra families have wide Conals
            {
                angle = 90.0f;
            }
            else if (this->m_Family >= 259 && (this->m_Family <= 264 || (this->m_Family >= 391 && this->m_Family <= 393))) // Wyrms have slightly wider than normal
            {
                angle = 60.0f;
            }
            else if (PSkill->getID() == 2335) // Ixion's Lightning Spear is the only 120º Conal that we know of
            {
                angle = 120.0f;
            }
            else
            {
                angle = 45.0f;
            }

            // for mobs that do not turn to face the target
            if (m_Behaviour & BEHAVIOUR_NO_TURN)
            {
                // need to always add the single main target as otherwise player can interrupt cone skill
                // by spinning around the mob which should not be possible
                PAI->TargetFind->findSingleTarget(PTarget, findFlags);
            }

            if (PSkill->m_Aoe == 6) // Conal from center of mob
            {
                PAI->TargetFind->findWithinCone(PTarget, AOE_RADIUS::ATTACKER, distance, angle, findFlags, 0);
            }
            else if (PSkill->m_Aoe == 7) // Conal from center of mob in front and behind
            {
                PAI->TargetFind->findWithinCone(PTarget, AOE_RADIUS::ATTACKER, distance, angle, findFlags, 128);
                PAI->TargetFind->findWithinCone(PTarget, AOE_RADIUS::ATTACKER, distance, angle, findFlags, 0);
            }
            else // Conal in front centered on target, m_AoE 5 sets conal to rear
            {
                PAI->TargetFind->findWithinCone(PTarget, AOE_RADIUS::TARGET, distance, angle, findFlags, (PSkill->m_Aoe == 5) * 128);
            }
        }
        else
        {
            if (this->objtype == TYPE_MOB && PTarget->objtype == TYPE_PC)
            {
                CBattleEntity* PCoverAbilityUser = battleutils::GetCoverAbilityUser(PTarget, this);
                if (PCoverAbilityUser != nullptr)
                {
                    PTarget = PCoverAbilityUser;
                }
            }

            PAI->TargetFind->findSingleTarget(PTarget, findFlags);
        }
    }
    else // Out of range
    {
        action.actiontype         = ACTION_MOBABILITY_INTERRUPT;
        action.actionid           = 0;
        actionList_t& actionList  = action.getNewActionList();
        actionList.ActionTargetID = PTarget->id;

        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.animation       = 0x1FC; // Hardcoded magic sent from the server
        actionTarget.messageID       = MSGBASIC_TOO_FAR_AWAY;
        actionTarget.speceffect      = SPECEFFECT::BLOOD;
        return;
    }

    uint16 targets = static_cast<uint16>(PAI->TargetFind->m_targets.size());

    // No targets, perhaps something like Super Jump or otherwise untargetable
    if (targets == 0)
    {
        action.actiontype         = ACTION_MOBABILITY_INTERRUPT;
        action.actionid           = 28787; // Some hardcoded magic for interrupts
        actionList_t& actionList  = action.getNewActionList();
        actionList.ActionTargetID = id;

        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.animation       = 0x1FC; // Hardcoded magic sent from the server
        actionTarget.messageID       = 0;
        actionTarget.reaction        = REACTION::ABILITY | REACTION::HIT;

        return;
    }

    PSkill->setTotalTargets(targets);
    PSkill->setTP(state.GetSpentTP());
    PSkill->setHP(health.hp);
    PSkill->setHPP(GetHPP());

    // Spend MP for blood pacts here so MP is only deducted if successful
    if (objtype == TYPE_PET && static_cast<CPetEntity*>(this)->getPetType() == PET_TYPE::AVATAR &&
        PMaster && PMaster->objtype == TYPE_PC)
    {
        CAbility* PPactAbility = ability::GetAbility(PSkill->getBloodPactAbilityID());

        if (PPactAbility->getID() >= ABILITY_HEALING_RUBY && PPactAbility->getID() <= ABILITY_PERFECT_DEFENSE)
        {
            // Blood Pact mp cost stored in animation ID
            float mpCost = PPactAbility->getAnimationID();

            if (PMaster->StatusEffectContainer->HasStatusEffect(EFFECT_APOGEE))
            {
                mpCost *= 1.5f;
                PMaster->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_BLOODPACT);
            }

            // Blood Boon (does not affect Astral Flow BPs)
            if ((PPactAbility->getAddType() & ADDTYPE_ASTRAL_FLOW) == 0)
            {
                int16 bloodBoonRate = PMaster->getMod(Mod::BLOOD_BOON);
                if (xirand::GetRandomNumber(100) < bloodBoonRate)
                {
                    mpCost *= xirand::GetRandomNumber(8.f, 16.f) / 16.f;
                }
            }

            PMaster->addMP((int32)-mpCost);
        }
    }

    uint16 msg            = 0;
    uint16 defaultMessage = PSkill->getMsg();

    bool first{ true };
    for (auto&& PTargetFound : PAI->TargetFind->m_targets)
    {
        actionList_t& list = action.getNewActionList();

        list.ActionTargetID = PTargetFound->id;

        actionTarget_t& target = list.getNewActionTarget();

        list.ActionTargetID = PTargetFound->id;
        target.reaction     = REACTION::HIT;
        target.speceffect   = SPECEFFECT::HIT;
        target.animation    = PSkill->getAnimationID();
        target.messageID    = PSkill->getMsg();

        // reset the skill's message back to default
        PSkill->setMsg(defaultMessage);
        int32 damage = 0;
        if (objtype == TYPE_PET && static_cast<CPetEntity*>(this)->getPetType() != PET_TYPE::JUG_PET)
        {
            PET_TYPE petType = static_cast<CPetEntity*>(this)->getPetType();

            if (static_cast<CPetEntity*>(this)->getPetType() == PET_TYPE::AVATAR || static_cast<CPetEntity*>(this)->getPetType() == PET_TYPE::WYVERN)
            {
                target.animation = PSkill->getPetAnimationID();
            }

            if (petType == PET_TYPE::AUTOMATON)
            {
                damage = luautils::OnAutomatonAbility(PTargetFound, this, PSkill, PMaster, &action);
            }
            else
            {
                damage = luautils::OnPetAbility(PTargetFound, this, PSkill, PMaster, &action);
            }
        }
        else
        {
            damage = luautils::OnMobWeaponSkill(PTargetFound, this, PSkill, &action);
            this->PAI->EventHandler.triggerListener("WEAPONSKILL_USE", CLuaBaseEntity(this), CLuaBaseEntity(PTargetFound), PSkill->getID(), state.GetSpentTP(), CLuaAction(&action));
            PTarget->PAI->EventHandler.triggerListener("WEAPONSKILL_TAKE", CLuaBaseEntity(PTargetFound), CLuaBaseEntity(this), PSkill->getID(), state.GetSpentTP(), CLuaAction(&action));
        }

        if (msg == 0)
        {
            msg = PSkill->getMsg();
        }
        else
        {
            msg = PSkill->getAoEMsg();
        }

        if (damage < 0)
        {
            msg          = MSGBASIC_SKILL_RECOVERS_HP; // TODO: verify this message does/does not vary depending on mob/avatar/automaton use
            target.param = std::clamp(-damage, 0, PTargetFound->GetMaxHP() - PTargetFound->health.hp);
        }
        else
        {
            target.param = damage;
        }

        target.messageID = msg;

        if (PSkill->hasMissMsg())
        {
            target.reaction   = REACTION::MISS;
            target.speceffect = SPECEFFECT::NONE;
            if (msg == PSkill->getAoEMsg())
            {
                msg = 282;
            }
        }
        else
        {
            target.reaction   = REACTION::HIT;
            target.speceffect = SPECEFFECT::HIT;
        }

        // TODO: Should this be reaction and not speceffect?
        if (target.speceffect == SPECEFFECT::HIT) // Formerly bitwise and, though nothing in this function adds additional bits to the field
        {
            target.speceffect = SPECEFFECT::RECOIL;
            target.knockback  = PSkill->getKnockback();
            if (first && (PSkill->getPrimarySkillchain() != 0))
            {
                SUBEFFECT effect = battleutils::GetSkillChainEffect(PTargetFound, PSkill->getPrimarySkillchain(), PSkill->getSecondarySkillchain(),
                                                                    PSkill->getTertiarySkillchain());
                if (effect != SUBEFFECT_NONE)
                {
                    int32 skillChainDamage = battleutils::TakeSkillchainDamage(this, PTargetFound, target.param, nullptr);
                    if (skillChainDamage < 0)
                    {
                        target.addEffectParam   = -skillChainDamage;
                        target.addEffectMessage = 384 + effect;
                    }
                    else
                    {
                        target.addEffectParam   = skillChainDamage;
                        target.addEffectMessage = 287 + effect;
                    }
                    target.additionalEffect = effect;
                }

                first = false;
            }
        }

        if (PSkill->getValidTargets() & TARGET_ENEMY)
        {
            PTargetFound->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DETECTABLE);
        }

        if (PTargetFound->isDead())
        {
            battleutils::ClaimMob(PTargetFound, this);
        }
        battleutils::DirtyExp(PTargetFound, this);
    }

    PTarget = dynamic_cast<CBattleEntity*>(state.GetTarget()); // TODO: why is this recast here? can state change between now and the original cast?

    if (PTarget)
    {
        if (PTarget->objtype == TYPE_MOB && (PTarget->isDead() || (objtype == TYPE_PET && static_cast<CPetEntity*>(this)->getPetType() == PET_TYPE::AVATAR)))
        {
            battleutils::ClaimMob(PTarget, this);
        }
        battleutils::DirtyExp(PTarget, this);
    }
}

void CMobEntity::DistributeRewards()
{
    TracyZoneScoped;
    CCharEntity* PChar = (CCharEntity*)GetEntity(m_OwnerID.targid, TYPE_PC);

    if (PChar != nullptr && PChar->id == m_OwnerID.id)
    {
        StatusEffectContainer->KillAllStatusEffect();
        PChar->m_charHistory.enemiesDefeated++;

        // NOTE: this is called for all alliance / party members!
        luautils::OnMobDeath(this, PChar);

        if (!GetCallForHelpFlag())
        {
            blueutils::TryLearningSpells(PChar, this);
            m_UsedSkillIds.clear();

            // RoE Mob kill event for all party members
            // clang-format off
            PChar->ForAlliance([this, PChar](CBattleEntity* PMember)
            {
                if (PMember->getZone() == PChar->getZone())
                {
                    RoeDatagramList datagrams;
                    datagrams.push_back(RoeDatagram("mob", this));
                    datagrams.push_back(RoeDatagram("atkType", static_cast<uint8>(this->BattleHistory.lastHitTaken_atkType)));
                    roeutils::event(ROE_MOBKILL, (CCharEntity*)PMember, datagrams);
                }
            });
            // clang-format on

            if (m_giveExp && !PChar->StatusEffectContainer->HasStatusEffect(EFFECT_BATTLEFIELD))
            {
                charutils::DistributeExperiencePoints(PChar, this);
                charutils::DistributeCapacityPoints(PChar, this);
            }

            // check for gil (beastmen drop gil, some NMs drop gil)
            if ((settings::get<float>("map.MOB_GIL_MULTIPLIER") > 0.0f && CanDropGil()) ||
                (settings::get<float>("map.ALL_MOBS_GIL_BONUS") > 0 &&
                 getMobMod(MOBMOD_GIL_MAX) >= 0)) // Negative value of MOBMOD_GIL_MAX is used to prevent gil drops in Dynamis/Limbus.
            {
                charutils::DistributeGil(PChar, this); // TODO: REALISATION MUST BE IN TREASUREPOOL
            }

            DropItems(PChar);
        }
    }
    else
    {
        luautils::OnMobDeath(this, nullptr);
    }
}

float CMobEntity::ApplyTH(int16 m_THLvl, int16 rate)
{
    TracyZoneScoped;

    float multi       = 1.00f;
    bool  ultra_rare  = (rate == 1);
    bool  super_rare  = (rate == 5);
    bool  very_rare   = (rate == 10);
    bool  rare        = (rate == 50);
    bool  uncommon    = (rate == 100);
    bool  common      = (rate == 150);
    bool  very_common = (rate == 240);

    if (ultra_rare)
    {
        if (m_THLvl < 3)
        {
            multi = 1.00f + (1.00f * m_THLvl);
            return multi;
        }
        else if (m_THLvl < 7)
        {
            multi = 3.00f + (0.50f * (m_THLvl - 2));
            return multi;
        }
        else if (m_THLvl < 12)
        {
            multi = 5.00f + (1.00f * (m_THLvl - 6));
            return multi;
        }
        else if (m_THLvl < 14)
        {
            multi = 9.00f + (1.50f * (m_THLvl - 11));
            return multi;
        }
        else
        {
            multi = 12.00f + (2.00f * (m_THLvl - 14));
            return multi;
        }
    }
    else if (super_rare)
    {
        if (m_THLvl < 3)
        {
            multi = 1.00f + (0.50f * m_THLvl);
            return multi;
        }
        else if (m_THLvl < 8)
        {
            multi = 2.00f + (0.40f * (m_THLvl - 2));
            return multi;
        }
        else if (m_THLvl < 10)
        {
            multi = 4.00f + (0.60f * (m_THLvl - 7));
            return multi;
        }
        else if (m_THLvl < 11)
        {
            multi = 5.20f + (0.80f * (m_THLvl - 9));
            return multi;
        }
        else
        {
            multi = 9.20f + (1.00f * (m_THLvl - 10));
            return multi;
        }
    }
    else if (very_rare)
    {
        if (m_THLvl < 3)
        {
            multi = 1.00f + (0.50f * m_THLvl);
            return multi;
        }
        else if (m_THLvl < 5)
        {
            multi = 2.00f + (0.25f * (m_THLvl - 2));
            return multi;
        }
        else if (m_THLvl < 8)
        {
            multi = 1.40f + (0.10f * (m_THLvl - 2));
            return multi;
        }
        else if (m_THLvl < 12)
        {
            multi = 1.90f + (0.20f * (m_THLvl - 7));
            return multi;
        }
        else if (m_THLvl < 14)
        {
            multi = 2.70f + (0.40f * (m_THLvl - 11));
            return multi;
        }
        else
        {
            multi = 3.50f + (0.50f * (m_THLvl - 13));
            return multi;
        }
    }
    else if (rare)
    {
        if (m_THLvl < 3)
        {
            multi = 1.00f + (0.20f * m_THLvl);
            return multi;
        }
        else if (m_THLvl < 8)
        {
            multi = 1.40f + (0.10f * (m_THLvl - 2));
            return multi;
        }
        else if (m_THLvl < 12)
        {
            multi = 1.90f + (0.20f * (m_THLvl - 7));
            return multi;
        }
        else if (m_THLvl < 14)
        {
            multi = 2.70f + (0.40f * (m_THLvl - 11));
            return multi;
        }
        else
        {
            multi = 3.50f + (0.50f * (m_THLvl - 13));
            return multi;
        }
    }
    else if (uncommon)
    {
        if (m_THLvl < 2)
        {
            multi = 1.00f + (0.20f * m_THLvl);
            return multi;
        }
        else if (m_THLvl < 3)
        {
            multi = 1.20f + (0.30f * (m_THLvl - 1));
            return multi;
        }
        else if (m_THLvl < 5)
        {
            multi = 1.50f + (0.15f * (m_THLvl - 2));
            return multi;
        }
        else if (m_THLvl < 8)
        {
            multi = 1.80f + (0.10f * (m_THLvl - 3));
            return multi;
        }
        else if (m_THLvl < 10)
        {
            multi = 2.10f + (0.15f * (m_THLvl - 7));
            return multi;
        }
        else if (m_THLvl < 11)
        {
            multi = 2.40f + (0.25f * (m_THLvl - 9));
            return multi;
        }
        else
        {
            multi = 2.65f + (0.15f * (m_THLvl - 10));
            return multi;
        }
    }
    else if (common)
    {
        if (m_THLvl < 2)
        {
            multi = 1.00f + (1.00f * m_THLvl);
            return multi;
        }
        else if (m_THLvl < 3)
        {
            multi = 2.00f + (0.66f * (m_THLvl - 1));
            return multi;
        }
        else
        {
            multi = 2.66f + (0.17f * (m_THLvl - 2));
            return multi;
        }
    }
    else if (very_common)
    {
        if (m_THLvl < 2)
        {
            multi = 1.00f + (1.00f * m_THLvl);
            return multi;
        }
        else if (m_THLvl < 3)
        {
            multi = 2.00f + (0.34f * (m_THLvl - 1));
            return multi;
        }
        else if (m_THLvl < 5)
        {
            multi = 2.66f + (0.16f * (m_THLvl - 2));
            return multi;
        }
        else if (m_THLvl < 6)
        {
            multi = 2.82f + (0.11f * (m_THLvl - 4));
            return multi;
        }
        else if (m_THLvl < 7)
        {
            multi = 2.93f + (0.05f * (m_THLvl - 5));
            return multi;
        }
        else if (m_THLvl < 8)
        {
            multi = 2.98f + (0.04f * (m_THLvl - 6));
            return multi;
        }
        else if (m_THLvl < 11)
        {
            multi = 3.02f + (0.06f * (m_THLvl - 7));
            return multi;
        }
        else if (m_THLvl < 12)
        {
            multi = 3.20f + (0.03f * (m_THLvl - 10));
            return multi;
        }
        else
        {
            multi = 3.23f + (0.10f * (m_THLvl - 11));
            return multi;
        }
    }
    else
    {
        return multi; // TH Didn't Apply
    }
}

void CMobEntity::DropItems(CCharEntity* PChar)
{
    TracyZoneScoped;
    // Adds an item to the treasure pool
    auto AddItemToPool = [this, PChar](uint16 ItemID, uint8 dropCount)
    {
        PChar->PTreasurePool->AddItem(ItemID, this);
        // This used to cap the number of drops a mob can produce at 10, but
        // that's not the correct behavior.
        return false; // dropCount >= TREASUREPOOL_SIZE;
    };

    // Limit number of items that can drop to the treasure pool size
    uint8 dropCount = 0;

    DropList_t* dropList = itemutils::GetDropList(m_DropID);

    if (!getMobMod(MOBMOD_NO_DROPS) && dropList != nullptr && (!dropList->Items.empty() || !dropList->Groups.empty() || PAI->EventHandler.hasListener("ITEM_DROPS")))
    {
        // THLvl is the number of 'extra chances' at an item. If the item is obtained, then break out.
        int16 maxRolls = 1;

        LootContainer loot(dropList);

        PAI->EventHandler.triggerListener("ITEM_DROPS", CLuaBaseEntity(this), CLuaLootContainer(&loot));

        // clang-format off
        loot.ForEachGroup([&](const DropGroup_t& group)
        {
            uint16 total = 0;
            for (const DropItem_t& item : group.Items)
            {
                total += item.DropRate;
            }

            // NOTE: When switching over to the correct TH table method fixed rate means to not use the TH table
            int16 rolls = group.hasFixedRate ? 1 : maxRolls;

            for (int16 roll = 0; roll < rolls; ++roll)
            {
                // Determine if this group should drop an item and determine bonus
                float bonus = ApplyTH(m_THLvl, group.GroupRate);
                if (group.GroupRate > 0 && xirand::GetRandomNumber(1000) < std::round(group.GroupRate * settings::get<float>("map.DROP_RATE_MULTIPLIER") * bonus))
                {
                    // Each item in the group is given its own weight range which is the previous value to the previous value + item.DropRate
                    // Such as 2 items with drop rates of 200 and 800 would be 0-199 and 200-999 respectively
                    uint16 previousRateValue = 0;
                    uint16 itemRoll          = xirand::GetRandomNumber(total);
                    for (const DropItem_t& item : group.Items)
                    {
                        if (previousRateValue + item.DropRate > itemRoll)
                        {
                            if (AddItemToPool(item.ItemID, ++dropCount))
                            {
                                return;
                            }
                            break;
                        }
                        previousRateValue += item.DropRate;
                    }
                    break;
                }
            }
        });

        loot.ForEachItem([&](const DropItem_t& item)
        {
            // NOTE: When switching over to the correct TH table method fixed rate means to not use the TH table
            int16 rolls = item.hasFixedRate ? 1 : maxRolls;

            for (int16 roll = 0; roll < rolls; ++roll)
            {
                float bonus = ApplyTH(m_THLvl, item.DropRate);
                if (item.DropRate > 0 && xirand::GetRandomNumber(1000) < std::round(item.DropRate * settings::get<float>("map.DROP_RATE_MULTIPLIER") * bonus))
                {
                    if (AddItemToPool(item.ItemID, ++dropCount))
                    {
                        return;
                    }
                    break;
                }
            }
        });
        // clang-format on
    }

    ZONE_TYPE zoneType  = zoneutils::GetZone(PChar->getZone())->GetType();
    bool      validZone = zoneType != ZONE_TYPE::BATTLEFIELD && zoneType != ZONE_TYPE::DYNAMIS;

    // Check if mob can drop seals -- mobmod to disable drops, zone type isnt battlefield/dynamis, mob is stronger than Too Weak, or mobmod for EXP bonus is -100 or lower (-100% exp)
    if (!getMobMod(MOBMOD_NO_DROPS) && validZone && charutils::CheckMob(m_HiPCLvl, GetMLevel()) > EMobDifficulty::TooWeak && getMobMod(MOBMOD_EXP_BONUS) > -100)
    {
        // check for seal drops
        /* MobLvl >= 1 = Beastmen Seals ID=1126
        >= 50 = Kindred Seals ID=1127
        >= 75 = Kindred Crests ID=2955
        >= 90 = High Kindred Crests ID=2956
        */
        if (xirand::GetRandomNumber(100) < 20 && PChar->PTreasurePool->CanAddSeal())
        {
            // RULES: Only 1 kind may drop per mob
            if (GetMLevel() >= 75 && luautils::IsContentEnabled("ABYSSEA")) // all 4 types
            {
                switch (xirand::GetRandomNumber(4))
                {
                    case 0:

                        if (AddItemToPool(1126, ++dropCount))
                        {
                            return;
                        }
                        break;
                    case 1:
                        if (AddItemToPool(1127, ++dropCount))
                        {
                            return;
                        }
                        break;
                    case 2:
                        if (AddItemToPool(2955, ++dropCount))
                        {
                            return;
                        }
                        break;
                    case 3:
                        if (AddItemToPool(2956, ++dropCount))
                        {
                            return;
                        }
                        break;
                }
            }
            else if (GetMLevel() >= 70 && luautils::IsContentEnabled("ABYSSEA")) // b.seal & k.seal & k.crest
            {
                switch (xirand::GetRandomNumber(3))
                {
                    case 0:
                        if (AddItemToPool(1126, ++dropCount))
                        {
                            return;
                        }
                        break;
                    case 1:
                        if (AddItemToPool(1127, ++dropCount))
                        {
                            return;
                        }
                        break;
                    case 2:
                        if (AddItemToPool(2955, ++dropCount))
                        {
                            return;
                        }
                        break;
                }
            }
            else if (GetMLevel() >= 50) // b.seal & k.seal only
            {
                if (xirand::GetRandomNumber(2) == 0)
                {
                    if (AddItemToPool(1126, ++dropCount))
                    {
                        return;
                    }
                }
                else
                {
                    if (AddItemToPool(1127, ++dropCount))
                    {
                        return;
                    }
                }
            }
            else
            {
                // b.seal only
                if (AddItemToPool(1126, ++dropCount))
                {
                    return;
                }
            }
        }

        /* check for Avatarite/Geode Drops.
            LV >= 50 = Geodes can drop IF matching weather or day.
            Weather gets priority e.g. rainstorm on firesday would get Water Geode instead of fire
            LV >= 80 = Avatrites can also drop, same rules. If one drops, the other does not.
            unfortunately, the order of the items/weathers/days don't match.
        */
        if (GetMLevel() >= 50 && luautils::IsContentEnabled("ABYSSEA"))
        {
            uint8 weather = PChar->loc.zone->GetWeather();
            uint8 element = 0;

            // Set element by weather
            if (weather >= 4 && weather <= 19)
            {
                /*
                element = zoneutils::GetWeatherElement(weather);
                Can't use this because of the TODO in zoneutils about broken element order >.<
                So we have this ugly switch until then.
                */
                switch (weather)
                {
                    case 4:
                    case 5:
                        element = ELEMENT_FIRE;
                        break;
                    case 6:
                    case 7:
                        element = ELEMENT_WATER;
                        break;
                    case 8:
                    case 9:
                        element = ELEMENT_EARTH;
                        break;
                    case 10:
                    case 11:
                        element = ELEMENT_WIND;
                        break;
                    case 12:
                    case 13:
                        element = ELEMENT_ICE;
                        break;
                    case 14:
                    case 15:
                        element = ELEMENT_THUNDER;
                        break;
                    case 16:
                    case 17:
                        element = ELEMENT_LIGHT;
                        break;
                    case 18:
                    case 19:
                        element = ELEMENT_DARK;
                        break;
                    default:
                        break;
                }
            }
            // Set element from day instead
            else
            {
                element = battleutils::GetDayElement();
            }

            // Roll for Geode, dude!
            if (xirand::GetRandomNumber(100) < 20)
            {
                switch (element)
                {
                    case ELEMENT_FIRE:
                        AddItemToPool(3297, ++dropCount); // Flame Geode
                        break;
                    case ELEMENT_EARTH:
                        AddItemToPool(3300, ++dropCount); // Soil Geode
                        break;
                    case ELEMENT_WATER:
                        AddItemToPool(3302, ++dropCount); // Aqua Geode
                        break;
                    case ELEMENT_WIND:
                        AddItemToPool(3299, ++dropCount); // Breeze Geode
                        break;
                    case ELEMENT_ICE:
                        AddItemToPool(3298, ++dropCount); // Snow Geode
                        break;
                    case ELEMENT_THUNDER:
                        AddItemToPool(3301, ++dropCount); // Thunder Geode
                        break;
                    case ELEMENT_LIGHT:
                        AddItemToPool(3303, ++dropCount); // Light Geode
                        break;
                    case ELEMENT_DARK:
                        AddItemToPool(3304, ++dropCount); // Shadow Geode
                        break;
                    default:
                        break;
                }
            }
            // At LV 80 and above, you may get Avatarite if a Geode didn't drop
            else if (GetMLevel() >= 80 && xirand::GetRandomNumber(100) < 20)
            {
                switch (element)
                {
                    case ELEMENT_FIRE:
                        AddItemToPool(3520, ++dropCount); // Ifritite
                        break;
                    case ELEMENT_EARTH:
                        AddItemToPool(3523, ++dropCount); // Titanite
                        break;
                    case ELEMENT_WATER:
                        AddItemToPool(3525, ++dropCount); // Leviatite
                        break;
                    case ELEMENT_WIND:
                        AddItemToPool(3522, ++dropCount); // Garudite
                        break;
                    case ELEMENT_ICE:
                        AddItemToPool(3521, ++dropCount); // Shivite
                        break;
                    case ELEMENT_THUNDER:
                        AddItemToPool(3524, ++dropCount); // Ramuite
                        break;
                    case ELEMENT_LIGHT:
                        AddItemToPool(3526, ++dropCount); // Carbit
                        break;
                    case ELEMENT_DARK:
                        AddItemToPool(3527, ++dropCount); // Fenrite
                        break;
                    default:
                        break;
                }
            }
        }

        uint8 effect = 0; // Begin Adding Crystals

        if (m_Element > 0)
        {
            REGION_TYPE regionID = PChar->loc.zone->GetRegionID();
            switch (regionID)
            {
                // Sanction Regions
                case REGION_TYPE::WEST_AHT_URHGAN:
                case REGION_TYPE::MAMOOL_JA_SAVAGE:
                case REGION_TYPE::HALVUNG:
                case REGION_TYPE::ARRAPAGO:
                    effect = 2;
                    break;
                // Sigil Regions
                case REGION_TYPE::RONFAURE_FRONT:
                case REGION_TYPE::NORVALLEN_FRONT:
                case REGION_TYPE::GUSTABERG_FRONT:
                case REGION_TYPE::DERFLAND_FRONT:
                case REGION_TYPE::SARUTA_FRONT:
                case REGION_TYPE::ARAGONEAU_FRONT:
                case REGION_TYPE::FAUREGANDI_FRONT:
                case REGION_TYPE::VALDEAUNIA_FRONT:
                    effect = 3;
                    break;
                // Signet Regions
                default:
                    effect = (conquest::GetRegionOwner(PChar->loc.zone->GetRegionID()) <= 2) ? 1 : 0;
                    break;
            }
        }
        uint8 crystalRolls = 0;
        // clang-format off
        PChar->ForParty([this, &crystalRolls, &effect](CBattleEntity* PMember)
        {
            switch (effect)
            {
                case 1:
                    if (PMember->StatusEffectContainer->HasStatusEffect(EFFECT_SIGNET) && PMember->getZone() == getZone() &&
                        distance(PMember->loc.p, loc.p) < 100)
                    {
                        crystalRolls++;
                    }
                    break;
                case 2:
                    if (PMember->StatusEffectContainer->HasStatusEffect(EFFECT_SANCTION) && PMember->getZone() == getZone() &&
                        distance(PMember->loc.p, loc.p) < 100)
                    {
                        crystalRolls++;
                    }
                    break;
                case 3:
                    if (PMember->StatusEffectContainer->HasStatusEffect(EFFECT_SIGIL) && PMember->getZone() == getZone() &&
                        distance(PMember->loc.p, loc.p) < 100)
                    {
                        crystalRolls++;
                    }
                    break;
                default:
                    break;
            }
        });
        // clang-forman on

        for (uint8 i = 0; i < crystalRolls; i++)
        {
            if (xirand::GetRandomNumber(100) < 35 && AddItemToPool(4095 + m_Element, ++dropCount))
            {
                return;
            }
        }
    }
}

bool CMobEntity::CanMove()
{
    return !StatusEffectContainer->IsAsleep() && !StatusEffectContainer->HasStatusEffect({EFFECT_BIND, EFFECT_PETRIFICATION, EFFECT_TERROR, EFFECT_STUN});
}

bool CMobEntity::CanAttack(CBattleEntity* PTarget, std::unique_ptr<CBasicPacket>& errMsg)
{
    TracyZoneScoped;
    auto skill_list_id{ getMobMod(MOBMOD_ATTACK_SKILL_LIST) };
    if (skill_list_id)
    {
        auto attack_range{ GetMeleeRange() };
        auto skillList{ battleutils::GetMobSkillList(skill_list_id) };
        if (!skillList.empty())
        {
            auto* skill{ battleutils::GetMobSkill(skillList.front()) };
            if (skill)
            {
                attack_range = (uint8)skill->getDistance();
            }
        }

        if ((distance(loc.p, PTarget->loc.p) - PTarget->m_ModelRadius) > attack_range)
        {
            m_pathFindDisengage += 1;
            return false;
        }
        else if (!PAI->GetController()->IsAutoAttackEnabled())
        {
            return false;
        }
        else
        {
            return true;
        }
    }
    else
    {
        return CBattleEntity::CanAttack(PTarget, errMsg);
    }
}

void CMobEntity::OnEngage(CAttackState& state)
{
    TracyZoneScoped;
    CBattleEntity::OnEngage(state);
    luautils::OnMobEngaged(this, state.GetTarget());
    unsigned int range = this->getMobMod(MOBMOD_ALLI_HATE);
    if (range != 0)
    {
        CBaseEntity* PTarget = state.GetTarget();
        CBaseEntity* PPet    = nullptr;
        if (PTarget->objtype == TYPE_PET)
        {
            PPet    = state.GetTarget();
            PTarget = ((CPetEntity*)PTarget)->PMaster;
        }
        if (PTarget->objtype == TYPE_PC)
        {
            // clang-format off
            ((CCharEntity*)PTarget)->ForAlliance([this, PTarget, range](CBattleEntity* PMember)
            {
                auto currentDistance = distance(PMember->loc.p, PTarget->loc.p);
                if (currentDistance < range)
                {
                    this->PEnmityContainer->AddBaseEnmity(PMember);
                }
            });
            // clang-format on

            this->PEnmityContainer->UpdateEnmity((PPet ? (CBattleEntity*)PPet : (CBattleEntity*)PTarget), 0, 1); // Set VE so target doesn't change
        }
    }
    TapDeaggroTime();
}

void CMobEntity::FadeOut()
{
    TracyZoneScoped;
    CBaseEntity::FadeOut();
    PEnmityContainer->Clear();
}

void CMobEntity::OnDeathTimer()
{
    TracyZoneScoped;
    if (!(m_Behaviour & BEHAVIOUR_RAISABLE))
    {
        PAI->Despawn();
    }
}

void CMobEntity::OnDespawn(CDespawnState& /*unused*/)
{
    TracyZoneScoped;

    FadeOut();

    if (this->m_spawnSet > 0)
    {
        // Might need some logic in here to control whether you want to force-spawn the same mob
        // eg. if someone just zoned it and not killed it, etc.
        auto&       spawnGroup = this->loc.zone->m_SpawnGroups[this->m_spawnSet];
        CMobEntity* nextMob    = spawnGroup.replaceMob(this);
        if (nextMob)
        {
            if (nextMob->PAI && !nextMob->PAI->Internal_Respawn(std::chrono::milliseconds(m_RespawnTime)))
            {
                nextMob->PAI->GetCurrentState()->ResetEntryTime();
            }
        }
    }

    PAI->Internal_Respawn(std::chrono::milliseconds(m_RespawnTime));

    luautils::OnMobDespawn(this);
    PAI->ClearActionQueue();
    // #event despawn
    PAI->EventHandler.triggerListener("DESPAWN", CLuaBaseEntity(this));
}

void CMobEntity::Die()
{
    TracyZoneScoped;

    if (PBattlefield != nullptr)
    {
        PBattlefield->handleDeath(this);
    }

    PEnmityContainer->Clear();
    PAI->ClearStateStack();
    if (PPet != nullptr && PPet->isAlive() && GetMJob() == JOB_SMN)
    {
        PPet->Die();
    }
    PAI->Internal_Die(15s);
    CBattleEntity::Die();

    // clang-format off
    PAI->QueueAction(queueAction_t(std::chrono::milliseconds(m_DropItemTime), false, [this](CBaseEntity* PEntity)
    {
        if (static_cast<CMobEntity*>(PEntity)->isDead())
        {
            if (PLastAttacker)
            {
                loc.zone->PushPacket(this, CHAR_INRANGE, new CMessageBasicPacket(PLastAttacker, this, 0, 0, MSGBASIC_DEFEATS_TARG));
            }
            else
            {
                loc.zone->PushPacket(this, CHAR_INRANGE, new CMessageBasicPacket(this, this, 0, 0, MSGBASIC_FALLS_TO_GROUND));
            }

            DistributeRewards();
            m_OwnerID.clean();
            m_THLvl = 0;
        }
    }));
    // clang-format on

    if (PMaster && PMaster->PPet == this && PMaster->objtype == TYPE_PC)
    {
        petutils::DetachPet(PMaster);
    }
}

void CMobEntity::OnDisengage(CAttackState& state)
{
    TracyZoneScoped;
    PAI->PathFind->Clear();
    PEnmityContainer->Clear();

    if (getMobMod(MOBMOD_IDLE_DESPAWN))
    {
        SetDespawnTime(std::chrono::seconds(getMobMod(MOBMOD_IDLE_DESPAWN)));
    }
    // this will let me decide to walk home or despawn
    m_neutral = true;

    m_OwnerID.clean();

    CBattleEntity::OnDisengage(state);

    luautils::OnMobDisengage(this);
}

void CMobEntity::OnCastFinished(CMagicState& state, action_t& action)
{
    TracyZoneScoped;
    CBattleEntity::OnCastFinished(state, action);

    TapDeaggroTime();
}

bool CMobEntity::OnAttack(CAttackState& state, action_t& action)
{
    TracyZoneScoped;
    TapDeaggroTime();

    if (getMobMod(MOBMOD_ATTACK_SKILL_LIST))
    {
        return static_cast<CMobController*>(PAI->GetController())->MobSkill(getMobMod(MOBMOD_ATTACK_SKILL_LIST));
    }
    else
    {
        return CBattleEntity::OnAttack(state, action);
    }
}
