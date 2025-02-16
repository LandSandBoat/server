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

#include "common/logging.h"
#include "common/utils.h"

#include "battleentity.h"

#include "ai/ai_container.h"
#include "ai/states/attack_state.h"
#include "ai/states/death_state.h"
#include "ai/states/despawn_state.h"
#include "ai/states/inactive_state.h"
#include "ai/states/magic_state.h"
#include "ai/states/mobskill_state.h"
#include "ai/states/raise_state.h"
#include "ai/states/weaponskill_state.h"
#include "attack.h"
#include "attackround.h"
#include "items/item_weapon.h"
#include "job_points.h"
#include "lua/luautils.h"
#include "mob_modifier.h"
#include "notoriety_container.h"
#include "packets/action.h"
#include "recast_container.h"
#include "roe.h"
#include "status_effect_container.h"
#include "utils/battleutils.h"
#include "utils/petutils.h"
#include "utils/puppetutils.h"
#include "utils/zoneutils.h"
#include "weapon_skill.h"

CBattleEntity::CBattleEntity()
{
    TracyZoneScoped;
    m_OwnerID.clean();
    m_ModelRadius = 0;
    m_mlvl        = 0;
    m_slvl        = 0;

    m_mjob = JOB_WAR;
    m_sjob = JOB_WAR;

    m_magicEvasion = 0;

    m_Weapons[SLOT_MAIN]   = nullptr;
    m_Weapons[SLOT_SUB]    = nullptr;
    m_Weapons[SLOT_RANGED] = nullptr;
    m_Weapons[SLOT_AMMO]   = nullptr;
    m_dualWield            = false;

    std::memset(&health, 0, sizeof(health));
    health.maxhp = 1;

    PPet          = nullptr;
    PParty        = nullptr;
    PMaster       = nullptr;
    PLastAttacker = nullptr;

    StatusEffectContainer = std::make_unique<CStatusEffectContainer>(this);
    PRecastContainer      = std::make_unique<CRecastContainer>(this);
    PNotorietyContainer   = std::make_unique<CNotorietyContainer>(this);

    m_modStat[Mod::SLASH_SDT]  = 1000;
    m_modStat[Mod::PIERCE_SDT] = 1000;
    m_modStat[Mod::HTH_SDT]    = 1000;
    m_modStat[Mod::IMPACT_SDT] = 1000;

    m_Immunity   = 0;
    isCharmed    = false;
    m_unkillable = false;

    m_DeathType = DEATH_TYPE::NONE;

    BattleHistory.lastHitTaken_atkType = ATTACK_TYPE::NONE;
}

CBattleEntity::~CBattleEntity()
{
    TracyZoneScoped;
}

bool CBattleEntity::isDead()
{
    return (health.hp <= 0 || status == STATUS_TYPE::DISAPPEAR || PAI->IsCurrentState<CDeathState>() || PAI->IsCurrentState<CDespawnState>());
}

bool CBattleEntity::isAlive()
{
    return !isDead();
}

bool CBattleEntity::isInDynamis()
{
    auto* PZone = loc.zone == nullptr ? zoneutils::GetZone(loc.destination) : loc.zone;
    if (PZone)
    {
        return PZone->GetTypeMask() & ZONE_TYPE::DYNAMIS;
    }
    return false;
}

bool CBattleEntity::isInAssault()
{
    if (loc.zone != nullptr)
    {
        return loc.zone->GetTypeMask() & ZONE_TYPE::INSTANCED &&
               (loc.zone->GetRegionID() >= REGION_TYPE::WEST_AHT_URHGAN && loc.zone->GetRegionID() <= REGION_TYPE::ALZADAAL);
    }
    return false;
}

bool CBattleEntity::isInAdoulin()
{
    if (loc.zone != nullptr)
    {
        ZONEID zoneid = loc.zone->GetID();
        switch (zoneid)
        {
            case ZONEID::ZONE_WESTERN_ADOULIN:
            case ZONEID::ZONE_EASTERN_ADOULIN:
            case ZONEID::ZONE_MOG_GARDEN:
            case ZONEID::ZONE_SILVER_KNIFE:
            case ZONEID::ZONE_CELENNIA_MEMORIAL_LIBRARY:
                return true;
            default:
                break;
        }
    }
    return false;
}

bool CBattleEntity::isInMogHouse()
{
    if (this->objtype == TYPE_PC)
    {
        return static_cast<CCharEntity*>(this)->m_moghouseID;
    }

    return false;
}

// return true if the mob has immunity
bool CBattleEntity::hasImmunity(uint32 imID)
{
    if (objtype == TYPE_MOB || objtype == TYPE_PET)
    {
        IMMUNITY mobImmunity = (IMMUNITY)imID;
        return (m_Immunity & mobImmunity);
    }
    return false;
}

bool CBattleEntity::isAsleep()
{
    return PAI->IsCurrentState<CInactiveState>();
}

bool CBattleEntity::isMounted()
{
    return (animation == ANIMATION_CHOCOBO || animation == ANIMATION_MOUNT);
}

bool CBattleEntity::isSitting()
{
    return (animation == ANIMATION_HEALING || animation == ANIMATION_SIT || (animation >= ANIMATION_SITCHAIR_0 && animation <= ANIMATION_SITCHAIR_10));
}

/************************************************************************
 *                                                                       *
 *  Recalculate hp and mp maximum values, taking into account modifiers  *
 *                                                                       *
 ************************************************************************/

void CBattleEntity::UpdateHealth()
{
    TracyZoneScoped;

    float weaknessPower = (100.f + getMod(Mod::WEAKNESS_PCT)) / 100.f;
    float cursePower    = (100.f + getMod(Mod::CURSE_PCT)) / 100.f;
    float HPPPower      = (100.f + getMod(Mod::HPP)) / 100.f;
    float MPPPower      = (100.f + getMod(Mod::MPP)) / 100.f;

    // Calculate "base" hp/mp with weakness, curse, HP mods. Raw HP/MP mods from food are post-curse.
    // Note: Afflictor was noted to use exactly 75/256 for curse power
    int32 baseHPBonus = std::floor((std::floor((health.maxhp + getMod(Mod::BASE_HP)) * weaknessPower) + getMod(Mod::HP)) * cursePower) + getMod(Mod::FOOD_HP);
    int32 baseMPBonus = std::floor((std::floor((health.maxmp + getMod(Mod::BASE_MP)) * weaknessPower) + getMod(Mod::MP)) * cursePower) + getMod(Mod::FOOD_MP);

    // Resolve HP/MP conversion
    int32 HPMPConvertDiff = getMod(Mod::CONVMPTOHP) - getMod(Mod::CONVHPTOMP);
    int32 convertHP       = 0;
    int32 convertMP       = 0;

    // positive = convert HP to MP wins out
    if (HPMPConvertDiff > 0)
    {
        convertHP = std::min(baseMPBonus, HPMPConvertDiff);
        convertMP = -convertHP;
    }
    else if (HPMPConvertDiff < 0) // negative = convert MP to HP wins out
    {
        // -1 so we don't end up with zero HP...
        convertMP = std::min(baseHPBonus - 1, -HPMPConvertDiff);
        convertHP = -convertMP;
    }

    // add in convert HP/MP..
    baseHPBonus = std::floor((baseHPBonus + convertHP) * HPPPower);
    baseMPBonus = std::floor((baseMPBonus + convertMP) * MPPPower);

    // Food is additive at the end
    float foodHPBonus = std::min<int16>(baseHPBonus * m_modStat[Mod::FOOD_HPP] / 100, m_modStat[Mod::FOOD_HP_CAP]);
    float foodMPBonus = std::min<int16>(baseMPBonus * m_modStat[Mod::FOOD_MPP] / 100, m_modStat[Mod::FOOD_MP_CAP]);

    health.modhp = baseHPBonus + foodHPBonus;
    health.modmp = baseMPBonus + foodMPBonus;

    if (objtype == TYPE_PC)
    {
        health.modhp = std::clamp(health.modhp, 1, 9999);
        health.modmp = std::clamp(health.modmp, 0, 9999);
    }

    health.hp = std::clamp(health.hp, 0, health.modhp);
    health.mp = std::clamp(health.mp, 0, health.modmp);

    updatemask |= UPDATE_HP;
}

/************************************************************************
 *                                                                       *
 *  Get current number of hit points                                     *
 *                                                                       *
 ************************************************************************/

uint8 CBattleEntity::GetHPP() const
{
    if (health.hp == 0)
    {
        return 0;
    }

    return static_cast<uint8>(std::max<uint8>(1, std::floor((static_cast<float>(health.hp) / static_cast<float>(GetMaxHP())) * 100.f)));
}

int32 CBattleEntity::GetMaxHP() const
{
    return health.modhp;
}

/************************************************************************
 *                                                                       *
 *  Get current number of mana points                                    *
 *                                                                       *
 ************************************************************************/

uint8 CBattleEntity::GetMPP() const
{
    if (health.mp == 0)
    {
        return 0;
    }

    return static_cast<uint8>(std::max<uint8>(1, std::floor((static_cast<float>(health.mp) / static_cast<float>(GetMaxMP())) * 100.f)));
}

int32 CBattleEntity::GetMaxMP() const
{
    return health.modmp;
}

/************************************************************************
 *                                                                       *
 *  Movement speed, taking into account modifiers                        *
 *  Note: retail speeds show as a float in the client,                   *
 *        yet in the packet it seems to be just one byte 0-255..         *
 *                                                                       *
 ************************************************************************/

