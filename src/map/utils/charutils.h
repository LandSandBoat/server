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

#ifndef _CHARUTILS_H
#define _CHARUTILS_H

#include "common/cbasetypes.h"

#include "entities/charentity.h"
#include "items/item_equipment.h"
#include "trait.h"

class CPetEntity;
class CMobEntity;
class CMeritPoints;
class CAbility;

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
    auto LoadChar(uint32 charId) -> CCharEntity*;
    void LoadSpells(CCharEntity* PChar);
    void LoadInventory(CCharEntity* PChar);
    void LoadEquip(CCharEntity* PChar);

    void SendQuestMissionLog(CCharEntity* PChar);
    void SendKeyItems(CCharEntity* PChar);
    void SendInventory(CCharEntity* PChar);

    void CalculateStats(CCharEntity* PChar);
    void UpdateSubJob(CCharEntity* PChar);

    void SetLevelRestriction(CCharEntity* PChar, uint8 lvl);

    EMobDifficulty CheckMob(uint8 charlvl, uint8 moblvl);

    uint32 GetBaseExp(uint8 charlvl, uint8 moblvl);
    uint32 GetExpNEXTLevel(uint8 charlvl);

    void DelExperiencePoints(CCharEntity* PChar, float retainpct, uint16 forcedXpLoss);
    void DistributeExperiencePoints(CCharEntity* PChar, CMobEntity* PMob);
    void DistributeGil(CCharEntity* PChar, CMobEntity* PMob);
    void DistributeItem(CCharEntity* PChar, CBaseEntity* PEntity, uint16 itemid, uint16 droprate);
    void AddExperiencePoints(bool expFromRaise, CCharEntity* PChar, CBaseEntity* PMob, uint32 exp, EMobDifficulty mobCheck = EMobDifficulty::TooWeak,
                             bool isexpchain = false);

    uint16 AddCapacityBonus(CCharEntity* PChar, uint16 capacityPoints);
    void   AddCapacityPoints(CCharEntity* PChar, CBaseEntity* PMob, uint32 capacityPoints, int16 levelDiff = 0, bool isCapacityChain = false);
    void   DistributeCapacityPoints(CCharEntity* PChar, CMobEntity* PMob);

    void TrySkillUP(CCharEntity* PChar, SKILLTYPE SkillID, uint8 lvl, bool forceSkillUp = false, bool useSubSkill = false);
    void BuildingCharSkillsTable(CCharEntity* PChar);
    void BuildingCharWeaponSkills(CCharEntity* PChar);
    void BuildingCharAbilityTable(CCharEntity* PChar);
    void BuildingCharTraitsTable(CCharEntity* PChar);
    void BuildingCharPetAbilityTable(CCharEntity* PChar, CPetEntity* PPet, uint32 PetID);

    void DoTrade(CCharEntity* PChar, CCharEntity* PTarget);
    bool CanTrade(CCharEntity* PChar, CCharEntity* PTarget);

    void   CheckWeaponSkill(CCharEntity* PChar, uint8 skill);
    bool   HasItem(CCharEntity* PChar, uint16 ItemID);
    uint32 getItemCount(CCharEntity* PChar, uint16 ItemID);
    uint8  AddItem(CCharEntity* PChar, uint8 LocationID, CItem* PItem, bool silence = false);
    uint8  AddItem(CCharEntity* PChar, uint8 LocationID, uint16 itemID, uint32 quantity = 1, bool silence = false);
    uint8  MoveItem(CCharEntity* PChar, uint8 LocationID, uint8 SlotID, uint8 NewSlotID);
    uint32 UpdateItem(CCharEntity* PChar, uint8 LocationID, uint8 slotID, int32 quantity, bool force = false);
    void   DropItem(CCharEntity* PChar, uint8 container, uint8 slotID, int32 quantity, uint16 ItemID);
    void   CheckValidEquipment(CCharEntity* PChar);
    void   CheckEquipLogic(CCharEntity* PChar, SCRIPTTYPE ScriptType, uint32 param);
    void   SaveJobChangeGear(CCharEntity* PChar);
    void   LoadJobChangeGear(CCharEntity* PChar);
    void   EquipItem(CCharEntity* PChar, uint8 slotID, uint8 equipSlotID, uint8 containerID);
    void   UnequipItem(CCharEntity* PChar, uint8 equipSlotID,
                       bool update = true); // call with update == false to prevent calls to UpdateHealth() - used for correct handling of stats on armor swaps
    bool   hasSlotEquipped(CCharEntity* PChar, uint8 equipSlotID);
    void   RemoveSub(CCharEntity* PChar);
    bool   EquipArmor(CCharEntity* PChar, uint8 slotID, uint8 equipSlotID, uint8 containerID);
    void   CheckUnarmedWeapon(CCharEntity* PChar);
    void   SetStyleLock(CCharEntity* PChar, bool isStyleLocked);
    void   UpdateWeaponStyle(CCharEntity* PChar, uint8 equipSlotID, CItemEquipment* PItem);
    void   UpdateArmorStyle(CCharEntity* PChar, uint8 equipSlotID);
    void   UpdateRemovedSlotsLookForLockStyle(CCharEntity* PChar);
    void   UpdateRemovedSlotsLook(CCharEntity* PChar);
    void   AddItemToRecycleBin(CCharEntity* PChar, uint32 container, uint8 slotID, uint8 quantity);
    void   EmptyRecycleBin(CCharEntity* PChar);

    bool hasKeyItem(CCharEntity* PChar, uint16 KeyItemID);    // checking the presence of a key item
    bool seenKeyItem(CCharEntity* PChar, uint16 KeyItemID);   // checking whether the description of the key item has been read
    void unseenKeyItem(CCharEntity* PChar, uint16 KeyItemID); // attempt to remove keyitem from seen list
    void addKeyItem(CCharEntity* PChar, uint16 KeyItemID);    // add a key item
    void delKeyItem(CCharEntity* PChar, uint16 KeyItemID);    // delete a key item

    int32 hasSpell(CCharEntity* PChar, uint16 SpellID); // checking for the presence of a spell
    int32 addSpell(CCharEntity* PChar, uint16 SpellID); // add a spell
    int32 delSpell(CCharEntity* PChar, uint16 SpellID); // delete a spell

    int32 hasLearnedAbility(CCharEntity* PChar, uint16 AbilityID); // checking for the presence of a learned ability
    int32 addLearnedAbility(CCharEntity* PChar, uint16 AbilityID); // add a learned ability
    int32 delLearnedAbility(CCharEntity* PChar, uint16 AbilityID); // delete a learned ability

    bool hasLearnedWeaponskill(CCharEntity* PChar, uint8 wsUnlockId);
    void addLearnedWeaponskill(CCharEntity* PChar, uint8 wsUnlockId);
    void delLearnedWeaponskill(CCharEntity* PChar, uint8 wsUnlockId);

    int32 hasAbility(CCharEntity* PChar, uint16 AbilityID); // checking the presence of an ability
    int32 addAbility(CCharEntity* PChar, uint16 AbilityID); // add an ability
    int32 delAbility(CCharEntity* PChar, uint16 AbilityID); // delete an ability

    int32 hasTitle(CCharEntity* PChar, uint16 Title);
    int32 addTitle(CCharEntity* PChar, uint16 Title);
    int32 delTitle(CCharEntity* PChar, uint16 Title);
    void  setTitle(CCharEntity* PChar, uint16 Title); // set title if not, save and update player

    int32 hasPetAbility(CCharEntity* PChar, uint16 AbilityID); // same as Ability but for pet commands (e.g. Healing Ruby)
    int32 addPetAbility(CCharEntity* PChar, uint16 AbilityID);
    int32 delPetAbility(CCharEntity* PChar, uint16 AbilityID);

    int32 hasTrait(CCharEntity* PChar, uint16 TraitID); // check if pchar has trait by traitid and jobid
    int32 addTrait(CCharEntity* PChar, uint16 TraitID); // add trait by traitid and jobid
    int32 delTrait(CCharEntity* PChar, uint16 TraitID); // delete trait by traitid and jobid

    int32 addWeaponSkill(CCharEntity* PChar, uint16 WeaponSkillID); // declaration of function to add weapon skill
    int32 hasWeaponSkill(CCharEntity* PChar, uint16 WeaponSkillID); // declaration of function to check for weapon skill
    int32 delWeaponSkill(CCharEntity* PChar, uint16 WeaponSkillID); // declaration of function to delete weapon skill
    bool  canUseWeaponSkill(CCharEntity* PChar, uint16 wsid);

    void SaveCharJob(CCharEntity* PChar, JOBTYPE job); // save the level for the selected character's jobs
    void SaveCharExp(CCharEntity* PChar, JOBTYPE job); // save experience for the selected character’s chosen job
    void SaveCharEquip(CCharEntity* PChar);            // preserve the character’s equipment and appearance
    void SaveCharLook(CCharEntity* PChar);             // saves a character's appearance based on style locking
    void SaveCharPosition(CCharEntity* PChar);         // save the character's position (x/y/z)
    // void SaveCharLinkshells(CCharEntity* PChar);     // TODO: save the character's linkshells
    void SaveMissionsList(CCharEntity* PChar);          // save the missions list
    void SaveEminenceData(CCharEntity* PChar);          // save Eminence Record (RoE) data
    void SaveQuestsList(CCharEntity* PChar);            // save the list of quests
    void SaveFame(CCharEntity* PChar);                  // save area fame / reputation
    void SaveZonesVisited(CCharEntity* PChar);          // save visited areas
    void SaveKeyItems(CCharEntity* PChar);              // save key items
    void SaveCharInventoryCapacity(CCharEntity* PChar); // save Character inventory capacity
    void SaveSpell(CCharEntity* PChar, uint16 spellID); // save learned spells
    void DeleteSpell(CCharEntity* PChar, uint16 spellID);
    void SaveLearnedAbilities(CCharEntity* PChar);             // save learned abilities (e.g., corsair rolls)
    void SaveTitles(CCharEntity* PChar);                       // save character's titles
    void SaveCharStats(CCharEntity* PChar);                    // save flags, current values of character stats (jobs/HP/MP/etc.)
    void SaveCharGMLevel(CCharEntity* PChar);                  // save the character's gm level
    void SaveMentorFlag(CCharEntity* PChar);                   // save the character's mentor flag
    void SaveJobMasterDisplay(CCharEntity* PChar);             // Save the character's job master display status
    void SavePlayerSettings(CCharEntity* PChar);               // save the character's settings
    void SaveChatFilterFlags(CCharEntity* PChar);              // save the character's chat filters
    void SaveLanguages(CCharEntity* PChar);                    // save the character's language preference
    void SaveCharNation(CCharEntity* PChar);                   // save the character's nation of allegiance
    void SaveCampaignAllegiance(CCharEntity* PChar);           // save the character's campaign allegiance
    void SaveCharMoghancement(CCharEntity* PChar);             // save the character's current moghancement
    void SaveCharSkills(CCharEntity* PChar, uint8 skillID);    // save the character's skills
    void SaveTeleport(CCharEntity* PChar, TELEPORT_TYPE type); // save the character's teleports (homepoints, outposts, maws, etc)
    void SaveDeathTime(CCharEntity* PChar);                    // save when this character last died
    void SavePlayTime(CCharEntity* PChar);                     // save this character's total play time
    bool hasMogLockerAccess(CCharEntity* PChar);               // true if have access, false otherwise

    uint8 getQuestStatus(CCharEntity* PChar, uint8 log, uint8 quest); // Get Quest status (used in FishingUtils.cpp, allows to fish quest specific mobs, like PLD AF NM)

    float AddExpBonus(CCharEntity* PChar, float exp);

    void RemoveAllEquipment(CCharEntity* PChar);

    uint16 AvatarPerpetuationReduction(CCharEntity* PChar);

    void OpenSendBox(CCharEntity* PChar, uint8 action, uint8 boxtype);
    void OpenRecvBox(CCharEntity* PChar, uint8 action, uint8 boxtype);
    bool isSendBoxOpen(CCharEntity* PChar);
    bool isRecvBoxOpen(CCharEntity* PChar);
    bool isAnyDeliveryBoxOpen(CCharEntity* PChar);

    bool CheckAbilityAddtype(CCharEntity* PChar, CAbility* PAbility);

    void RemoveStratagems(CCharEntity* PChar, CSpell* PSpell);

    void RemoveAllEquipMods(CCharEntity* PChar);
    void ApplyAllEquipMods(CCharEntity* PChar);

    void ClearTempItems(CCharEntity* PChar);
    void ReloadParty(CCharEntity* PChar);

    bool IsAidBlocked(CCharEntity* PInitiator, CCharEntity* PTarget);

    void  AddPoints(CCharEntity* PChar, const char* type, int32 amount, int32 max = INT32_MAX);
    void  SetPoints(CCharEntity* PChar, const char* type, int32 amount);
    int32 GetPoints(CCharEntity* PChar, const char* type);
    void  SetUnityLeader(CCharEntity* PChar, uint8 leaderID);
    auto  GetConquestPointsName(CCharEntity* PChar) -> std::string;
    void  SendToZone(CCharEntity* PChar, uint8 type, uint64 ipp);
    void  ForceLogout(CCharEntity* PChar);
    void  ForceRezone(CCharEntity* PChar);
    void  HomePoint(CCharEntity* PChar, bool resetHPMP);
    bool  AddWeaponSkillPoints(CCharEntity*, SLOTTYPE, int);

    int32 GetCharVar(CCharEntity* PChar, std::string const& var);
    void  SetCharVar(uint32 charId, std::string const& var, int32 value, uint32 expiry = 0);
    void  SetCharVar(CCharEntity* PChar, std::string const& var, int32 value, uint32 expiry = 0);
    int32 ClearCharVarsWithPrefix(CCharEntity* PChar, std::string const& prefix);
    int32 RemoveCharVarsWithTag(CCharEntity* PChar, std::string const& varsTag);
    void  ClearCharVarFromAll(std::string const& varName, bool localOnly = false);
    void  IncrementCharVar(CCharEntity* PChar, std::string const& var, int32 value);

    auto FetchCharVar(uint32 charId, std::string const& var) -> std::pair<int32, uint32>;
    void PersistCharVar(uint32 charId, std::string const& var, int32 value, uint32 expiry = 0);

    uint16 getWideScanRange(JOBTYPE job, uint8 level);
    uint16 getWideScanRange(CCharEntity* PChar);

    void SendTimerPacket(CCharEntity* PChar, uint32 seconds);
    void SendTimerPacket(CCharEntity* PChar, duration dur);
    void SendClearTimerPacket(CCharEntity* PChar);

    time_t getTraverserEpoch(CCharEntity* PChar);
    void   setTraverserEpoch(CCharEntity* PChar);
    uint32 getClaimedTraverserStones(CCharEntity* PChar);
    void   addClaimedTraverserStones(CCharEntity* PChar, uint16 numStones);
    void   setClaimedTraverserStones(CCharEntity* PChar, uint16 stoneTotal);
    uint32 getAvailableTraverserStones(CCharEntity* PChar);

    void ReadHistory(CCharEntity* PChar);
    void WriteHistory(CCharEntity* PChar);

    uint8 getMaxItemLevel(CCharEntity* PChar);
    uint8 getItemLevelDifference(CCharEntity* PChar);
    uint8 getMainhandItemLevel(CCharEntity* PChar);
    uint8 getRangedItemLevel(CCharEntity* PChar);

    bool hasEntitySpawned(CCharEntity* PChar, CBaseEntity* entity);

    auto getCharIdFromName(const std::string& name) -> uint32;
    auto getAccountIdFromName(const std::string& name) -> uint32;
    auto getCharIdAndAccountIdFromName(const std::string& name) -> std::pair<uint32, uint32>;

    void forceSynthCritFail(const std::string& sourceFunction, CCharEntity* PChar);

    void removeCharFromZone(CCharEntity* PChar);

    bool isOrchestrionPlaced(CCharEntity* PChar);
}; // namespace charutils

#endif // _CHARUTILS_H
