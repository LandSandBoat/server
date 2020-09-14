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

#ifndef _BATTLEUTILS_H
#define _BATTLEUTILS_H

#include "../../common/cbasetypes.h"
#include "../blue_spell.h"
#include "../status_effect.h"
#include "../merit.h"

#include <list>

#include "../entities/battleentity.h"

class CAbility;
class CItemWeapon;
class CMobSkill;
class CSpell;
class CTrait;
class CWeaponSkill;
struct actionTarget_t;
enum class PHYSICAL_ATTACK_TYPE;

enum ENSPELL
{
    ENSPELL_NONE = 0,
    ENSPELL_I_FIRE = 1,
    ENSPELL_I_EARTH = 2,
    ENSPELL_I_WATER = 3,
    ENSPELL_I_WIND = 4,
    ENSPELL_I_ICE = 5,
    ENSPELL_I_THUNDER = 6,
    ENSPELL_I_LIGHT = 7,
    ENSPELL_I_DARK = 8,
    ENSPELL_II_FIRE = 9,
    ENSPELL_II_EARTH = 10,
    ENSPELL_II_WATER = 11,
    ENSPELL_II_WIND = 12,
    ENSPELL_II_ICE = 13,
    ENSPELL_II_THUNDER = 14,
    ENSPELL_II_LIGHT = 15,
    ENSPELL_BLOOD_WEAPON = 16,
    ENSPELL_ROLLING_THUNDER = 17,
    ENSPELL_AUSPICE = 18,
    ENSPELL_DRAIN_SAMBA = 19,
    ENSPELL_ASPIR_SAMBA = 20,
    ENSPELL_HASTE_SAMBA = 21
};

enum SPIKES
{
    SPIKE_NONE = 0,
    SPIKE_BLAZE = 1,
    SPIKE_ICE = 2,
    SPIKE_DREAD = 3,
    SPIKE_CURSE = 4,
    SPIKE_SHOCK = 5,
    SPIKE_REPRISAL = 6,
    SPIKE_WIND = 7,
    SPIKE_STONE = 8,
    SPIKE_DELUGE = 9,
    RETALIATION = 63
};

enum ELEMENT
{
    ELEMENT_NONE = 0,
    ELEMENT_FIRE = 1,
    ELEMENT_EARTH = 2,
    ELEMENT_WATER = 3,
    ELEMENT_WIND = 4,
    ELEMENT_ICE = 5,
    ELEMENT_THUNDER = 6,
    ELEMENT_LIGHT = 7,
    ELEMENT_DARK = 8
};


namespace battleutils
{
    void            LoadSkillTable();
    void            LoadWeaponSkillsList();
    void            LoadMobSkillsList();
    void            LoadSkillChainDamageModifiers();

    uint8           CheckMultiHits(CBattleEntity* PEntity, CItemWeapon* PWeapon);

    uint8           getHitCount(uint8 hits);
    uint8           CheckMobMultiHits(CBattleEntity* PEntity);

    int16           GetSnapshotReduction(CCharEntity* m_PChar, int16 delay);
    int32           GetRangedAttackBonuses(CBattleEntity* battleEntity);
    int32           GetRangedAccuracyBonuses(CBattleEntity* battleEntity);

    uint8           GetSkillRank(SKILLTYPE SkillID, JOBTYPE JobID);
    uint16          GetMaxSkill(SKILLTYPE SkillID, JOBTYPE JobID, uint8 level);
    uint16          GetMaxSkill(uint8 rank, uint8 level);

    CWeaponSkill*   GetWeaponSkill(uint16 WSkillID);
    CMobSkill*      GetMobSkill(uint16 SkillID);

    const std::list<CWeaponSkill*>& GetWeaponSkills(uint8 skill);
    const std::vector<uint16>& GetMobSkillList(uint16 ListID);

    void                FreeWeaponSkillsList();
    void                FreeMobSkillList();

