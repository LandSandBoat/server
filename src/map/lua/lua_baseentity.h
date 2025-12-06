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

#ifndef _CLUABASEENTITY_H
#define _CLUABASEENTITY_H

#include "common/cbasetypes.h"
#include "enums/mission_log.h"
#include "luautils.h"
#include "packets/s2c/0x009_message.h"
#include "utils/battleutils.h"
#include "utils/charutils.h"

enum class QuestLog : uint8_t;
enum class POSMODE : uint8;
enum class MusicSlot : uint16_t;
enum class ChocoboColor : uint8_t;
class CBaseEntity;
class CCharEntity;
class CLuaBattlefield;
class CLuaInstance;
class CLuaItem;
class CLuaSpell;
class CLuaStatusEffect;
class CLuaTradeContainer;
class CLuaZone;

class CLuaBaseEntity
{
protected:
    CBaseEntity* m_PBaseEntity;

public:
    CLuaBaseEntity(CBaseEntity*);

    CBaseEntity* GetBaseEntity() const
    {
        return m_PBaseEntity;
    }

    friend std::ostream& operator<<(std::ostream& out, const CLuaBaseEntity& entity);

    // Messaging System
    void showText(CLuaBaseEntity* entity, uint16 messageID, const sol::object& p0, const sol::object& p1, const sol::object& p2, const sol::object& p3, const sol::object& p4, const sol::object& p5);
    void messageText(CLuaBaseEntity* PLuaBaseEntity, uint16 messageID, const sol::object& arg2, const sol::object& arg3);
    void printToPlayer(const std::string& message, const sol::object& messageTypeObj, const sol::object& nameObj);
    void printToArea(const std::string& message, const sol::object& arg1, const sol::object& arg2, const sol::object& arg3, const sol::object& arg4);
    void messageBasic(uint16 messageID, const sol::object& p0, const sol::object& p1, const sol::object& target);
    void messageName(uint16 messageID, const sol::object& entity, const sol::object& p0, const sol::object& p1, const sol::object& p2, const sol::object& p3, const sol::object& chat);
    void messagePublic(uint16 messageID, const CLuaBaseEntity* PEntity, const sol::object& arg2, const sol::object& arg3);
    void messageSpecial(uint16 messageID, sol::variadic_args va);
    void messageSystem(MsgStd messageID, const sol::object& p0, const sol::object& p1);
    void messageCombat(const sol::object& speaker, int32 p0, int32 p1, int16 message);
    void messageStandard(uint16 messageID);

    void customMenu(const sol::object& obj);

    // Variables
    int32  getCharVar(const std::string& varName);
    auto   getCharVarsWithPrefix(const std::string& prefix) -> sol::table;
    void   setCharVar(const std::string& varname, int32 value, const sol::object& expiry);
    void   setCharVarExpiration(const std::string& varName, uint32 expiry); // Sets character variable expiration timestamp
    void   incrementCharVar(const std::string& varname, int32 value);       // Increments/decrements/sets a character variable
    void   setVolatileCharVar(const std::string& varName, int32 value, const sol::object& expiry);
    auto   getLocalVars() -> sol::table;
    uint32 getLocalVar(const std::string& var);
    void   setLocalVar(const std::string& var, uint32 val);
    void   clearLocalVarsWithPrefix(const std::string& prefix);
    void   resetLocalVars();
    void   clearVarsWithPrefix(const std::string& prefix);
    uint32 getLastOnline(); // Returns the unix timestamp of last time the player logged out or zoned

    // Packets, Events, and Flags
    void injectPacket(const std::string& filename); // Send the character a packet kept in a file
    void injectActionPacket(uint32 inTargetID, uint16 inCategory, uint16 inAnimationID, uint16 inInfo, uint16 inReaction, uint16 inMessage, uint16 inActionParam, uint16 inParam) const;
    void entityVisualPacket(const std::string& command, const sol::object& entity) const;
    void entityAnimationPacket(const char* command, const sol::object& target);
    void sendDebugPacket(const sol::table& packetData);

    void       StartEventHelper(int32 EventID, sol::variadic_args va, EVENT_TYPE eventType);
    EventInfo* ParseEvent(int32 EventID, sol::variadic_args va, EventPrep* eventPreparation, EVENT_TYPE eventType);
    void       startEvent(int32 EventID, sol::variadic_args va);
    void       startEventString(int32 EventID, sol::variadic_args va);      // Begins Event with string param (0x33 packet)
    void       startCutscene(int32 EventID, sol::variadic_args va);         // Begins cutscene which locks the character
    void       startOptionalCutscene(int32 EventID, sol::variadic_args va); // Begins an event that can turn into a cutscene

    void updateEvent(sol::variadic_args va);
    void updateEventString(sol::variadic_args va); // (string, string, string, string, uint32, ...)
    auto getEventTarget() -> CBaseEntity*;
    bool isInEvent();       // Returns true if the player is in an event
    void release();         // Stops event
    bool startSequence();   // Flags the player as being in a sequence
    bool didGetMessage();   // Used by interaction framework to determine if player triggered something else
    void resetGotMessage(); // Used by interaction framework to reset if player triggered something else

    uint16 getMoghouseFlag();
    void   setMoghouseFlag(uint16 flag);
    bool   needToZone(const sol::object& arg0);

    // Object Identification
    uint32 getID();
    uint16 getTargID();
    auto   getCursorTarget() -> CBaseEntity*;

    uint8 getObjType() const;

    bool isPC() const;
    bool isNPC() const;
    bool isMob() const;
    bool isPet() const;
    bool isTrust() const;
    bool isFellow() const;
    bool isAlly() const;

    // AI and Control
    void  initNpcAi();
    void  resetAI();
    uint8 getStatus();
    void  setStatus(uint8 status);
    uint8 getCurrentAction();
    bool  canUseAbilities();

    void lookAt(const sol::object& arg0, const sol::object& arg1, const sol::object& arg2);
    void facePlayer(CLuaBaseEntity* PLuaBaseEntity, const sol::object& nonGlobal);
    void clearTargID();

