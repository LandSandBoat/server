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

#include "common/cbasetypes.h"
#include "merit.h"
#include "status_effect.h"

#include <list>

#include "entities/battle_entity.h"

enum class ActionReactKind : uint8_t;
enum class ActionProcSkillChain : uint8_t;
#include "data/enums/weather.h"
class CMobEntity;
class CAbility;
class CAttack;
class CItemWeapon;
class CMobSkill;
class CPetSkill;
class CSpell;
class CTrait;
class CWeaponSkill;
struct action_result_t;
enum class PHYSICAL_ATTACK_TYPE;

enum ENSPELL
{
    ENSPELL_NONE             = 0,
    ENSPELL_I_FIRE           = 1,
    ENSPELL_I_ICE            = 2,
    ENSPELL_I_WIND           = 3,
    ENSPELL_I_EARTH          = 4,
    ENSPELL_I_THUNDER        = 5,
    ENSPELL_I_WATER          = 6,
    ENSPELL_I_LIGHT          = 7,
    ENSPELL_I_DARK           = 8,
    ENSPELL_II_FIRE          = 9,
    ENSPELL_II_ICE           = 10,
    ENSPELL_II_WIND          = 11,
    ENSPELL_II_EARTH         = 12,
    ENSPELL_II_THUNDER       = 13,
    ENSPELL_II_WATER         = 14,
    ENSPELL_II_LIGHT         = 15,
    ENSPELL_II_DARK          = 16,
    ENSPELL_BLOOD_WEAPON     = 17,
    ENSPELL_AUSPICE          = 18,
    ENSPELL_DRAIN_SAMBA      = 19,
    ENSPELL_ASPIR_SAMBA      = 20,
    ENSPELL_HASTE_SAMBA      = 21,
    ENSPELL_SOUL_ENSLAVEMENT = 22
};

enum SPIKES
{
    SPIKE_NONE     = 0,
    SPIKE_BLAZE    = 1,
    SPIKE_ICE      = 2,
    SPIKE_DREAD    = 3,
    SPIKE_CURSE    = 4,
    SPIKE_SHOCK    = 5,
    SPIKE_REPRISAL = 6,
    SPIKE_WIND     = 7,
    SPIKE_STONE    = 8,
    SPIKE_DELUGE   = 9,
    SPIKE_DEATH    = 10,
    RETALIATION    = 63
};

enum ELEMENT
{
    ELEMENT_NONE    = 0,
    ELEMENT_FIRE    = 1,
    ELEMENT_ICE     = 2,
    ELEMENT_WIND    = 3,
    ELEMENT_EARTH   = 4,
    ELEMENT_THUNDER = 5,
    ELEMENT_WATER   = 6,
    ELEMENT_LIGHT   = 7,
    ELEMENT_DARK    = 8
};

