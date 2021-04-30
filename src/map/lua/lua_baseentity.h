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

#include "../../common/cbasetypes.h"
#include "luautils.h"

class CBaseEntity;
class CCharEntity;
class CLuaBattlefield;
class CLuaInstance;
class CLuaItem;
class CLuaSpell;
class CLuaStatusEffect;
class CLuaZone;

class CLuaBaseEntity
{
    CBaseEntity* m_PBaseEntity;

public:
    CLuaBaseEntity(CBaseEntity*);

    CBaseEntity* GetBaseEntity() const
    {
        return m_PBaseEntity;
    }

    // Messaging System
    void showText(CLuaBaseEntity* mob, uint16 messageID, sol::object const& p0, sol::object const& p1, sol::object const& p2, sol::object const& p3); // Displays Dialog for npc
    void messageText(CLuaBaseEntity* PLuaBaseEntity, uint16 messageID, sol::object const& arg2, sol::object const& arg3);
    void PrintToPlayer(std::string const& message, sol::object messageType, sol::object name);                               // for sending debugging messages/command confirmations to the player's client
    void PrintToArea(std::string const& message, sol::object const& arg1, sol::object const& arg2, sol::object const& arg3); // for sending area messages to multiple players at once
    void messageBasic(uint16 messageID, sol::object const& p0, sol::object const& p1, sol::object const& target);            // Sends Basic Message
    void messageName(uint16 messageID, sol::object const& entity, sol::object const& p0, sol::object const& p1,
                     sol::object const& p2, sol::object const& p3, sol::object const& chat);                               // Sends a Message with a Name
    void messagePublic(uint16 messageID, CLuaBaseEntity const* PEntity, sol::object const& arg2, sol::object const& arg3); // Sends a public Basic Message

    void messageSpecial(uint16 messageID, sol::variadic_args va); // Sends Special Message

    void messageSystem(uint16 messageID, sol::object const& p0, sol::object const& p1); // Sends System Message
    void messageCombat(sol::object const& speaker, int32 p0, int32 p1, int16 message);  // Sends Combat Message

    // Variables
    int32  getCharVar(std::string const& varName);              // Returns a character variable
    void   setCharVar(std::string const& varname, int32 value); // Sets a character variable
    void   addCharVar(std::string const& varname, int32 value); // Increments/decriments/sets a character variable
    uint32 getLocalVar(std::string const& var);
    void   setLocalVar(std::string const& var, uint32 val);
    void   resetLocalVars();
    void   clearVarsWithPrefix(std::string const& prefix);
    uint32 getLastOnline(); // Returns the unix timestamp of last time the player logged out or zoned

    // Packets, Events, and Flags
    void injectPacket(std::string const& filename); // Send the character a packet kept in a file
    void injectActionPacket(uint16 action, uint16 anim, uint16 spec, uint16 react, uint16 message);
    void entityVisualPacket(std::string const& command, sol::object const& entity);
    void entityAnimationPacket(const char* command);

    void startEvent(uint32 EventID, sol::variadic_args va);
    void startEventString(uint16 EventID, sol::variadic_args va); // Begins Event with string param (0x33 packet)
    void updateEvent(sol::variadic_args va);                      // Updates event
    void updateEventString(sol::variadic_args va);                // (string, string, string, string, uint32, ...)
    auto getEventTarget() -> std::optional<CLuaBaseEntity>;
    bool isInEvent(); // Returns true if the player is in an event
    void release(); // Stops event
    bool startSequence(); // Flags the player as being in a sequence
    bool didGetMessage(); // Used by interaction framework to determine if player triggered something else
    void resetGotMessage(); // Used by interaction framework to reset if player triggered something else

    void  setFlag(uint32 flags);
    uint8 getMoghouseFlag();
    void  setMoghouseFlag(uint8 flag);
    bool  needToZone(sol::object const& arg0); // Check if player has zoned since the flag has been raised

    // Object Identification
    uint32 getID();
    uint16 getShortID();
    auto   getCursorTarget() -> std::optional<CLuaBaseEntity>; // Returns the ID any object under players in game cursor.

    uint8 getObjType();
    bool  isPC();
    bool  isNPC();
    bool  isMob();
    bool  isPet();
    bool  isAlly();

    // AI and Control
    void  initNpcAi();
    void  resetAI();
    uint8 getStatus();
    void  setStatus(uint8 status); // Sets Character's Status
    uint8 getCurrentAction();

    void lookAt(sol::object const& arg0, sol::object const& arg1, sol::object const& arg2); // look at given position
    void clearTargID();                                                                     // clears target of entity

    bool  atPoint(sol::variadic_args va);                                          // is at given point
    void  pathTo(float x, float y, float z, sol::object const& flags);             // set new path to point without changing action
    bool  pathThrough(sol::table const& pointsTable, sol::object const& flagsObj); // walk at normal speed through the given points
    bool  isFollowingPath();                                                       // checks if the entity is following a path
    void  clearPath(sol::object const& pauseObj);                                  // removes current pathfind and stops moving
    void  continuePath();                                                          // resumes previous pathfind if it was paused
    float checkDistance(sol::variadic_args va);                                    // Check Distacnce and returns distance number
    void  wait(sol::object const& milliseconds);                                   // make the npc wait a number of ms and then back into roam
    // int32 WarpTo(lua_Stat* L);           // warp to the given point -- These don't exist, breaking them just in case someone uncomments
    // int32 RoamAround(lua_Stat* L);       // pick a random point to walk to
    // int32 LimitDistance(lua_Stat* L);    // limits the current path distance to given max distance