    bool  atPoint(sol::variadic_args va);                                          // is at given point
    void  pathTo(float x, float y, float z, const sol::object& flags);             // set new path to point without changing action
    bool  pathThrough(const sol::table& pointsTable, const sol::object& flagsObj); // walk at normal speed through the given points
    bool  isFollowingPath();                                                       // checks if the entity is following a path
    void  clearPath(const sol::object& pauseObj);                                  // removes current pathfind and stops moving
    void  continuePath();                                                          // resumes previous pathfind if it was paused
    float checkDistance(sol::variadic_args va);                                    // Check Distance and returns distance number
    void  wait(const sol::object& milliseconds);                                   // make the npc wait a number of ms and then back into roam
    void  follow(CLuaBaseEntity* target, uint8 followType);                        // makes an npc follow or runaway from another target
    bool  hasFollowTarget();                                                       // checks if the mob has a target that it is currently following (via follow function)
    void  unfollow();                                                              // makes an npc stop following
    // int32 WarpTo(lua_Stat* L);           // warp to the given point -- These don't exist, breaking them just in case someone uncomments
    // int32 RoamAround(lua_Stat* L);       // pick a random point to walk to
    // int32 LimitDistance(lua_Stat* L);    // limits the current path distance to given max distance
    void setCarefulPathing(bool careful);

    void openDoor(const sol::object& seconds);
    void closeDoor(const sol::object& seconds);
    void setElevator(uint8 id, uint32 lowerDoor, uint32 upperDoor, uint32 elevatorId, bool reversed);

    void addPeriodicTrigger(uint8 id, uint16 period, uint16 minOffset); // Adds a periodic trigger to the NPC that allows time based scripting
    void showNPC(const sol::object& seconds);
    void hideNPC(const sol::object& seconds);
    void updateNPCHideTime(const sol::object& seconds); // Updates the length of time a NPC remains hidden, if shorter than the original hide time.

    auto getWeather(const sol::object& ignoreScholar) const -> uint8;
    void setWeather(Weather weatherType); // Set Weather condition (GM COMMAND)

    // PC Instructions
    void changeMusic(MusicSlot slotId, uint16 trackId) const;                             // Sets the specified music Track for specified music block.
    void sendMenu(uint32 menu);                                                           // Displays a menu (AH,Raise,Tractor,MH etc)
    auto sendGuild(uint16 guildId, uint8 open, uint8 close, uint8 holiday) const -> bool; // Sends guild shop menu
    void openSendBox() const;                                                             // Opens send box (to deliver items)
    void leaveGame();
    void sendEmote(const CLuaBaseEntity* target, uint8 emID, uint8 emMode) const;

    // Location and Positioning
    int16 getWorldAngle(sol::variadic_args va);                                                // return angle (rot) between two points (vector from a to b), aligned to absolute cardinal degree
    int16 getFacingAngle(const CLuaBaseEntity* target);                                        // return angle between entity rot and target pos, aligned to number of degrees of difference
    bool  isFacing(const CLuaBaseEntity* target, const sol::object& angleArg);                 // true if you are facing the target
    bool  isInfront(const CLuaBaseEntity* target, const sol::object& angleArg);                // true if you're infront of the input target
    bool  isBehind(const CLuaBaseEntity* target, const sol::object& angleArg);                 // true if you're behind the input target
    bool  isBeside(const CLuaBaseEntity* target, const sol::object& angleArg);                 // true if you're to the side of the input target
    auto  isToEntitysLeft(const CLuaBaseEntity* target, const sol::object& angleArg) -> bool;  // true if you're to the left side of the input target (from target's perspective)
    auto  isToEntitysRight(const CLuaBaseEntity* target, const sol::object& angleArg) -> bool; // true if you're to the right side of the input target (from target's perspective)

    auto   getZone(const sol::object& arg0) -> CZone*;
    uint16 getZoneID();
    auto   getZoneName() -> std::string;
    bool   hasVisitedZone(uint16 zone);
    uint16 getPreviousZone();
    uint32 getPreviousZoneLineID();
    uint8  getCurrentRegion();
    uint8  getContinentID();
    bool   isInMogHouse();

    bool isPlayerInTriggerArea(uint32 triggerAreaId);
    void onPlayerTriggerAreaEnter(uint32 triggerAreaId);
    void onPlayerTriggerAreaLeave(uint32 triggerAreaId);
    void clearPlayerTriggerAreas();

    void updateToEntireZone(uint8 statusID, uint8 animation, const sol::object& matchTime); // Forces an update packet to update the NPC entity zone-wide
    void sendEntityUpdateToPlayer(CLuaBaseEntity* entityToUpdate, uint8 entityUpdate, uint8 updateMask);
    void sendEmptyEntityUpdateToPlayer(CLuaBaseEntity* entityToUpdate);

    void forceRezone();
    void forceLogout();

    auto  getPos() -> sol::table;
    void  showPosition();
    float getXPos();
    float getYPos();
    float getZPos();
    uint8 getRotPos();
    void  setRotation(uint8 rotation);

    void positionSpecial(std::map<std::string, float> pos, POSMODE mode);
    void setPos(sol::variadic_args va);
    void warp();
    void teleport(std::map<std::string, float> pos, const sol::object& arg1); // Set Entity position (without entity despawn/spawn packets)

    void   addTeleport(uint8 teleType, uint32 bitval, const sol::object& setval); // Add new teleport means to char unlocks
    uint32 getTeleport(uint8 type, const sol::object& abysseaRegionObj);          // Get unlocked teleport means
    auto   getTeleportTable(uint8 type) -> sol::table;
    bool   hasTeleport(uint8 tType, uint8 bit, const sol::object& arg2);
    void   setTeleportMenu(uint16 type, const sol::object& teleportObj);
    auto   getTeleportMenu(uint8 type) -> sol::table;
    void   setHomePoint();

    void resetPlayer(const char* charName);

    void gotoEntity(uint32 targetID, const sol::object& option);
    bool gotoPlayer(const std::string& playerName);
    bool bringPlayer(const std::string& playerName);