uint8 CBattleEntity::UpdateSpeed(bool run)
{
    int16 outputSpeed = 0;

    // Mount speed. Independent from regular speed and unaffected by most things.
    if (isMounted())
    {
        outputSpeed = settings::get<uint8>("map.MOUNT_SPEED") / 2;
        outputSpeed *= (100 + getMod(Mod::MOUNT_MOVE)) / 100;
    }
    else if (baseSpeed == 0 || getMod(Mod::MOVE_SPEED_OVERRIDE) < 0)
    {
        outputSpeed = 0;
    }
    else if (getMod(Mod::MOVE_SPEED_OVERRIDE) > 0)
    {
        // GM speed bypass.
        // Speed cap can be bypassed. Ex. Feast of swords. GM speed.
        // TODO: Find exceptions. Add them here.
        outputSpeed = getMod(Mod::MOVE_SPEED_OVERRIDE);
    }
    else
    {
        // Gear penalties.
        int8 additiveMods = static_cast<int8>(getMod(Mod::MOVE_SPEED_STACKABLE));

        // Gravity and Curse. They seem additive to each other and the sum seems to be multiplicative.
        float weightFactor = std::clamp<float>(1.0f - static_cast<float>(getMod(Mod::MOVE_SPEED_WEIGHT_PENALTY)) / 100.0f, 0.1f, 1.0f);

        // Flee.
        float fleeFactor = std::clamp<float>(1.0f + static_cast<float>(getMod(Mod::MOVE_SPEED_FLEE)) / 10000.0f, 1.0f, 2.0f);

        // Cheer KI's
        float cheerFactor = (99.0f + static_cast<float>(getMod(Mod::MOVE_SPEED_CHEER))) / 99.0f;

        // Bolter's Roll. Additive
        uint8 boltersRollEffect = static_cast<uint8>(getMod(Mod::MOVE_SPEED_BOLTERS_ROLL));

        // Positive movement speed from gear and from Atmas. Only highest applies. Multiplicative to base speed.
        float gearFactor = 1.0f;

        if (objtype == TYPE_PC)
        {
            gearFactor = std::clamp<float>(1.0f + static_cast<float>(getMaxGearMod(Mod::MOVE_SPEED_GEAR_BONUS)) / 100.0f, 1.0f, 1.25f);
        }

        // Quickening and Mazurka. They share a cap. Additive.
        uint8 mazurkaQuickeningEffect = std::clamp<uint8>(getMod(Mod::MOVE_SPEED_QUICKENING) + getMod(Mod::MOVE_SPEED_MAZURKA), 0, 10);

        // We have all the modifiers needed. Calculate final speed.
        // This MUST BE DONE IN THIS ORDER. Using int8 data type, we use that to floor.
        outputSpeed = baseSpeed + additiveMods;
        outputSpeed = outputSpeed * weightFactor;
        outputSpeed = outputSpeed * fleeFactor;
        outputSpeed = outputSpeed * cheerFactor;
        outputSpeed = outputSpeed + boltersRollEffect;
        outputSpeed = outputSpeed * gearFactor;
        if (outputSpeed > 0)
        {
            outputSpeed = outputSpeed + mazurkaQuickeningEffect;
        }

        // Set cap if a PC (Default 80).
        if (objtype == TYPE_PC)
        {
            outputSpeed = std::clamp<int16>(outputSpeed, 0, settings::get<uint8>("map.SPEED_LIMIT"));
        }

        if (run && outputSpeed > 0)
        {
            float multiplier = settings::get<float>("map.MOB_RUN_SPEED_MULTIPLIER");
            if (multiplier > 1.0f)
            {
                if (auto* mobEntity = dynamic_cast<CMobEntity*>(this))
                {
                    // mob has a custom multiplier
                    if (mobEntity->getMobMod(MOBMOD_RUN_SPEED_MULT) > 0)
                    {
                        multiplier = mobEntity->getMobMod(MOBMOD_RUN_SPEED_MULT) / 100.0f;
                    }

                    // if some weight penalty (like gravity) then cut the multiplier
                    // (for mobs with default boost of 2.5 then boost becomes 1.20)
                    if (mobEntity->getMod(Mod::MOVE_SPEED_WEIGHT_PENALTY) > 0)
                    {
                        multiplier *= 0.48f;
                    }

                    // Ensure the multiplier is at least 1.0 so that multiplier never decreases speed
                    multiplier = std::max<float>(multiplier, 1.0f);

                    outputSpeed *= multiplier;
                }
            }
        }
    }

    speed = static_cast<uint8>(std::clamp<int16>(outputSpeed, std::numeric_limits<uint8>::min(), std::numeric_limits<uint8>::max()));

    return speed;
}

bool CBattleEntity::CanRest()
{
    return !getMod(Mod::REGEN_DOWN) && !StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_NO_REST);
}

bool CBattleEntity::Rest(float rate)
{
    bool didRest = false;

    if (health.hp != health.maxhp || health.mp != health.maxmp)
    {
        // recover some HP and MP
        uint32 recoverHP = (uint32)(health.maxhp * rate);
        uint32 recoverMP = (uint32)(health.maxmp * rate);
        addHP(recoverHP);
        addMP(recoverMP);
        didRest = true;
    }

    if (health.tp > 0)
    {
        // lower TP
        addTP((int16)(rate * -500));
        didRest = true;
    }

    return didRest;
}

int16 CBattleEntity::GetWeaponDelay(bool tp)
{
    TracyZoneScoped;
    uint16 WeaponDelay = 9999;
    if (auto* weapon = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_MAIN]))
    {
        uint16 MinimumDelay = weapon->getDelay(); // Track base delay.  We will need this later.  Mod::DELAY is ignored for now.
        WeaponDelay         = weapon->getDelay() - getMod(Mod::DELAY);
        if (weapon->isHandToHand())
        {
            WeaponDelay -= getMod(Mod::MARTIAL_ARTS) * 1000 / 60;
        }
        else if (auto* subweapon = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_SUB]);
                 subweapon && subweapon->getDmgType() > DAMAGE_TYPE::NONE && subweapon->getDmgType() < DAMAGE_TYPE::HTH)
        {
            MinimumDelay += subweapon->getDelay();
            WeaponDelay += subweapon->getDelay();
            // apply dual wield delay reduction
            WeaponDelay = (uint16)(WeaponDelay * ((100.0f - getMod(Mod::DUAL_WIELD)) / 100.0f));
        }

        // apply haste and delay reductions that don't affect tp
        if (!tp)
        {
            // Cap haste at appropriate levels.
            int16 hasteMagic   = std::clamp<int16>(getMod(Mod::HASTE_MAGIC), -10000, 4375);  // 43.75% cap -- handle 100% slow for weakness
            int16 hasteAbility = std::clamp<int16>(getMod(Mod::HASTE_ABILITY), -2500, 2500); // 25% cap
            int16 hasteGear    = std::clamp<int16>(getMod(Mod::HASTE_GEAR), -2500, 2500);    // 25%

            if (weapon->isTwoHanded())
            {
                hasteAbility = std::clamp<int16>(getMod(Mod::HASTE_ABILITY) + getMod(Mod::TWOHAND_HASTE_ABILITY), -2500, 2500); // 25% cap
            }

            // Check if we are using a special attack list that should not be affected by attack speed debuffs
            // Example: Wyrm's flying auto attack speed should not be modified by debuffs.
            bool specialAttackList = false;
            if (auto* mobEntity = dynamic_cast<CMobEntity*>(this))
            {
                if (mobEntity->getMobMod(MOBMODIFIER::MOBMOD_ATTACK_SKILL_LIST) != 0)
                {
                    specialAttackList = true;
                }
            }

            // Divide by float to get a more accurate reduction, then use int16 cast to truncate
            if (!specialAttackList)
            {
                WeaponDelay -= (int16)(WeaponDelay * (hasteMagic + hasteAbility + hasteGear) / 10000.f);
            }
        }
        WeaponDelay = (uint16)(WeaponDelay * ((100.0f + getMod(Mod::DELAYP)) / 100.0f));

        // Global delay reduction cap of "about 80%" being enforced.
        // This should be enforced on -delay equipment, martial arts, dual wield, and haste, hence MinimumDelay * 0.2.
        // TODO: Could be converted to value/1024 if the exact cap is ever determined.
        MinimumDelay -= (uint16)(MinimumDelay * 0.8);

        // if hundred fists then use the min delay (as hundred fists also reduces base delay by 80%
        if (StatusEffectContainer->HasStatusEffect(EFFECT_HUNDRED_FISTS) && !tp)
        {
            WeaponDelay = MinimumDelay;
        }

        WeaponDelay = (WeaponDelay < MinimumDelay) ? MinimumDelay : WeaponDelay;
    }
    return WeaponDelay;
}

float CBattleEntity::GetMeleeRange() const
{
    return m_ModelRadius + 3.0f;
}

int16 CBattleEntity::GetRangedWeaponDelay(bool forTPCalc)
{
    CItemWeapon* PRange = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_RANGED]);
    CItemWeapon* PAmmo  = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_AMMO]);

    // base delay
    int16 delay = 0;

    if (PRange && PRange->getDamage() != 0)
    {
        delay = PRange->getBaseDelay();

        if (PAmmo && forTPCalc)
        {
            delay += PAmmo->getBaseDelay();
        }
    }
    else if (PAmmo && PAmmo->getDamage() != 0)
    {
        delay = PAmmo->getBaseDelay();
    }

    // multiple the base delays by 1000 so final delays are in ms
    // divide by 120 to convert the delays to actual times
    delay = (delay - getMod(Mod::RANGED_DELAY)) * 1000 / 120;

    // apply haste and delay reductions that don't affect tp
    if (!forTPCalc)
    {
        delay = delay * ((100.0f + getMod(Mod::RANGED_DELAYP)) / 100.0f);
    }
    return delay;
}

int16 CBattleEntity::GetAmmoDelay()
{
    CItemWeapon* PAmmo = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_AMMO]);

    int delay = 0;
    if (PAmmo != nullptr && PAmmo->getDamage() != 0)
    {
        delay = PAmmo->getDelay() / 2;
    }

    return delay;
}

uint16 CBattleEntity::GetMainWeaponDmg()
{
    TracyZoneScoped;
    if (auto* weapon = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_MAIN]))
    {
        if ((weapon->getReqLvl() > GetMLevel()) && objtype == TYPE_PC)
        {
            // TODO: Determine the difference between augments and latents w.r.t. equipment scaling.
            // MAIN_DMG_RATING already has equipment scaling applied elsewhere.
            uint16 dmg = weapon->getDamage();
            dmg *= GetMLevel() * 3;
            dmg /= 4;
            dmg /= weapon->getReqLvl();
            return dmg + weapon->getModifier(Mod::DMG_RATING) + getMod(Mod::MAIN_DMG_RATING);
        }
        else
        {
            return weapon->getDamage() + weapon->getModifier(Mod::DMG_RATING) + getMod(Mod::MAIN_DMG_RATING);
        }
    }
    return 0;
}

uint16 CBattleEntity::GetSubWeaponDmg()
{
    TracyZoneScoped;
    if (auto* weapon = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_SUB]))
    {
        if ((weapon->getReqLvl() > GetMLevel()) && objtype == TYPE_PC)
        {
            uint16 dmg = weapon->getDamage();
            dmg *= GetMLevel() * 3;
            dmg /= 4;
            dmg /= weapon->getReqLvl();
            return dmg + weapon->getModifier(Mod::DMG_RATING) + getMod(Mod::SUB_DMG_RATING);
        }
        else
        {
            return weapon->getDamage() + weapon->getModifier(Mod::DMG_RATING) + getMod(Mod::SUB_DMG_RATING);
        }
    }
    return 0;
}

uint16 CBattleEntity::GetRangedWeaponDmg()
{
    TracyZoneScoped;
    uint16 dmg = 0;
    if (auto* weapon = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_RANGED]))
    {
        if ((weapon->getReqLvl() > GetMLevel()) && objtype == TYPE_PC)
        {
            uint16 scaleddmg = weapon->getDamage();
            scaleddmg *= GetMLevel() * 3;
            scaleddmg /= 4;
            scaleddmg /= weapon->getReqLvl();
            dmg += scaleddmg + weapon->getModifier(Mod::DMG_RATING);
        }
        else
        {
            dmg += weapon->getDamage() + weapon->getModifier(Mod::DMG_RATING);
        }
    }
    if (auto* ammo = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_AMMO]))
    {
        if ((ammo->getReqLvl() > GetMLevel()) && objtype == TYPE_PC)
        {
            uint16 scaleddmg = ammo->getDamage();
            scaleddmg *= GetMLevel() * 3;
            scaleddmg /= 4;
            scaleddmg /= ammo->getReqLvl();
            dmg += scaleddmg + ammo->getModifier(Mod::DMG_RATING);
        }
        else
        {
            dmg += ammo->getDamage() + ammo->getModifier(Mod::DMG_RATING);
        }
    }
    return dmg + getMod(Mod::RANGED_DMG_RATING);
}