    void openDoor(sol::object const& seconds);
    void closeDoor(sol::object const& seconds);
    void setElevator(uint8 id, uint32 lowerDoor, uint32 upperDoor, uint32 elevatorId, bool reversed);

    void addPeriodicTrigger(uint8 id, uint16 period, uint16 minOffset); // Adds a periodic trigger to the NPC that allows time based scripting
    void showNPC(sol::object const& seconds);                           // Show an NPC
    void hideNPC(sol::object const& seconds);                           // hide an NPC
    void updateNPCHideTime(sol::object const& seconds);                 // Updates the length of time a NPC remains hidden, if shorter than the original hide time.

    uint8 getWeather();
    void  setWeather(uint8 weatherType); // Set Weather condition (GM COMMAND)

    // PC Instructions
    void ChangeMusic(uint8 blockID, uint8 musicTrackID);                    // Sets the specified music Track for specified music block.
    void sendMenu(uint32 menu);                                             // Displays a menu (AH,Raise,Tractor,MH etc)
    bool sendGuild(uint16 guildID, uint8 open, uint8 close, uint8 holiday); // Sends guild shop menu
    void openSendBox();                                                     // Opens send box (to deliver items)
    void leaveGame();                                                       // Character leaving game
    void sendEmote(CLuaBaseEntity* target, uint8 emID, uint8 emMode);       // Character emits emote packet.

    // Location and Positioning
    int16 getWorldAngle(CLuaBaseEntity const* target, sol::object const& deg);  // return angle (rot) between two points (vector from a to b), aligned to absolute cardinal degree
    int16 getFacingAngle(CLuaBaseEntity const* target);                         // return angle between entity rot and target pos, aligned to number of degrees of difference
    bool  isFacing(CLuaBaseEntity const* target, sol::object const& angleArg);  // true if you are facing the target
    bool  isInfront(CLuaBaseEntity const* target, sol::object const& angleArg); // true if you're infront of the input target
    bool  isBehind(CLuaBaseEntity const* target, sol::object const& angleArg);  // true if you're behind the input target
    bool  isBeside(CLuaBaseEntity const* target, sol::object const& angleArg);  // true if you're to the side of the input target

    auto   getZone(sol::object const& arg0) -> std::optional<CLuaZone>; // Get Entity zone
    uint16 getZoneID();                                                 // Get Entity zone ID
    auto   getZoneName() -> const char*;                                // Get Entity zone name
    bool   isZoneVisited(uint16 zone);                                  // true если указанная зона посещалась персонажем ранее
    uint16 getPreviousZone();                                           // Get Entity previous zone
    uint8  getCurrentRegion();                                          // Get Entity conquest region
    uint8  getContinentID();                                            // узнаем континент, на котором находится сущность
    bool   isInMogHouse();                                              // Check if entity inside a mog house

    uint32 getPlayerRegionInZone();                                                           // Returns the player's current region in the zone. (regions made with registerRegion)
    void   updateToEntireZone(uint8 statusID, uint8 animation, sol::object const& matchTime); // Forces an update packet to update the NPC entity zone-wide

    auto  getPos() -> sol::table; // Get Entity position (x,y,z)
    void  showPosition();         // Display current position of character
    float getXPos();              // Get Entity X position
    float getYPos();              // Get Entity Y position
    float getZPos();              // Get Entity Z position
    uint8 getRotPos();            // Get Entity Rot position
    void setRotation(uint8 rotation); // Set Entity rotation

    void setPos(sol::variadic_args va);                                       // Set Entity position (x,y,z,rot) or (x,y,z,rot,zone)
    void warp();                                                              // Returns Character to home point
    void teleport(std::map<std::string, float> pos, sol::object const& arg1); // Set Entity position (without entity despawn/spawn packets)

    void   addTeleport(uint8 teleType, uint32 bitval, sol::object const& setval); // Add new teleport means to char unlocks
    uint32 getTeleport(uint8 type);                                               // Get unlocked teleport means
    auto   getTeleportTable(uint8 type) -> sol::table;
    bool   hasTeleport(uint8 tType, uint8 bit, sol::object const& arg2); // Has access to specific teleport
    void   setTeleportMenu(uint16 type, sol::table const& favs);         // Set favorites or menu layout preferences for homepoints or survival guides
    auto   getTeleportMenu(uint8 type) -> sol::table;                    // Get favorites and menu layout preferences
    void   setHomePoint();                                               // Sets character's homepoint

    void resetPlayer(const char* charName); // if player is stuck, GM command @resetPlayer name

    void goToEntity(uint32 targetID, sol::object const& option); // Warps self to NPC or Mob; works across multiple game servers
    bool gotoPlayer(std::string const& playerName);              // warps self to target player
    bool bringPlayer(std::string const& playerName);             // warps target to self

    // Items
    uint16 getEquipID(SLOTTYPE slot);                              // Gets the Item Id of the item in specified slot
    auto   getEquippedItem(uint8 slot) -> std::optional<CLuaItem>; // Returns the item object from specified slot
    bool   hasItem(uint16 itemID, sol::object const& location);    // Check to see if Entity has item in inventory (hasItem(itemNumber))
    bool   addItem(sol::variadic_args va);                         // Add item to Entity inventory (additem(itemNumber,quantity))
    bool   delItem(uint16 itemID, uint32 quantity, sol::object const& containerID);
    bool   addUsedItem(uint16 itemID);                                                      // Add charged item with timer already on full cooldown
    bool   addTempItem(uint16 itemID, sol::object const& arg1);                             // Add temp item to Entity Temp inventory
    bool   hasWornItem(uint16 itemID);                                                      // Check if the item is already worn (player:hasWornItem(itemid))
    void   createWornItem(uint16 itemID);                                                   // Update this item in worn item (player:createWornItem(itemid))
    auto   findItem(uint16 itemID, sol::object const& location) -> std::optional<CLuaItem>; // Like hasItem, but returns the item object (nil if not found)