    // Items
    uint16 getEquipID(SLOTTYPE slot);
    auto   getEquippedItem(uint8 slot) -> CItem*;
    bool   hasEquipped(uint16 equipmentID); // Returns true if item is equipped in any slot
    bool   hasItem(uint16 itemID, const sol::object& location);
    uint32 getItemCount(uint16 itemID);
    bool   addItem(sol::variadic_args va);
    bool   delItem(uint16 itemID, int32 quantity, const sol::object& containerID);
    bool   delItemAt(uint16 itemID, int32 quantity, uint8 containerId, uint8 slotId);
    bool   delContainerItems(const sol::object& containerID);
    bool   addUsedItem(uint16 itemID);
    bool   addTempItem(uint16 itemID, const sol::object& arg1);
    uint8  getWornUses(uint16 itemID);                                     // Check if the item is already worn
    uint8  incrementItemWear(uint16 itemID);                               // Increment the item's worn value and returns it
    auto   findItem(uint16 itemID, const sol::object& location) -> CItem*; // Like hasItem, but returns the item object (nil if not found)
    auto   findItems(uint16 itemID, const sol::object& location) -> sol::table;
    auto   getItems(const sol::object& location) -> sol::table;

    void createShop(uint8 size, const sol::object& arg1);
    void addShopItem(uint16 itemID, double rawPrice, const sol::object& arg2, const sol::object& arg3);
    auto getCurrentGPItem(uint8 guildId) const -> std::tuple<uint16, uint16>;
    bool breakLinkshell(const std::string& lsname);
    bool addLinkpearl(const std::string& lsname, bool equip);

    auto addSoulPlate(const std::string& name, uint32 interestData, uint8 zeni, uint16 skillIndex, uint8 fp) -> CItem*;

    // Trading
    uint8 getContainerSize(uint8 locationID);
    void  changeContainerSize(uint8 locationID, int8 newSize); // Increase/Decreases container size
    uint8 getFreeSlotsCount(const sol::object& locID);         // Gets value of free slots in Entity inventory
    void  confirmTrade() const;                                // Complete trade with an npc, only removing confirmed items
    void  tradeComplete() const;                               // Complete trade with an npc
    auto  getTrade() -> CTradeContainer*;

    // Equipping
    bool canEquipItem(uint16 itemID, const sol::object& chkLevel);
    void equipItem(uint16 itemID, const sol::object& container, const sol::object& equipSlot) const;
    void unequipItem(uint8 slotID);

    void setEquipBlock(uint16 equipBlock);
    void lockEquipSlot(uint8 slot);
    void unlockEquipSlot(uint8 slot);
    bool hasSlotEquipped(uint8 slot);

    int8  getShieldSize();
    int16 getShieldDefense();

    void addGearSetMod(uint8 setId, Mod modId, uint16 modValue);
    void clearGearSetMods();

    // Storing
    auto  getStorageItem(uint8 container, uint8 slotID, uint8 equipID) -> CItem*;
    uint8 storeWithPorterMoogle(uint16 slipId, const sol::table& extraTable, const sol::table& storableItemIdsTable);
    auto  getRetrievableItemsForSlip(uint16 slipId) const -> sol::table;
    void  retrieveItemFromSlip(uint16 slipId, uint16 itemId, uint16 extraId, uint8 extraData);

    // Player Appearance
    uint8  getRace();
    uint8  getFace();
    uint8  getGender();
    uint8  getSize();
    bool   raceChange(CharRace newRace, CharFace newFace, CharSize newSize);
    auto   getName() -> std::string;
    auto   getPacketName() -> std::string;
    void   renameEntity(const std::string& newName, const sol::object& arg2);
    void   hideName(bool isHidden);
    uint16 getModelId();
    void   setModelId(uint16 modelId, const sol::object& slotObj);
    void   setLook(const sol::table& look);
    uint16 getCostume();
    void   setCostume(uint16 costume);
    uint16 getCostume2();
    void   setCostume2(uint16 costume);
    uint8  getAnimation();
    void   setAnimation(uint8 animation);
    uint8  getAnimationSub();
    void   setAnimationSub(uint8 animationsub, const sol::object& sendUpdate);
    void   setSpawnAnimation(uint8 spawnAnimation);
    bool   getCallForHelpFlag() const;
    void   setCallForHelpFlag(bool cfh);
    bool   getCallForHelpBlocked() const;
    void   setCallForHelpBlocked(bool blocked);

    // Player Status
    uint8 getNation();
    void  setNation(uint8 nation);
    uint8 getAllegiance();
    void  setAllegiance(uint8 allegiance);

    uint8 getCampaignAllegiance();
    void  setCampaignAllegiance(uint8 allegiance);

    bool isSeekingParty();
    bool getNewPlayer();
    void setNewPlayer(bool newplayer);
    auto getMentor() const -> bool;
    void setMentor(bool mentor) const;

    uint8 getGMLevel();
    void  setGMLevel(uint8 level);
    void  setVisibleGMLevel(uint8 level);
    uint8 getVisibleGMLevel();
    bool  getGMHidden();
    void  setGMHidden(bool isHidden);
    bool  getWallhack();
    void  setWallhack(bool enable);
    void  setFreezeFlag(bool isFrozen);

    bool isJailed();
    void jail();

    bool canUseMisc(uint16 misc); // Check misc flags of current zone.

    uint8 getSpeed();
    uint8 getBaseSpeed();
    void  setBaseSpeed(uint8 speedVal);
    void  setAnimationSpeed(uint8 speedVal);

    uint32 getPlaytime(const sol::object& shouldUpdate);
    uint32 getTimeCreated();

    // Player Jobs and Levels
    uint8 getMainJob();
    uint8 getSubJob();
    void  changeJob(uint8 newJob);
    void  changesJob(uint8 subJob);
    void  unlockJob(uint8 JobID);
    bool  hasJob(uint8 job);

    uint8 getMainLvl();
    uint8 getSubLvl();
    uint8 getJobLevel(uint8 JobID); // Gets character job level for specified JOBTYPE
    void  setLevel(uint8 level);    // sets the character's mainjob level
    void  setsLevel(uint8 slevel);  // sets the character's subjob level
    uint8 getLevelCap();            // genkai
    void  setLevelCap(uint8 cap);
    uint8 levelRestriction(const sol::object& level); // Establish/return current level restriction
    void  addWyvernJobTraits(uint8 jobID, uint8 level);