uint16 CBattleEntity::GetMainWeaponRank()
{
    uint16 wDamage = 0;
    if (auto* weapon = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_MAIN]))
    {
        wDamage = weapon->getDamage() + getMod(Mod::MAIN_DMG_RANK);

        // apply the H2H formula adjustment only to players
        // as mobs use H2H for dual wield and thus further research is needed
        if (objtype == TYPE_PC && weapon->getSkillType() == SKILL_HAND_TO_HAND)
        {
            wDamage += 3;
        }
    }
    return wDamage / 9;
}

uint16 CBattleEntity::GetSubWeaponRank()
{
    if (auto* weapon = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_SUB]))
    {
        return (weapon->getDamage() + getMod(Mod::SUB_DMG_RANK)) / 9;
    }
    return 0;
}

uint16 CBattleEntity::GetRangedWeaponRank()
{
    // Check ranged slot first, otherwise use ammo if it's null
    CItemEquipment* item = m_Weapons[SLOT_RANGED] ? m_Weapons[SLOT_RANGED] : m_Weapons[SLOT_AMMO];

    if (auto* weapon = dynamic_cast<CItemWeapon*>(item))
    {
        return (weapon->getDamage() + getMod(Mod::RANGED_DMG_RANK)) / 9;
    }

    return 0;
}

/************************************************************************
 *                                                                       *
 *  Change the amount of TP of an entity                                 *
 *                                                                       *
 ************************************************************************/

int16 CBattleEntity::addTP(int16 tp)
{
    // When adding TP, we must adjust for Inhibit TP effect, which reduces TP gain.
    if (tp > 0)
    {
        float tpReducePercent = this->getMod(Mod::INHIBIT_TP) / 100.0f;
        tp                    = (int16)(tp - (tp * tpReducePercent));

        float TPMulti = 1.0;

        if (objtype == TYPE_PC)
        {
            TPMulti = settings::get<float>("map.PLAYER_TP_MULTIPLIER");
        }
        else if (objtype == TYPE_PET || (objtype == TYPE_MOB && this->PMaster)) // normal pet or charmed pet
        {
            TPMulti = settings::get<float>("map.PET_TP_MULTIPLIER");
        }
        else if (objtype == TYPE_MOB)
        {
            TPMulti = settings::get<float>("map.MOB_TP_MULTIPLIER");
        }
        else if (objtype == TYPE_TRUST)
        {
            TPMulti = settings::get<float>("map.TRUST_TP_MULTIPLIER");
        }
        else if (objtype == TYPE_FELLOW)
        {
            TPMulti = settings::get<float>("map.FELLOW_TP_MULTIPLIER");
        }

        tp = (int16)(tp * TPMulti);
    }
    if (tp != 0)
    {
        updatemask |= UPDATE_HP;
    }
    int16 cap = std::clamp(health.tp + tp, 0, 3000);
    tp        = health.tp - cap;
    health.tp = cap;
    return abs(tp);
}

int32 CBattleEntity::addHP(int32 hp)
{
    if (health.hp == 0 && hp < 0)
    {
        return 0; // if the entity is already dead, skip the rest to prevent killing it again
    }

    int32 cap = std::clamp(health.hp + hp, 0, GetMaxHP());
    hp        = health.hp - cap;
    health.hp = cap;

    if (hp > 0)
    {
        battleutils::MakeEntityStandUp(this);
    }

    if (hp != 0)
    {
        updatemask |= UPDATE_HP;
    }

    if (health.hp == 0 && m_unkillable)
    {
        health.hp = 1;
    }

    return abs(hp);
}

int32 CBattleEntity::addMP(int32 mp)
{
    int32 cap = std::clamp(health.mp + mp, 0, GetMaxMP());
    mp        = health.mp - cap;
    health.mp = cap;
    if (mp != 0)
    {
        updatemask |= UPDATE_HP;
    }
    return abs(mp);
}

int32 CBattleEntity::takeDamage(int32 amount, CBattleEntity* attacker /* = nullptr*/, ATTACK_TYPE attackType /* = ATTACK_NONE*/,
                                DAMAGE_TYPE damageType /* = DAMAGE_NONE*/, bool isSkillchainDamage /* = false */)
{
    TracyZoneScoped;
    PLastAttacker                            = attacker;
    this->BattleHistory.lastHitTaken_atkType = attackType;

    PAI->EventHandler.triggerListener("TAKE_DAMAGE", this, amount, attacker, (uint16)attackType, (uint16)damageType);

    // RoE Damage Taken Trigger
    if (this->objtype == TYPE_PC)
    {
        if (amount > 0)
        {
            roeutils::event(ROE_EVENT::ROE_DMGTAKEN, static_cast<CCharEntity*>(this), RoeDatagram("dmg", amount));
        }
    }
    else if (PLastAttacker && PLastAttacker->objtype == TYPE_PC)
    {
        if (amount > 0)
        {
            roeutils::event(ROE_EVENT::ROE_DMGDEALT, static_cast<CCharEntity*>(attacker), RoeDatagram("dmg", amount));
        }

        // Took dmg from non ws source, so remove ws data var.  Skillchain damage
        // occurs prior to listeners being fired, so retain this data for this case.
        if (!isSkillchainDamage)
        {
            this->SetLocalVar("weaponskillHit", 0);
        }
    }

    if (getMod(Mod::ABSORB_DMG_TO_MP) > 0)
    {
        int16 absorbedMP = (int16)(amount * getMod(Mod::ABSORB_DMG_TO_MP) / 100);
        if (absorbedMP > 0)
        {
            addMP(absorbedMP);
        }
    }

    return addHP(-amount);
}

uint16 CBattleEntity::STR()
{
    auto* weapon = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_MAIN]);

    // Hasso gives STR only if main weapon is two handed
    if (weapon && weapon->isTwoHanded())
    {
        return std::clamp(stats.STR + m_modStat[Mod::STR] + m_modStat[Mod::TWOHAND_STR], 0, 999);
    }
    return std::clamp(stats.STR + m_modStat[Mod::STR], 0, 999);
}

uint16 CBattleEntity::DEX()
{
    return std::clamp(stats.DEX + m_modStat[Mod::DEX], 0, 999);
}

uint16 CBattleEntity::VIT()
{
    return std::clamp(stats.VIT + m_modStat[Mod::VIT], 0, 999);
}

uint16 CBattleEntity::AGI()
{
    return std::clamp(stats.AGI + m_modStat[Mod::AGI], 0, 999);
}

uint16 CBattleEntity::INT()
{
    return std::clamp(stats.INT + m_modStat[Mod::INT], 0, 999);
}

uint16 CBattleEntity::MND()
{
    return std::clamp(stats.MND + m_modStat[Mod::MND], 0, 999);
}

uint16 CBattleEntity::CHR()
{
    return std::clamp(stats.CHR + m_modStat[Mod::CHR], 0, 999);
}

uint16 CBattleEntity::ATT(SLOTTYPE slot)
{
    TracyZoneScoped;
    // TODO: consider which weapon!
    int32 ATT    = 8 + m_modStat[Mod::ATT];
    auto  ATTP   = m_modStat[Mod::ATTP];
    auto* weapon = dynamic_cast<CItemWeapon*>(m_Weapons[slot]);

    // https://www.bg-wiki.com/ffxi/Strength
    if (weapon && weapon->isTwoHanded()) // 2-handed weapon
    {
        ATT += STR();
    }
    else if (weapon && weapon->isHandToHand()) // H2H Weapon
    {
        ATT += STR() * 3 / 4;
    }
    else if (slot == SLOT_RANGED || slot == SLOT_AMMO) // Ranged/ammo weapon.
    {
        ATT += STR();
    }
    else if (slot == SLOT_MAIN) // 1-handed weapon in main slot.
    {
        ATT += STR();
    }
    else // 1-handed weapon in sub slot.
    {
        ATT += STR() / 2;
    }

    if (this->StatusEffectContainer->HasStatusEffect(EFFECT_ENDARK))
    {
        ATT += this->getMod(Mod::ENSPELL_DMG);
    }

    if (this->objtype & TYPE_PC)
    {
        if (weapon)
        {
            ATT += GetSkill(weapon->getSkillType()) + weapon->getILvlSkill();

            // Smite applies (bonus ATTP) when using 2H or H2H weapons
            if (weapon->isTwoHanded() || weapon->isHandToHand())
            {
                ATTP += static_cast<int32>(this->getMod(Mod::SMITE) / 256.f * 100); // Divide Smite value by 256
            }
        }
    }
    else if (this->objtype == TYPE_PET && ((CPetEntity*)this)->getPetType() == PET_TYPE::AUTOMATON)
    {
        ATT += this->GetSkill(SKILL_AUTOMATON_MELEE);
    }
    // use max to prevent underflow
    return std::max(1, ATT + (ATT * ATTP / 100) + std::min<int16>((ATT * m_modStat[Mod::FOOD_ATTP] / 100), m_modStat[Mod::FOOD_ATT_CAP]));
}

uint16 CBattleEntity::RATT(uint8 skill, uint16 bonusSkill)
{
    auto* PWeakness = StatusEffectContainer->GetStatusEffect(EFFECT_WEAKNESS);
    if (PWeakness && PWeakness->GetPower() >= 2)
    {
        return 0;
    }

    // make sure to not use fishing skill
    uint16 baseSkill = skill == SKILL_FISHING ? 0 : GetSkill(skill);
    int32  RATT      = 8 + baseSkill + bonusSkill + m_modStat[Mod::RATT] + battleutils::GetRangedAttackBonuses(this) + STR();
    // use max to prevent any underflow
    return std::max(1, RATT + (RATT * m_modStat[Mod::RATTP] / 100) + std::min<int16>((RATT * m_modStat[Mod::FOOD_RATTP] / 100), m_modStat[Mod::FOOD_RATT_CAP]));
}

uint16 CBattleEntity::RACC(uint8 skill, uint16 bonusSkill)
{
    TracyZoneScoped;
    auto* PWeakness = StatusEffectContainer->GetStatusEffect(EFFECT_WEAKNESS);
    if (PWeakness && PWeakness->GetPower() >= 2)
    {
        return 0;
    }

    // make sure to not use fishing skill
    uint16 baseSkill   = skill == SKILL_FISHING ? 0 : GetSkill(skill);
    uint16 skill_level = baseSkill + bonusSkill;
    int16  RACC        = skill_level;
    if (skill_level > 200)
    {
        RACC = (int16)(200 + (skill_level - 200) * 0.9);
    }
    RACC += getMod(Mod::RACC);
    RACC += battleutils::GetRangedAccuracyBonuses(this);
    RACC += (AGI() * 3) / 4;
    // use max to prevent underflow
    return std::max(0, RACC + std::min<int16>(((100 + getMod(Mod::FOOD_RACCP) * RACC) / 100), getMod(Mod::FOOD_RACC_CAP)));
}