    void createShop(uint8 size, sol::object const& arg1);                                               // Prepare the container for work of shop ??
    void addShopItem(uint16 itemID, double rawPrice, sol::object const& arg2, sol::object const& arg3); // Adds item to shop container (16 max)
    auto getCurrentGPItem(uint8 guildID) -> std::tuple<uint16, uint16>;                                 // Gets current GP item id and max points
    bool breakLinkshell(std::string const& lsname);                                                     // Breaks all pearls/sacks
    bool addLinkpearl(std::string const& lsname, bool equip);                                           // Creates a linkpearl (pearlsack for GMs)

    // Trading
    uint8 getContainerSize(uint8 locationID);                  // Gets the current capacity of a container
    void  changeContainerSize(uint8 locationID, int8 newSize); // Increase/Decreases container size
    uint8 getFreeSlotsCount(sol::object const& locID);         // Gets value of free slots in Entity inventory
    void  confirmTrade();                                      // Complete trade with an npc, only removing confirmed items
    void  tradeComplete();                                     // Complete trade with an npc

    // Equipping
    bool canEquipItem(uint16 itemID, sol::object const& chkLevel); // returns true if the player is able to equip the item
    void equipItem(uint16 itemID, sol::object const& container);
    void unequipItem(uint8 itemID);

    void setEquipBlock(uint16 equipBlock);
    void lockEquipSlot(uint8 slot);   // блокируем ячейку экипировки
    void unlockEquipSlot(uint8 slot); // снимаем блокировку с ячейки экипировки

    int8 getShieldSize(); // Gets shield size of character

    bool hasGearSetMod(uint8 modNameId);                             // Checks if character already has a gear set mod
    void addGearSetMod(uint8 modNameId, Mod modId, uint16 modValue); // Sets the characters gear set mod
    void clearGearSetMods();                                         // Clears a characters gear set mods

    // Storing
    auto  getStorageItem(uint8 container, uint8 slotID, uint8 equipID) -> std::optional<CLuaItem>; // returns item object player:getStorageItem(containerid, slotid, equipslotid)
    uint8 storeWithPorterMoogle(uint16 slipId, sol::table const& extraTable, sol::table const& storableItemIdsTable);
    auto  getRetrievableItemsForSlip(uint16 slipId) -> sol::table;
    void  retrieveItemFromSlip(uint16 slipId, uint16 itemId, uint16 extraId, uint8 extraData);

    // Player Appearance
    uint8  getRace();
    uint8  getGender();              // Returns the player character's gender
    auto   getName() -> const char*; // Gets Entity Name
    void   hideName(bool isHidden);
    bool   checkNameFlags(uint32 flags); // this is check and not get because it tests for a flag, it doesn't return all flags
    uint16 getModelId();
    void   setModelId(uint16 modelId, sol::object const& slotObj);
    void   setCostume(uint16 costume);
    uint16 getCostume();
    uint16 getCostume2(); // set monstrosity costume
    void   setCostume2(uint16 costume);
    uint8  getAnimation();                // Get Entity Animation
    void   setAnimation(uint8 animation); // Set Entity Animation
    uint8  getAnimationSub();
    void   setAnimationSub(uint8 animationsub);

    // Player Status
    uint8 getNation();             // Gets Nation of Entity
    void  setNation(uint8 nation); // Sets Nation of Entity
    uint8 getAllegiance();
    void  setAllegiance(uint8 allegiance);
    uint8 getCampaignAllegiance();                 // Gets Campaign Allegiance of Entity
    void  setCampaignAllegiance(uint8 allegiance); // Sets Campaign Allegiance of Entity

    bool isSeekingParty();
    bool getNewPlayer();
    void setNewPlayer(bool newplayer);
    bool getMentor();
    void setMentor(bool mentor);

    uint8 getGMLevel();
    void  setGMLevel(uint8 level);
    bool  getGMHidden();
    void  setGMHidden(bool isHidden);

    bool isJailed(); // Is the player jailed
    void jail();

    bool canUseMisc(uint16 misc); // Check misc flags of current zone.

    uint8 getSpeed(); // скорость передвижения сущности
    void  setSpeed(uint8 speedVal);

    uint32 getPlaytime(sol::object const& shouldUpdate);
    int32  getTimeCreated();

    // Player Jobs and Levels
    uint8 getMainJob();             // Returns Entity Main Job
    uint8 getSubJob();              // Get Entity Sub Job
    void  changeJob(uint8 newJob);  // changes the job of a char (testing only!)
    void  changesJob(uint8 subJob); // changes the sub job of a char (testing only!)
    void  unlockJob(uint8 JobID);   // Unlocks a job for the entity, sets job level to 1
    bool  hasJob(uint8 job);        // Check to see if JOBTYPE is unlocked for a character

