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

#include "../../common/cbasetypes.h"

#include "../entities/charentity.h"
#include "../items/item_equipment.h"
#include "../trait.h"

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

namespace charutils
{
    void LoadExpTable();
    void LoadChar(CCharEntity* PChar);
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

    uint32 GetRealExp(uint8 charlvl, uint8 moblvl);
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
    uint8  AddItem(CCharEntity* PChar, uint8 LocationID, CItem* PItem, bool silence = false);
    uint8  AddItem(CCharEntity* PChar, uint8 LocationID, uint16 itemID, uint32 quantity = 1, bool silence = false);
    uint8  MoveItem(CCharEntity* PChar, uint8 LocationID, uint8 SlotID, uint8 NewSlotID);
    uint32 UpdateItem(CCharEntity* PChar, uint8 LocationID, uint8 slotID, int32 quantity, bool force = false);
    void   CheckValidEquipment(CCharEntity* PChar);
    void   CheckEquipLogic(CCharEntity* PChar, SCRIPTTYPE ScriptType, uint32 param);
    void   EquipItem(CCharEntity* PChar, uint8 slotID, uint8 equipSlotID, uint8 containerID);
    void   UnequipItem(CCharEntity* PChar, uint8 equipSlotID,
                       bool update = true); // call with update == false to prevent calls to UpdateHealth() - used for correct handling of stats on armor swaps
    void   RemoveSub(CCharEntity* PChar);
    bool   EquipArmor(CCharEntity* PChar, uint8 slotID, uint8 equipSlotID, uint8 containerID);
    void   CheckUnarmedWeapon(CCharEntity* PChar);
    void   SetStyleLock(CCharEntity* PChar, bool isStyleLocked);
    void   UpdateWeaponStyle(CCharEntity* PChar, uint8 equipSlotID, CItemWeapon* PItem);
    void   UpdateArmorStyle(CCharEntity* PChar, uint8 equipSlotID);

    bool hasKeyItem(CCharEntity* PChar, uint16 KeyItemID);    // проверяем наличие ключевого предмета
    bool seenKeyItem(CCharEntity* PChar, uint16 KeyItemID);   // проверяем, было ли описание ключевого предмета прочитано
    void unseenKeyItem(CCharEntity* PChar, uint16 KeyItemID); // Attempt to remove keyitem from seen list
    void addKeyItem(CCharEntity* PChar, uint16 KeyItemID);    // добавляем ключевой предмет
    void delKeyItem(CCharEntity* PChar, uint16 KeyItemID);    // улаляем ключевой предмет

    int32 hasSpell(CCharEntity* PChar, uint16 SpellID); // проверяем наличие заклинания
    int32 addSpell(CCharEntity* PChar, uint16 SpellID); // добавляем заклинание
    int32 delSpell(CCharEntity* PChar, uint16 SpellID); // улаляем заклинание

    int32 hasLearnedAbility(CCharEntity* PChar, uint16 AbilityID); // проверяем наличие заклинания
    int32 addLearnedAbility(CCharEntity* PChar, uint16 AbilityID); // добавляем заклинание
    int32 delLearnedAbility(CCharEntity* PChar, uint16 AbilityID); // улаляем заклинание

    bool hasLearnedWeaponskill(CCharEntity* PChar, uint8 wsid);
    void addLearnedWeaponskill(CCharEntity* PChar, uint8 wsid);
    void delLearnedWeaponskill(CCharEntity* PChar, uint8 wsid);

    int32 hasAbility(CCharEntity* PChar, uint16 AbilityID); // проверяем наличие ключевого предмета
    int32 addAbility(CCharEntity* PChar, uint16 AbilityID); // добавляем ключевой предмет
    int32 delAbility(CCharEntity* PChar, uint16 AbilityID); // улаляем ключевой предмет

    int32 hasTitle(CCharEntity* PChar, uint16 Title);
    int32 addTitle(CCharEntity* PChar, uint16 Title);
    int32 delTitle(CCharEntity* PChar, uint16 Title);
    void  setTitle(CCharEntity* PChar, uint16 Title); // set title if not, save and update player

    int32 hasPetAbility(CCharEntity* PChar, uint16 AbilityID); // same as Ability but for pet commands (e.g. Healing Ruby)
    int32 addPetAbility(CCharEntity* PChar, uint16 AbilityID);
    int32 delPetAbility(CCharEntity* PChar, uint16 AbilityID);