uint16 CBattleEntity::ACC(uint8 attackNumber, uint16 offsetAccuracy)
{
    TracyZoneScoped;

    if (this->objtype & TYPE_PC)
    {
        uint8  skill       = 0;
        uint16 iLvlSkill   = 0;
        auto   PMainWeapon = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_MAIN]);

        if (attackNumber == 0)
        {
            if (PMainWeapon)
            {
                skill     = PMainWeapon->getSkillType();
                iLvlSkill = PMainWeapon->getILvlSkill();
                if (skill == SKILL_NONE && GetSkill(SKILL_HAND_TO_HAND) > 0)
                {
                    skill = SKILL_HAND_TO_HAND;
                }
            }
        }
        else if (attackNumber == 1)
        {
            if (auto* weapon = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_SUB]))
            {
                skill     = weapon->getSkillType();
                iLvlSkill = weapon->getILvlSkill();
                if (skill == SKILL_NONE && GetSkill(SKILL_HAND_TO_HAND) > 0)
                {
                    auto* main_weapon = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_MAIN]);
                    if (main_weapon && (main_weapon->getSkillType() == SKILL_NONE || main_weapon->getSkillType() == SKILL_HAND_TO_HAND))
                    {
                        skill = SKILL_HAND_TO_HAND;
                    }
                }
            }
            else if (PMainWeapon && PMainWeapon->isHandToHand())
            {
                iLvlSkill = PMainWeapon->getILvlSkill();
                skill     = SKILL_HAND_TO_HAND;
            }
        }
        else if (attackNumber == 2)
        {
            if (auto* weapon = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_MAIN]))
            {
                iLvlSkill = weapon->getILvlSkill();
            }
            skill = SKILL_HAND_TO_HAND;
        }
        int32 ACC = GetSkill(skill) + iLvlSkill;
        ACC       = (ACC > 200 ? (int16)(((ACC - 200) * 0.9) + 200) : ACC);
        if (auto* weapon = dynamic_cast<CItemWeapon*>(m_Weapons[SLOT_MAIN]); weapon && weapon->isTwoHanded())
        {
            ACC += (int16)(DEX() * 0.75);
            ACC += m_modStat[Mod::TWOHAND_ACC];
        }
        else
        {
            ACC += (int16)(DEX() * 0.75);
        }
        ACC = (ACC + m_modStat[Mod::ACC] + offsetAccuracy);

        if (this->StatusEffectContainer->HasStatusEffect(EFFECT_ENLIGHT))
        {
            ACC += this->getMod(Mod::ENSPELL_DMG);
        }

        auto* PChar = dynamic_cast<CCharEntity*>(this);
        if (PChar)
        {
            ACC += PChar->PMeritPoints->GetMeritValue(MERIT_ACCURACY, PChar);
        }

        ACC = ACC + std::min<int16>((ACC * m_modStat[Mod::FOOD_ACCP] / 100), m_modStat[Mod::FOOD_ACC_CAP]);
        return std::max<int16>(0, ACC);
    }
    else if (this->objtype == TYPE_PET && ((CPetEntity*)this)->getPetType() == PET_TYPE::AUTOMATON)
    {
        int32 ACC = this->GetSkill(SKILL_AUTOMATON_MELEE);
        ACC       = (ACC > 200 ? (int16)(((ACC - 200) * 0.9) + 200) : ACC);
        ACC += (int16)(DEX() * 0.5);
        ACC += m_modStat[Mod::ACC] + offsetAccuracy;

        if (this->StatusEffectContainer->HasStatusEffect(EFFECT_ENLIGHT))
        {
            ACC += this->getMod(Mod::ENSPELL_DMG);
        }

        ACC = ACC + std::min<int16>((ACC * m_modStat[Mod::FOOD_ACCP] / 100), m_modStat[Mod::FOOD_ACC_CAP]);
        return std::max<int16>(0, ACC);
    }
    else
    {
        int32 ACC = m_modStat[Mod::ACC] + offsetAccuracy;

        if (this->StatusEffectContainer->HasStatusEffect(EFFECT_ENLIGHT))
        {
            ACC += this->getMod(Mod::ENSPELL_DMG);
        }

        ACC = ACC + std::min<int16>((ACC * m_modStat[Mod::FOOD_ACCP] / 100), m_modStat[Mod::FOOD_ACC_CAP]) + DEX() / 2; // Account for food mods here for Snatch Morsel
        return std::max<int16>(0, ACC);
    }
}

uint16 CBattleEntity::DEF()
{
    // VIT * 1.5 for PCs / Alter egos / Fellows / Familiars / Wyverns / Avatars / Automatons / Luopans
    // VIT * 0.5 for Enemy NPCs and pets controlled by Charm
    // https://wiki.ffo.jp/html/313.html
    // https://wiki.ffo.jp/html/35712.html
    // https://forum.square-enix.com/ffxi/threads/51154-Aug.-3-2016-%28JST%29-Version-Update?p=583669&viewfull=1#post583669
    int32 DEF       = 8 + m_modStat[Mod::DEF];
    float vitFactor = 1.5f;

    if (this->objtype == TYPE_MOB)
    {
        vitFactor = 0.5f;
    }

    DEF = DEF + std::floor(VIT() * vitFactor);

    if (this->StatusEffectContainer->HasStatusEffect(EFFECT_COUNTERSTANCE, 0))
    {
        return DEF / 2;
    }
    // use max to prevent underflow
    return std::max(1, DEF + (DEF * m_modStat[Mod::DEFP] / 100) + std::min<int16>((DEF * m_modStat[Mod::FOOD_DEFP] / 100), m_modStat[Mod::FOOD_DEF_CAP]));
}

uint16 CBattleEntity::EVA()
{
    int16 evasion = 1;

    if (this->objtype == TYPE_MOB || this->objtype == TYPE_PET)
    {
        evasion = m_modStat[Mod::EVA]; // Mobs and pets base evasion is based off the EVA mod
    }
    else // If it is a player then evasion = SKILL_EVASION
    {
        evasion = GetSkill(SKILL_EVASION);

        // Player only evasion calculation
        if (evasion > 200)
        {
            evasion = 200 + (evasion - 200) * 0.9;
        }
    }

    evasion += AGI() / 2;

    return std::max(1, evasion + (this->objtype == TYPE_MOB || this->objtype == TYPE_PET ? 0 : m_modStat[Mod::EVA])); // The mod for a pet or mob is already calclated in the above so return 0
}

JOBTYPE CBattleEntity::GetMJob()
{
    return m_mjob;
}

uint8 CBattleEntity::GetMLevel() const
{
    return m_mlvl;
}

JOBTYPE CBattleEntity::GetSJob()
{
    if (StatusEffectContainer->HasStatusEffect({ EFFECT_OBLIVISCENCE, EFFECT_SJ_RESTRICTION }))
    {
        return JOB_NON;
    }
    return m_sjob;
}

uint8 CBattleEntity::GetSLevel() const
{
    if (StatusEffectContainer->HasStatusEffect({ EFFECT_OBLIVISCENCE, EFFECT_SJ_RESTRICTION }))
    {
        return 0;
    }
    return m_slvl;
}

void CBattleEntity::SetMJob(uint8 mjob)
{
    if (mjob == 0 || mjob >= MAX_JOBTYPE)
    {
        ShowWarning("Invalid Job Type passed to function (%d).", mjob);
        return;
    }

    m_mjob = (JOBTYPE)mjob;
}

void CBattleEntity::SetSJob(uint8 sjob)
{
    if (sjob >= MAX_JOBTYPE)
    {
        ShowWarning("sjob (%d) exceeds MAX_JOBTYPE", sjob);
        return;
    }

    m_sjob = (JOBTYPE)sjob;
}

void CBattleEntity::SetMLevel(uint8 mlvl)
{
    TracyZoneScoped;
    m_modStat[Mod::DEF] -= m_mlvl + std::clamp(m_mlvl - 50, 0, 10);
    m_mlvl = (mlvl == 0 ? 1 : mlvl);
    m_modStat[Mod::DEF] += m_mlvl + std::clamp(m_mlvl - 50, 0, 10);

    if (this->objtype & TYPE_PC)
    {
        _sql->Query("UPDATE char_stats SET mlvl = %u WHERE charid = %u LIMIT 1", m_mlvl, this->id);
    }
}

void CBattleEntity::SetSLevel(uint8 slvl)
{
    TracyZoneScoped;
    if (!settings::get<bool>("map.INCLUDE_MOB_SJ") && this->objtype == TYPE_MOB && this->objtype != TYPE_PET)
    {
        m_slvl = m_mlvl; // All mobs have a 1:1 ratio of MainJob/Subjob
    }
    else
    {
        auto ratio = settings::get<uint8>("map.SUBJOB_RATIO");
        switch (ratio)
        {
            case 0: // no SJ
                m_slvl = 0;
                break;
            case 1: // 1/2 (75/37, 99/49)
                m_slvl = (slvl > (m_mlvl >> 1) ? (m_mlvl == 1 ? 1 : (m_mlvl >> 1)) : slvl);
                break;
            case 2: // 2/3 (75/50, 99/66)
                m_slvl = (slvl > (m_mlvl * 2) / 3 ? (m_mlvl == 1 ? 1 : (m_mlvl * 2) / 3) : slvl);
                break;
            case 3: // equal (75/75, 99/99)
                m_slvl = (slvl > m_mlvl ? (m_mlvl == 1 ? 1 : m_mlvl) : slvl);
                break;
            default: // Error
                ShowError("Error setting subjob level: Invalid ratio '%s' check your settings file!", ratio);
                break;
        }
    }

    if (this->objtype & TYPE_PC)
    {
        _sql->Query("UPDATE char_stats SET slvl = %u WHERE charid = %u LIMIT 1", m_slvl, this->id);
    }
}

void CBattleEntity::SetDeathType(uint8 type)
{
    m_DeathType = static_cast<DEATH_TYPE>(type);
}

uint8 CBattleEntity::GetDeathType()
{
    return static_cast<uint8>(m_DeathType);
}

/************************************************************************
 *                                                                      *
 *  Adding modifier(s)                                                  *
 *                                                                      *
 ************************************************************************/

void CBattleEntity::addModifier(Mod type, int16 amount)
{
    m_modStat[type] += amount;
}

void CBattleEntity::addModifiers(std::vector<CModifier>* modList)
{
    TracyZoneScoped;
    for (auto modifier : *modList)
    {
        m_modStat[modifier.getModID()] += modifier.getModAmount();
    }
}

void CBattleEntity::addEquipModifiers(std::vector<CModifier>* modList, uint8 itemLevel, uint8 slotid)
{
    TracyZoneScoped;
    if (GetMLevel() >= itemLevel)
    {
        for (auto& i : *modList)
        {
            if (slotid == SLOT_SUB)
            {
                if (i.getModID() == Mod::MAIN_DMG_RANK)
                {
                    m_modStat[Mod::SUB_DMG_RANK] += i.getModAmount();
                }
                else
                {
                    m_modStat[i.getModID()] += i.getModAmount();
                }
            }
            else
            {
                m_modStat[i.getModID()] += i.getModAmount();
            }
        }
    }
    else
    {
        for (auto& i : *modList)
        {
            int16 modAmount = GetMLevel() * i.getModAmount();
            switch (i.getModID())
            {
                case Mod::DEF:
                case Mod::MAIN_DMG_RATING:
                case Mod::SUB_DMG_RATING:
                case Mod::RANGED_DMG_RATING:
                    modAmount *= 3;
                    modAmount /= 4;
                    break;
                case Mod::HP:
                case Mod::MP:
                    modAmount /= 2;
                    break;
                case Mod::STR:
                case Mod::DEX:
                case Mod::VIT:
                case Mod::AGI:
                case Mod::INT:
                case Mod::MND:
                case Mod::CHR:
                case Mod::ATT:
                case Mod::RATT:
                case Mod::ACC:
                case Mod::RACC:
                case Mod::MATT:
                case Mod::MACC:
                    modAmount /= 3;
                    break;
                default:
                    modAmount = 0;
                    break;
            }
            modAmount /= itemLevel;
            if (slotid == SLOT_SUB)
            {
                if (i.getModID() == Mod::MAIN_DMG_RANK)
                {
                    m_modStat[Mod::SUB_DMG_RANK] += modAmount;
                }
                else
                {
                    m_modStat[i.getModID()] += modAmount;
                }
            }
            else
            {
                m_modStat[i.getModID()] += modAmount;
            }
        }
    }
}