    uint8 getMainLvl();             // Gets Entity Main Job Level
    uint8 getSubLvl();              // Get Entity Sub Job Level
    uint8 getJobLevel(uint8 JobID); // Gets character job level for specified JOBTYPE
    void  setLevel(uint8 level);    // sets the character's level
    void  setsLevel(uint8 slevel);  // sets the character's level
    uint8 getLevelCap();            // genkai
    void  setLevelCap(uint8 cap);
    uint8 levelRestriction(sol::object const& level); // Establish/return current level restriction
    void  addJobTraits(uint8 jobID, uint8 level);     // Add job traits

    // Player Titles and Fame
    uint16 getTitle();
    bool   hasTitle(uint16 titleID);
    void   addTitle(uint16 titleID);
    void   setTitle(uint16 titleID);
    void   delTitle(uint16 titleID);

    uint16 getFame(sol::object const& areaObj);              // Gets Fame
    void   addFame(sol::object const& areaObj, uint16 fame); // Adds Fame
    void   setFame(sol::object const& areaObj, uint16 fame); // Sets Fame
    uint8  getFameLevel(sol::object const& areaObj);         // Gets Fame Level for specified nation

    uint8  getRank();                        // Get Rank for current active nation
    uint8  getOtherRank(uint8 nation);       // Get Rank for a specific nation, getNationRank is used in utils, and this may be unneeded
    void   setRank(uint8 rank);              // Set Rank
    uint32 getRankPoints();                  // Get Current Rank points
    void   addRankPoints(uint32 rankpoints); // Add rank points to existing rank point total
    void   setRankPoints(uint32 rankpoints); // Set Current Rank points

    void  addQuest(uint8 questLogID, uint16 questID);          // Add Quest to Entity Quest Log
    void  delQuest(uint8 questLogID, uint16 questID);          // Remove quest from quest log (should be used for debugging only)
    uint8 getQuestStatus(uint8 questLogID, uint16 questID);    // Get Quest Status
    bool  hasCompletedQuest(uint8 questLogID, uint16 questID); // Checks if quest has been completed
    void  completeQuest(uint8 questLogID, uint16 questID);     // Set a quest status to complete

    void   addMission(uint8 missionLogID, uint16 missionID);          // Add Mission
    void   delMission(uint8 missionLogID, uint16 missionID);          // Delete Mission from Mission Log
    uint16 getCurrentMission(sol::object const& missionLogObj);       // Gets the current mission
    bool   hasCompletedMission(uint8 missionLogID, uint16 missionID); // Checks if mission has been completed
    void   completeMission(uint8 missionLogID, uint16 missionID);     // Complete Mission

    void   setMissionStatus(uint8 missionLogID, sol::object const& arg2Obj, sol::object const& arg3Obj); // Sets mission progress data.
    uint32 getMissionStatus(uint8 missionLogID, sol::object const& missionStatusPosObj);                 // Gets mission progress data.

    void   setEminenceCompleted(uint16 recordID, sol::object const& arg1, sol::object const& arg2); // Sets the complete flag for a record of eminence
    bool   getEminenceCompleted(uint16 recordID);                                                   // Gets the record completed flag
    uint16 getNumEminenceCompleted();                                                               // Get total count of records completed for player
    bool   setEminenceProgress(uint16 recordID, uint32 progress, sol::object const& arg2);          // Sets progress on a record of eminence
    auto   getEminenceProgress(uint16 recordID) -> std::optional<uint32>;                           // gets progress on a record of eminence
    bool   hasEminenceRecord(uint16 recordID);                                                      // Check if record is active
    void   triggerRoeEvent(uint8 eventNum, sol::object const& reqTable);
    void   setUnityLeader(uint8 leaderID);                                    // Sets a player's unity leader
    uint8  getUnityLeader();                                                  // Returns player's unity leader
    auto   getUnityRank(sol::object const& unityObj) -> std::optional<uint8>; // Returns current rank of player's unity

    void  addAssault(uint8 missionID);          // Add Mission
    void  delAssault(uint8 missionID);          // Delete Mission from Mission Log
    uint8 getCurrentAssault();                  // Gets the current mission
    bool  hasCompletedAssault(uint8 missionID); // Checks if mission has been completed
    void  completeAssault(uint8 missionID);     // Complete Mission

    void addKeyItem(uint16 keyItemID);    // Add key item to Entity Key Item collection
    bool hasKeyItem(uint16 keyItemID);    // Checks Entity key item collection to see if Entity has the key item
    void delKeyItem(uint16 keyItemID);    // Removes key item from Entity key item collection
    bool seenKeyItem(uint16 keyItemID);   // If Key Item is viewed, add it to the seen key item collection
    void unseenKeyItem(uint16 keyItemID); // Attempt to remove the keyitem from the seen key item collection, only works on logout

    // Player Points
    void  addExp(uint32 exp);
    void  addCapacityPoints(uint32 capacity);
    void  delExp(uint32 exp);
    int32 getMerit(uint16 merit);
    uint8 getMeritCount();
    void  setMerits(uint8 numPoints); // set merits (testing only!)

    uint8 getJobPointLevel(uint16 jpType); // Returns Value of Job Point Type
    void  setJobPoints(uint16 amount);     // Set Job Points for current job
    void  setCapacityPoints(uint16 amount);

    uint32 getGil();
    void   addGil(int32 gil);
    void   setGil(int32 amount);
    bool   delGil(int32 gil);

    int32 getCurrency(std::string const& currencyType);
    void  addCurrency(std::string const& currencyType, int32 amount, sol::object const& maxObj);
    void  setCurrency(std::string const& currencyType, int32 amount);
    void  delCurrency(std::string const& currencyType, int32 amount);