    // Monstrosity
    auto getMonstrosityData() -> sol::table;
    void setMonstrosityData(sol::table table);
    bool getBelligerencyFlag();
    void setBelligerencyFlag(bool flag);
    auto getMonstrositySize() -> uint8;
    void setMonstrosityEntryData(float x, float y, float z, uint8 rot, uint16 zoneId, uint8 mjob, uint8 sjob);

    // Player Titles and Fame
    uint16 getTitle();
    bool   hasTitle(uint16 titleID);
    void   addTitle(uint16 titleID);
    void   setTitle(uint16 titleID);
    void   delTitle(uint16 titleID);

    uint16 getFame(const sol::object& areaObj);
    void   addFame(const sol::object& areaObj, uint16 fame);
    void   setFame(const sol::object& areaObj, uint16 fame);
    uint8  getFameLevel(const sol::object& areaObj); // Gets Fame Level for specified nation

    uint8  getRank(uint8 nation);
    void   setRank(uint8 rank);
    uint16 getRankPoints();
    void   addRankPoints(uint16 rankpoints);
    void   setRankPoints(uint16 rankpoints);

    void  addQuest(QuestLog logId, uint16 questId) const;
    void  delCurrentQuest(QuestLog logId, uint16 questID) const;
    void  delQuest(QuestLog logId, uint16 questID) const;
    uint8 getQuestStatus(QuestLog logId, uint16 questID) const;
    bool  hasCompletedQuest(QuestLog logId, uint16 questID) const;
    void  completeQuest(QuestLog logId, uint16 questID) const;

    void   addMission(MissionLog logId, uint16 missionID) const;
    void   delMission(MissionLog logId, uint16 missionID) const;
    uint16 getCurrentMission(const sol::object& missionLogObj) const;
    bool   hasCompletedMission(MissionLog logId, uint16 missionID) const;
    void   completeMission(MissionLog logId, uint16 missionID) const;

    void   setMissionStatus(MissionLog logId, const sol::object& arg2Obj, const sol::object& arg3Obj) const;
    uint32 getMissionStatus(MissionLog logId, const sol::object& missionStatusPosObj) const;

    void   setEminenceCompleted(uint16 recordID, const sol::object& arg1, const sol::object& arg2);
    bool   getEminenceCompleted(uint16 recordID);
    uint16 getNumEminenceCompleted();
    bool   setEminenceProgress(uint16 recordID, uint32 progress, const sol::object& arg2);
    auto   getEminenceProgress(uint16 recordID) -> std::optional<uint32>;
    bool   hasEminenceRecord(uint16 recordID);
    void   triggerRoeEvent(uint8 eventNum, const sol::object& reqTable);
    void   setUnityLeader(uint8 leaderID);
    uint8  getUnityLeader();
    auto   getUnityRank(const sol::object& unityObj) -> std::optional<uint8>;
    auto   getClaimedDeedMask() -> sol::table;
    void   toggleReceivedDeedRewards();
    void   setClaimedDeed(uint16 deedBitNum);
    void   resetClaimedDeeds();

    void setUniqueEvent(uint16 uniqueEventId);
    void delUniqueEvent(uint16 uniqueEventId);
    bool hasCompletedUniqueEvent(uint16 uniqueEventId);

    void  addAssault(uint8 missionID) const;
    void  delAssault(uint8 missionID);
    uint8 getCurrentAssault();
    bool  hasCompletedAssault(uint8 missionID);
    void  completeAssault(uint8 missionID) const;

    void addKeyItem(KeyItem keyItemID) const;
    auto hasKeyItem(KeyItem keyItemID) const -> bool;
    void delKeyItem(KeyItem keyItemID) const;
    auto seenKeyItem(KeyItem keyItemID) const -> bool;
    void unseenKeyItem(KeyItem keyItemID) const; // Attempt to remove the keyitem from the seen key item collection, only works on logout

    // Player Points
    void  addExp(uint32 exp);
    void  addCapacityPoints(uint32 capacity);
    void  delExp(uint32 exp);
    int32 getMerit(uint16 merit);
    uint8 getMeritCount();
    void  setMerits(uint8 numPoints);

    uint16 getSpentJobPoints();
    uint8  getJobPointLevel(uint16 jpType);
    void   setJobPoints(uint16 amount);
    void   addJobPoints(uint8 jobID, uint16 amount);
    void   delJobPoints(uint8 jobID, uint16 amount);
    uint16 getJobPoints(JOBTYPE jobID);
    void   setCapacityPoints(uint16 amount);
    void   masterJob();

    uint32 getGil();
    void   addGil(int32 gil);
    void   setGil(int32 amount);
    bool   delGil(int32 gil);

    int32 getCurrency(const std::string& currencyType);
    void  addCurrency(const std::string& currencyType, int32 amount, const sol::object& maxObj);
    void  setCurrency(const std::string& currencyType, int32 amount);
    void  delCurrency(const std::string& currencyType, int32 amount);

    int32 getCP(); // Conquest points, not to be confused with Capacity Points
    void  addCP(int32 cp);
    void  delCP(int32 cp);

    int32 getSeals(uint8 sealType);
    void  addSeals(int32 points, uint8 sealType);
    void  delSeals(int32 points, uint8 sealType);

    int32 getAssaultPoint(uint8 region);
    void  addAssaultPoint(uint8 region, int32 points);
    void  delAssaultPoint(uint8 region, int32 points);

    auto addGuildPoints(uint8 guildId, uint8 slotId) const -> std::tuple<uint8, int16>;

