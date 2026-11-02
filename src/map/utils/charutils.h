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
#include "common/types/flag.h"
#include "data/enums/quest_log.h"

#include <memory>
#include <string>
#include <utility>
#include <vector>

#include "entities/char_entity.h"
#include "persist_batch.h"
#include "zone.h"

using Recalculate       = xi::Flag<struct RecalculateTag>;
using IncludeRecycleBin = xi::Flag<struct IncludeRecycleBinTag>;

namespace xi
{

enum class KeyItem : uint16_t;

}

struct Charge_t;
enum class MissionLog : uint8_t;
class CPetEntity;
class CMobEntity;
class CAbility;
class CItemWeapon;

/**
 * @enum EMobDifficulty
 * @brief Order matters for /check message packet
 */
enum class EMobDifficulty : uint8
{
    TooWeak = 0,
    IncrediblyEasyPrey,
    EasyPrey,
    DecentChallenge,
    EvenMatch,
    Tough,
    VeryTough,
    IncrediblyTough,
    MAX
};

// Capacity Bonuses applied based on RoE Completion
// TODO: Add RoV Completion and Reive bonuses once implemented
const std::vector<std::pair<uint16, uint8>> roeCapacityBonusRecords = {
    { 1332, 10 }, // San d'Oria Missions (10%)
    { 1352, 10 }, // Bastok Missions (10%)
    { 1372, 10 }, // Windurst Missions (10%)
    { 1392, 10 }, // Zilart Missions (10%)
    { 1400, 10 }, // Chains of Promathia Missions (10%)
    { 1409, 10 }, // Wings of the Goddess Missions (10%)
    { 1415, 10 }, // Treasures of Aht Urhgan Missions (10%)
    { 1430, 10 }, // Seekers of Adoulin Missions (10%
};