    int32 hasTrait(CCharEntity* PChar, uint8 TraitID); // check if pchar has trait by traitid and jobid
    int32 addTrait(CCharEntity* PChar, uint8 TraitID); // add trait by traitid and jobid
    int32 delTrait(CCharEntity* PChar, uint8 TraitID); // delete trait by traitid and jobid

    int32 addWeaponSkill(CCharEntity* PChar, uint16 WeaponSkillID); // declaration of function to add weapon skill
    int32 hasWeaponSkill(CCharEntity* PChar, uint16 WeaponSkillID); // declaration of function to check for weapon skill
    int32 delWeaponSkill(CCharEntity* PChar, uint16 WeaponSkillID); // declaration of function to delete weapon skill

    void SaveCharJob(CCharEntity* PChar, JOBTYPE job);  // сохраняем уровень для выбранной профессий персонажа
    void SaveCharExp(CCharEntity* PChar, JOBTYPE job);  // сохраняем опыт для выбранной профессии персонажа
    void SaveCharEquip(CCharEntity* PChar);             // сохраняем экипировку и внешний вид персонажа
    void SaveCharLook(CCharEntity* PChar);              // Saves a character's appearance based on style locking.
    void SaveCharPosition(CCharEntity* PChar);          // сохраняем позицию персонажа
    void SaveMissionsList(CCharEntity* PChar);          // Save the missions list
    void SaveEminenceData(CCharEntity* PChar);          // Save Eminence Record (RoE) data
    void SaveQuestsList(CCharEntity* PChar);            // сохраняем список ксевтов
    void SaveFame(CCharEntity* PChar);                  // Save area fame / reputation
    void SaveZonesVisited(CCharEntity* PChar);          // сохраняем посещенные зоны
    void SaveKeyItems(CCharEntity* PChar);              // сохраняем ключевые предметы
    void SaveCharInventoryCapacity(CCharEntity* PChar); // Save Character inventory capacity
    void SaveSpell(CCharEntity* PChar, uint16 spellID); // сохраняем выученные заклинания
    void DeleteSpell(CCharEntity* PChar, uint16 spellID);
    void SaveLearnedAbilities(CCharEntity* PChar);             // saved learned abilities (corsair rolls)
    void SaveTitles(CCharEntity* PChar);                       // сохраняем заслуженные звания
    void SaveCharStats(CCharEntity* PChar);                    // сохраняем флаги, текущие значения жихней, маны и профессий
    void SaveCharGMLevel(CCharEntity* PChar);                  // saves the char's gm level and nameflags
    void SaveMentorFlag(CCharEntity* PChar);                   // saves the char's mentor flag
    void SaveJobMasterDisplay(CCharEntity* PChar);             // Saves the char's job master display status
    void SaveMenuConfigFlags(CCharEntity* PChar);              // saves the char's unnamed flags
    void SaveCharNation(CCharEntity* PChar);                   // Save the character's nation of allegiance.
    void SaveCampaignAllegiance(CCharEntity* PChar);           // Save the character's campaign allegiance.
    void SaveCharMoghancement(CCharEntity* PChar);             // Save the character's current moghancement
    void SaveCharSkills(CCharEntity* PChar, uint8 skillID);    // сохраняем указанный skill персонажа
    void SaveTeleport(CCharEntity* PChar, TELEPORT_TYPE type); // Homepoints, outposts, etc
    void SaveDeathTime(CCharEntity* PChar);                    // Saves when this character last died.
    void SavePlayTime(CCharEntity* PChar);                     // Saves this characters total play time.
    bool hasMogLockerAccess(CCharEntity* PChar);               // true if have access, false otherwise.

    float AddExpBonus(CCharEntity* PChar, float exp);

    void RemoveAllEquipment(CCharEntity* PChar);

    uint16 AvatarPerpetuationReduction(CCharEntity* PChar);

    void OpenSendBox(CCharEntity* PChar);

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
    void  HomePoint(CCharEntity* PChar);
    bool  AddWeaponSkillPoints(CCharEntity*, SLOTTYPE, int);

    int32 GetCharVar(CCharEntity* PChar, const char* var);
    void  SetCharVar(CCharEntity* PChar, const char* var, int32 value);
    void ClearCharVarsWithPrefix(CCharEntity* PChar, std::string prefix);

    uint16 getWideScanRange(JOBTYPE job, uint8 level);
    uint16 getWideScanRange(CCharEntity* PChar);

    void SendTimerPacket(CCharEntity* PChar, uint32 seconds);
    void SendTimerPacket(CCharEntity* PChar, duration dur);
    void SendClearTimerPacket(CCharEntity* PChar);
}; // namespace charutils

#endif // _CHARUTILS_H