    // Health and Status
    int32 getHP();
    uint8 getHPP();
    int32 getMaxHP();
    int32 getBaseHP();                                                                                                                             // Returns Entity base Hit Points (before modifiers)
    int32 addHP(int32 hpAdd);                                                                                                                      // Increase hp of Entity
    int32 addHPLeaveSleeping(int32 hpAdd);                                                                                                         // Increase hp of Entity but do not awaken the Entity
    void  setHP(int32 value);                                                                                                                      // Set hp of Entity to value
    void  setMaxHP(int32 value);                                                                                                                   // Set max hp of Entity to value
    int32 restoreHP(int32 restoreAmt);                                                                                                             // Modify hp of Entity, but check if alive first
    void  delHP(int32 delAmt);                                                                                                                     // Decrease hp of Entity
    void  takeDamage(int32 damage, const sol::object& attacker, const sol::object& atkType, const sol::object& dmgType, const sol::object& flags); // Takes damage from the provided attacker
    void  hideHP(bool value);
    int32 getDeathType();            // Returns Death Type (for Abyssea)
    void  setDeathType(int32 value); // Sets Death Type (for Abyssea)

    int32 getMP();
    uint8 getMPP();
    int32 getMaxMP();
    int32 getBaseMP();             // Returns Entity base Mana Points (before modifiers)
    int32 addMP(int32 amount);     // Increase mp of Entity
    void  setMP(int32 value);      // Set mp of Entity to value
    void  setMaxMP(int32 value);   // Set max mp of Entity to value
    int32 restoreMP(int32 amount); // Modify mp of Entity, but check if alive first
    int32 delMP(int32 amount);     // Decrease mp of Entity

    float getTP();
    int16 addTP(int16 amount); // Increase mp of Entity
    void  setTP(int16 value);  // Set tp of Entity to value
    int16 delTP(int16 amount); // Decrease tp of Entity

    void  updateHealth();
    uint8 getAverageItemLevel();

    // Skills and Abilities
    void capSkill(uint8 skill);
    void capAllSkills() const;

    uint16 getSkillLevel(uint16 skillId);
    void   setSkillLevel(uint8 SkillID, uint16 SkillAmount);
    uint16 getMaxSkillLevel(uint8 level, uint8 jobId, uint8 skillId);
    uint8  getSkillRank(uint8 rankID);
    void   setSkillRank(uint8 skillID, uint8 newrank);
    uint16 getCharSkillLevel(uint8 skillID);

    void addLearnedWeaponskill(uint8 wsUnlockId);
    bool hasLearnedWeaponskill(uint8 wsUnlockId);
    void delLearnedWeaponskill(uint8 wsUnlockId);

    void trySkillUp(uint8 skill, uint8 level, const sol::object& forceSkillUpObj, const sol::object& useSubSkillObj);

    bool addWeaponSkillPoints(uint8 slotID, uint16 points);

    void   addLearnedAbility(uint16 abilityID);
    bool   hasLearnedAbility(uint16 abilityID);
    uint32 canLearnAbility(uint16 abilityID);
    void   delLearnedAbility(uint16 abilityID);

    void   addSpell(uint16 spellID, const sol::optional<sol::table>& paramTable);
    bool   hasSpell(uint16 spellID);
    uint32 canLearnSpell(uint16 spellID);
    void   delSpell(uint16 spellID, const sol::optional<sol::table>& paramTable);

    void recalculateSkillsTable();
    void recalculateAbilitiesTable();
    auto getEntitiesInRange(CLuaBaseEntity* PLuaEntityTarget, sol::variadic_args va) -> sol::table;

    // Parties and Alliances
    auto   getParty() -> sol::table;
    auto   getPartyWithTrusts() -> sol::table;
    uint8  getPartySize(const sol::object& arg0);
    bool   hasPartyJob(uint8 job);
    auto   getPartyMember(uint8 member, uint8 allianceparty) -> CBaseEntity*;
    auto   getPartyLeader() -> CBaseEntity*;
    uint32 getLeaderID();
    uint32 getPartyLastMemberJoinedTime();
    void   forMembersInRange(float range, sol::function function);

    void addPartyEffect(sol::variadic_args va);
    bool hasPartyEffect(uint16 effectid);
    void removePartyEffect(uint16 effectid);

    auto  getAlliance() -> sol::table;
    uint8 getAllianceSize();

    void reloadParty();
    void disableLevelSync();

    uint8 checkSoloPartyAlliance(); // Check if Player is in Party or Alliance (0=Solo 1=Party 2=Alliance)

    bool checkKillCredit(CLuaBaseEntity* PLuaBaseEntity, const sol::object& minRange);

    uint8 checkDifficulty(CLuaBaseEntity* PLuaBaseEntity);

    // Instances
    auto getInstance() -> CInstance*;
    void setInstance(CLuaInstance* PLuaInstance);
    void createInstance(uint16 instanceID);
    void instanceEntry(CLuaBaseEntity* PLuaBaseEntity, uint32 response);
    // int32 isInAssault(lua_Stat*); // If player is in a Instanced Assault Dungeon returns true --- Not Implemented

    uint16 getConfrontationEffect();
    uint16 copyConfrontationEffect(uint16 targetID); // copy confrontation effect, param = targetEntity:getTargID()

    // Battlefields
    auto getBattlefield() const -> CBattlefield*;                                                                                                // returns CBattlefield* or nullptr if not available
    auto getBattlefieldID() const -> int32;                                                                                                      // returns entity->PBattlefield->GetID() or -1 if not available
    auto registerBattlefield(const sol::object& arg0, const sol::object& arg1, const sol::object& arg2, const sol::object& arg3) const -> uint8; // attempt to register a battlefield, returns BATTLEFIELD_RETURNCODE
    auto battlefieldAtCapacity(int battlefieldID) const -> bool;                                                                                 // returns 1 if this battlefield is full
    auto enterBattlefield(const sol::object& area) const -> bool;
    auto leaveBattlefield(uint8 leavecode) const -> bool;
    auto isInDynamis() const -> bool;
    void setEnteredBattlefield(bool entered) const;
    auto hasEnteredBattlefield() const -> bool;

    // Battle Utilities
    bool isAlive();
    bool isDead();

    bool hasRaiseTractorMenu();
    void sendRaise(uint8 raiseLevel);
    void sendReraise(uint8 raiseLevel);
    void sendTractor(float xPos, float yPos, float zPos, uint8 rotation);
    void allowSendRaisePrompt();