    SUBEFFECT            GetSkillChainEffect(CBattleEntity* PDefender, uint8 primary, uint8 secondary, uint8 tertiary);
    SKILLCHAIN_ELEMENT   FormSkillchain(const std::list<SKILLCHAIN_ELEMENT>& resonance, const std::list<SKILLCHAIN_ELEMENT>& skill);
    uint8                GetSkillchainTier(SKILLCHAIN_ELEMENT skillchain);
    uint8                GetSkillchainSubeffect(SKILLCHAIN_ELEMENT skillchain);
    int16                GetSkillchainMinimumResistance(SKILLCHAIN_ELEMENT element, CBattleEntity* PDefender, ELEMENT* appliedEle);
    std::vector<ELEMENT> GetSkillchainMagicElement(SKILLCHAIN_ELEMENT skillchain);

    bool            IsParalyzed(CBattleEntity* PAttacker);
    bool            IsAbsorbByShadow(CBattleEntity* PDefender);
    bool            IsIntimidated(CBattleEntity* PAttacker, CBattleEntity* PDefender);

    int32               GetFSTR(CBattleEntity* PAttacker, CBattleEntity* PDefender, uint8 SlotID);
    uint8               GetHitRateEx(CBattleEntity* PAttacker, CBattleEntity* PDefender, uint8 attackNumber, int8 offsetAccuracy);
    uint8               GetHitRate(CBattleEntity* PAttacker, CBattleEntity* PDefender);
    uint8               GetHitRate(CBattleEntity* PAttacker, CBattleEntity* PDefender, uint8 attackNumber);
    uint8               GetHitRate(CBattleEntity* PAttacker, CBattleEntity* PDefender, uint8 attackNumber, int8 offsetAccuracy);
    uint8               GetCritHitRate(CBattleEntity* PAttacker, CBattleEntity* PDefender, bool ignoreSneakTrickAttack);
    uint8               GetBlockRate(CBattleEntity* PAttacker, CBattleEntity* PDefender);
    uint8               GetParryRate(CBattleEntity* PAttacker, CBattleEntity* PDefender);
    uint8               GetGuardRate(CBattleEntity* PAttacker, CBattleEntity* PDefender);
    float               GetDamageRatio(CBattleEntity* PAttacker, CBattleEntity* PDefender, bool isCritical, float bonusAttPercent);

    int32               TakePhysicalDamage(CBattleEntity* PAttacker, CBattleEntity* PDefender, PHYSICAL_ATTACK_TYPE physicalAttackType, int32 damage, bool isBlocked, uint8 slot, uint16 tpMultiplier, CBattleEntity* taChar, bool giveTPtoVictim, bool giveTPtoAttacker, bool isCounter = false,  bool isCovered = false, CBattleEntity* POriginalTarget = nullptr);
    int32               TakeWeaponskillDamage(CCharEntity* PAttacker, CBattleEntity* PDefender, int32 damage, ATTACKTYPE attackType, DAMAGETYPE damageType, uint8 slot, bool primary, float tpMultiplier, uint16 bonusTP, float targetTPMultiplier);
    int32               TakeSkillchainDamage(CBattleEntity* PAttacker, CBattleEntity* PDefender, int32 lastSkillDamage, CBattleEntity* taChar);
    int32               TakeSpellDamage(CBattleEntity* PDefender, CCharEntity* PAttacker, CSpell* PSpell, int32 damage, ATTACKTYPE attackType, DAMAGETYPE damageType);