namespace battleutils
{

void LoadSkillTable();
void LoadWeaponSkillsList();
void LoadMobSkillsList();
void LoadPetSkillsList();

[[nodiscard]] auto GetEcosystemStrongAgainst(xi::Ecosystem ecosystem) -> xi::Ecosystem;

auto CheckMultiHits(CBattleEntity* PEntity, CItemWeapon* PWeapon) -> uint8;

auto getHitCount(uint8 hits) -> uint8;

auto GetRangedDelayReduction(CBattleEntity* battleEntity, int16 delay) -> int16;
auto GetRangedAttackBonuses(CBattleEntity* battleEntity) -> int32;
auto GetRangedAccuracyBonuses(CBattleEntity* battleEntity) -> int32;

auto GetSkillRank(xi::SkillType SkillID, xi::Job JobID) -> uint8;
auto GetMaxSkill(xi::SkillType SkillID, xi::Job JobID, uint8 level) -> uint16;
auto GetMaxSkill(uint8 rank, uint8 level) -> uint16;

auto GetWeaponSkill(uint16 WSkillID) -> CWeaponSkill*;
auto GetMobSkill(uint16 SkillID) -> CMobSkill*;
auto GetPetSkill(uint16 SkillID) -> CPetSkill*;

auto GetWeaponSkills(uint8 skill) -> const std::list<CWeaponSkill*>&;
auto GetMobSkillList(uint16 ListID) -> const std::vector<uint16>&;

void FreeWeaponSkillsList();
void FreeMobSkillList();
void FreePetSkillList();

auto GetSkillChainEffect(const CBattleEntity* PDefender, uint8 primary, uint8 secondary, uint8 tertiary) -> ActionProcSkillChain;
auto FormSkillchain(const std::list<xi::SkillchainType>& resonance, const std::list<xi::SkillchainType>& skill) -> xi::SkillchainType;
auto GetSkillchainTier(xi::SkillchainType skillchain) -> uint8;
auto GetSkillchainSubeffect(xi::SkillchainType skillchain) -> ActionProcSkillChain;
auto GetSkillchainMinimumResistance(xi::SkillchainType element, CBattleEntity* PDefender, ELEMENT& appliedEle) -> int16;
auto GetSkillchainMagicElement(xi::SkillchainType skillchain) -> std::vector<ELEMENT>;

auto IsParalyzed(CBattleEntity* PAttacker) -> bool;
auto IsAbsorbByShadow(CBattleEntity* PDefender, CBattleEntity* PAttacker) -> bool;
auto IsIntimidated(CBattleEntity* PAttacker, CBattleEntity* PDefender) -> bool;

auto GetFSTR(CBattleEntity* PAttacker, CBattleEntity* PDefender, uint8 SlotID) -> int32;
auto GetHitRateEx(CBattleEntity* PAttacker, CBattleEntity* PDefender, uint8 attackNumber, int16 offsetAccuracy) -> uint8;
auto GetHitRate(CBattleEntity* PAttacker, CBattleEntity* PDefender) -> uint8;
auto GetHitRate(CBattleEntity* PAttacker, CBattleEntity* PDefender, uint8 attackNumber) -> uint8;
auto GetHitRate(CBattleEntity* PAttacker, CBattleEntity* PDefender, uint8 attackNumber, int16 offsetAccuracy) -> uint8;
auto GetCritHitRate(CBattleEntity* PAttacker, CBattleEntity* PDefender, bool ignoreSneakTrickAttack, SLOTTYPE weaponSlot = SLOT_MAIN) -> uint8;
auto GetRangedCritHitRate(CBattleEntity* PAttacker, CBattleEntity* PDefender) -> uint8;
auto GetDexCritBonus(CBattleEntity* PAttacker, CBattleEntity* PDefender) -> int8;
auto GetAGICritBonus(CBattleEntity* PAttacker, CBattleEntity* PDefender) -> int8;
auto GetDamageRatio(CBattleEntity* PAttacker, CBattleEntity* PDefender, bool isCritical, float bonusAttPercent, xi::SkillType weaponType, SLOTTYPE weaponSlot, bool isCannonball) -> float;

auto TakePhysicalDamage(CBattleEntity* PAttacker, CBattleEntity* PDefender, PHYSICAL_ATTACK_TYPE physicalAttackType, int32 damage, bool isBlocked, uint8 slot, uint16 tpMultiplier, CBattleEntity* taChar, bool giveTPtoVictim, bool giveTPtoAttacker, bool isCounter = false, bool isCovered = false, CBattleEntity* POriginalTarget = nullptr) -> int32;
auto TakeWeaponskillDamage(CBattleEntity* PAttacker, CBattleEntity* PDefender, int32 damage, xi::AttackType attackType, xi::DamageType damageType, uint8 slot, bool primary, float tpMultiplier, uint16 bonusTP, float targetTPMultiplier) -> int32;
auto TakeSkillchainDamage(CBattleEntity* PAttacker, CBattleEntity* PDefender, int32 lastSkillDamage, CBattleEntity* taChar) -> int32;
void TakeSpellDamage(CBattleEntity* PDefender, CBattleEntity* PAttacker, CSpell* PSpell, int32 damage, xi::AttackType attackType, xi::DamageType damageType);
auto TakeSwipeLungeDamage(CBattleEntity* PDefender, CBattleEntity* PAttacker, int32 damage, xi::AttackType attackType, xi::DamageType damageType) -> int32;

auto TryInterruptSpell(CBattleEntity* PAttacker, CBattleEntity* PDefender, CSpell* PSpell) -> bool;
auto GetRangedDamageRatio(CBattleEntity* PAttacker, CBattleEntity* PDefender, bool isCritical, int16 bonusRangedAttack) -> float;
auto CalculateSpikeDamage(CBattleEntity* PAttacker, CBattleEntity* PDefender, action_result_t* Action, uint16 damageTaken) -> int32;
auto HandleSpikesDamage(CBattleEntity* PAttacker, CBattleEntity* PDefender, action_result_t* Action, int32 damage) -> bool;
auto HandleParrySpikesDamage(CBattleEntity* PAttacker, CBattleEntity* PDefender, action_result_t* Action, int32 damage) -> bool;
auto HandleSpikesEquip(CBattleEntity* PAttacker, CBattleEntity* PDefender, action_result_t* Action, uint8 damage, ActionReactKind spikesType, uint8 chance) -> bool;
void HandleSpikesStatusEffect(const CBattleEntity* PAttacker, const CBattleEntity* PDefender, const action_result_t* Action);
void HandleEnspell(CBattleEntity* PAttacker, CBattleEntity* PDefender, action_result_t* Action, bool isFirstSwing, CItemWeapon* weapon, int32 damage, CAttack& attack);
auto GetRangedHitRate(CBattleEntity* PAttacker, CBattleEntity* PDefender, bool isBarrage) -> uint8;
auto GetRangedHitRate(CBattleEntity* PAttacker, CBattleEntity* PDefender, bool isBarrage, int16 accBonus) -> uint8;
auto CalculateEnspellDamage(CBattleEntity* PAttacker, CBattleEntity* PDefender, uint8 Tier, uint8 element) -> int32;

auto GetEnmityModDamage(int16 level) -> int32;
auto GetEnmityModCure(int16 level) -> int32;
auto isValidSelfTargetWeaponskill(int wsid) -> bool;
auto CanUseWeaponskill(CCharEntity* PChar, CWeaponSkill* PSkill) -> bool;
auto CalculateBaseTP(CBattleEntity* PEntity, int32 delay) -> int16;
auto GetBaseDelay(CBattleEntity* PEntity) -> uint16;       // get base delay of entity, melee only
auto GetBaseRangedDelay(CBattleEntity* PEntity) -> uint16; // get base delay of entity, ranged only
auto CalculateTPFromDamageDealt(CBattleEntity* PAttacker, const bool& isZanshin, const SLOTTYPE& slot) -> int32;
auto CalculateTPFromDamageTaken(CBattleEntity* PAttacker, CBattleEntity* PDefender, int32 damage, uint16 delay) -> int32;
void GenerateCureEnmity(CBattleEntity* PSource, CBattleEntity* PTarget, int32 amount, int32 fixedCE = 0, int32 fixedVE = 0);
void GenerateInRangeEnmity(CBattleEntity* PSource, int32 CE, int32 VE);
void handleKillshotEnmity(CBattleEntity* PAttacker, CBattleEntity* PTarget);
void handleSecondaryTargetEnmity(CBattleEntity* PAttacker, CBattleEntity* PTarget);

auto GetEntityWeapon(CBattleEntity* PEntity, SLOTTYPE Slot) -> CItemWeapon*;
auto GetEntityArmor(CBattleEntity* PEntity, SLOTTYPE Slot) -> CItemEquipment*;

void        MakeEntityStandUp(CBattleEntity* PEntity);
inline auto areInLine(uint8 firstPlayerWA, CBattleEntity* insidePlayer, CBattleEntity* outidePlayer) -> bool;
auto        getAvailableTrickAttackChar(CBattleEntity* taUser, CBattleEntity* PMob) -> CBattleEntity*;

auto HasNinjaTool(CBattleEntity* PEntity, CSpell* PSpell, bool ConsumeTool) -> bool;

void applyCharm(CBattleEntity* PCharmer, CBattleEntity* PVictim, timer::duration charmTime = 0s);
void unCharm(CBattleEntity* PEntity);

auto doSoulEaterEffect(CCharEntity* m_PChar, uint32 damage) -> uint16;
auto doConsumeManaEffect(CCharEntity* m_PChar) -> uint16;
auto getOverWhelmDamageBonus(CBattleEntity* PAttacker, CBattleEntity* PDefender, int32 damage) -> int32;

void TransferEnmity(CBattleEntity* PHateReceiver, CBattleEntity* PHateGiver, CMobEntity* PMob, uint8 percentToTransfer);
auto getBarrageShotCount(CBattleEntity* PBattleEntity) -> uint8;
auto getStoreTPbonusFromMerit(CBattleEntity* PEntity) -> uint8;

void ClaimMob(CBattleEntity* PDefender, CBattleEntity* PAttacker, bool passing = false);
void DirtyExp(CBattleEntity* PDefender, CBattleEntity* PAttacker);
void RelinquishClaim(CCharEntity* PDefender);
void ForceDeaggro(CMobEntity* PAttacker, CBattleEntity* PDefender);

auto MagicDmgTaken(CBattleEntity* PDefender, int32 damage, ELEMENT element) -> int32;
auto PhysicalDmgTaken(CBattleEntity* PDefender, int32 damage, xi::DamageType damageType, bool IsCovered = false) -> int32;
auto RangedDmgTaken(CBattleEntity* PDefender, int32 damage, xi::DamageType damageType, bool IsCovered = false) -> int32;
auto CheckAndApplyDamageCap(int32 damage, CBattleEntity* PDefender) -> int32;

void HandleIssekiganEnmityBonus(CBattleEntity* PDefender, CBattleEntity* PAttacker);
auto HandleSevereDamage(CBattleEntity* PDefender, int32 damage, bool isPhysical) -> int32;
auto HandleSevereDamageEffect(CBattleEntity* PDefender, xi::StatusEffect effect, int32 damage, bool removeEffect) -> int32;
void HandleTacticalParry(CBattleEntity* PEntity);
void HandleTacticalGuard(CBattleEntity* PEntity);

// Handles everything related to breaking Bind
void BindBreakCheck(CBattleEntity* PAttacker, CBattleEntity* PDefender);

// returns damage taken
auto HandleStoneskin(CBattleEntity* PDefender, int32 damage, xi::AttackType attackType = xi::AttackType::None) -> int32;
auto HandleOneForAll(CBattleEntity* PDefender, int32 damage) -> int32;
auto HandleFanDance(CBattleEntity* PDefender, int32 damage) -> int32;
void HandleScarletDelirium(CBattleEntity* PDefender, int32 damage);

// stores damage for afflatus misery if active
void HandleAfflatusMiseryDamage(CBattleEntity* PDefender, int32 damage);
// boosts accuracy when afflatus msiery is active
void HandleAfflatusMiseryAccuracyBonus(CBattleEntity* PAttacker);

// handles enmity loss calculations for tranquil heart
auto HandleTranquilHeart(CBattleEntity* PEntity) -> float;

void assistTarget(CCharEntity* PChar, uint16 TargID);

auto GetDayElement() -> ELEMENT;
auto GetWeather(CBattleEntity* PEntity, bool ignoreScholar) -> xi::Weather;
auto GetWeather(CBattleEntity* PEntity, bool ignoreScholar, xi::Weather zoneWeather) -> xi::Weather;
auto WeatherMatchesElement(xi::Weather weather, uint8 element) -> bool;
void DrawIn(CBattleEntity* PTarget, position_t pos, float offset, float degrees);
void DoWildCardToEntity(CCharEntity* PCaster, CCharEntity* PTarget, uint8 roll);
auto DoRandomDealToEntity(CCharEntity* PChar, CBattleEntity* PTarget) -> bool;

void turnTowardsTarget(CBaseEntity* PEntity, CBaseEntity* PTarget, bool force = false);

void AddTraits(CBattleEntity* PEntity, TraitList_t* TraitList, uint8 level);
auto HasClaim(CBattleEntity* PEntity, CBattleEntity* PTarget) -> bool;

auto CalculateSpellCastTime(CBattleEntity*, CMagicState*) -> timer::duration;
auto CalculateSpellCost(CBattleEntity*, CSpell*) -> uint16;
auto CalculateSpellRecastTime(CBattleEntity*, CSpell*) -> timer::duration;
auto CanAffordSpell(CBattleEntity* PEntity, CSpell* PSpell, uint8 flags = 0) -> bool;
auto CalculateWeaponSkillTP(CBattleEntity*, CWeaponSkill*, int16) -> int16;
auto RemoveAmmo(CCharEntity*, int quantity = 1) -> bool;
auto GetMeritValue(CBattleEntity*, xi::Merit) -> int32;

auto GetScaledItemModifier(CBattleEntity*, CItemEquipment*, xi::Mod, bool isDelevel = false) -> int32;
auto GetSpikesDamageType(ActionReactKind spikesType) -> xi::DamageType;
auto GetEnspellDamageType(ENSPELL enspellType) -> xi::DamageType;
auto GetRuneEnhancementDamageType(xi::StatusEffect runeEffect) -> xi::DamageType;
auto GetRuneEnhancementElement(xi::StatusEffect runeEffect) -> ELEMENT;

auto GetCoverAbilityUser(CBattleEntity* PCoverAbilityTarget, CBattleEntity* PMob) -> CBattleEntity*;
auto IsMagicCovered(CCharEntity* PCoverAbilityUser) -> bool;
void ConvertDmgToMP(CBattleEntity* PDefender, int32 damage, bool IsCovered);
void addEcosystemKillerEffects(CBattleEntity* PBattleEntity);
auto CheckLiementAbsorb(CBattleEntity* PBattleEntity, xi::DamageType DamageType) -> float;

}; // namespace battleutils