    void countdown(const sol::object& secondsObj) const;
    void objectiveUtility(const sol::object& obj) const;
    void enableEntities(const sol::object& obj);
    void independentAnimation(CLuaBaseEntity* PTarget, uint16 animId, uint8 mode);

    void engage(uint16 requestedTarget);
    bool isEngaged();
    void disengage();
    void timer(int ms, sol::function func); // execute lua closure after some time
    void queue(int ms, sol::function func);
    void addRecast(uint8 recastCont, uint16 recastID, uint32 duration);
    bool hasRecast(uint8 rType, uint16 recastID, const sol::object& arg2);
    void resetRecast(uint8 rType, uint16 recastID); // Reset one recast ID
    void resetRecasts();                            // Reset recasts for the caller

    void addListener(const std::string& eventName, const std::string& identifier, const sol::function& func);
    void removeListener(const std::string& identifier);
    void triggerListener(const std::string& eventName, sol::variadic_args args);
    bool hasListener(const std::string& eventName);

    auto getEntity(uint16 targetID) -> CBaseEntity*;
    bool canChangeState();

    void wakeUp();

    void   setBattleID(uint16 battleID);
    uint16 getBattleID();

    void recalculateStats();
    bool checkImbuedItems();

    bool   isDualWielding();
    bool   isUsingH2H();
    uint16 getBaseWeaponDelay(uint16 slot); // get base delay of weapon
    uint16 getBaseDelay();                  // get base delay of entity, melee only
    uint16 getBaseRangedDelay();            // get base delay of entity, ranged only

    float checkLiementAbsorb(uint16 damageType); // return 1.0 if did not absorb, return >= -1.0 if did absorb

    // Enmity
    int32 getCE(const CLuaBaseEntity* target);
    int32 getVE(const CLuaBaseEntity* target);
    void  setCE(CLuaBaseEntity* target, uint16 amount);
    void  setVE(CLuaBaseEntity* target, uint16 amount);
    void  addBaseEnmity(CLuaBaseEntity* PEntity);
    void  addEnmity(CLuaBaseEntity* PEntity, int32 CE, int32 VE); // Add specified amount of enmity (target, CE, VE)
    void  lowerEnmity(CLuaBaseEntity* PEntity, uint8 percent);
    void  updateEnmity(CLuaBaseEntity* PEntity);
    void  transferEnmity(CLuaBaseEntity* entity, uint8 percent, float range);
    void  updateEnmityFromDamage(CLuaBaseEntity* PEntity, int32 damage); // Adds Enmity to player for specified mob for the damage specified
    void  updateEnmityFromCure(CLuaBaseEntity* PEntity, int32 amount, const sol::object& fixedCE, const sol::object& fixedVE);
    void  resetEnmity(CLuaBaseEntity* PEntity);
    void  updateClaim(const sol::object& entity);
    bool  hasClaim(CLuaBaseEntity* PTarget);
    bool  hasEnmity();
    auto  getNotorietyList() -> sol::table;
    void  clearEnmityForEntity(CLuaBaseEntity* PEntity);

    // Status Effects
    bool  addStatusEffect(sol::variadic_args va);
    auto  addStatusEffectEx(sol::variadic_args va) -> bool;
    auto  getStatusEffect(uint16 StatusID, const sol::object& SubType, const sol::object& SourceType, const sol::object& SourceTypeParam) -> CStatusEffect*;
    auto  getStatusEffectBySource(uint16 StatusID, EffectSourceType SourceType, uint16 SourceTypeParam) -> CStatusEffect*;
    auto  getStatusEffects() -> sol::table;
    int16 getStatusEffectElement(uint16 statusId);
    bool  canGainStatusEffect(uint16 effect, const sol::object& powerObj);
    bool  hasStatusEffect(uint16 StatusID, const sol::object& SubType);
    bool  hasStatusEffectByFlag(uint16 StatusID);
    uint8 countEffect(uint16 StatusID);     // Gets the number of effects of a specific type on the entity
    uint8 countEffectWithFlag(uint32 flag); // Gets the number of effects with a flag on the entity

    bool   delStatusEffect(uint16 StatusID, const sol::object& SubType, const sol::object& SourceType, const sol::object& SourceTypeParam);
    void   delStatusEffectsByFlag(uint32 flag, const sol::object& silent);
    bool   delStatusEffectSilent(uint16 StatusID); // Removes Status Effect, suppresses message
    uint16 eraseStatusEffect();
    uint8  eraseAllStatusEffect();
    int32  dispelStatusEffect(const sol::object& flagObj);
    uint8  dispelAllStatusEffect(const sol::object& flagObj);
    uint16 stealStatusEffect(CLuaBaseEntity* PTargetEntity, const sol::object& flagObj, const sol::object& silentObj);

    void  addMod(uint16 type, int16 amount);
    int16 getMod(uint16 modID);
    void  setMod(uint16 modID, int16 value);
    void  delMod(uint16 modID, int16 value);
    void  printAllMods();
    int16 getMaxGearMod(Mod modId);

    void addLatent(uint16 condID, uint16 conditionValue, uint16 mID, int16 modValue);
    bool delLatent(uint16 condID, uint16 conditionValue, uint16 mID, int16 modValue);
    bool hasAllLatentsActive(uint8 slot);

    void   fold();
    void   doWildCard(CLuaBaseEntity* PEntity, uint8 total);
    bool   doRandomDeal(CLuaBaseEntity* PTarget);
    auto   addCorsairRoll(sol::variadic_args va) -> bool;
    bool   hasCorsairEffect();
    bool   hasBustEffect(uint16 id); // Checks to see if a character has a specified busted corsair roll
    uint8  numBustEffects();         // Gets the number of bust effects on the player
    uint16 healingWaltz();
    bool   addBardSong(CLuaBaseEntity* PEntity, uint16 effectID, uint16 power, uint16 tick, uint16 duration, uint16 SubType, uint16 subPower, uint16 tier);

    void charm(const CLuaBaseEntity* target, const sol::object& p0);
    void uncharm();
    auto isCharmed() const -> bool;
    bool isTandemActive();