    bool                TryInterruptSpell(CBattleEntity* PAttacker, CBattleEntity* PDefender, CSpell* PSpell);
    float               GetRangedDamageRatio(CBattleEntity* PAttacker, CBattleEntity* PDefender, bool isCritical);
    void                HandleRangedAdditionalEffect(CCharEntity* PAttacker, CBattleEntity* PDefender, apAction_t* Action);
    uint16              CalculateSpikeDamage(CBattleEntity* PAttacker, CBattleEntity* PDefender, actionTarget_t* Action, uint16 damageTaken);
    bool                HandleSpikesDamage(CBattleEntity* PAttacker, CBattleEntity* PDefender, actionTarget_t* Action, int32 damage);
    bool                HandleSpikesEquip(CBattleEntity* PAttacker, CBattleEntity* PDefender, actionTarget_t* Action, uint8 damage, SUBEFFECT spikesType, uint8 chance);
    void                HandleSpikesStatusEffect(CBattleEntity* PAttacker, CBattleEntity* PDefender, actionTarget_t* Action);
    void                HandleEnspell(CBattleEntity* PAttacker, CBattleEntity* PDefender, actionTarget_t* Action, bool isFirstSwing, CItemWeapon* weapon, int32 damage);
    uint8               GetRangedHitRate(CBattleEntity* PAttacker, CBattleEntity* PDefender, bool isBarrage);
    uint8               GetRangedHitRate(CBattleEntity* PAttacker, CBattleEntity* PDefender, bool isBarrage, int8 accBonus);
    int32               CalculateEnspellDamage(CBattleEntity* PAttacker, CBattleEntity* PDefender, uint8 Tier, uint8 element);

    int16               GetEnmityModDamage(int16 level);
    int16               GetEnmityModCure(int16 level);
    bool                isValidSelfTargetWeaponskill(int wsid);
    bool                CanUseWeaponskill(CCharEntity* PChar, CWeaponSkill* PSkill);
    int16               CalculateBaseTP(int delay);
    void                GenerateCureEnmity(CBattleEntity* PSource, CBattleEntity* PTarget, int32 amount);
    void                GenerateInRangeEnmity(CBattleEntity* PSource, int16 CE, int16 VE);

    CItemWeapon*        GetEntityWeapon(CBattleEntity* PEntity, SLOTTYPE Slot);
    CItemEquipment*         GetEntityArmor(CBattleEntity* PEntity, SLOTTYPE Slot);

    void                MakeEntityStandUp(CBattleEntity* PEntity);
    CBattleEntity*      getAvailableTrickAttackChar(CBattleEntity* taUser, CBattleEntity* PMob);

    bool                HasNinjaTool(CBattleEntity* PEntity, CSpell* PSpell, bool ConsumeTool);

    float               GetCharmChance(CBattleEntity* PCharmer, CBattleEntity* PTarget, bool includeCharmAffinityAndChanceMods = true);
    bool                TryCharm(CBattleEntity* PCharmer, CBattleEntity* PVictim);
    void                tryToCharm(CBattleEntity* PCharmer, CBattleEntity* PVictim);
    void                applyCharm(CBattleEntity* PCharmer, CBattleEntity* PVictim, duration charmTime = 0s);
    void                unCharm(CBattleEntity* PEntity);

    uint16              doSoulEaterEffect(CCharEntity* m_PChar, uint32 damage);
    uint16              doConsumeManaEffect(CCharEntity* m_PChar, uint32 damage);
    int32               getOverWhelmDamageBonus(CCharEntity* m_PChar, CBattleEntity* PDefender, int32 damage);
    uint16              jumpAbility(CBattleEntity* PAttacker, CBattleEntity* PVictim, uint8 tier);

    void                TransferEnmity(CBattleEntity* PHateReceiver, CBattleEntity* PHateGiver, CMobEntity* PMob, uint8 percentToTransfer);
    uint8               getBarrageShotCount(CCharEntity* PChar);
    uint8               getStoreTPbonusFromMerit(CBattleEntity* PEntity);

    void                ClaimMob(CBattleEntity* PDefender, CBattleEntity* PAttacker, bool passing = false);
    void                DirtyExp(CBattleEntity* PDefender, CBattleEntity* PAttacker);
    void                RelinquishClaim(CCharEntity* PDefender);