/************************************************************************
 *                                                                      *
 *  Setting modifier(s)                                                 *
 *                                                                      *
 ************************************************************************/

void CBattleEntity::setModifier(Mod type, int16 amount)
{
    m_modStat[type] = amount;
}

void CBattleEntity::setModifiers(std::vector<CModifier>* modList)
{
    TracyZoneScoped;
    for (auto& i : *modList)
    {
        m_modStat[i.getModID()] = i.getModAmount();
    }
}

/************************************************************************
 *                                                                      *
 *  Removing modifier(s)                                                *
 *                                                                      *
 ************************************************************************/

void CBattleEntity::delModifier(Mod type, int16 amount)
{
    m_modStat[type] -= amount;
}

void CBattleEntity::saveModifiers()
{
    m_modStatSave = m_modStat;
}

void CBattleEntity::restoreModifiers()
{
    m_modStat = m_modStatSave;
}

void CBattleEntity::delModifiers(std::vector<CModifier>* modList)
{
    TracyZoneScoped;
    for (auto& i : *modList)
    {
        m_modStat[i.getModID()] -= i.getModAmount();
    }
}

void CBattleEntity::delEquipModifiers(std::vector<CModifier>* modList, uint8 itemLevel, uint8 slotid)
{
    TracyZoneScoped;
    if (GetMLevel() >= itemLevel)
    {
        for (auto& i : *modList)
        {
            if (slotid == SLOT_SUB)
            {
                if (i.getModID() == Mod::MAIN_DMG_RANK)
                {
                    m_modStat[Mod::SUB_DMG_RANK] -= i.getModAmount();
                }
                else
                {
                    m_modStat[i.getModID()] -= i.getModAmount();
                }
            }
            else
            {
                m_modStat[i.getModID()] -= i.getModAmount();
            }
        }
    }
    else
    {
        for (auto& i : *modList)
        {
            int16 modAmount = GetMLevel() * i.getModAmount();
            switch (i.getModID())
            {
                case Mod::DEF:
                case Mod::MAIN_DMG_RATING:
                case Mod::SUB_DMG_RATING:
                case Mod::RANGED_DMG_RATING:
                    modAmount *= 3;
                    modAmount /= 4;
                    break;
                case Mod::HP:
                case Mod::MP:
                    modAmount /= 2;
                    break;
                case Mod::STR:
                case Mod::DEX:
                case Mod::VIT:
                case Mod::AGI:
                case Mod::INT:
                case Mod::MND:
                case Mod::CHR:
                case Mod::ATT:
                case Mod::RATT:
                case Mod::ACC:
                case Mod::RACC:
                case Mod::MATT:
                case Mod::MACC:
                    modAmount /= 3;
                    break;
                default:
                    modAmount = 0;
                    break;
            }
            modAmount /= itemLevel;
            if (slotid == SLOT_SUB)
            {
                if (i.getModID() == Mod::MAIN_DMG_RANK)
                {
                    m_modStat[Mod::SUB_DMG_RANK] -= modAmount;
                }
                else
                {
                    m_modStat[i.getModID()] -= modAmount;
                }
            }
            else
            {
                m_modStat[i.getModID()] -= modAmount;
            }
        }
    }
}

/************************************************************************
 *                                                                      *
 *  Get the current value of the specified modifier                     *
 *                                                                      *
 ************************************************************************/

int16 CBattleEntity::getMod(Mod modID)
{
    TracyZoneScoped;
    return m_modStat[modID];
}

/************************************************************************
 *                                                                      *
 *  Get the highest value of the specified modifier across all gear     *
 *                                                                      *
 ************************************************************************/
int16 CBattleEntity::getMaxGearMod(Mod modID)
{
    TracyZoneScoped;
    CCharEntity* PChar       = dynamic_cast<CCharEntity*>(this);
    uint16       maxModValue = 0;

    if (!PChar)
    {
        ShowWarning("CBattleEntity::getMaxGearMod() - Entity is not a player.");

        return 0;
    }

    for (uint8 i = 0; i < SLOT_BACK; ++i)
    {
        auto* PItem = PChar->getEquip((SLOTTYPE)i);
        if (PItem && (PItem->isType(ITEM_EQUIPMENT) || PItem->isType(ITEM_WEAPON)))
        {
            uint16 modValue = PItem->getModifier(modID);

            if (modValue > maxModValue)
            {
                maxModValue = modValue;
            }
        }
    }

    return maxModValue;
}

void CBattleEntity::addPetModifier(Mod type, PetModType petmod, int16 amount)
{
    TracyZoneScoped;
    m_petMod[petmod][type] += amount;

    if (PPet && petutils::CheckPetModType(PPet, petmod))
    {
        PPet->addModifier(type, amount);
        PPet->UpdateHealth();
    }
}

void CBattleEntity::setPetModifier(Mod type, PetModType petmod, int16 amount)
{
    TracyZoneScoped;
    m_petMod[petmod][type] = amount;

    if (PPet && petutils::CheckPetModType(PPet, petmod))
    {
        PPet->setModifier(type, amount);
        PPet->UpdateHealth();
    }
}

void CBattleEntity::delPetModifier(Mod type, PetModType petmod, int16 amount)
{
    TracyZoneScoped;
    m_petMod[petmod][type] -= amount;

    if (PPet && petutils::CheckPetModType(PPet, petmod))
    {
        PPet->delModifier(type, amount);
        PPet->UpdateHealth();
    }
}

void CBattleEntity::addPetModifiers(std::vector<CPetModifier>* modList)
{
    TracyZoneScoped;
    for (auto modifier : *modList)
    {
        addPetModifier(modifier.getModID(), modifier.getPetModType(), modifier.getModAmount());
    }
}

void CBattleEntity::delPetModifiers(std::vector<CPetModifier>* modList)
{
    TracyZoneScoped;
    for (auto modifier : *modList)
    {
        delPetModifier(modifier.getModID(), modifier.getPetModType(), modifier.getModAmount());
    }
}

void CBattleEntity::applyPetModifiers(CPetEntity* PPet)
{
    TracyZoneScoped;
    for (const auto& modtype : m_petMod)
    {
        if (petutils::CheckPetModType(PPet, modtype.first))
        {
            for (auto mod : modtype.second)
            {
                PPet->addModifier(mod.first, mod.second);
                PPet->UpdateHealth();
            }
        }
    }
}

void CBattleEntity::removePetModifiers(CPetEntity* PPet)
{
    TracyZoneScoped;
    for (const auto& modtype : m_petMod)
    {
        if (petutils::CheckPetModType(PPet, modtype.first))
        {
            for (auto mod : modtype.second)
            {
                PPet->delModifier(mod.first, mod.second);
                PPet->UpdateHealth();
            }
        }
    }
}

/************************************************************************
 *                                                                      *
 *  Obtain the current value of the skill                               *
 *  (not the maximum, but limited by the level)                         *
 *                                                                      *
 ************************************************************************/

uint16 CBattleEntity::GetSkill(uint16 SkillID)
{
    TracyZoneScoped;
    if (SkillID < MAX_SKILLTYPE)
    {
        return WorkingSkills.skill[SkillID] & 0x7FFF;
    }
    return 0;
}

void CBattleEntity::addTrait(CTrait* PTrait)
{
    TracyZoneScoped;
    TraitList.emplace_back(PTrait);
    addModifier(PTrait->getMod(), PTrait->getValue());
}

void CBattleEntity::delTrait(CTrait* PTrait)
{
    TracyZoneScoped;
    delModifier(PTrait->getMod(), PTrait->getValue());
    TraitList.erase(std::remove(TraitList.begin(), TraitList.end(), PTrait), TraitList.end());
}

bool CBattleEntity::hasTrait(uint16 traitID)
{
    for (CTrait* Trait : TraitList)
    {
        if (Trait->getID() == traitID)
        {
            return true;
        }
    }

    return false;
}

bool CBattleEntity::ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags)
{
    TracyZoneScoped;
    if (targetFlags & TARGET_ENEMY)
    {
        if (!isDead())
        {
            // Teams PVP
            if (allegiance >= ALLEGIANCE_TYPE::WYVERNS && PInitiator->allegiance >= ALLEGIANCE_TYPE::WYVERNS)
            {
                return allegiance != PInitiator->allegiance;
            }

            // Nation PVP
            if ((allegiance >= ALLEGIANCE_TYPE::SAN_DORIA && allegiance <= ALLEGIANCE_TYPE::WINDURST) &&
                (PInitiator->allegiance >= ALLEGIANCE_TYPE::SAN_DORIA && PInitiator->allegiance <= ALLEGIANCE_TYPE::WINDURST))
            {
                return allegiance != PInitiator->allegiance;
            }

            // PVE
            if (allegiance <= ALLEGIANCE_TYPE::PLAYER && PInitiator->allegiance <= ALLEGIANCE_TYPE::PLAYER)
            {
                bool haveDiffAllegiances = allegiance != PInitiator->allegiance;

                if (haveDiffAllegiances)
                {
                    return true;
                }
                // if seems like an invalid target due to allegiances then check for special mob mod
                // this is needed for mobs that heal themselves with TARGET_ENEMY spells
                // like fire-absorbing mobs casting Fire IV on themselves
                else if (auto* PMobInitiator = dynamic_cast<CMobEntity*>(PInitiator))
                {
                    return PMobInitiator->getMobMod(MOBMODIFIER::MOBMOD_SKIP_ALLEGIANCE_CHECK) == 1;
                }
            }

            return false;
        }
    }

    return (targetFlags & TARGET_SELF) &&
           (this == PInitiator ||
            (PInitiator->objtype == TYPE_PET && static_cast<CPetEntity*>(PInitiator)->getPetType() == PET_TYPE::AUTOMATON && this == PInitiator->PMaster));
}

bool CBattleEntity::CanUseSpell(CSpell* PSpell)
{
    TracyZoneScoped;
    return spell::CanUseSpell(this, PSpell) && !PRecastContainer->Has(RECAST_MAGIC, static_cast<uint16>(PSpell->getID()));
}

void CBattleEntity::Spawn()
{
    TracyZoneScoped;
    animation = ANIMATION_NONE;
    HideName(false);
    CBaseEntity::Spawn();
    m_OwnerID.clean();
    setBattleID(0);
}

void CBattleEntity::Die()
{
    TracyZoneScoped;
    if (CBaseEntity* PKiller = GetEntity(m_OwnerID.targid))
    {
        // clang-format off
        static_cast<CBattleEntity*>(PKiller)->ForAlliance([this](CBattleEntity* PMember)
        {
            CCharEntity* member = static_cast<CCharEntity*>(PMember);
            if (member->PClaimedMob == this)
            {
                member->PClaimedMob = nullptr;
            }
        });
        // clang-format on
        PAI->EventHandler.triggerListener("DEATH", this, PKiller);
    }
    else
    {
        PAI->EventHandler.triggerListener("DEATH", this);
    }
    SetBattleTargetID(0);
}