    uint8 addBurden(uint8 element, uint8 burden);
    uint8 getOverloadChance(uint8 element);
    void  setStatDebilitation(uint16 statDebil);

    // Damage Calculation
    uint16 getStat(uint16 statId, sol::variadic_args va); // STR,DEX,VIT,AGI,INT,MND,CHR,ATT,DEF
    uint16 getACC(const sol::object& maybeAttackNumber);
    uint16 getEVA();
    int    getRACC();
    uint16 getRATT();
    uint16 getILvlMacc();
    uint16 getILvlSkill();
    uint16 getILvlParry();
    bool   isSpellAoE(uint16 spellId);

    int32 physicalDmgTaken(double damage, sol::variadic_args va);
    int32 rangedDmgTaken(double damage, sol::variadic_args va);
    void  handleAfflatusMiseryDamage(double damage);

    bool   isWeaponTwoHanded();
    uint16 getWeaponDmg();                  // gets the current equipped weapons' DMG rating
    uint16 getWeaponDmgRank();              // gets the current equipped weapons' DMG rating for Rank calc
    uint16 getOffhandDmg();                 // gets the current equipped offhand's DMG rating (used in WS calcs)
    uint16 getOffhandDmgRank();             // gets the current equipped offhand's DMG rating for Rank calc
    uint16 getRangedDmg();                  // Get ranged weapon DMG rating
    uint16 getRangedDmgRank();              // Get ranged weapond DMG rating used for calculating rank
    uint16 getAmmoDmg();                    // Get ammo DMG rating
    uint16 getWeaponHitCount(bool offhand); // Get PC weapon hit count (Occasionally Attacks N times weapons)
    uint32 addDamageFromMultipliers(uint32 damage, PHYSICAL_ATTACK_TYPE attackType, uint8 weaponSlot, bool allowProc);

    void removeAmmo(const sol::object& ammoUsed) const;

    uint16 getWeaponSkillLevel(uint8 slotID);                        // Get Skill for equipped weapon
    uint16 getWeaponDamageType(uint8 slotID);                        // gets the type of weapon equipped
    uint8  getWeaponSkillType(uint8 slotID);                         // gets the skill type of weapon equipped
    uint8  getWeaponSubSkillType(uint8 slotID);                      // gets the subskill of weapon equipped
    auto   getWSSkillchainProp() -> std::tuple<uint8, uint8, uint8>; // returns weapon skill's skillchain properties (up to 3)

    int32 takeWeaponskillDamage(CLuaBaseEntity* attacker, int32 damage, uint8 atkType, uint8 dmgType, uint8 slot, bool primary, float tpMultiplier, uint16 bonusTP, float targetTPMultiplier);

    void  takeSpellDamage(CLuaBaseEntity* caster, CLuaSpell* spell, int32 damage, uint8 atkType, uint8 dmgType);
    int32 takeSwipeLungeDamage(CLuaBaseEntity* caster, int32 damage, uint8 atkType, uint8 dmgType);
    int32 checkDamageCap(int32 damage);
    auto  handleSevereDamage(int32 damage, bool isPhysical) -> int32;

    // Pets and Automations
    void spawnPet(const sol::object& arg0);
    void despawnPet();
    void setJugRemainingTime(uint32 remainingSeconds);

    auto   spawnTrust(uint16 trustId) -> CBaseEntity*;
    void   clearTrusts();
    uint32 getTrustID();
    void   trustPartyMessage(uint32 message_id);
    auto   addGambit(uint16 targ, const sol::table& predicates, const sol::table& reactions, const sol::object& retry) -> std::string;
    void   removeGambit(const std::string& id);
    void   removeAllGambits();
    void   setTrustTPSkillSettings(uint16 trigger, uint16 select, const sol::object& value);

    bool   hasPet();
    bool   hasJugPet();
    auto   getPet() -> CBaseEntity*;
    uint32 getPetID();
    bool   isAutomaton();
    bool   isAvatar();
    auto   getMaster() -> CBaseEntity*;
    uint8  getPetElement();
    void   setPet(const sol::object& petObj);
    uint8  getMinimumPetLevel(); // Returns the minimum level of the pet, such as level 23 for Courier Carrie or 0 if non applicable.

    auto getPetName() -> const std::string;
    void setPetName(uint8 pType, uint16 value, const sol::object& arg2);
    void registerChocobo(ChocoboColor color, const sol::table& traits) const;

    void petAttack(CLuaBaseEntity* PEntity);
    void petAbility(uint16 abilityID); // Function exists, but is not implemented.  Warning will be displayed.
    void petRetreat();
    void extendCharm(uint16 minSeconds, uint16 maxSeconds);

    void addPetMod(uint16 modID, int16 amount);
    void setPetMod(uint16 modID, int16 amount);
    void delPetMod(uint16 modID, int16 amount);

    bool  hasAttachment(uint16 itemID);
    auto  getAutomatonName() -> std::string;
    uint8 getAutomatonFrame();
    void  setAutomatonFrame(uint8 frameItemID);
    uint8 getAutomatonHead();
    void  setAutomatonHead(uint8 headItemID);
    bool  unlockAttachment(uint16 itemID);
    uint8 getActiveManeuverCount();
    void  removeOldestManeuver();
    void  removeAllManeuvers();
    auto  getAttachment(uint8 slotId) const -> CItem*;
    auto  getAttachments() -> sol::table;
    void  setAttachment(uint8 attachmentItemID, uint8 slotID) const;
    void  updateAttachments();
    void  reduceBurden(float percentReduction, const sol::object& intReductionObj);
    bool  isExceedingElementalCapacity();

    auto   getAllRuneEffects() -> sol::table;
    uint8  getActiveRuneCount();
    uint16 getHighestRuneEffect();
    uint16 getNewestRuneEffect();
    void   removeOldestRune();
    void   removeNewestRune();
    void   removeAllRunes();

    // Mob Entity-Specific
    void   setMobLevel(uint8 level);
    uint8  getEcosystem();
    uint16 getSuperFamily();
    uint16 getFamily();
    auto   isMobType(uint8 mobType) const -> bool; // True if mob is of type passed to function
    bool   isUndead();
    bool   isNM();