namespace charutils
{

void LoadExpTable();
void SetExpDifficultyCurve(std::vector<std::pair<uint16, EMobDifficulty>>& curve, std::pair<uint16, uint8>& incrediblyEasyPreyData);
auto LoadChar(uint32 charId) -> std::unique_ptr<CCharEntity>;
void LoadFromCharSpellsSQL(CCharEntity* PChar);
void LoadInventory(CCharEntity* PChar);
void LoadEquip(CCharEntity* PChar);
void SetRaceHitbox(CCharEntity* PChar);

void SendQuestMissionLog(CCharEntity* PChar);
void SendPartialMissionLog(CCharEntity* PChar, MissionLog log, bool completed);
void SendPartialQuestLog(CCharEntity* PChar, xi::QuestLog log, bool completed);
void SendRecordsOfEminenceLog(CCharEntity* PChar);
void SendKeyItems(CCharEntity* PChar);
void SendInventory(CCharEntity* PChar);
void SendUnityPackets(CCharEntity* PChar);
void SendExtendedJobPackets(CCharEntity* PChar);
void SendLocalPlayerPackets(CCharEntity* PChar);

void CalculateStats(CCharEntity* PChar);
void UpdateSubJob(CCharEntity* PChar);

void SetLevelRestriction(CCharEntity* PChar, uint8 lvl);

auto CheckMob(uint8 charlvl, CBattleEntity* PMob) -> EMobDifficulty;

auto GetBaseExp(uint8 charlvl, int16 moblvl) -> uint32;
auto GetExpNEXTLevel(uint8 charlvl) -> uint32;
auto GetExpNEXTLevelForChar(const CCharEntity* PChar, uint8 charlvl) -> uint32;
auto GetExpLevel(CBattleEntity* PMember) -> uint8;

void DelExperiencePoints(CCharEntity* PChar, float retainpct, uint16 forcedXpLoss);
void DistributeExperiencePoints(CCharEntity* PChar, CMobEntity* PMob);
void DistributeGil(CCharEntity* PChar, CMobEntity* PMob);
void DistributeItem(CCharEntity* PChar, CBaseEntity* PEntity, uint16 itemid, uint16 droprate);
void AddExperiencePoints(bool expFromRaise, bool awardRegionPoints, bool fromScripts, CCharEntity* PChar, CBaseEntity* PMob, uint32 exp, EMobDifficulty mobCheck = EMobDifficulty::TooWeak, bool isexpchain = false, bool allowLimitPoints = true);

auto AddCapacityBonus(CCharEntity* PChar, uint16 capacityPoints) -> uint16;
void AddCapacityPoints(CCharEntity* PChar, CBaseEntity* PMob, uint32 capacityPoints, int16 levelDiff = 0, bool isCapacityChain = false);
void DistributeCapacityPoints(CCharEntity* PChar, CMobEntity* PMob);

void TrySkillUP(CCharEntity* PChar, xi::SkillType SkillID, uint8 lvl, bool forceSkillUp = false, bool useSubSkill = false);
void TrackArrowUsageForScavenge(CCharEntity* PChar, CItemWeapon* PAmmo);
auto isArtsBonusActive(CCharEntity* PChar, xi::SkillType SkillID) -> bool;
auto ArtsBonusSkill(CCharEntity* PChar, xi::SkillType SkillID) -> int16;
void BuildingCharSkillsTable(CCharEntity* PChar);
void BuildingCharWeaponSkills(CCharEntity* PChar);
void BuildingCharAbilityTable(CCharEntity* PChar);
void BuildingCharTraitsTable(CCharEntity* PChar);
void BuildingCharPetAbilityTable(CCharEntity* PChar, CPetEntity* PPet, uint32 PetID);

void CheckWeaponSkill(CCharEntity* PChar, uint8 skill);
auto HasItem(CCharEntity* PChar, uint16 ItemID, IncludeRecycleBin includeRecycleBin = IncludeRecycleBin::Yes) -> bool;
auto getItemCount(CCharEntity* PChar, uint16 ItemID) -> uint32;
auto MoveItem(CCharEntity* PChar, uint8 LocationID, uint8 SlotID, uint8 NewSlotID) -> uint8;

void DropItem(CCharEntity* PChar, uint8 container, uint8 slotID, int32 quantity, uint16 ItemID);
void CheckValidEquipment(CCharEntity* PChar, bool isDelevel = false);
void SaveJobChangeGear(CCharEntity* PChar);
void LoadJobChangeGear(CCharEntity* PChar);
void EquipItem(CCharEntity* PChar, uint8 slotID, uint8 equipSlotID, uint8 containerID);
void UnequipItem(CCharEntity* PChar, uint8 equipSlotID, xi::Flag<struct RecalculateTag> recalculate = Recalculate::Yes, bool isDelevel = false);
auto hasSlotEquipped(CCharEntity* PChar, uint8 equipSlotID) -> bool;
void RemoveSub(CCharEntity* PChar);
auto EquipArmor(CCharEntity* PChar, uint8 slotID, uint8 equipSlotID, uint8 containerID) -> bool;
void CheckUnarmedWeapon(CCharEntity* PChar);
void SetStyleLock(CCharEntity* PChar, bool isStyleLocked);
void UpdateWeaponStyle(CCharEntity* PChar, uint8 equipSlotID, CItemEquipment* PItem);
void UpdateArmorStyle(CCharEntity* PChar, uint8 equipSlotID);
auto canEquipItemOnAnyJob(CCharEntity* PChar, const CItemEquipment* PItem) -> bool;
auto hasValidStyle(CCharEntity* PChar, const CItemEquipment* PItem, const CItemEquipment* AItem) -> bool;
void UpdateRemovedSlotsLookForLockStyle(CCharEntity* PChar);
void UpdateRemovedSlotsLook(CCharEntity* PChar);
void AddItemToRecycleBin(CCharEntity* PChar, uint32 container, uint8 slotID, uint8 quantity);
void EmptyRecycleBin(CCharEntity* PChar);

auto hasKeyItem(const CCharEntity* PChar, xi::KeyItem keyItemId) -> bool; // checking the presence of a key item
auto seenKeyItem(CCharEntity* PChar, xi::KeyItem keyItemId) -> bool;      // checking whether the description of the key item has been read
void markSeenKeyItem(CCharEntity* PChar, xi::KeyItem keyItemId);          // mark key item as seen (description read)
void unseenKeyItem(CCharEntity* PChar, xi::KeyItem keyItemId);            // attempt to remove keyitem from seen list
void addKeyItem(CCharEntity* PChar, xi::KeyItem keyItemId);               // add a key item
void delKeyItem(CCharEntity* PChar, xi::KeyItem keyItemId);               // delete a key item

auto hasSpell(CCharEntity* PChar, uint16 SpellID) -> int32; // checking for the presence of a spell
auto addSpell(CCharEntity* PChar, uint16 SpellID) -> int32; // add a spell
auto delSpell(CCharEntity* PChar, uint16 SpellID) -> int32; // delete a spell

auto hasLearnedAbility(CCharEntity* PChar, uint16 AbilityID) -> int32; // checking for the presence of a learned ability
auto addLearnedAbility(CCharEntity* PChar, uint16 AbilityID) -> int32; // add a learned ability
auto delLearnedAbility(CCharEntity* PChar, uint16 AbilityID) -> int32; // delete a learned ability

auto hasLearnedWeaponskill(CCharEntity* PChar, uint8 wsUnlockId) -> bool;
void addLearnedWeaponskill(CCharEntity* PChar, uint8 wsUnlockId);
void delLearnedWeaponskill(CCharEntity* PChar, uint8 wsUnlockId);

auto hasAbility(CCharEntity* PChar, uint16 AbilityID) -> int32; // checking the presence of an ability
auto addAbility(CCharEntity* PChar, uint16 AbilityID) -> int32; // add an ability
auto delAbility(CCharEntity* PChar, uint16 AbilityID) -> int32; // delete an ability

auto hasTitle(CCharEntity* PChar, uint16 Title) -> int32;
auto addTitle(CCharEntity* PChar, uint16 Title) -> int32;
auto delTitle(CCharEntity* PChar, uint16 Title) -> int32;
void setTitle(CCharEntity* PChar, uint16 Title); // set title if not, save and update player

auto hasPetAbility(CCharEntity* PChar, uint16 AbilityID) -> int32; // same as Ability but for pet commands (e.g. Healing Ruby)
auto addPetAbility(CCharEntity* PChar, uint16 AbilityID) -> int32;
auto delPetAbility(CCharEntity* PChar, uint16 AbilityID) -> int32;

auto hasTrait(CCharEntity* PChar, uint16 TraitID) -> int32; // check if pchar has trait by traitid and jobid
auto addTrait(CCharEntity* PChar, uint16 TraitID) -> int32; // add trait by traitid and jobid
auto delTrait(CCharEntity* PChar, uint16 TraitID) -> int32; // delete trait by traitid and jobid

auto addWeaponSkill(CCharEntity* PChar, uint16 WeaponSkillID) -> int32; // declaration of function to add weapon skill
auto hasWeaponSkill(CCharEntity* PChar, uint16 WeaponSkillID) -> int32; // declaration of function to check for weapon skill
auto delWeaponSkill(CCharEntity* PChar, uint16 WeaponSkillID) -> int32; // declaration of function to delete weapon skill
auto canUseWeaponSkill(CCharEntity* PChar, uint16 wsid) -> bool;

void SaveCharJob(const CCharEntity* PChar, xi::Job job); // save the level for the selected character's jobs
void SaveCharExp(const CCharEntity* PChar, xi::Job job); // save experience for the selected character’s chosen job
void SaveCharEquip(CCharEntity* PChar);                  // preserve the character’s equipment and appearance
void SaveCharPosition(CCharEntity* PChar);               // save the character's position (x/y/z)
void SaveCharPositions(const std::vector<CharPosition>& rows);
void SaveCharEquips(const std::vector<uint32>& replaceFor, const std::vector<CharEquipSlot>& rows);
void SaveCharAppearances(const std::vector<CharAppearance>& rows);
void PersistCharVars(const std::vector<CharVarChange>& rows);
auto BuildCharEquipSlots(const CCharEntity* PChar) -> std::vector<CharEquipSlot>;
auto BuildCharAppearance(const CCharEntity* PChar) -> CharAppearance;
void SaveMissionsList(CCharEntity* PChar);          // save the missions list
void SaveEminenceData(CCharEntity* PChar);          // save Eminence Record (RoE) data
void SaveQuestsList(CCharEntity* PChar);            // save the list of quests
void SaveFame(CCharEntity* PChar);                  // save area fame / reputation
void SaveZonesVisited(CCharEntity* PChar);          // save visited areas
void SaveKeyItems(CCharEntity* PChar);              // save key items
void SaveCharInventoryCapacity(CCharEntity* PChar); // save Character inventory capacity
void SaveSpell(CCharEntity* PChar, uint16 spellID); // save learned spells
void DeleteSpell(CCharEntity* PChar, uint16 spellID);
void SaveLearnedAbilities(CCharEntity* PChar);                  // save learned abilities (e.g., corsair rolls)
void SaveTitles(CCharEntity* PChar);                            // save character's titles
void SaveCharStats(CCharEntity* PChar);                         // save flags, current values of character stats (jobs/HP/MP/etc.)
void SaveCharGMLevel(CCharEntity* PChar);                       // save the character's gm level
void SaveMentorFlag(CCharEntity* PChar);                        // save the character's mentor flag
void SaveJobMasterDisplay(CCharEntity* PChar);                  // Save the character's job master display status
void SavePlayerSettings(CCharEntity* PChar);                    // save the character's settings
void SaveChatFilterFlags(CCharEntity* PChar);                   // save the character's chat filters
void SaveLanguages(CCharEntity* PChar);                         // save the character's language preference
void SaveCharNation(CCharEntity* PChar);                        // save the character's nation of allegiance
void SaveCampaignAllegiance(const CCharEntity* PChar);          // save the character's campaign allegiance
void SaveCharMoghancement(const CCharEntity* PChar);            // save the character's current moghancement
void SaveCharSkills(const CCharEntity* PChar, uint8 skillID);   // save the character's skills
void SaveTeleport(CCharEntity* PChar, TELEPORT_TYPE type);      // save the character's teleports (homepoints, outposts, maws, etc)
void SaveMazeUnlocks(CCharEntity* PChar);                       // save the character's learned Moblin Maze Mongers vouchers and runes
void SaveDeathTime(CCharEntity* PChar);                         // save when this character last died
void SavePlayTime(CCharEntity* PChar);                          // save this character's total play time
void SaveLastLogout(const CCharEntity* PChar);                  // save the last logout time of this character
void SavePrevZoneLineID(CCharEntity* PChar, uint32 ZoneLineID); // save the last zoneline the player crossed.
auto hasMogLockerAccess(const CCharEntity* PChar) -> bool;      // true if have access, false otherwise

auto getQuestStatus(CCharEntity* PChar, uint8 log, uint8 quest) -> uint8; // Get Quest status (used in FishingUtils.cpp, allows to fish quest specific mobs, like PLD AF NM)

void RemoveAllEquipment(CCharEntity* PChar);

void OpenSendBox(CCharEntity* PChar, uint8 action, uint8 boxtype);
void OpenRecvBox(CCharEntity* PChar, uint8 action, uint8 boxtype);
auto isSendBoxOpen(CCharEntity* PChar) -> bool;
auto isRecvBoxOpen(CCharEntity* PChar) -> bool;
auto isAnyDeliveryBoxOpen(CCharEntity* PChar) -> bool;

auto CheckAbilityAddtype(CCharEntity* PChar, const CAbility* PAbility) -> bool;

void RemoveInvisible(const CCharEntity* PChar);
void RemoveStratagems(CCharEntity* PChar, CSpell* PSpell);

void RemoveAllEquipMods(CCharEntity* PChar);
void ApplyAllEquipMods(CCharEntity* PChar);

void ClearTempItems(CCharEntity* PChar);
void LeaveParty(CCharEntity* PChar);
void ReloadParty(CCharEntity* PChar);
void RemoveSeekFlag(CCharEntity* PChar);

auto IsAidBlocked(CCharEntity* PInitiator, CCharEntity* PTarget) -> bool;

void AddPoints(CCharEntity* PChar, const char* type, int32 amount, int32 max = INT32_MAX);
void SetPoints(CCharEntity* PChar, const char* type, int32 amount);
auto GetPoints(CCharEntity* PChar, const char* type) -> int32;
void CheckCharPointsQueries();
void SetUnityLeader(CCharEntity* PChar, uint8 leaderID);
auto GetConquestPointsName(CCharEntity* PChar) -> std::string;
auto SendToZone(CCharEntity* PChar, xi::ZoneId zoneId) -> bool;
void SendDisconnect(CCharEntity* PChar);
void ForceLogout(CCharEntity* PChar);
void ForceRezone(CCharEntity* PChar);
auto HomePoint(CCharEntity* PChar, bool resetHPMP) -> bool;
auto AddWeaponSkillPoints(CCharEntity*, SLOTTYPE, int) -> bool;

auto GetCharVar(CCharEntity* PChar, const std::string& var) -> int32;
void SetCharVar(uint32 charId, const std::string& var, int32 value, uint32 expiry = 0);
void SetCharVar(CCharEntity* PChar, const std::string& var, int32 value, uint32 expiry = 0);
auto ClearCharVarsWithPrefix(CCharEntity* PChar, const std::string& prefix) -> int32;
void ClearCharVarFromAll(const std::string& varName, bool localOnly = false);
void IncrementCharVar(uint32 charId, const std::string& var, int32 value);
void IncrementCharVar(CCharEntity* PChar, const std::string& var, int32 value);

auto FetchCharVar(uint32 charId, const std::string& var) -> std::pair<int32, uint32>;
void PersistCharVar(uint32 charId, const std::string& var, int32 value, uint32 expiry = 0);

auto getWideScanRange(xi::Job job, uint8 level) -> uint16;
auto getWideScanRange(CCharEntity* PChar) -> uint16;

void SendTimerPacket(CCharEntity* PChar, uint32 seconds);
void SendTimerPacket(CCharEntity* PChar, timer::duration dur);
void SendClearTimerPacket(CCharEntity* PChar);

auto getTraverserEpoch(CCharEntity* PChar) -> earth_time::time_point;
void setTraverserEpoch(CCharEntity* PChar);
auto getClaimedTraverserStones(CCharEntity* PChar) -> uint32;
void addClaimedTraverserStones(CCharEntity* PChar, uint16 numStones);
void setClaimedTraverserStones(CCharEntity* PChar, uint16 stoneTotal);
auto getAvailableTraverserStones(CCharEntity* PChar) -> uint32;

void ReadHistory(CCharEntity* PChar);
void WriteHistory(const CCharEntity* PChar);

auto getMaxItemLevel(CCharEntity* PChar) -> uint8;
auto getItemLevelDifference(CCharEntity* PChar) -> uint8;
auto getMainhandItemLevel(CCharEntity* PChar) -> uint8;
auto getRangedItemLevel(CCharEntity* PChar) -> uint8;

auto hasEntitySpawned(CCharEntity* PChar, CBaseEntity* entity) -> bool;

auto getCharIdFromName(const std::string& name) -> uint32;
auto getAccountIdFromName(const std::string& name) -> uint32;
auto getCharIdAndAccountIdFromName(const std::string& name) -> std::pair<uint32, uint32>;

void forceSynthCritFail(const std::string& sourceFunction, CCharEntity* PChar);

void removeCharFromZone(CCharEntity* PChar);

void updateSession(MapSession* PSession, CCharEntity* PChar, CZone* currentZone);
void loadDeathTimestamp(CCharEntity* PChar);
void loadZoningFlag(CCharEntity* PChar);

auto IsHomeNation(xi::Nation nation, xi::Region region) -> bool;
auto isOrchestrionPlaced(CCharEntity* PChar) -> bool;
void updateMannequins(CCharEntity* PChar);

auto raceChange(CCharEntity* PChar, CharRace newRace, CharFace newFace, CharSize newSize) -> bool;

void ApplyAbilityRecast(CCharEntity* PChar, const CAbility* PAbility, const Charge_t* charge, timer::duration baseChargeTime, timer::duration recastTime);

}; // namespace charutils