void CBattleEntity::OnDeathTimer()
{
    TracyZoneScoped;
}

void CBattleEntity::OnCastFinished(CMagicState& state, action_t& action)
{
    TracyZoneScoped;
    auto*          PSpell          = state.GetSpell();
    auto*          PActionTarget   = static_cast<CBattleEntity*>(state.GetTarget());
    CBattleEntity* POriginalTarget = PActionTarget;
    bool           IsMagicCovered  = false;

    luautils::OnSpellPrecast(this, PSpell);

    state.SpendCost();

    // remove effects based on spell cast first
    int16 effectFlags = EFFECTFLAG_INVISIBLE | EFFECTFLAG_MAGIC_BEGIN;

    if (PSpell->canTargetEnemy())
    {
        effectFlags |= EFFECTFLAG_DETECTABLE;
    }

    StatusEffectContainer->DelStatusEffectsByFlag(effectFlags);
    StatusEffectContainer->DelStatusEffect(EFFECT_ILLUSION);

    PAI->TargetFind->reset();

    // setup special targeting flags
    // can this spell target the dead?

    uint8 flags = FINDFLAGS_NONE;
    if (PSpell->getValidTarget() & TARGET_PLAYER_DEAD)
    {
        flags |= FINDFLAGS_DEAD;
    }
    if (PSpell->getFlag() & SPELLFLAG_HIT_ALL)
    {
        flags |= FINDFLAGS_HIT_ALL;
    }
    uint8 aoeType = battleutils::GetSpellAoEType(this, PSpell);

    if (aoeType == SPELLAOE_RADIAL)
    {
        float distance = spell::GetSpellRadius(PSpell, this);

        PAI->TargetFind->findWithinArea(PActionTarget, AOE_RADIUS::TARGET, distance, flags, PSpell->getValidTarget());
    }
    else if (aoeType == SPELLAOE_CONAL)
    {
        // TODO: actual radius calculation
        float radius = spell::GetSpellRadius(PSpell, this);

        PAI->TargetFind->findWithinCone(PActionTarget, radius, 45, flags, PSpell->getValidTarget());
    }
    else
    {
        if (this->objtype == TYPE_MOB && PActionTarget->objtype == TYPE_PC)
        {
            CBattleEntity* PCoverAbilityUser = battleutils::GetCoverAbilityUser(PActionTarget, this);
            IsMagicCovered                   = battleutils::IsMagicCovered((CCharEntity*)PCoverAbilityUser);

            if (IsMagicCovered)
            {
                PActionTarget = PCoverAbilityUser;
            }
        }
        // only add target
        PAI->TargetFind->findSingleTarget(PActionTarget, flags, PSpell->getValidTarget());
    }

    auto totalTargets = (uint16)PAI->TargetFind->m_targets.size();

    PSpell->setTotalTargets(totalTargets);
    PSpell->setPrimaryTargetID(PActionTarget->id);

    action.id         = id;
    action.actiontype = ACTION_MAGIC_FINISH;
    action.actionid   = static_cast<uint16>(PSpell->getID());
    action.recast     = state.GetRecast();
    action.spellgroup = PSpell->getSpellGroup();

    uint16 msg = MSGBASIC_NONE;

    for (auto* PTarget : PAI->TargetFind->m_targets)
    {
        actionList_t& actionList  = action.getNewActionList();
        actionList.ActionTargetID = PTarget->id;

        actionTarget_t& actionTarget = actionList.getNewActionTarget();

        actionTarget.reaction   = REACTION::NONE;
        actionTarget.speceffect = SPECEFFECT::NONE;
        actionTarget.animation  = PSpell->getAnimationID();
        actionTarget.param      = 0;
        actionTarget.messageID  = MSGBASIC_NONE;

        auto ce = PSpell->getCE();
        auto ve = PSpell->getVE();

        int32 damage = 0;

        // Take all shadows
        if (PSpell->canTargetEnemy() && (aoeType > SPELLAOE_NONE || (PSpell->getFlag() & SPELLFLAG_WIPE_SHADOWS)))
        {
            PTarget->StatusEffectContainer->DelStatusEffect(EFFECT_BLINK);
            PTarget->StatusEffectContainer->DelStatusEffect(EFFECT_COPY_IMAGE);
        }

        // TODO: this is really hacky and should eventually be moved into lua, and spellFlags should probably be in the spells table..
        // Also need to have IsAbsorbByShadow last in conditional because that has side effects including removing a shadow
        if (PSpell->canHitShadow() && aoeType == SPELLAOE_NONE && !(PSpell->getFlag() & SPELLFLAG_IGNORE_SHADOWS) && battleutils::IsAbsorbByShadow(PTarget, this))
        {
            // take shadow
            msg                = MSGBASIC_SHADOW_ABSORB;
            actionTarget.param = 1;
            ve                 = 0;
            ce                 = 0;
        }
        else
        {
            damage = luautils::OnSpellCast(this, PTarget, PSpell);

            // Remove Saboteur
            if (PSpell->getSkillType() == SKILLTYPE::SKILL_ENFEEBLING_MAGIC)
            {
                StatusEffectContainer->DelStatusEffect(EFFECT_SABOTEUR);
            }

            if (msg == MSGBASIC_NONE)
            {
                msg = PSpell->getMessage();
            }
            else
            {
                msg = PSpell->getAoEMessage();
            }

            actionTarget.modifier = PSpell->getModifier();
            PSpell->setModifier(MODIFIER::NONE); // Reset modifier on use

            actionTarget.param = damage;
        }

        if (actionTarget.animation == 122)
        { // Teleport spells don't target unqualified members
            if (PSpell->getMessage() == MSGBASIC_NONE)
            {
                actionTarget.animation = 0; // stop target from going invisible
                if (PTarget != PActionTarget)
                {
                    action.actionLists.pop_back();
                }
                else
                { // set this message in anticipation of nobody having the gate crystal
                    actionTarget.messageID = MSGBASIC_MAGIC_NO_EFFECT;
                }
                continue;
            }
            if (msg == MSGBASIC_MAGIC_TELEPORT && PTarget != PActionTarget)
            { // reset the no effect message above if somebody has gate crystal
                action.actionLists[0].actionTargets[0].messageID = MSGBASIC_NONE;
            }
        }
        actionTarget.messageID = msg;

        if (IsMagicCovered)
        {
            state.ApplyMagicCoverEnmity(POriginalTarget, PActionTarget, (CMobEntity*)this);
        }
        else
        {
            state.ApplyEnmity(PTarget, ce, ve);
        }

        if (PTarget->objtype == TYPE_MOB &&
            msg != MSGBASIC_SHADOW_ABSORB) // If message isn't the shadow loss message, because I had to move this outside of the above check for it.
        {
            luautils::OnMagicHit(this, PTarget, PSpell);
        }

        if (this == PTarget || // Casting on self or ally
            (this->PParty && PTarget->PParty &&
             ((this->PParty == PTarget->PParty) || (this->PParty->m_PAlliance && this->PParty->m_PAlliance == PTarget->PParty->m_PAlliance))))
        {
            if (PSpell->isHeal())
            {
                roeutils::event(ROE_HEALALLY, static_cast<CCharEntity*>(this), RoeDatagram("heal", actionTarget.param));

                // We know its an ally or self, if not self and leader matches, credit the RoE Objective
                if (this != PTarget && this->objtype == TYPE_PC && PTarget->objtype == TYPE_PC && static_cast<CCharEntity*>(this)->profile.unity_leader == static_cast<CCharEntity*>(PTarget)->profile.unity_leader)
                {
                    roeutils::event(ROE_HEAL_UNITYALLY, static_cast<CCharEntity*>(this), RoeDatagram("heal", actionTarget.param));
                }
            }
            else if (this != PTarget && PSpell->isBuff() && actionTarget.param)
            {
                roeutils::event(ROE_BUFFALLY, static_cast<CCharEntity*>(this), RoeDatagramList{});
            }
        }
    }
    if ((!(PSpell->isHeal()) || PSpell->tookEffect()) && PActionTarget->isAlive())
    {
        if (objtype != TYPE_PET)
        {
            battleutils::ClaimMob(PActionTarget, this);
        }
    }

    // TODO: Pixies will probably break here, once they're added.
    if (this->allegiance != PActionTarget->allegiance)
    {
        // Should not be removed by AoE effects that don't target the player or
        // buffs cast by other players or mobs.
        PActionTarget->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DETECTABLE);
    }

    StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_MAGIC_END);

    PRecastContainer->Add(RECAST_MAGIC, static_cast<uint16>(PSpell->getID()), action.recast);
}

void CBattleEntity::OnCastInterrupted(CMagicState& state, action_t& action, MSGBASIC_ID msg, bool blockedCast)
{
    TracyZoneScoped;
    CSpell* PSpell = state.GetSpell();
    if (PSpell)
    {
        action.id         = id;
        action.spellgroup = PSpell->getSpellGroup();
        action.recast     = 0;
        action.actiontype = ACTION_MAGIC_INTERRUPT;

        actionList_t& actionList  = action.getNewActionList();
        actionList.ActionTargetID = id;

        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.messageID       = 0;
        actionTarget.animation       = 0;
        actionTarget.param           = static_cast<uint16>(PSpell->getID());

        if (blockedCast)
        {
            // In a cutscene or otherwise, it seems the target "evades" the cast, despite the ID being set to the caster?
            // No message is sent in this case
            actionTarget.reaction = REACTION::EVADE;
        }
        else
        {
            actionTarget.reaction = REACTION::HIT;
            // For some reason, despite the system supporting interrupted message in the action packet (like auto attacks, JA), an 0x029 message is sent for spells.
            loc.zone->PushPacket(this, CHAR_INRANGE_SELF, std::make_unique<CMessageBasicPacket>(this, state.GetTarget() ? state.GetTarget() : this, 0, 0, msg));
        }
    }
}

void CBattleEntity::OnWeaponSkillFinished(CWeaponSkillState& state, action_t& action)
{
    TracyZoneScoped;
    auto* PWeaponskill = state.GetSkill();

    action.id         = id;
    action.actiontype = ACTION_WEAPONSKILL_FINISH;
    action.actionid   = PWeaponskill->getID();
}