    uint8  getModelSize();
    void   setModelSize(uint8 newSize);
    float  getHitboxSize();
    void   setHitboxSize(float newSize);
    float  getMeleeRange(CLuaBaseEntity* target);
    void   setMobFlags(uint32 flags, const sol::object& mobId); // Used to manipulate the mob's flags, such as changing size.
    uint32 getMobFlags();

    void setNpcFlags(uint32 flags);

    void   spawn(const sol::object& despawnSec, const sol::object& respawnSec);
    bool   isSpawned();
    auto   getSpawnPos() -> sol::table;
    void   setSpawn(float x, float y, float z, const sol::object& rot);
    uint32 getRespawnTime();
    void   setRespawnTime(uint32 seconds);

    void instantiateMob(uint32 groupID);

    bool hasTrait(uint16 traitID);
    bool hasImmunity(uint32 immunityID); // Check if the mob has immunity for a type of spell (immunity list in mobentity.h)
    void addImmunity(uint32 immunityID);
    void delImmunity(uint32 immunityID);

    void setAggressive(bool aggressive);
    void setTrueDetection(bool truedetection);
    void setUnkillable(bool unkillable);
    void setUntargetable(bool untargetable);
    bool getUntargetable();
    void setIsAggroable(bool isAggroable);
    bool isAggroable();

    void setDelay(uint16 delay);
    void setDamage(uint16 damage);
    auto getSpellListId() const -> uint16;
    auto hasSpellList() const -> bool;
    void setSpellList(uint16 spellListId) const;
    void setAutoAttackEnabled(bool state);   // halts/resumes auto attack of entity
    void setMagicCastingEnabled(bool state); // halt/resumes casting magic
    void setMobAbilityEnabled(bool state);   // halt/resumes mob skills
    void setMobSkillAttack(int16 listId);    // enable/disable using mobskills as regular attacks

    int16 getMobMod(uint16 mobModID);
    void  setMobMod(uint16 mobModID, int16 value);
    void  addMobMod(uint16 mobModID, int16 value);
    void  delMobMod(uint16 mobModID, int16 value);

    uint32 getBattleTime();
    auto   getCrystalElement() const -> ELEMENT;

    uint16 getBehavior();
    void   setBehavior(uint16 behavior);
    uint8  getLink();
    void   setLink(uint8 link);
    uint16 getRoamFlags();
    void   setRoamFlags(uint16 newRoamFlags);

    auto getTarget() -> CBaseEntity*;
    void updateTarget(); // Force mob to update target from enmity container (ie after updateEnmity)
    auto getEnmityList() -> sol::table;
    auto getTrickAttackChar(CLuaBaseEntity* PLuaBaseEntity) -> CBaseEntity*; // true if TA target is available

    bool actionQueueEmpty();

    void castSpell(const sol::object& spell, const sol::object& entity); // forces a mob to cast a spell (parameter = spell ID, otherwise picks a spell from its list)
    void useJobAbility(uint16 skillID, const sol::object& pet);          // forces a job ability use (players/pets only)
    void useMobAbility(sol::variadic_args va);                           // forces a mob to use a mobability (parameter = skill ID)
    void usePetAbility(uint16 skillId, const sol::object& target) const; // forces a pet to use a pet ability
    auto getAbilityDistance(uint16 skillID) -> float;                    // Returns the specified distance for mob skill
    bool hasTPMoves();
    void drawIn(const sol::variadic_args& va) const; // Forces a mob to draw-in the specified target, or its current target with no args

    void weaknessTrigger(uint8 level);
    void restoreFromChest(CLuaBaseEntity* PLuaBaseEntity, uint32 restoreType);
    bool hasPreventActionEffect();
    void stun(uint32 milliseconds);
    void untargetableAndUnactionable(uint32 milliseconds);
    void tryHitInterrupt(CLuaBaseEntity* attacker);

    uint32 getPool(); // Returns a mobs pool ID. If entity is not a mob, returns nil.
    uint32 getDropID();
    void   setDropID(uint32 dropID);
    void   addTreasure(uint16 itemID, const sol::object& arg1, const sol::object& arg2);
    auto   getTreasurePool() -> CTreasurePool*;
    uint16 getStealItem();
    uint16 getDespoilItem();                // gets ItemID of droplist despoil item from mob (steal item if no despoil item)
    uint16 getDespoilDebuff(uint16 itemID); // gets the status effect id to apply to the mob on successful despoil
    bool   itemStolen();                    // sets mob's ItemStolen var = true
    bool   itemDespoiled();                 // sets mob's ItemDespoiled var = true
    int16  getTHlevel();                    // Returns the Monster's current Treasure Hunter Tier
    void   setTHlevel(int16 newLevel);      // Sets the Monster's current Treasure Hunter Tier

    uint32 getAvailableTraverserStones();
    uint32 getTraverserEpoch();
    void   setTraverserEpoch();
    uint32 getClaimedTraverserStones();
    void   addClaimedTraverserStones(uint16 numStones);
    void   setClaimedTraverserStones(uint16 totalStones);

    uint32 getHistory(uint8 index);

    auto getChocoboRaisingInfo() -> sol::table;
    bool setChocoboRaisingInfo(const sol::table& table);
    bool deleteRaisedChocobo();

    void clearActionQueue();
    void clearTimerQueue();

    void  setMannequinPose(uint16 itemID, uint8 race, uint8 pose);
    uint8 getMannequinPose(uint16 itemID);

    void   submitContestFish(uint32 score);
    void   withdrawContestFish();
    uint32 getContestScore();
    uint8  getContestRank();
    auto   getContestRewardStatus() -> sol::table;
    auto   getContestRankHistory() -> sol::table;
    void   claimContestReward();

    void addPacketMod(uint16 packetId, uint16 offset, uint8 value);
    void clearPacketMods();

    bool operator==(const CLuaBaseEntity& other) const
    {
        return this->m_PBaseEntity == other.m_PBaseEntity;
    }

    static void Register();
};

#endif
