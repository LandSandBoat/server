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

#include "../../common/timer.h"
#include "../../common/utils.h"
#include "../ai/ai_container.h"
#include "../ai/controllers/mob_controller.h"
#include "../ai/helpers/pathfind.h"
#include "../ai/helpers/targetfind.h"
#include "../ai/states/attack_state.h"
#include "../ai/states/mobskill_state.h"
#include "../ai/states/weaponskill_state.h"
#include "../conquest_system.h"
#include "../enmity_container.h"
#include "../entities/charentity.h"
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
#include "../weapon_skill.h"
#include <cstring>

CMobEntity::CMobEntity()
{
    objtype = TYPE_MOB;

    m_DropID = 0;

    m_minLevel = 1;
    m_maxLevel = 1;

    HPscale = 1.0;
    MPscale = 1.0;
    m_flags = 0;

    allegiance = ALLEGIANCE_TYPE::MOB;

    // default to normal roaming
    m_roamFlags    = ROAMFLAG_NONE;
    m_specialFlags = SPECIALFLAG_NONE;
    m_name_prefix  = 0;
    m_MobSkillList = 0;

    m_AllowRespawn = false;
    m_DropItemTime = 0;
    m_Family       = 0;
    m_Type         = MOBTYPE_NORMAL;
    m_Behaviour    = BEHAVIOUR_NONE;
    m_SpawnType    = SPAWNTYPE_NORMAL;
    m_EcoSystem    = ECOSYSTEM::UNCLASSIFIED;
    m_Element      = 0;
    m_HiPCLvl      = 0;
    m_HiPartySize  = 0;
    m_THLvl        = 0;
    m_ItemStolen   = false;

    strRank = 3;
    vitRank = 3;
    agiRank = 3;
    intRank = 3;
    mndRank = 3;
    chrRank = 3;
    attRank = 3;
    defRank = 3;
    accRank = 3;
    evaRank = 3;

    m_dmgMult = 100;

    m_giveExp       = false;
    m_neutral       = false;
    m_Aggro         = false;
    m_TrueDetection = false;
    m_Detects       = DETECT_NONE;
    m_Link          = 0;

    m_battlefieldID = 0;
    m_bcnmID        = 0;

    m_maxRoamDistance = 50.0f;
    m_disableScent    = false;

    // False positive: any reasonable compiler is IEEE754-1985 compatible
    // portability: Using memset() on struct which contains a floating point number.
    // This is not portable because memset() sets each byte of a block of memory to a specific value and
    // the actual representation of a floating-point value is implementation defined. Note: In case of an IEEE754-1985 compatible
    // implementation setting all bits to zero results in the value 0.0. [memsetClassFloat]
    // cppcheck-suppress memsetClassFloat
    memset(&m_SpawnPoint, 0, sizeof(m_SpawnPoint));

    m_SpellListContainer = nullptr;
    PEnmityContainer     = new CEnmityContainer(this);
    SpellContainer       = new CMobSpellContainer(this);

    // For Dyna Stats
    m_StatPoppedMobs = false;

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
    delete PEnmityContainer;
    delete SpellContainer;
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

    if (getMobMod(MOBMOD_NO_DESPAWN) != 0 || map_config.mob_no_despawn)
    {
        return true;
    }

    return distance(m_SpawnPoint, loc.p) < roam_home_distance;
}

bool CMobEntity::CanRoam()
{
    return !(m_roamFlags & ROAMFLAG_EVENT) && PMaster == nullptr && (speed > 0 || (m_roamFlags & ROAMFLAG_WORM)) && getMobMod(MOBMOD_NO_MOVE) == 0;
}