void CBattleEntity::OnMobSkillFinished(CMobSkillState& state, action_t& action)
{
    auto* PSkill  = state.GetSkill();
    auto* PTarget = dynamic_cast<CBattleEntity*>(state.GetTarget());

    if (PTarget == nullptr)
    {
        ShowWarning("CMobEntity::OnMobSkillFinished: PTarget is null");
        return;
    }

    if (auto* PMob = dynamic_cast<CMobEntity*>(this))
    {
        // store the skill used
        PMob->m_UsedSkillIds[PSkill->getID()] = GetMLevel();
    }

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
    else if (PSkill->getID() < 256)
    {
        action.actiontype = ACTION_WEAPONSKILL_FINISH;
    }
    else
    {
        action.actiontype = ACTION_MOBABILITY_FINISH;
    }
    action.actionid = PSkill->getID();

    if (PAI->TargetFind->isWithinRange(&PTarget->loc.p, distance))
    {
        if (PSkill->isAoE())
        {
            PAI->TargetFind->findWithinArea(PTarget, static_cast<AOE_RADIUS>(PSkill->getAoe()), PSkill->getRadius(), findFlags, PSkill->getValidTargets());
        }
        else if (PSkill->isConal())
        {
            float angle = 45.0f;
            PAI->TargetFind->findWithinCone(PTarget, distance, angle, findFlags, PSkill->getValidTargets(), PSkill->getAoe());
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

            PAI->TargetFind->findSingleTarget(PTarget, findFlags, PSkill->getValidTargets());
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

    PSkill->setTargets(PAI->TargetFind->m_targets);
    PSkill->setTotalTargets(targets);
    PSkill->setPrimaryTargetID(PTarget->id);
    PSkill->setTP(state.GetSpentTP());
    PSkill->setHPP(GetHPP());

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
            this->PAI->EventHandler.triggerListener("WEAPONSKILL_USE", this, PTargetFound, PSkill->getID(), state.GetSpentTP(), &action, damage);
            PTarget->PAI->EventHandler.triggerListener("WEAPONSKILL_TAKE", PTargetFound, this, PSkill->getID(), state.GetSpentTP(), &action);
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
            if (target.reaction == REACTION::HIT)
            {
                target.knockback = PSkill->getKnockback();
            }
            else
            {
                target.knockback = 0;
            }

            if (first && PTargetFound->health.hp > 0 && PSkill->getPrimarySkillchain() != 0)
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

bool CBattleEntity::CanAttack(CBattleEntity* PTarget, std::unique_ptr<CBasicPacket>& errMsg)
{
    TracyZoneScoped;
    if (PTarget->PAI->IsUntargetable())
    {
        return false;
    }
    return !((distance(loc.p, PTarget->loc.p) - PTarget->m_ModelRadius) > GetMeleeRange() || !PAI->GetController()->IsAutoAttackEnabled());
}

void CBattleEntity::OnDisengage(CAttackState& s)
{
    TracyZoneScoped;
    m_battleTarget = 0;
    if (animation == ANIMATION_ATTACK)
    {
        animation = ANIMATION_NONE;
    }
    updatemask |= UPDATE_HP;
    PAI->EventHandler.triggerListener("DISENGAGE", this);
}

void CBattleEntity::OnChangeTarget(CBattleEntity* PTarget)
{
}

void CBattleEntity::setActionInterrupted(action_t& action, CBattleEntity* PTarget, uint16 messageID, uint16 actionID)
{
    if (PTarget)
    {
        actionList_t& actionList  = action.getNewActionList();
        actionList.ActionTargetID = PTarget->id;
        action.id                 = this->id;
        action.actiontype         = ACTION_MAGIC_FINISH; // all "is paralyzed" messages are cat 4
        action.actionid           = actionID;

        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.animation       = 0x1FC; // Seems hardcoded, two bits away from 0x1FF (0x1FC = 1 1111 1100)
        actionTarget.messageID       = messageID;
        actionTarget.param           = 0;
    }
}

CBattleEntity* CBattleEntity::GetBattleTarget()
{
    return static_cast<CBattleEntity*>(GetEntity(GetBattleTargetID()));
}

bool CBattleEntity::OnAttack(CAttackState& state, action_t& action)
{
    TracyZoneScoped;
    auto* PTarget = static_cast<CBattleEntity*>(state.GetTarget());

    if (PTarget->objtype == TYPE_PC)
    {
        // TODO: Should not be removed by AoE effects that don't target the player.
        PTarget->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DETECTABLE);
    }

    battleutils::ClaimMob(PTarget, this); // Mobs get claimed whether or not your attack actually is intimidated/paralyzed
    PTarget->LastAttacked = server_clock::now();

    if (battleutils::IsParalyzed(this))
    {
        setActionInterrupted(action, PTarget, MSGBASIC_IS_PARALYZED_2, 0);
        return true;
    }

    if (battleutils::IsIntimidated(this, PTarget))
    {
        setActionInterrupted(action, PTarget, MSGBASIC_IS_INTIMIDATED, 0);
        return true;
    }

    // Create a new attack round.
    CAttackRound attackRound(this, PTarget);

    action.actiontype  = ACTION_ATTACK;
    action.id          = this->id;
    actionList_t& list = action.getNewActionList();

    list.ActionTargetID = PTarget->id;

    CBattleEntity* POriginalTarget = PTarget;

    /////////////////////////////////////////////////////////////////////////
    //  Start of the attack loop.
    //  Make sure our target is alive on each iteration to not overkill;
    //  And make sure we aren't dead in case we died to a counter.
    /////////////////////////////////////////////////////////////////////////
    while (attackRound.GetAttackSwingCount() && PTarget->isAlive() && this->isAlive())
    {
        actionTarget_t& actionTarget = list.getNewActionTarget();
        // Reference to the current swing.
        CAttack& attack = attackRound.GetCurrentAttack();

        // Set the swing animation.
        actionTarget.animation = attack.GetAnimationID();

        if (attack.CheckCover())
        {
            PTarget             = attackRound.GetCoverAbilityUserEntity();
            list.ActionTargetID = PTarget->id;
        }

        if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_PERFECT_DODGE, 0))
        {
            actionTarget.messageID  = 32;
            actionTarget.reaction   = REACTION::EVADE;
            actionTarget.speceffect = SPECEFFECT::NONE;
        }
        else if (attack.IsDeflected())
        {
            actionTarget.messageID  = 1;
            actionTarget.reaction   = REACTION::PARRY | REACTION::HIT;
            actionTarget.speceffect = SPECEFFECT::NONE;
        }
        else if ((xirand::GetRandomNumber(100) < attack.GetHitRate() || attackRound.GetSATAOccured()) &&
                 !PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_ALL_MISS))
        {
            // Check parry.
            if (attack.CheckParried())
            {
                actionTarget.messageID  = 70;
                actionTarget.reaction   = REACTION::PARRY | REACTION::HIT;
                actionTarget.speceffect = SPECEFFECT::NONE;
                battleutils::HandleTacticalParry(PTarget);
                battleutils::HandleIssekiganEnmityBonus(PTarget, this);
            }
            // attack hit, try to be absorbed by shadow unless it is a SATA attack round
            else if (!(attackRound.GetSATAOccured()) && battleutils::IsAbsorbByShadow(PTarget, this))
            {
                actionTarget.messageID = MSGBASIC_SHADOW_ABSORB;
                actionTarget.param     = 1;
                actionTarget.reaction  = REACTION::EVADE;
                attack.SetEvaded(true);
            }
            else if (attack.CheckAnticipated() || attack.CheckCounter())
            {
                if (attack.IsAnticipated())
                {
                    actionTarget.messageID  = 30;
                    actionTarget.reaction   = REACTION::EVADE;
                    actionTarget.speceffect = SPECEFFECT::NONE;
                }
                if (attack.IsCountered())
                {
                    actionTarget.reaction     = REACTION::EVADE;
                    actionTarget.speceffect   = SPECEFFECT::NONE;
                    actionTarget.param        = 0;
                    actionTarget.messageID    = 0;
                    actionTarget.spikesEffect = SUBEFFECT_COUNTER;
                    if (battleutils::IsAbsorbByShadow(this, PTarget))
                    {
                        actionTarget.spikesParam   = 1;
                        actionTarget.spikesMessage = MSGBASIC_COUNTER_ABS_BY_SHADOW;
                        actionTarget.messageID     = 0;
                        actionTarget.param         = 0;
                    }
                    else
                    {
                        int16     naturalh2hDMG = 0;
                        auto*     targ_weapon   = dynamic_cast<CItemWeapon*>(PTarget->m_Weapons[SLOT_MAIN]);
                        SKILLTYPE skilltype     = SKILLTYPE::SKILL_NONE;

                        if (PTarget->objtype == TYPE_PC)
                        {
                            if (targ_weapon)
                            {
                                skilltype = static_cast<SKILLTYPE>(targ_weapon->getSkillType());
                            }
                            else
                            {
                                skilltype = SKILLTYPE::SKILL_HAND_TO_HAND;
                            }
                        }

                        if (skilltype == SKILLTYPE::SKILL_HAND_TO_HAND || (PTarget->objtype == TYPE_MOB && PTarget->GetMJob() == JOB_MNK))
                        {
                            naturalh2hDMG = (int16)((PTarget->GetSkill(SKILL_HAND_TO_HAND) * 0.11f) + 3);
                        }

                        // Calculate attack bonus for Counterstance Effect Job Points
                        // Needs verification, as there appears to be conflicting information regarding an attack bonus based on DEX
                        // vs a base damage increase.
                        float attBonus = 1.0f;
                        if (PTarget->objtype == TYPE_PC && PTarget->GetMJob() == JOB_MNK && PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_COUNTERSTANCE))
                        {
                            auto*  PChar        = static_cast<CCharEntity*>(PTarget);
                            uint8  csJpModifier = PChar->PJobPoints->GetJobPointValue(JP_COUNTERSTANCE_EFFECT) * 2;
                            uint16 targetDex    = PTarget->DEX();

                            attBonus += ((static_cast<float>(targetDex) / 100) * csJpModifier);
                        }

                        float DamageRatio = battleutils::GetDamageRatio(PTarget, this, attack.IsCritical(), attBonus, skilltype, SLOT_MAIN, false);
                        auto  damage      = (int32)((PTarget->GetMainWeaponDmg() + naturalh2hDMG + battleutils::GetFSTR(PTarget, this, SLOT_MAIN)) * DamageRatio);

                        actionTarget.spikesParam =
                            battleutils::TakePhysicalDamage(PTarget, this, attack.GetAttackType(), damage, false, SLOT_MAIN, 1, nullptr, true, false, true);
                        actionTarget.spikesMessage = 33;
                        if (PTarget->objtype == TYPE_PC)
                        {
                            charutils::TrySkillUP((CCharEntity*)PTarget, skilltype, GetMLevel());
                        } // In case the Automaton can counter
                        else if (PTarget->objtype == TYPE_PET && PTarget->PMaster && PTarget->PMaster->objtype == TYPE_PC &&
                                 static_cast<CPetEntity*>(PTarget)->getPetType() == PET_TYPE::AUTOMATON)
                        {
                            puppetutils::TrySkillUP((CAutomatonEntity*)PTarget, SKILL_AUTOMATON_MELEE, GetMLevel());
                        }
                    }
                }

                this->PAI->EventHandler.triggerListener("MELEE_SWING_MISS", this, PTarget, &attack);
            }
            else
            {
                SLOTTYPE weaponSlot = static_cast<SLOTTYPE>(attack.GetWeaponSlot());
                // Set this attack's critical flag.
                attack.SetCritical(xirand::GetRandomNumber(100) < battleutils::GetCritHitRate(this, PTarget, !attack.IsFirstSwing(), weaponSlot));

                this->PAI->EventHandler.triggerListener("MELEE_SWING_HIT", this, PTarget, &attack);

                actionTarget.reaction = REACTION::HIT;

                // Critical hit.
                if (attack.IsCritical())
                {
                    actionTarget.speceffect = SPECEFFECT::CRITICAL_HIT;
                    actionTarget.messageID  = attack.GetAttackType() == PHYSICAL_ATTACK_TYPE::DAKEN ? 353 : 67;

                    if (PTarget->objtype == TYPE_MOB)
                    {
                        // Listener (hook)
                        PTarget->PAI->EventHandler.triggerListener("CRITICAL_TAKE", PTarget, this);

                        // Binding
                        luautils::OnCriticalHit(PTarget, this);
                    }
                }
                // Not critical hit.
                else
                {
                    actionTarget.speceffect = SPECEFFECT::HIT;
                    actionTarget.messageID  = attack.GetAttackType() == PHYSICAL_ATTACK_TYPE::DAKEN ? 352 : 1;
                }

                // Guarded. TODO: Stuff guards that shouldn't.
                if (attack.IsGuarded())
                {
                    actionTarget.reaction |= REACTION::GUARDED;
                    battleutils::HandleTacticalGuard(PTarget);
                }

                // Apply Feint
                if (CStatusEffect* PFeintEffect = StatusEffectContainer->GetStatusEffect(EFFECT_FEINT))
                {
                    if (PTarget->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_EVASION_DOWN, EFFECT_EVASION_DOWN, PFeintEffect->GetPower(), 3, 30)))
                    {
                        auto PEffect = PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_EVASION_DOWN);

                        // When Feint's evasion down effect is on, the target can get "debuffed" with TREASURE_HUNTER_PROC +25% * level above first on Feint
                        PEffect->addMod(Mod::TREASURE_HUNTER_PROC, PFeintEffect->GetSubPower());      // Remove TREASURE_HUNTER_PROC debuff on effect wearing off. This isnt added to the mob directly.
                        PTarget->addModifier(Mod::TREASURE_HUNTER_PROC, PFeintEffect->GetSubPower()); // Add TREASURE_HUNTER_PROC debuff immediately to mob
                    }
                    StatusEffectContainer->DelStatusEffect(EFFECT_FEINT);
                }

                // Process damage.
                attack.ProcessDamage();

                // Try shield block
                if (attack.IsBlocked())
                {
                    actionTarget.reaction |= REACTION::BLOCK;
                }

                actionTarget.param =
                    battleutils::TakePhysicalDamage(this, PTarget, attack.GetAttackType(), attack.GetDamage(), attack.IsBlocked(), attack.GetWeaponSlot(), 1,
                                                    attackRound.GetTAEntity(), true, true, attack.IsCountered(), attack.IsCovered(), POriginalTarget);
                if (actionTarget.param < 0)
                {
                    actionTarget.param     = -(actionTarget.param);
                    actionTarget.messageID = 373;
                }
            }

            if (PTarget->objtype == TYPE_PC)
            {
                if (attack.IsGuarded() || !settings::get<bool>("map.GUARD_OLD_SKILLUP_STYLE"))
                {
                    if (battleutils::GetGuardRate(this, PTarget) > 0)
                    {
                        charutils::TrySkillUP((CCharEntity*)PTarget, SKILL_GUARD, GetMLevel());
                    }
                }

                if (attack.IsBlocked() || !settings::get<bool>("map.BLOCK_OLD_SKILLUP_STYLE"))
                {
                    if (battleutils::GetBlockRate(this, PTarget) > 0)
                    {
                        charutils::TrySkillUP((CCharEntity*)PTarget, SKILL_SHIELD, GetMLevel());
                    }
                }

                if (attack.IsParried() || !settings::get<bool>("map.PARRY_OLD_SKILLUP_STYLE"))
                {
                    if (battleutils::GetParryRate(this, PTarget) > 0)
                    {
                        charutils::TrySkillUP((CCharEntity*)PTarget, SKILL_PARRY, GetMLevel());
                    }
                }
                if (!attack.IsCountered() && !attack.IsParried())
                {
                    charutils::TrySkillUP((CCharEntity*)PTarget, SKILL_EVASION, GetMLevel());
                }
            }
        }
        else
        {
            // misses the target
            actionTarget.reaction   = REACTION::EVADE;
            actionTarget.speceffect = SPECEFFECT::NONE;
            actionTarget.messageID  = 15;
            attack.SetEvaded(true);

            // Check & Handle Afflatus Misery Accuracy Bonus
            battleutils::HandleAfflatusMiseryAccuracyBonus(this);

            // player should still be able to skill up evasion on an evaded attack
            if (auto* PChar = dynamic_cast<CCharEntity*>(PTarget))
            {
                charutils::TrySkillUP(PChar, SKILL_EVASION, GetMLevel());
            }

            this->PAI->EventHandler.triggerListener("MELEE_SWING_MISS", this, PTarget, &attack);
        }

        // If we didn't hit at all, set param to 0 if we didn't blink any shadows.
        if ((actionTarget.reaction & REACTION::HIT) == REACTION::NONE && actionTarget.messageID != MSGBASIC_SHADOW_ABSORB)
        {
            actionTarget.param = 0;
        }

        // if we did hit, run enspell/spike routines as long as this isn't a Daken swing
        if ((actionTarget.reaction & REACTION::MISS) == REACTION::NONE && attack.GetAttackType() != PHYSICAL_ATTACK_TYPE::DAKEN)
        {
            battleutils::HandleEnspell(this, PTarget, &actionTarget, attack.IsFirstSwing(), (CItemWeapon*)this->m_Weapons[attack.GetWeaponSlot()],
                                       attack.GetDamage(), attack);
            battleutils::HandleSpikesDamage(this, PTarget, &actionTarget, attack.GetDamage());
        }

        // if we parried, run battuta check if applicable
        if ((actionTarget.reaction & REACTION::PARRY) == REACTION::PARRY && PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_BATTUTA))
        {
            battleutils::HandleParrySpikesDamage(this, PTarget, &actionTarget, attack.GetDamage());
        }

        // set recoil if we hit and dealt non-zero damage
        if (actionTarget.speceffect == SPECEFFECT::HIT && actionTarget.param > 0)
        {
            actionTarget.speceffect = SPECEFFECT::RECOIL;
        }

        // try zanshin only on single swing attack rounds - it is last priority in the multi-hit order
        // if zanshin procs, add a new zanshin based attack.
        if (attack.IsFirstSwing() && attackRound.GetAttackSwingCount() == 1)
        {
            uint16 zanshinChance = this->getMod(Mod::ZANSHIN) + battleutils::GetMeritValue(this, MERIT_ZASHIN_ATTACK_RATE);
            zanshinChance        = std::clamp<uint16>(zanshinChance, 0, 100);
            // zanshin may only proc on a missed/guarded/countered swing or as SAM main with hasso up (at 25% of the base zanshin rate)
            if ((((actionTarget.reaction & REACTION::MISS) != REACTION::NONE || (actionTarget.reaction & REACTION::GUARDED) != REACTION::NONE || actionTarget.spikesEffect == SUBEFFECT_COUNTER) &&
                 xirand::GetRandomNumber(100) < zanshinChance) ||
                (GetMJob() == JOB_SAM && this->StatusEffectContainer->HasStatusEffect(EFFECT_HASSO) && xirand::GetRandomNumber(100) < (zanshinChance / 4)))
            {
                attackRound.AddAttackSwing(PHYSICAL_ATTACK_TYPE::ZANSHIN, PHYSICAL_ATTACK_DIRECTION::RIGHTATTACK, 1);
            }
        }

        // Remove shuriken if Daken proc and Sange is up
        if (attack.GetAttackType() == PHYSICAL_ATTACK_TYPE::DAKEN)
        {
            if (StatusEffectContainer && StatusEffectContainer->HasStatusEffect(EFFECT_SANGE))
            {
                CCharEntity* PChar = dynamic_cast<CCharEntity*>(this);
                CItemWeapon* PAmmo = dynamic_cast<CItemWeapon*>(PChar->getEquip(SLOT_AMMO));

                if (PChar && PAmmo && PAmmo->isShuriken()) // Not sure how they wouldn't have a shuriken by this point, but just in case...
                {
                    // Removing ammo here is safe because you can only create one Daken attack per attack round
                    battleutils::RemoveAmmo(PChar, 1);
                }
            }
        }

        attackRound.DeleteAttackSwing();

        if (list.actionTargets.size() == 8)
        {
            break;
        }
    }

    PAI->EventHandler.triggerListener("ATTACK", this, PTarget, &action);
    PTarget->PAI->EventHandler.triggerListener("ATTACKED", PTarget, this, &action);
    /////////////////////////////////////////////////////////////////////////////////////////////
    // End of attack loop
    /////////////////////////////////////////////////////////////////////////////////////////////

    this->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_ATTACK | EFFECTFLAG_DETECTABLE);

    return true;
}