    int32 getCP(); // Conquest points, not to be confused with Capacity Points
    void  addCP(int32 cp);
    void  delCP(int32 cp);

    int32 getSeals(uint8 sealType);
    void  addSeals(int32 points, uint8 sealType);
    void  delSeals(int32 points, uint8 sealType);

    int32 getAssaultPoint(uint8 region);
    void  addAssaultPoint(uint8 region, int32 points);
    void  delAssaultPoint(uint8 region, int32 points);

    auto addGuildPoints(uint8 guildID, uint8 slotID) -> std::tuple<uint8, int16>;

    // Health and Status
    int32 getHP();                     // Returns Entity Health
    uint8 getHPP();                    // Returns Entity Health %
    int32 getMaxHP();                  // Get max hp of entity
    int32 getBaseHP();                 // Returns Entity base Health before modifiers
    int32 addHP(int32 hpAdd);          // Modify hp of Entity +/-
    void  setHP(int32 value);          // Set hp of Entity to value
    int32 restoreHP(int32 restoreAmt); // Modify hp of Entity, but check if alive first
    void  delHP(int32 delAmt);         // Subtract hp of Entity
    void  takeDamage(int32 damage, sol::object const& attacker, sol::object const& atkType,
                     sol::object const& dmgType, sol::object const& flags); // Takes damage from the provided attacker
    void  hideHP(bool value);

    int32 getMP();
    uint8 getMPP();
    int32 getMaxMP();
    int32 getBaseMP();
    int32 addMP(int32 amount);     // Modify mp of Entity +/-
    void  setMP(int32 value);      // Set mp of Entity to value
    int32 restoreMP(int32 amount); // Modify mp of Entity, but check if alive first
    void  delMP(int32 amount);     // Subtract mp of Entity

    float getTP();
    void  addTP(int16 amount); // Modify tp of Entity +/-
    void  setTP(int16 value);  // Set tp of Entity to value
    void  delTP(int16 amount); // Subtract tp of Entity

    void updateHealth();

    // Skills and Abilities
    void capSkill(uint8 skill); // Caps the given skill id for the job you're on (GM COMMAND)
    void capAllSkills();        // Caps All skills, GM command

    uint16 getSkillLevel(uint16 skillId);                             // Get Current Skill Level
    void   setSkillLevel(uint8 SkillID, uint16 SkillAmount);          // Set Current Skill Level
    uint16 getMaxSkillLevel(uint8 level, uint8 jobId, uint8 skillId); // Get Skill Cap for skill and rank
    uint8  getSkillRank(uint8 rankID);                                // Get your current skill craft Rank
    void   setSkillRank(uint8 skillID, uint8 newrank);                // Set new skill craft rank
    uint16 getCharSkillLevel(uint8 skillID);                          // Get char skill level

    void addLearnedWeaponskill(uint8 wsID);
    bool hasLearnedWeaponskill(uint8 wsID);
    void delLearnedWeaponskill(uint8 wsID);

    void trySkillUp(uint8 skill, uint8 level, sol::object const& forceSkillUpObj, sol::object const& useSubSkillObj);

    bool addWeaponSkillPoints(uint8 slotID, uint16 points); // Adds weapon skill points to an equipped weapon

    void   addLearnedAbility(uint16 abilityID); // Add spell to Entity spell list
    bool   hasLearnedAbility(uint16 abilityID); // Check to see if character has item in spell list
    uint32 canLearnAbility(uint16 abilityID);   // Check to see if character can learn spell, 0 if so
    void   delLearnedAbility(uint16 abilityID); // Remove spell from Entity spell list

    void   addSpell(uint16 spellID, sol::variadic_args va); // Add spell to Entity spell list
    bool   hasSpell(uint16 spellID);                        // Check to see if character has item in spell list
    uint32 canLearnSpell(uint16 spellID);                   // Check to see if character can learn spell, 0 if so
    void   delSpell(uint16 spellID);                        // Remove spell from Entity spell list

    void recalculateSkillsTable();
    void recalculateAbilitiesTable();

    // Parties and Alliances
    auto   getParty() -> sol::table;
    auto   getPartyWithTrusts() -> sol::table;
    uint8  getPartySize(sol::object const& arg0); // Get the size of a party in an entity's alliance
    bool   hasPartyJob(uint8 job);
    auto   getPartyMember(uint8 member, uint8 allianceparty) -> std::optional<CLuaBaseEntity>; // Get a character entity from another entity's party or alliance
    auto   getPartyLeader() -> std::optional<CLuaBaseEntity>;
    uint32 getLeaderID(); // Get the id of the alliance/party leader *falls back to player id if no party*
    uint32 getPartyLastMemberJoinedTime();
    void   forMembersInRange(float range, sol::function function);

    void addPartyEffect(sol::variadic_args va); // Adds Effect to all party members
    bool hasPartyEffect(uint16 effectid);       // Has Effect from all party members
    void removePartyEffect(uint16 effectid);    // Removes Effect from all party members

    auto  getAlliance() -> sol::table;
    uint8 getAllianceSize(); // Get the size of an entity's alliance

    void reloadParty();
    void disableLevelSync();
    bool isLevelSync();

    uint8 checkSoloPartyAlliance(); // Check if Player is in Party or Alliance 0=Solo 1=Party 2=Alliance

    bool checkKillCredit(CLuaBaseEntity* PLuaBaseEntity, sol::object const& arg1, sol::object const& arg2);