bool CMobEntity::CanLink(position_t* pos, int16 superLink)
{
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

    // link only if I see him
    if (m_Detects & DETECT_SIGHT)
    {
        if (!facing(loc.p, *pos, 64))
        {
            return false;
        }
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

    if (health.tp == 3000 || (GetHPP() <= 25 && health.tp >= 1000))
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

void CMobEntity::CallForHelp(bool call)
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

bool CMobEntity::CalledForHelp() const
{
    return m_flags & FLAG_CALL_FOR_HELP;
}

void CMobEntity::Untargetable(bool untargetable)
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

bool CMobEntity::IsUntargetable() const
{
    return m_flags & FLAG_UNTARGETABLE;
}

void CMobEntity::PostTick()
{
    CBattleEntity::PostTick();
    if (loc.zone && updatemask)
    {
        loc.zone->PushPacket(this, CHAR_INRANGE, new CEntityUpdatePacket(this, ENTITY_UPDATE, updatemask));

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
    if (StatusEffectContainer->GetConfrontationEffect() != PInitiator->StatusEffectContainer->GetConfrontationEffect())
    {
        return false;
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

void CMobEntity::Spawn()
{
    CBattleEntity::Spawn();
    m_giveExp      = true;
    m_HiPCLvl      = 0;
    m_HiPartySize  = 0;
    m_THLvl        = 0;
    m_ItemStolen   = false;
    m_DropItemTime = 1000;
    animationsub   = (uint8)getMobMod(MOBMOD_SPAWN_ANIMATIONSUB);
    CallForHelp(false);

    PEnmityContainer->Clear();

    uint8 level = m_minLevel;

    // Generate a random level between min and max level
    if (m_maxLevel > m_minLevel)
    {
        level += xirand::GetRandomNumber(0, m_maxLevel - m_minLevel + 1);
    }

    SetMLevel(level);
    SetSLevel(level); // calculated in function

    mobutils::CalculateStats(this);
    mobutils::GetAvailableSpells(this);

    // spawn somewhere around my point
    loc.p = m_SpawnPoint;

    if (m_roamFlags & ROAMFLAG_STEALTH)
    {
        HideName(true);
        Untargetable(true);
    }

    // add people to my posse
    if (getMobMod(MOBMOD_ASSIST))
    {
        for (int8 i = 1; i < getMobMod(MOBMOD_ASSIST) + 1; i++)
        {
            CMobEntity* PMob = (CMobEntity*)GetEntity(targid + i, TYPE_MOB);

            if (PMob != nullptr)
            {
                PMob->setMobMod(MOBMOD_SUPERLINK, targid);
            }
        }
    }

    m_DespawnTimer = time_point::min();
    luautils::OnMobSpawn(this);
}

void CMobEntity::OnWeaponSkillFinished(CWeaponSkillState& state, action_t& action)
{
    CBattleEntity::OnWeaponSkillFinished(state, action);

    static_cast<CMobController*>(PAI->GetController())->TapDeaggroTime();
}

void CMobEntity::OnMobSkillFinished(CMobSkillState& state, action_t& action)
{
    auto* PSkill  = state.GetSkill();
    auto* PTarget = static_cast<CBattleEntity*>(state.GetTarget());

    static_cast<CMobController*>(PAI->GetController())->TapDeaggroTime();

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

    action.id = id;
    if (objtype == TYPE_PET && static_cast<CPetEntity*>(this)->getPetType() == PET_TYPE::AVATAR)
    {
        action.actiontype = ACTION_PET_MOBABILITY_FINISH;
    }
    else if (PSkill->getID() < 256)
    {
        action.actiontype = ACTION_WEAPONSKILL_FINISH;
    }
    else
    {
        action.actiontype = ACTION_MOBABILITY_FINISH;
    }
    action.actionid = PSkill->getID();

    if (PTarget && PAI->TargetFind->isWithinRange(&PTarget->loc.p, distance))
    {
        if (PSkill->isAoE())
        {
            PAI->TargetFind->findWithinArea(PTarget, static_cast<AOE_RADIUS>(PSkill->getAoe()), PSkill->getRadius(), findFlags);
        }
        else if (PSkill->isConal())
        {
            float angle = 45.0f;
            PAI->TargetFind->findWithinCone(PTarget, distance, angle, findFlags);
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

    uint16 targets = (uint16)PAI->TargetFind->m_targets.size();

    if (!PTarget || targets == 0)
    {
        action.actiontype         = ACTION_MOBABILITY_INTERRUPT;
        actionList_t& actionList  = action.getNewActionList();
        actionList.ActionTargetID = id;

        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.animation       = PSkill->getID();
        return;
    }

    PSkill->setTotalTargets(targets);
    PSkill->setTP(state.GetSpentTP());
    PSkill->setHPP(GetHPP());

    uint16 msg            = 0;
    uint16 defaultMessage = PSkill->getMsg();

    bool first{ true };
    for (auto&& PTarget : PAI->TargetFind->m_targets)
    {
        actionList_t& list = action.getNewActionList();

        list.ActionTargetID = PTarget->id;

        actionTarget_t& target = list.getNewActionTarget();

        list.ActionTargetID = PTarget->id;
        target.reaction     = REACTION::HIT;
        target.speceffect   = SPECEFFECT::HIT;
        target.animation    = PSkill->getAnimationID();
        target.messageID    = PSkill->getMsg();

        // reset the skill's message back to default
        PSkill->setMsg(defaultMessage);

        if (objtype == TYPE_PET && static_cast<CPetEntity*>(this)->getPetType() != PET_TYPE::JUG_PET)
        {
            PET_TYPE petType = static_cast<CPetEntity*>(this)->getPetType();

            if (static_cast<CPetEntity*>(this)->getPetType() == PET_TYPE::AVATAR || static_cast<CPetEntity*>(this)->getPetType() == PET_TYPE::WYVERN)
            {
                target.animation = PSkill->getPetAnimationID();
            }

            if (petType == PET_TYPE::AUTOMATON)
            {
                target.param = luautils::OnAutomatonAbility(PTarget, this, PSkill, PMaster, &action);
            }
            else
            {
                target.param = luautils::OnPetAbility(PTarget, this, PSkill, PMaster, &action);
            }
        }
        else
        {
            target.param = luautils::OnMobWeaponSkill(PTarget, this, PSkill, &action);
            this->PAI->EventHandler.triggerListener("WEAPONSKILL_USE", CLuaBaseEntity(this), CLuaBaseEntity(PTarget), PSkill->getID(), state.GetSpentTP(), &action);
            PTarget->PAI->EventHandler.triggerListener("WEAPONSKILL_TAKE", CLuaBaseEntity(PTarget), CLuaBaseEntity(this), PSkill->getID(), state.GetSpentTP(), &action);
        }

        if (msg == 0)
        {
            msg = PSkill->getMsg();
        }
        else
        {
            msg = PSkill->getAoEMsg();
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
            target.reaction = REACTION::HIT;
            target.speceffect = SPECEFFECT::HIT;
        }

        // TODO: Should this be reaction and not speceffect?
        if (target.speceffect == SPECEFFECT::HIT) // Formerly bitwise and, though nothing in this function adds additional bits to the field
        {
            target.speceffect = SPECEFFECT::RECOIL;
            target.knockback  = PSkill->getKnockback();
            if (first && (PSkill->getPrimarySkillchain() != 0))
            {
                if (PSkill->getPrimarySkillchain())
                {
                    SUBEFFECT effect = battleutils::GetSkillChainEffect(PTarget, PSkill->getPrimarySkillchain(), PSkill->getSecondarySkillchain(),
                                                                        PSkill->getTertiarySkillchain());
                    if (effect != SUBEFFECT_NONE)
                    {
                        int32 skillChainDamage = battleutils::TakeSkillchainDamage(this, PTarget, target.param, nullptr);
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
                }
                first = false;
            }
        }
        PTarget->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DETECTABLE);
        if (PTarget->isDead())
        {
            battleutils::ClaimMob(PTarget, this);
        }
        battleutils::DirtyExp(PTarget, this);
    }
    PTarget = static_cast<CBattleEntity*>(state.GetTarget());
    if (PTarget->objtype == TYPE_MOB && (PTarget->isDead() || (objtype == TYPE_PET && static_cast<CPetEntity*>(this)->getPetType() == PET_TYPE::AVATAR)))
    {
        battleutils::ClaimMob(PTarget, this);
    }
    battleutils::DirtyExp(PTarget, this);
}

void CMobEntity::DistributeRewards()
{
    CCharEntity* PChar = (CCharEntity*)GetEntity(m_OwnerID.targid, TYPE_PC);

    if (PChar != nullptr && PChar->id == m_OwnerID.id)
    {
        StatusEffectContainer->KillAllStatusEffect();
        PChar->m_charHistory.enemiesDefeated++;

        // NOTE: this is called for all alliance / party members!
        luautils::OnMobDeath(this, PChar);

        if (!CalledForHelp())
        {
            blueutils::TryLearningSpells(PChar, this);
            m_UsedSkillIds.clear();

            // RoE Mob kill event for all party members
            PChar->ForAlliance([this, PChar](CBattleEntity* PMember) {
                if (PMember->getZone() == PChar->getZone())
                {
                    RoeDatagramList datagrams;
                    datagrams.push_back(RoeDatagram("mob", (CMobEntity*)this));
                    datagrams.push_back(RoeDatagram("atkType", static_cast<uint8>(this->BattleHistory.lastHitTaken_atkType)));
                    roeutils::event(ROE_MOBKILL, (CCharEntity*)PMember, datagrams);
                }
            });

            if (m_giveExp && !PChar->StatusEffectContainer->HasStatusEffect(EFFECT_BATTLEFIELD))
            {
                charutils::DistributeExperiencePoints(PChar, this);
                charutils::DistributeCapacityPoints(PChar, this);
            }

            // check for gil (beastmen drop gil, some NMs drop gil)
            if ((map_config.mob_gil_multiplier > 0 && CanDropGil()) ||
                (map_config.all_mobs_gil_bonus > 0 &&
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

void CMobEntity::DropItems(CCharEntity* PChar)
{
    // Adds an item to the treasure pool and returns true if the pool has been filled
    auto AddItemToPool = [this, PChar](uint16 ItemID, uint8 dropCount)
    {
        PChar->PTreasurePool->AddItem(ItemID, this);
        return dropCount >= TREASUREPOOL_SIZE;
    };

    auto UpdateDroprateOrAddToList = [&](std::vector<DropItem_t>& list, uint8 dropType, uint16 itemID, uint16 dropRate)
    {
        // Try and update droprate for an item in place
        bool updated = false;
        for (auto& entry : list)
        {
            if (!updated && entry.ItemID == itemID)
            {
                entry.DropRate = dropRate;
                updated        = true;
            }
        }

        // If that item wasn't found and updated, add the item and droprate to the list
        if (!updated)
        {
            list.emplace_back(DropItem_t(dropType, itemID, dropRate));
        }
    };

    // Limit number of items that can drop to the treasure pool size
    uint8 dropCount = 0;

    // Make a temporary copy of the global droplist entry for this drop id
    // so we can modify it without modifying the global lists
    DropList_t DropList;
    if (auto droplistPtr = itemutils::GetDropList(m_DropID))
    {
        DropList = *droplistPtr;
    }

    // Apply m_DropListModifications changes to DropList
    for (auto& entry : m_DropListModifications)
    {
        uint16 itemID = entry.first;
        uint16 dropRate = entry.second.first;
        DROP_TYPE dropType = static_cast<DROP_TYPE>(entry.second.second);

        if (dropType == DROP_NORMAL)
        {
            UpdateDroprateOrAddToList(DropList.Items, DROP_NORMAL, itemID, dropRate);
        }
        else if (dropType == DROP_GROUPED)
        {
            for (auto& group : DropList.Groups)
            {
                UpdateDroprateOrAddToList(group.Items, DROP_NORMAL, itemID, dropRate);
            }
        }
    }

    // Make sure m_DropListModifications doesn't persist by clearing it out now
    m_DropListModifications.clear();

    if (!getMobMod(MOBMOD_NO_DROPS) && (!DropList.Items.empty() || !DropList.Groups.empty()))
    {
        // THLvl is the number of 'extra chances' at an item. If the item is obtained, then break out.
        int16 maxRolls = 1 + (m_THLvl > 2 ? 2 : m_THLvl);
        int16 bonus    = (m_THLvl > 2 ? (m_THLvl - 2) * 10 : 0);

        for (const DropGroup_t& group : DropList.Groups)
        {
            for (int16 roll = 0; roll < maxRolls; ++roll)
            {
                // Determine if this group should drop an item
                if (group.GroupRate > 0 && xirand::GetRandomNumber(1000) < group.GroupRate * map_config.drop_rate_multiplier + bonus)
                {
                    // Each item in the group is given its own weight range which is the previous value to the previous value + item.DropRate
                    // Such as 2 items with drop rates of 200 and 800 would be 0-199 and 200-999 respectively
                    uint16 previousRateValue = 0;
                    uint16 itemRoll          = xirand::GetRandomNumber(1000);
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
        }

        for (const DropItem_t& item : DropList.Items)
        {
            for (int16 roll = 0; roll < maxRolls; ++roll)
            {
                if (item.DropRate > 0 && xirand::GetRandomNumber(1000) < item.DropRate * map_config.drop_rate_multiplier + bonus)
                {
                    if (AddItemToPool(item.ItemID, ++dropCount))
                    {
                        return;
                    }
                    break;
                }
            }
        }
    }

    uint16 Pzone = PChar->getZone();

    bool validZone = ((Pzone > 0 && Pzone < 39) || (Pzone > 42 && Pzone < 134) || (Pzone > 135 && Pzone < 185) || (Pzone > 188 && Pzone < 255));

    if (validZone && charutils::CheckMob(m_HiPCLvl, GetMLevel()) > EMobDifficulty::TooWeak)
    {
        // check for seal drops
        /* MobLvl >= 1 = Beastmen Seals ID=1126
        >= 50 = Kindred Seals ID=1127
        >= 75 = Kindred Crests ID=2955
        >= 90 = High Kindred Crests ID=2956
        */
        if (xirand::GetRandomNumber(100) < 20 && PChar->PTreasurePool->CanAddSeal() && !getMobMod(MOBMOD_NO_DROPS))
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
            unfortunately, order of the items weather and day don't match.
            ...So no loops...
        */
        uint8 weather = PChar->loc.zone->GetWeather();
        uint8 day = (uint8)CVanaTime::getInstance()->getWeekday();
        // Avatarite. Both wiki say mobs lv 80+
        if (GetMLevel() >= 80 && xirand::GetRandomNumber(100) < 80)
        {
            if (weather >=4 && weather <=19)
            {
                uint8 weatherRoll = xirand::GetRandomNumber(100);
                switch (weather)
                {
                    case 4: // Fire
                    case 5: // Double Fire
                        if (weatherRoll < 55)
                            AddItemToPool(3520, ++dropCount); // Ifritite
                        else
                            AddItemToPool(3297, ++dropCount); // Flame Geode
                        break;
                    case 6: // Water
                    case 7: // Double Water
                        if (weatherRoll < 55)
                            AddItemToPool(3525, ++dropCount); // Leviatite
                        else
                            AddItemToPool(3302, ++dropCount); // Aqua Geode
                        break;
                    case 8: // Earth
                    case 9: // Double Earth
                        if (weatherRoll < 55)
                            AddItemToPool(3523, ++dropCount); // Titanite
                        else
                            AddItemToPool(3300, ++dropCount); // Soil Geode
                        break;
                    case 10: // Wind
                    case 11: // Double Wind
                        if (weatherRoll < 55)
                            AddItemToPool(3522, ++dropCount); // Garudite
                        else
                            AddItemToPool(3299, ++dropCount); // Breeze Geode
                        break;
                    case 12: // Ice
                    case 13: // Double Ice
                        if (weatherRoll < 55)
                            AddItemToPool(3521, ++dropCount); // Shivite
                        else
                            AddItemToPool(3298, ++dropCount); // Snow Geode
                        break;
                    case 14: // Thunder
                    case 15: // Double Thunder
                        if (weatherRoll < 55)
                            AddItemToPool(3524, ++dropCount); // Ramuite
                        else
                            AddItemToPool(3301, ++dropCount); // Thunder Geode
                        break;
                    case 16: // Light
                    case 17: // Double Light
                        if (weatherRoll < 55)
                            AddItemToPool(3526, ++dropCount); // Carbite
                        else
                            AddItemToPool(3303, ++dropCount); // Light Geode
                        break;
                    case 18: // Dark
                    case 19: // Double Dark
                        if (weatherRoll < 55)
                            AddItemToPool(3527, ++dropCount); // Fenrite
                        else
                            AddItemToPool(3304, ++dropCount); // Shadow Geode
                        break;
                    default:
                        break;
                }
            }
            else if (xirand::GetRandomNumber(100) < 20)
            {
                uint8 dayRoll = xirand::GetRandomNumber(100);
                switch (day)
                {
                    case 0: // Fire
                        if (dayRoll < 45)
                            AddItemToPool(3520, ++dropCount); // Ifritite
                        else
                            AddItemToPool(3297, ++dropCount); // Flame Geode
                        break;
                    case 1: // Earth
                        if (dayRoll < 45)
                            AddItemToPool(3523, ++dropCount); // Titanite
                        else
                            AddItemToPool(3300, ++dropCount); // Soil Geode
                        break;
                    case 2: // Water
                        if (dayRoll < 45)
                            AddItemToPool(3525, ++dropCount); // Leviatite
                        else
                            AddItemToPool(3302, ++dropCount); // Aqua Geode
                        break;
                    case 3: // Wind
                        if (dayRoll < 45)
                            AddItemToPool(3522, ++dropCount); // Garudite
                        else
                            AddItemToPool(3299, ++dropCount); // Breeze Geode
                        break;
                    case 4: // Ice
                        if (dayRoll < 45)
                            AddItemToPool(3521, ++dropCount); // Shivite
                        else
                            AddItemToPool(3298, ++dropCount); // Snow Geode
                        break;
                    case 5: // Thunder
                        if (dayRoll < 45)
                            AddItemToPool(3524, ++dropCount); // Ramuite
                        else
                            AddItemToPool(3301, ++dropCount); // Thunder Geode
                        break;
                    case 6: // Light
                        if (dayRoll < 45)
                            AddItemToPool(3526, ++dropCount); // Carbite
                        else
                            AddItemToPool(3303, ++dropCount); // Light Geode
                        break;
                    case 7: // Dark
                        if (dayRoll < 45)
                            AddItemToPool(3527, ++dropCount); // Fenrite
                        else
                            AddItemToPool(3304, ++dropCount); // Shadow Geode
                        break;
                }
            }
        }
        // Geodes. Wiki's have conflicting info on mob lv required. One says 50 the other 75. Betting 50 is correct since the other tier is 80.
        else if (GetMLevel() >= 50 && xirand::GetRandomNumber(100) < 85)
        {
            if (weather >=4 && weather <=19)
            {
                switch (weather)
                {
                    case 4: // Fire
                    case 5: // Double Fire
                        AddItemToPool(3297, ++dropCount); // Flame Geode
                        break;
                    case 6: // Water
                    case 7: // Double Water
                        AddItemToPool(3302, ++dropCount); // Aqua Geode
                        break;
                    case 8: // Earth
                    case 9: // Double Earth
                        AddItemToPool(3300, ++dropCount); // Soil Geode
                        break;
                    case 10: // Wind
                    case 11: // Double Wind
                        AddItemToPool(3299, ++dropCount); // Breeze Geode
                        break;
                    case 12: // Ice
                    case 13: // Double Ice
                        AddItemToPool(3298, ++dropCount); // Snow Geode
                        break;
                    case 14: // Thunder
                    case 15: // Double Thunder
                        AddItemToPool(3301, ++dropCount); // Thunder Geode
                        break;
                    case 16: // Light
                    case 17: // Double Light
                        AddItemToPool(3303, ++dropCount); // Light Geode
                        break;
                    case 18: // Dark
                    case 19: // Double Dark
                        AddItemToPool(3304, ++dropCount); // Shadow Geode
                        break;
                    default:
                        break;
                }
            }
            else if (xirand::GetRandomNumber(100) < 20)
            {
                switch (day)
                {
                    case 0: // Fire
                        AddItemToPool(3297, ++dropCount); // Flame Geode
                        break;
                    case 1: // Earth
                        AddItemToPool(3300, ++dropCount); // Soil Geode
                        break;
                    case 2: // Water
                        AddItemToPool(3302, ++dropCount); // Aqua Geode
                        break;
                    case 3: // Wind
                        AddItemToPool(3299, ++dropCount); // Breeze Geode
                        break;
                    case 4: // Ice
                        AddItemToPool(3298, ++dropCount); // Snow Geode
                        break;
                    case 5: // Thunder
                        AddItemToPool(3301, ++dropCount); // Thunder Geode
                        break;
                    case 6: // Light
                        AddItemToPool(3303, ++dropCount); // Light Geode
                        break;
                    case 7: // Dark
                        AddItemToPool(3304, ++dropCount); // Shadow Geode
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
        PChar->ForParty([this, &crystalRolls, &effect](CBattleEntity* PMember) {
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
        for (uint8 i = 0; i < crystalRolls; i++)
        {
            if (xirand::GetRandomNumber(100) < 20 && AddItemToPool(4095 + m_Element, ++dropCount))
            {
                return;
            }
        }
    }
}

bool CMobEntity::CanAttack(CBattleEntity* PTarget, std::unique_ptr<CBasicPacket>& errMsg)
{
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
        return !((distance(loc.p, PTarget->loc.p) - PTarget->m_ModelSize) > attack_range || !PAI->GetController()->IsAutoAttackEnabled());
    }
    else
    {
        return CBattleEntity::CanAttack(PTarget, errMsg);
    }
}

void CMobEntity::OnEngage(CAttackState& state)
{
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
            ((CCharEntity*)PTarget)->ForAlliance([this, PTarget, range](CBattleEntity* PMember) {
                auto currentDistance = distance(PMember->loc.p, PTarget->loc.p);
                if (currentDistance < range)
                {
                    this->PEnmityContainer->AddBaseEnmity(PMember);
                }
            });
            this->PEnmityContainer->UpdateEnmity((PPet ? (CBattleEntity*)PPet : (CBattleEntity*)PTarget), 0, 1); // Set VE so target doesn't change
        }
    }

    static_cast<CMobController*>(PAI->GetController())->TapDeaggroTime();
}

void CMobEntity::FadeOut()
{
    CBaseEntity::FadeOut();
    PEnmityContainer->Clear();
}

void CMobEntity::OnDeathTimer()
{
    if (!(m_Behaviour & BEHAVIOUR_RAISABLE))
    {
        PAI->Despawn();
    }
}

void CMobEntity::OnDespawn(CDespawnState& /*unused*/)
{
    FadeOut();
    PAI->Internal_Respawn(std::chrono::milliseconds(m_RespawnTime));
    luautils::OnMobDespawn(this);
    //#event despawn
    PAI->EventHandler.triggerListener("DESPAWN", CLuaBaseEntity(this));
}

void CMobEntity::Die()
{
    m_THLvl = PEnmityContainer->GetHighestTH();
    PEnmityContainer->Clear();
    PAI->ClearStateStack();
    if (PPet != nullptr && PPet->isAlive() && GetMJob() == JOB_SMN)
    {
        PPet->Die();
    }
    PAI->Internal_Die(15s);
    CBattleEntity::Die();
    PAI->QueueAction(queueAction_t(std::chrono::milliseconds(m_DropItemTime), false, [this](CBaseEntity* PEntity) {
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
        }
    }));
    if (PMaster && PMaster->PPet == this && PMaster->objtype == TYPE_PC)
    {
        petutils::DetachPet(PMaster);
    }
}

void CMobEntity::OnDisengage(CAttackState& state)
{
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
    CBattleEntity::OnCastFinished(state, action);

    static_cast<CMobController*>(PAI->GetController())->TapDeaggroTime();
}

bool CMobEntity::OnAttack(CAttackState& state, action_t& action)
{
    static_cast<CMobController*>(PAI->GetController())->TapDeaggroTime();

    if (getMobMod(MOBMOD_ATTACK_SKILL_LIST))
    {
        return static_cast<CMobController*>(PAI->GetController())->MobSkill(getMobMod(MOBMOD_ATTACK_SKILL_LIST));
    }
    else
    {
        return CBattleEntity::OnAttack(state, action);
    }
}