CBattleEntity* CBattleEntity::IsValidTarget(uint16 targid, uint16 validTargetFlags, std::unique_ptr<CBasicPacket>& errMsg)
{
    TracyZoneScoped;
    auto* PTarget = PAI->TargetFind->getValidTarget(targid, validTargetFlags);
    return PTarget;
}

void CBattleEntity::OnEngage(CAttackState& state)
{
    TracyZoneScoped;
    animation = ANIMATION_ATTACK;
    updatemask |= UPDATE_HP;
    PAI->EventHandler.triggerListener("ENGAGE", this, state.GetTarget());
}

void CBattleEntity::TryHitInterrupt(CBattleEntity* PAttacker)
{
    if (PAI->GetCurrentState())
    {
        PAI->GetCurrentState()->TryInterrupt(PAttacker);
    }
}

void CBattleEntity::OnDespawn(CDespawnState& /*unused*/)
{
    TracyZoneScoped;
    FadeOut();
    // #event despawn
    PAI->EventHandler.triggerListener("DESPAWN", this);
    PAI->Internal_Respawn(0s);
}

void CBattleEntity::SetBattleStartTime(time_point time)
{
    m_battleStartTime = time;
}

duration CBattleEntity::GetBattleTime()
{
    return server_clock::now() - m_battleStartTime;
}

void CBattleEntity::setBattleID(uint16 battleID)
{
    m_battleID = battleID;
}

uint16 CBattleEntity::getBattleID()
{
    return m_battleID;
}

void CBattleEntity::Tick(time_point /*unused*/)
{
    TracyZoneScoped;
}

void CBattleEntity::PostTick()
{
    TracyZoneScoped;
    if (health.hp == 0 && PAI->IsSpawned() && !PAI->IsCurrentState<CDeathState>() && !PAI->IsCurrentState<CRaiseState>() &&
        !PAI->IsCurrentState<CDespawnState>())
    {
        Die();
    }
}

uint16 CBattleEntity::GetBattleTargetID() const
{
    return m_battleTarget;
}

bool CBattleEntity::hasEnmityEXPENSIVE() const
{
    // TODO: This check seems to always fail for pets?
    if (PNotorietyContainer->hasEnmity())
    {
        return true;
    }

    bool isTargeted = false;

    // TODO: this is bad but because of how super tanking is implemented there's not much we can do without a larger refactor
    if (loc.zone)
    {
        // clang-format off
        loc.zone->ForEachMob([&](CMobEntity* PMob)
        {
            if (!PMob->isAlive())
            {
                return;
            }
            // Account for charmed mobs attacking normal mobs, etc
            if (PMob->GetBattleTargetID() == targid && PMob->allegiance != allegiance)
            {
                isTargeted = true;
                return;
            }
        });
        // clang-format on
    }

    return isTargeted;
}