    // Instances
    auto getInstance() -> std::optional<CLuaInstance>;
    void setInstance(CLuaInstance* PLuaInstance);
    void createInstance(uint8 instanceID, uint16 zoneID);
    void instanceEntry(CLuaBaseEntity* PLuaBaseEntity, uint32 response);
    // int32 isInAssault(lua_Stat*); // If player is in a Instanced Assault Dungeon returns true --- Not Implemented

    uint16 getConfrontationEffect();
    uint16 copyConfrontationEffect(uint16 targetID); // copy confrontation effect, param = targetEntity:getShortID()

    // Battlefields
    auto  getBattlefield() -> std::optional<CLuaBattlefield>;                                             // returns CBattlefield* or nullptr if not available
    int32 getBattlefieldID();                                                                             // returns entity->PBattlefield->GetID() or -1 if not available
    uint8 registerBattlefield(sol::object const& arg0, sol::object const& arg1, sol::object const& arg2); // attempt to register a battlefield, returns BATTLEFIELD_RETURNCODE
    bool  battlefieldAtCapacity(int battlefieldID);                                                       // 1 if this battlefield is full
    bool  enterBattlefield(sol::object const& area);                                                      // enter a battlefield entity is registered with
    bool  leaveBattlefield(uint8 leavecode);                                                              // leave battlefield if inside one
    bool  isInDynamis();                                                                                  // If player is in Dynamis return true else false

    // Battle Utilities
    bool isAlive();
    bool isDead();
    void sendRaise(uint8 raiseLevel);
    void sendReraise(uint8 raiseLevel);
    void sendTractor(float xPos, float yPos, float zPos, uint8 rotation);

    void countdown(sol::object const& secondsObj,
                   sol::object const& bar1NameObj, sol::object const& bar1ValObj,
                   sol::object const& bar2NameObj, sol::object const& bar2ValObj);
    void enableEntities(std::vector<uint32> data);
    void independentAnimation(CLuaBaseEntity* PTarget, uint16 animId, uint8 mode);

    void engage(uint16 requestedTarget);
    bool isEngaged();
    void disengage();
    void timer(int ms, sol::function func); // execute lua closure after some time
    void queue(int ms, sol::function func);
    void addRecast(uint8 recastCont, uint16 recastID, uint32 duration);
    bool hasRecast(uint8 rType, uint16 recastID, sol::object const& arg2);
    void resetRecast(uint8 rType, uint16 recastID); // Reset one recast ID
    void resetRecasts();                            // Reset recasts for the caller

    void addListener(std::string eventName, std::string identifier, sol::function func);
    void removeListener(std::string identifier);
    void triggerListener(std::string eventName, sol::variadic_args args);

    auto getEntity(uint16 targetID) -> std::optional<CLuaBaseEntity>;
    bool canChangeState();

    void wakeUp(); // wakes target if necessary

    void recalculateStats();
    bool checkImbuedItems();

    bool isDualWielding(); // Checks if the battle entity is dual wielding

    // Enmity
    int32 getCE(CLuaBaseEntity const* target);                    // gets current CE the mob has towards the player
    int32 getVE(CLuaBaseEntity const* target);                    // gets current VE the mob has towards the player
    void  setCE(CLuaBaseEntity* target, uint16 amount);           // sets current CE the mob has towards the player
    void  setVE(CLuaBaseEntity* target, uint16 amount);           // sets current VE the mob has towards the player
    void  addEnmity(CLuaBaseEntity* PEntity, int32 CE, int32 VE); // Add specified amount of enmity (target, CE, VE)
    void  lowerEnmity(CLuaBaseEntity* PEntity, uint8 percent);    // lower enmity to player for specificed mob
    void  updateEnmity(CLuaBaseEntity* PEntity);                  // Adds Enmity to player for specified mob
    void  transferEnmity(CLuaBaseEntity* entity, uint8 percent, float range);
    void  updateEnmityFromDamage(CLuaBaseEntity* PEntity, int32 damage); // Adds Enmity to player for specified mob for the damage specified
    void  updateEnmityFromCure(CLuaBaseEntity* PEntity, int32 amount);
    void  resetEnmity(CLuaBaseEntity* PEntity);   // resets enmity to player for specificed mob
    void  updateClaim(sol::object const& entity); // Adds Enmity to player for specified mob and claims
    bool  hasEnmity();                            // Does the player have any enmity at all from any source
    auto  getNotorietyList() -> sol::table;       // Returns a table with all of the entities on a chars notoriety list

    // Status Effects
    bool   addStatusEffect(sol::variadic_args va);
    bool   addStatusEffectEx(sol::variadic_args va);
    auto   getStatusEffect(uint16 StatusID, sol::object const& SubID) -> std::optional<CLuaStatusEffect>;
    auto   getStatusEffects() -> sol::table;
    int16  getStatusEffectElement(uint16 statusId);
    bool   canGainStatusEffect(uint16 effect, sol::object const& powerObj); // Returns true if the effect can be added
    bool   hasStatusEffect(uint16 StatusID, sol::object const& SubID);      // Checks to see if character has specified effect
    uint16 hasStatusEffectByFlag(uint16 StatusID);                          // Checks to see if a character has an effect with the specified flag
    uint8  countEffect(uint16 StatusID);                                    // Gets the number of effects of a specific type on the player