    int32               BreathDmgTaken(CBattleEntity* PDefender, int32 damage);
    int32               MagicDmgTaken(CBattleEntity* PDefender, int32 damage, ELEMENT element);
    int32               PhysicalDmgTaken(CBattleEntity* PDefender, int32 damage, int16 damageType, bool IsCovered = false);
    int32               RangedDmgTaken(CBattleEntity* PDefender, int32 damage, int16 damageType, bool IsCovered = false);
    int32               HandleSteamJacket(CBattleEntity* PDefender, int32 damage, int16 damageType);

    void                HandleIssekiganEnmityBonus(CBattleEntity* PDefender, CBattleEntity* PAttacker);
    int32               HandleSevereDamage(CBattleEntity* PDefender, int32 damage, bool isPhysical);
    int32               HandleSevereDamageEffect(CBattleEntity* PDefender, EFFECT effect, int32 damage, bool removeEffect);
    void                HandleTacticalParry(CBattleEntity* PEntity);
    void                HandleTacticalGuard(CBattleEntity* PEntity);

    // Handles everything related to breaking Bind
    void                BindBreakCheck(CBattleEntity* PAttacker, CBattleEntity* PDefender);

    // returns damage taken
    int32               HandleStoneskin(CBattleEntity* PDefender, int32 damage);
    int32               HandleFanDance(CBattleEntity* PDefender, int32 damage);

    // stores damage for afflatus misery if active
    void                HandleAfflatusMiseryDamage(CBattleEntity* PDefender, int32 damage);
    // boosts accuracy when afflatus msiery is active
    void                HandleAfflatusMiseryAccuracyBonus(CBattleEntity* PAttacker);

    // handles enmity loss calculations for tranquil heart
    float               HandleTranquilHeart(CBattleEntity* PEntity);

    void                assistTarget(CCharEntity* PChar, uint16 TargID);

    uint8               GetSpellAoEType(CBattleEntity* PCaster, CSpell* PSpell);
    WEATHER             GetWeather(CBattleEntity* PEntity, bool ignoreScholar);
    WEATHER             GetWeather(CBattleEntity* PEntity, bool ignoreScholar, uint16 zoneWeather);
    bool                WeatherMatchesElement(WEATHER weather, uint8 element);
    bool                DrawIn(CBattleEntity* PEntity, CMobEntity* PMob, float offset);
    void                DoWildCardToEntity(CCharEntity* PCaster, CCharEntity* PTarget, uint8 roll);
    void                AddTraits(CBattleEntity* PEntity, TraitList_t* TraitList, uint8 level);
    bool                HasClaim(CBattleEntity* PEntity, CBattleEntity* PTarget);

    uint32              CalculateSpellCastTime(CBattleEntity*, CMagicState*);
    uint16              CalculateSpellCost(CBattleEntity*, CSpell*);
    uint32              CalculateSpellRecastTime(CBattleEntity*, CSpell*);
    int16               CalculateSpellTP(CBattleEntity* PEntity, CSpell* PSpell);
    int16               CalculateWeaponSkillTP(CBattleEntity*, CWeaponSkill*, int16);
    bool                RemoveAmmo(CCharEntity*, int quantity = 1);
    int32               GetMeritValue(CBattleEntity*, MERIT_TYPE);

    int32               GetScaledItemModifier(CBattleEntity*, CItemEquipment*, Mod);
    DAMAGETYPE          GetSpikesDamageType(SUBEFFECT spikesType);
    DAMAGETYPE          GetEnspellDamageType(ENSPELL enspellType);

    CBattleEntity*      GetCoverAbilityUser(CBattleEntity* PCoverAbilityTarget, CBattleEntity* PMob);
    bool                IsMagicCovered(CCharEntity* PCoverAbilityUser);
    void                ConvertDmgToMP(CBattleEntity* PDefender, int32 damage, bool IsCovered);
};

#endif