    bool   delStatusEffect(uint16 StatusID, sol::object const& SubID);                   // Removes Status Effect
    void   delStatusEffectsByFlag(uint32 flag, sol::object const& silent);               // Removes Status Effects by Flag
    bool   delStatusEffectSilent(uint16 StatusID);                                       // Removes Status Effect, suppresses message
    uint16 eraseStatusEffect();                                                          // Used with "Erase" spell
    uint8  eraseAllStatusEffect();                                                       // Erases all effects and returns number erased
    int32  dispelStatusEffect(sol::object const& flagObj);                               // Used with "Dispel" spell
    uint8  dispelAllStatusEffect(sol::object const& flagObj);                            // Dispels all effects and returns number erased
    uint16 stealStatusEffect(CLuaBaseEntity* PTargetEntity, sol::object const& flagObj); // Used in mob skills to steal effects

    void  addMod(uint16 type, int16 amount); // Adds Modifier Value
    int16 getMod(uint16 modID);              // Retrieves Modifier Value
    void  setMod(uint16 modID, int16 value); // Sets Modifier Value
    void  delMod(uint16 modID, int16 value); // Subtracts Modifier Value

    void addLatent(uint16 condID, uint16 conditionValue, uint16 mID, int16 modValue); // Adds a latent effect
    bool delLatent(uint16 condID, uint16 conditionValue, uint16 mID, int16 modValue); // Removes a latent effect

    void   fold();
    void   doWildCard(CLuaBaseEntity* PEntity, uint8 total);
    bool   addCorsairRoll(uint8 casterJob, uint8 bustDuration, uint16 effectID, uint16 power, uint32 tick, uint32 duration,
                          sol::object const& arg6, sol::object const& arg7, sol::object const& arg8); // Adds corsair roll effect
    bool   hasCorsairEffect();
    bool   hasBustEffect(uint16 id); // Checks to see if a character has a specified busted corsair roll
    uint8  numBustEffects();         // Gets the number of bust effects on the player
    uint16 healingWaltz();           // Used with "Healing Waltz" ability
    bool   addBardSong(CLuaBaseEntity* PEntity, uint16 effectID, uint16 power, uint16 tick,
                       uint16 duration, uint16 subID, uint16 subPower, uint16 tier); // Adds bard song effect

    void charm(CLuaBaseEntity const* target); // applies charm on target
    void uncharm();                           // removes charm on target

    uint8 addBurden(uint8 element, uint8 burden);
    void  setStatDebilitation(uint16 statDebil);

    // Damage Calculation
    uint16 getStat(uint16 statId); // STR,DEX,VIT,AGI,INT,MND,CHR,ATT,DEF
    uint16 getACC();
    uint16 getEVA();
    int    getRACC();
    uint16 getRATT();
    uint16 getILvlMacc();
    bool   isSpellAoE(uint16 spellId);

    int32 physicalDmgTaken(double damage, sol::variadic_args va);
    int32 magicDmgTaken(double damage, sol::variadic_args va);
    int32 rangedDmgTaken(double damage, sol::variadic_args va);
    int32 breathDmgTaken(double damage);
    void  handleAfflatusMiseryDamage(double damage);

    bool   isWeaponTwoHanded();
    int    getMeleeHitDamage(CLuaBaseEntity* PLuaBaseEntity, sol::object const& arg1); // gets the damage of a single hit vs the specified mob
    uint16 getWeaponDmg();                                                             // gets the current equipped weapons' DMG rating
    uint16 getWeaponDmgRank();                                                         // gets the current equipped weapons' DMG rating for Rank calc
    uint16 getOffhandDmg();                                                            // gets the current equipped offhand's DMG rating (used in WS calcs)
    uint16 getOffhandDmgRank();                                                        // gets the current equipped offhand's DMG rating for Rank calc
    uint16 getRangedDmg();                                                             // Get ranged weapon DMG rating
    uint16 getRangedDmgRank();                                                         // Get ranged weapond DMG rating used for calculating rank
    uint16 getAmmoDmg();                                                               // Get ammo DMG rating

    void removeAmmo();

    uint8  getWeaponSkillLevel(uint8 slotID);                        // Get Skill for equipped weapon
    uint16 getWeaponDamageType(uint8 slotID);                        // gets the type of weapon equipped
    uint8  getWeaponSkillType(uint8 slotID);                         // gets the type of weapon equipped
    uint8  getWeaponSubSkillType(uint8 slotID);                      // gets the subskill of weapon equipped
    auto   getWSSkillchainProp() -> std::tuple<uint8, uint8, uint8>; // returns weapon skill's skillchain properties (up to 3)

    int32 takeWeaponskillDamage(CLuaBaseEntity* attacker, int32 damage, uint8 atkType, uint8 dmgType, uint8 slot, bool primary,
                                float tpMultiplier, uint16 bonusTP, float targetTPMultiplier);

    int32 takeSpellDamage(CLuaBaseEntity* caster, CLuaSpell* spell, int32 damage, uint8 atkType, uint8 dmgType);

    // Pets and Automations
    void spawnPet(sol::object const& arg0); // Calls Pet
    void despawnPet();                      // Despawns Pet

    void   spawnTrust(uint16 trustId);
    void   clearTrusts();
    uint32 getTrustID();
    void   trustPartyMessage(uint32 message_id);
    void   addSimpleGambit(uint16 targ, uint16 cond, uint32 condition_arg, uint16 react, uint16 select, uint32 selector_arg, sol::object const& retry);
    int32  addFullGambit(lua_State*);
    void   setTrustTPSkillSettings(uint16 trigger, uint16 select);

    bool isJugPet(); // If the entity has a pet, test if it is a jug pet.
    bool hasValidJugPetItem();

    bool   hasPet();                                  // returns true if the player has a pet
    auto   getPet() -> std::optional<CLuaBaseEntity>; // Creates an LUA reference to a pet entity
    uint32 getPetID();                                // If the entity has a pet, returns the PetID to identify pet type.
    auto   getMaster() -> std::optional<CLuaBaseEntity>;
    uint8  getPetElement();

    auto getPetName() -> const char*;
    void setPetName(uint8 pType, uint16 value, sol::object const& arg2);

    float getCharmChance(CLuaBaseEntity const* target, sol::object const& mods); // Gets the chance the entity has to charm its target.
    void  charmPet(CLuaBaseEntity const* target);                                // Charms Pet (Beastmaster ability only)

    void petAttack(CLuaBaseEntity* PEntity); // Despawns Pet
    void petAbility(uint16 abilityID);       // Function exists, but is not implemented.  Warning will be displayed.
    void petRetreat();
    void familiar();

    void addPetMod(uint16 modID, int16 amount);
    void setPetMod(uint16 modID, int16 amount);
    void delPetMod(uint16 modID, int16 amount);

    bool  hasAttachment(uint16 itemID);
    auto  getAutomatonName() -> const char*;
    uint8 getAutomatonFrame();
    uint8 getAutomatonHead();
    bool  unlockAttachment(uint16 itemID);
    uint8 getActiveManeuvers();
    void  removeOldestManeuver();
    void  removeAllManeuvers();
    void  updateAttachments();
    void  reduceBurden(float percentReduction, sol::object const& intReductionObj);

    // Mob Entity-Specific
    void   setMobLevel(uint8 level);
    uint8  getSystem();
    uint16 getFamily();
    bool   isMobType(uint8 mobType); // True if mob is of type passed to function
    bool   isUndead();               // True if mob is undead
    bool   isNM();

    uint8  getModelSize();
    void   setMobFlags(uint32 flags, uint32 mobid); // Used to manipulate the mob's flags for testing.
    uint32 getMobFlags();

    void   spawn(sol::object const& despawnSec, sol::object const& respawnSec);
    bool   isSpawned();
    auto   getSpawnPos() -> std::map<std::string, float>;               // Get Mob spawn position (x,y,z)
    void   setSpawn(float x, float y, float z, sol::object const& rot); // Sets spawn point
    uint32 getRespawnTime();
    void   setRespawnTime(uint32 seconds); // set respawn time

    void instantiateMob(uint32 groupID);

    bool hasTrait(uint8 traitID);
    bool hasImmunity(uint32 immunityID); // Check if the mob has immunity for a type of spell (list at mobentity.h)

    void setAggressive(bool aggressive);
    void setTrueDetection(bool truedetection);
    void setUnkillable(bool unkillable);
    void untargetable(bool untargetable);

    void setDelay(uint16 delay);   // sets a mobs weapon delay
    void setDamage(uint16 damage); // sets a mobs weapon damage
    bool hasSpellList();
    void setSpellList(uint16 spellList);
    void SetAutoAttackEnabled(bool state);   // halts/resumes auto attack of entity
    void SetMagicCastingEnabled(bool state); // halt/resumes casting magic
    void SetMobAbilityEnabled(bool state);   // halt/resumes mob skills
    void SetMobSkillAttack(int16 value);     // enable/disable using mobskills as regular attacks

    int16 getMobMod(uint16 mobModID);
    void  setMobMod(uint16 mobModID, int16 value);
    void  addMobMod(uint16 mobModID, int16 value);
    void  delMobMod(uint16 mobModID, int16 value);

    uint32 getBattleTime(); // Get the time in second of the battle

    uint16 getBehaviour();
    void   setBehaviour(uint16 behavior);

    auto getTarget() -> std::optional<CLuaBaseEntity>;
    void updateTarget(); // Force mob to update target from enmity container (ie after updateEnmity)
    auto getEnmityList() -> sol::table;
    auto getTrickAttackChar(CLuaBaseEntity* PLuaBaseEntity) -> std::optional<CLuaBaseEntity>; // true if TA target is available

    bool actionQueueEmpty(); // returns whether the action queue is empty or not

    void castSpell(sol::object const& spell, sol::object entity); // forces a mob to cast a spell (parameter = spell ID, otherwise picks a spell from its list)
    void useJobAbility(uint16 skillID, sol::object const& pet);   // forces a job ability use (players/pets only)
    void useMobAbility(sol::variadic_args va);                    // forces a mob to use a mobability (parameter = skill ID)
    bool hasTPMoves();

    void weaknessTrigger(uint8 level);
    bool hasPreventActionEffect();
    void stun(uint32 milliseconds);

    uint32 getPool(); // Returns a mobs pool ID. If entity is not a mob, returns nil.
    uint32 getDropID();
    void   setDropID(uint32 dropID);
    void   addTreasure(uint16 itemID, sol::object const& arg1, sol::object const& arg2); // Add item to directly to treasure pool
    uint16 getStealItem();                                                               // gets ItemID of droplist steal item from mob
    uint16 getDespoilItem();                                                             // gets ItemID of droplist despoil item from mob (steal item if no despoil item)
    uint16 getDespoilDebuff(uint16 itemID);                                              // gets the status effect id to apply to the mob on successful despoil
    bool   itemStolen();                                                                 // sets mob's ItemStolen var = true
    int16  getTHlevel();                                                                 // Returns the Monster's current Treasure Hunter Tier
    void   addDropListModification(uint16 id, uint16 newRate, sol::variadic_args va);    // Adds a modification to the drop list of this mob, erased on death

    static void Register();
};

#endif
