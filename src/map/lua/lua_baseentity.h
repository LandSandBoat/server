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
    int32 showText(lua_State*); // Displays Dialog for npc
    int32 messageText(lua_State* L);
    void  PrintToPlayer(const char* message, sol::object messageType, sol::object name); // for sending debugging messages/command confirmations to the player's client
    int32 PrintToArea(lua_State* L);                                                     // for sending area messages to multiple players at once
    int32 messageBasic(lua_State*);                                                      // Sends Basic Message
    int32 messageName(lua_State* L);                                                     // Sends a Message with a Name
    int32 messagePublic(lua_State*);                                                     // Sends a public Basic Message
    int32 messageSpecial(lua_State*);                                                    // Sends Special Message
    int32 messageSystem(lua_State*);                                                     // Sends System Message
    int32 messageCombat(lua_State* L);                                                   // Sends Combat Message

    // Variables
    int32  getCharVar(std::string const& varName);              // Returns a character variable
    void   setCharVar(std::string const& varname, int32 value); // Sets a character variable
    void   addCharVar(std::string const& varname, int32 value); // Increments/decriments/sets a character variable
    uint32 getLocalVar(std::string const& var);
    void   setLocalVar(std::string const& var, uint32 val);
    void   resetLocalVars();
    uint32 getLastOnline(); // Returns the unix timestamp of last time the player logged out or zoned

    // Packets, Events, and Flags
    int32 injectPacket(lua_State*);       // Send the character a packet kept in a file
    int32 injectActionPacket(lua_State*); // ONLY FOR DEBUGGING. Injects an action packet with the specified params.
    int32 entityVisualPacket(lua_State* L);
    int32 entityAnimationPacket(lua_State* L);

    int32 startEvent(lua_State*);        // Begins Event
    int32 startEventString(lua_State*);  // Begins Event with string param (0x33 packet)
    int32 updateEvent(lua_State*);       // Updates event
    int32 updateEventString(lua_State*); // (string, string, string, string, uint32, ...)
    int32 getEventTarget(lua_State*);    //
    void  release();                     // Stops event

    void  setFlag(uint32 flags);
    int32 moghouseFlag(lua_State*);
    int32 needToZone(lua_State*); // Check if player has zoned since the flag has been raised

    // Object Identification
    uint32 getID();
    uint16 getShortID();
    auto   getCursorTarget() -> std::shared_ptr<CLuaBaseEntity>; // Returns the ID any object under players in game cursor.

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
    int32 getCurrentAction(lua_State* L);

    int32 lookAt(lua_State* L);    // look at given position
    int32 clearTargID(lua_State*); // clears target of entity

    int32 atPoint(lua_State* L);         // is at given point
    int32 pathTo(lua_State* L);          // set new path to point without changing action
    int32 pathThrough(lua_State* L);     // walk at normal speed through the given points
    int32 isFollowingPath(lua_State* L); // checks if the entity is following a path
    int32 clearPath(lua_State* L);       // removes current pathfind and stops moving
    int32 checkDistance(lua_State*);     // Check Distacnce and returns distance number
    int32 wait(lua_State* L);            // make the npc wait a number of ms and then back into roam
    // int32 WarpTo(lua_State* L);           // warp to the given point
    // int32 RoamAround(lua_State* L);       // pick a random point to walk to
    // int32 LimitDistance(lua_State* L);    // limits the current path distance to given max distance

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
    void  ChangeMusic(uint8 blockID, uint8 musicTrackID);                    // Sets the specified music Track for specified music block.
    void  sendMenu(uint32 menu);                                             // Displays a menu (AH,Raise,Tractor,MH etc)
    bool  sendGuild(uint16 guildID, uint8 open, uint8 close, uint8 holiday); // Sends guild shop menu
    void  openSendBox();                                                     // Opens send box (to deliver items)
    void  leaveGame();                                                       // Character leaving game
    int32 sendEmote(lua_State*);                                             // Character emits emote packet.

    // Location and Positioning

    int32 getWorldAngle(lua_State* L);  // return angle (rot) between two points (vector from a to b), aligned to absolute cardinal degree
    int32 getFacingAngle(lua_State* L); // return angle between entity rot and target pos, aligned to number of degrees of difference
    int32 isFacing(lua_State*);         // true if you are facing the target
    int32 isInfront(lua_State*);        // true if you're infront of the input target
    int32 isBehind(lua_State*);         // true if you're behind the input target
    int32 isBeside(lua_State*);         // true if you're to the side of the input target

    int32 getZone(lua_State*);          // Get Entity zone
    int32 getZoneID(lua_State*);        // Get Entity zone ID
    int32 getZoneName(lua_State*);      // Get Entity zone name
    int32 isZoneVisited(lua_State*);    // true если указанная зона посещалась персонажем ранее
    int32 getPreviousZone(lua_State*);  // Get Entity previous zone
    int32 getCurrentRegion(lua_State*); // Get Entity conquest region
    int32 getContinentID(lua_State*);   // узнаем континент, на котором находится сущность
    int32 isInMogHouse(lua_State*);     // Check if entity inside a mog house

    int32 getPlayerRegionInZone(lua_State*); // Returns the player's current region in the zone. (regions made with registerRegion)
    int32 updateToEntireZone(lua_State*);    // Forces an update packet to update the NPC entity zone-wide

    int32 getPos(lua_State*);       // Get Entity position (x,y,z)
    int32 showPosition(lua_State*); // Display current position of character
    int32 getXPos(lua_State*);      // Get Entity X position
    int32 getYPos(lua_State*);      // Get Entity Y position
    int32 getZPos(lua_State*);      // Get Entity Z position
    int32 getRotPos(lua_State*);    // Get Entity Rot position

    int32 setPos(lua_State*);   // Set Entity position (x,y,z,rot) or (x,y,z,rot,zone)
    int32 warp(lua_State*);     // Returns Character to home point
    int32 teleport(lua_State*); // Set Entity position (without entity despawn/spawn packets)

    int32 addTeleport(lua_State*);     // Add new teleport means to char unlocks
    int32 getTeleport(lua_State*);     // Get unlocked teleport means
    int32 hasTeleport(lua_State*);     // Has access to specific teleport
    int32 setTeleportMenu(lua_State*); // Set favorites or menu layout preferences for homepoints or survival guides
    int32 getTeleportMenu(lua_State*); // Get favorites and menu layout preferences
    int32 setHomePoint(lua_State*);    // Sets character's homepoint

    int32 resetPlayer(lua_State*); // if player is stuck, GM command @resetPlayer name

    int32 goToEntity(lua_State*);  // Warps self to NPC or Mob; works across multiple game servers
    int32 gotoPlayer(lua_State*);  // warps self to target player
    int32 bringPlayer(lua_State*); // warps target to self

    // Items
    uint16 getEquipID(SLOTTYPE slot);   // Gets the Item Id of the item in specified slot
    int32  getEquippedItem(lua_State*); // Returns the item object from specified slot
    int32  hasItem(lua_State*);         // Check to see if Entity has item in inventory (hasItem(itemNumber))
    int32  addItem(lua_State*);         // Add item to Entity inventory (additem(itemNumber,quantity))
    int32  delItem(lua_State*);
    int32  addUsedItem(lua_State*);    // Add charged item with timer already on full cooldown
    int32  addTempItem(lua_State*);    // Add temp item to Entity Temp inventory
    int32  hasWornItem(lua_State*);    // Check if the item is already worn (player:hasWornItem(itemid))
    int32  createWornItem(lua_State*); // Update this item in worn item (player:createWornItem(itemid))

    int32 createShop(lua_State*);       // Prepare the container for work of shop ??
    int32 addShopItem(lua_State*);      // Adds item to shop container (16 max)
    int32 getCurrentGPItem(lua_State*); // Gets current GP item id and max points
    int32 breakLinkshell(lua_State*);   // Breaks all pearls/sacks

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
    int32 getStorageItem(lua_State*); // returns item object player:getStorageItem(containerid, slotid, equipslotid)
    int32 storeWithPorterMoogle(lua_State* L);
    int32 getRetrievableItemsForSlip(lua_State* L);
    int32 retrieveItemFromSlip(lua_State* L);

    // Player Appearance
    uint8  getRace();
    uint8  getGender();              // Returns the player character's gender
    auto   getName() -> const char*; // Gets Entity Name
    void   hideName(bool isHidden);
    bool   checkNameFlags(uint32 flags); // this is check and not get because it tests for a flag, it doesn't return all flags
    uint16 getModelId();
    void   setModelId(uint16 modelId, uint8 slot);
    void   setCostume(uint16 costume);
    uint16 getCostume();
    int32  costume2(lua_State*);     // set monstrosity costume
    int32  getAnimation(lua_State*); // Get Entity Animation
    int32  setAnimation(lua_State*); // Set Entity Animation
    int32  AnimationSub(lua_State*); // get or set animationsub

    // Player Status
    uint8 getNation();             // Gets Nation of Entity
    void  setNation(uint8 nation); // Sets Nation of Entity
    uint8 getAllegiance();
    void  setAllegiance(uint8 allegiance);
    uint8 getCampaignAllegiance();                 // Gets Campaign Allegiance of Entity
    void  setCampaignAllegiance(uint8 allegiance); // Sets Campaign Allegiance of Entity

    bool  isSeekingParty();
    bool  getNewPlayer();
    int32 setNewPlayer(lua_State* L);
    int32 getMentor(lua_State* L);
    int32 setMentor(lua_State* L);

    int32 getGMLevel(lua_State* L);
    int32 setGMLevel(lua_State* L);
    int32 getGMHidden(lua_State* L);
    int32 setGMHidden(lua_State* L);

    int32 isJailed(lua_State* L); // Is the player jailed
    int32 jail(lua_State* L);

    int32 canUseMisc(lua_State*); // Check misc flags of current zone.

    int32 speed(lua_State*); // скорость передвижения сущности

    int32 getPlaytime(lua_State*);
    int32 getTimeCreated(lua_State*);

    // Player Jobs and Levels
    uint8 getMainJob();             // Returns Entity Main Job
    uint8 getSubJob();              // Get Entity Sub Job
    void  changeJob(uint8 newJob);  // changes the job of a char (testing only!)
    void  changesJob(uint8 subJob); // changes the sub job of a char (testing only!)
    void  unlockJob(uint8 JobID);   // Unlocks a job for the entity, sets job level to 1
    bool  hasJob(uint8 job);        // Check to see if JOBTYPE is unlocked for a character

    uint8 getMainLvl();                 // Gets Entity Main Job Level
    uint8 getSubLvl();                  // Get Entity Sub Job Level
    uint8 getJobLevel(uint8 JobID);     // Gets character job level for specified JOBTYPE
    void  setLevel(uint8 level);        // sets the character's level
    int32 setsLevel(lua_State*);        // sets the character's level
    int32 levelCap(lua_State*);         // genkai
    int32 levelRestriction(lua_State*); // Establish/return current level restriction
    int32 addJobTraits(lua_State*);     // Add job traits

    // Player Titles and Fame
    uint16 getTitle(); // Gets character's title
    bool   hasTitle(uint16 titleID);
    void   addTitle(uint16 titleID);
    void   setTitle(uint16 titleID); // Sets character's title
    void   delTitle(uint16 titleID);

    int32 getFame(lua_State*);      // Gets Fame
    int32 addFame(lua_State*);      // Adds Fame
    int32 setFame(lua_State*);      // Sets Fame
    int32 getFameLevel(lua_State*); // Gets Fame Level for specified nation

    uint8  getRank();                        // Get Rank for current active nation
    uint8  getOtherRank(uint8 nation);       // Get Rank for a specific nation, getNationRank is used in utils, and this may be unneeded
    void   setRank(uint8 rank);              // Set Rank
    uint32 getRankPoints();                  // Get Current Rank points
    void   addRankPoints(uint32 rankpoints); // Add rank points to existing rank point total
    void   setRankPoints(uint32 rankpoints); // Set Current Rank points

    int32 addQuest(lua_State*);          // Add Quest to Entity Quest Log
    int32 delQuest(lua_State*);          // Remove quest from quest log (should be used for debugging only)
    int32 getQuestStatus(lua_State*);    // Get Quest Status
    int32 hasCompletedQuest(lua_State*); // Checks if quest has been completed
    int32 completeQuest(lua_State*);     // Set a quest status to complete

    int32 addMission(lua_State*);          // Add Mission
    int32 delMission(lua_State*);          // Delete Mission from Mission Log
    int32 getCurrentMission(lua_State*);   // Gets the current mission
    int32 hasCompletedMission(lua_State*); // Checks if mission has been completed
    int32 completeMission(lua_State*);     // Complete Mission
    int32 setMissionLogEx(lua_State*);     // Sets mission log extra data to correctly track progress in branching missions.
    int32 getMissionLogEx(lua_State*);     // Gets mission log extra data.

    int32 setEminenceCompleted(lua_State* L); // Sets the complete flag for a record of eminence
    int32 getEminenceCompleted(lua_State* L); // Gets the record completed flag
    int32 setEminenceProgress(lua_State* L);  // Sets progress on a record of eminence
    int32 getEminenceProgress(lua_State* L);  // gets progress on a record of eminence

    void  addAssault(uint8 missionID);          // Add Mission
    void  delAssault(uint8 missionID);          // Delete Mission from Mission Log
    uint8 getCurrentAssault();                  // Gets the current mission
    bool  hasCompletedAssault(uint8 missionID); // Checks if mission has been completed
    void  completeAssault(uint8 missionID);     // Complete Mission

    int32 addKeyItem(lua_State*);    // Add key item to Entity Key Item collection
    int32 hasKeyItem(lua_State*);    // Checks Entity key item collection to see if Entity has the key item
    int32 delKeyItem(lua_State*);    // Removes key item from Entity key item collection
    int32 seenKeyItem(lua_State*);   // If Key Item is viewed, add it to the seen key item collection
    int32 unseenKeyItem(lua_State*); // Attempt to remove the keyitem from the seen key item collection, only works on logout

    // Player Points
    void  addExp(uint32 exp);
    void  delExp(uint32 exp);
    int32 getMerit(uint16 merit);
    uint8 getMeritCount();
    void  setMerits(uint8 numPoints); // set merits (testing only!)

    uint32 getGil();
    void   addGil(int32 gil);
    void   setGil(int32 amount);
    bool   delGil(int32 gil);

    int32 getCurrency(std::string const& currencyType);
    void  addCurrency(std::string const& currencyType, int32 amount);
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
    int32 takeDamage(lua_State*);      // Takes damage from the provided attacker
    int32 hideHP(lua_State* L);

    int32 getMP();
    int32 getMaxMP();
    int32 getBaseMP();
    int32 addMP(int32 amount);     // Modify mp of Entity +/-
    int32 setMP(lua_State*);       // Set mp of Entity to value
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
    uint16 getMaxSkillLevel(uint8 skillId, uint8 jobId, uint8 level); // Get Skill Cap for skill and rank
    uint8  getSkillRank(uint8 rankID);                                // Get your current skill craft Rank
    void   setSkillRank(uint8 skillID, uint8 newrank);                // Set new skill craft rank
    uint16 getCharSkillLevel(uint8 skillID);                          // Get char skill level

    void addLearnedWeaponskill(uint8 wsID);
    bool hasLearnedWeaponskill(uint8 wsID);
    void delLearnedWeaponskill(uint8 wsID);

    bool addWeaponSkillPoints(uint8 slotID, uint16 points); // Adds weapon skill points to an equipped weapon

    int32 addLearnedAbility(lua_State*); // Add spell to Entity spell list
    int32 hasLearnedAbility(lua_State*); // Check to see if character has item in spell list
    int32 canLearnAbility(lua_State*);   // Check to see if character can learn spell, 0 if so
    int32 delLearnedAbility(lua_State*); // Remove spell from Entity spell list

    int32 addSpell(lua_State*);      // Add spell to Entity spell list
    int32 hasSpell(lua_State*);      // Check to see if character has item in spell list
    int32 canLearnSpell(lua_State*); // Check to see if character can learn spell, 0 if so
    int32 delSpell(lua_State*);      // Remove spell from Entity spell list

    int32 recalculateSkillsTable(lua_State*);
    int32 recalculateAbilitiesTable(lua_State*);

    // Parties and Alliances
    int32 getParty(lua_State* L);
    int32 getPartyWithTrusts(lua_State* L);
    int32 getPartySize(lua_State* L); // Get the size of a party in an entity's alliance
    int32 hasPartyJob(lua_State*);
    int32 getPartyMember(lua_State* L); // Get a character entity from another entity's party or alliance
    int32 getPartyLeader(lua_State* L);
    int32 getLeaderID(lua_State* L); // Get the id of the alliance/party leader *falls back to player id if no party*
    int32 getPartyLastMemberJoinedTime(lua_State* L);
    int32 forMembersInRange(lua_State* L);

    int32 addPartyEffect(lua_State*);    // Adds Effect to all party members
    int32 hasPartyEffect(lua_State*);    // Has Effect from all party members
    int32 removePartyEffect(lua_State*); // Removes Effect from all party members

    int32 getAlliance(lua_State* L);
    int32 getAllianceSize(lua_State* L); // Get the size of an entity's alliance

    int32 reloadParty(lua_State* L);
    int32 disableLevelSync(lua_State* L);
    int32 isLevelSync(lua_State* L);

    int32 checkSoloPartyAlliance(lua_State*); // Check if Player is in Party or Alliance 0=Solo 1=Party 2=Alliance

    int32 checkKillCredit(lua_State*);

    // Instances
    int32 getInstance(lua_State* L);
    int32 setInstance(lua_State* L);
    int32 createInstance(lua_State* L);
    int32 instanceEntry(lua_State* L);
    int32 isInAssault(lua_State*); // If player is in a Instanced Assault Dungeon returns true

    int32 getConfrontationEffect(lua_State* L);
    int32 copyConfrontationEffect(lua_State* L); // copy confrontation effect, param = targetEntity:getShortID()

    // Battlefields
    int32 getBattlefield(lua_State* L);      // returns CBattlefield* or nullptr if not available
    int32 getBattlefieldID(lua_State*);      // returns entity->PBattlefield->GetID() or -1 if not available
    int32 registerBattlefield(lua_State*);   // attempt to register a battlefield, returns BATTLEFIELD_RETURNCODE
    int32 battlefieldAtCapacity(lua_State*); // 1 if this battlefield is full
    int32 enterBattlefield(lua_State*);      // enter a battlefield entity is registered with
    int32 leaveBattlefield(lua_State*);      // leave battlefield if inside one
    int32 isInDynamis(lua_State*);           // If player is in Dynamis return true else false

    // Battle Utilities
    bool isAlive();
    bool isDead();
    void sendRaise(uint8 raiseLevel);
    void sendReraise(uint8 raiseLevel);
    void sendTractor(float xPos, float yPos, float zPos, uint8 rotation);

    int32 countdown(lua_State* L);
    int32 enableEntities(lua_State* L);
    int32 independantAnimation(lua_State* L);

    int32 engage(lua_State* L);
    int32 isEngaged(lua_State* L);
    int32 disengage(lua_State* L);
    int32 timer(lua_State* L); // execute lua closure after some time
    int32 queue(lua_State* L);
    int32 addRecast(lua_State*);
    int32 hasRecast(lua_State*);
    int32 resetRecast(lua_State*);  // Reset one recast ID
    int32 resetRecasts(lua_State*); // Reset recasts for the caller

    int32 addListener(lua_State* L);
    int32 removeListener(lua_State* L);
    int32 triggerListener(lua_State* L);

    int32 getEntity(lua_State* L);
    int32 getNearbyEntities(lua_State* L);
    int32 canChangeState(lua_State* L);

    int32 wakeUp(lua_State*); // wakes target if necessary

    int32 recalculateStats(lua_State* L);
    int32 checkImbuedItems(lua_State* L);

    int32 isDualWielding(lua_State*); // Checks if the battle entity is dual wielding

    // Enmity
    int32 getCE(lua_State*);        // gets current CE the mob has towards the player
    int32 getVE(lua_State*);        // gets current VE the mob has towards the player
    int32 setCE(lua_State*);        // sets current CE the mob has towards the player
    int32 setVE(lua_State*);        // sets current VE the mob has towards the player
    int32 addEnmity(lua_State*);    // Add specified amount of enmity (target, CE, VE)
    int32 lowerEnmity(lua_State*);  // lower enmity to player for specificed mob
    int32 updateEnmity(lua_State*); // Adds Enmity to player for specified mob
    int32 transferEnmity(lua_State*);
    int32 updateEnmityFromDamage(lua_State*); // Adds Enmity to player for specified mob for the damage specified
    int32 updateEnmityFromCure(lua_State*);
    int32 resetEnmity(lua_State*);      // resets enmity to player for specificed mob
    int32 updateClaim(lua_State*);      // Adds Enmity to player for specified mob and claims
    int32 hasEnmity(lua_State*);        // Does the player have any enmity at all from any source
    int32 getNotorietyList(lua_State*); // Returns a table with all of the entities on a chars notoriety list

    // Status Effects
    bool addStatusEffect(sol::object const& arg0, sol::object const& arg1, sol::object const& arg2, sol::object const& arg3,
                         sol::object const& arg4, sol::object const& arg5, sol::object const& arg6);
    bool addStatusEffectEx(sol::object const& arg0, sol::object const& arg1, sol::object const& arg2, sol::object const& arg3,
                           sol::object const& arg4, sol::object const& arg5, sol::object const& arg6, sol::object const& arg7,
                           sol::object const& arg8, sol::object const& arg9);
    auto getStatusEffect(uint16 StatusID, sol::object const& SubID) -> CStatusEffect*;
    auto   getStatusEffects() -> sol::table;
    int16 getStatusEffectElement(uint16 statusId);
    bool   canGainStatusEffect(uint16 effect, uint16 power);           // Returns true if the effect can be added
    bool hasStatusEffect(uint16 StatusID, sol::object const& SubID);// Checks to see if character has specified effect
    uint16 hasStatusEffectByFlag(uint16 StatusID);  // Checks to see if a character has an effect with the specified flag
    uint8 countEffect(uint16 StatusID);            // Gets the number of effects of a specific type on the player

    bool delStatusEffect(uint16 StatusID, sol::object const& SubID);        // Removes Status Effect
    void delStatusEffectsByFlag(uint16 flag, sol::object const& silent); // Removes Status Effects by Flag
    bool delStatusEffectSilent(uint16 StatusID);  // Removes Status Effect, suppresses message
    uint16 eraseStatusEffect();      // Used with "Erase" spell
    uint8 eraseAllStatusEffect();   // Erases all effects and returns number erased
    int32 dispelStatusEffect(sol::object const& flagObj); // Used with "Dispel" spell
    uint8 dispelAllStatusEffect(sol::object const& flagObj); // Dispels all effects and returns number erased
    uint16 stealStatusEffect(CLuaBaseEntity* PTargetEntity, sol::object const& flagObj); // Used in mob skills to steal effects

    void  addMod(uint16 type, int16 amount); // Adds Modifier Value
    int32 getMod(lua_State*); // Retrieves Modifier Value
    int32 setMod(lua_State*); // Sets Modifier Value
    int32 delMod(lua_State*); // Subtracts Modifier Value

    int32 addLatent(lua_State*); // Adds a latent effect
    int32 delLatent(lua_State*); // Removes a latent effect

    int32 fold(lua_State*);
    int32 doWildCard(lua_State*);
    int32 addCorsairRoll(lua_State*); // Adds corsair roll effect
    int32 hasCorsairEffect(lua_State*);
    int32 hasBustEffect(lua_State*);  // Checks to see if a character has a specified busted corsair roll
    int32 numBustEffects(lua_State*); // Gets the number of bust effects on the player
    int32 healingWaltz(lua_State*);   // Used with "Healing Waltz" ability
    int32 addBardSong(lua_State*);    // Adds bard song effect

    int32 charm(lua_State*);   // applies charm on target
    int32 uncharm(lua_State*); // removes charm on target

    int32 addBurden(lua_State* L);
    int32 setStatDebilitation(lua_State* L);

    // Damage Calculation
    uint16 getStat(uint16 statId); // STR,DEX,VIT,AGI,INT,MND,CHR,ATT,DEF
    uint16 getACC();
    uint16 getEVA();
    int    getRACC();
    uint16 getRATT();
    uint16 getILvlMacc();
    bool   isSpellAoE(uint16 spellId);

    int32 physicalDmgTaken(int32 damage, sol::object const& dmgType);
    int32 magicDmgTaken(lua_State* L);
    int32 rangedDmgTaken(int32 damage, sol::object const& dmgType);
    int32 breathDmgTaken(int32 damage);
    void  handleAfflatusMiseryDamage(int32 damage);

    bool  isWeaponTwoHanded();
    int32 getMeleeHitDamage(lua_State*); // gets the damage of a single hit vs the specified mob
    int32 getWeaponDmg(lua_State*);      // gets the current equipped weapons' DMG rating
    int32 getWeaponDmgRank(lua_State*);  // gets the current equipped weapons' DMG rating for Rank calc
    int32 getOffhandDmg(lua_State*);     // gets the current equipped offhand's DMG rating (used in WS calcs)
    int32 getOffhandDmgRank(lua_State*); // gets the current equipped offhand's DMG rating for Rank calc
    int32 getRangedDmg(lua_State*);      // Get ranged weapon DMG rating
    int32 getRangedDmgRank(lua_State*);  // Get ranged weapond DMG rating used for calculating rank
    int32 getAmmoDmg(lua_State*);        // Get ammo DMG rating

    int32 removeAmmo(lua_State* L);

    int32 getWeaponSkillLevel(lua_State*);   // Get Skill for equipped weapon
    int32 getWeaponDamageType(lua_State*);   // gets the type of weapon equipped
    int32 getWeaponSkillType(lua_State*);    // gets the type of weapon equipped
    int32 getWeaponSubSkillType(lua_State*); // gets the subskill of weapon equipped
    int32 getWSSkillchainProp(lua_State* L); // returns weapon skill's skillchain properties (up to 3)

    int32 takeWeaponskillDamage(lua_State* L);
    int32 takeSpellDamage(lua_State* L);

    // Pets and Automations
    int32 spawnPet(lua_State*);   // Calls Pet
    int32 despawnPet(lua_State*); // Despawns Pet

    int32 spawnTrust(lua_State*);
    int32 clearTrusts(lua_State*);
    int32 getTrustID(lua_State*);
    int32 trustPartyMessage(lua_State*);
    int32 addSimpleGambit(lua_State*);
    int32 addFullGambit(lua_State*);
    int32 setTrustTPSkillSettings(lua_State*);

    int32 isJugPet(lua_State*); // If the entity has a pet, test if it is a jug pet.
    int32 hasValidJugPetItem(lua_State*);

    int32 hasPet(lua_State*);   // returns true if the player has a pet
    int32 getPet(lua_State*);   // Creates an LUA reference to a pet entity
    int32 getPetID(lua_State*); // If the entity has a pet, returns the PetID to identify pet type.
    int32 getMaster(lua_State*);
    int32 getPetElement(lua_State*);

    int32 getPetName(lua_State*);
    int32 setPetName(lua_State*);

    int32 getCharmChance(lua_State*); // Gets the chance the entity has to charm its target.
    int32 charmPet(lua_State*);       // Charms Pet (Beastmaster ability only)

    int32 petAttack(lua_State*); // Despawns Pet
    int32 petAbility(lua_State*);
    int32 petRetreat(lua_State*);
    int32 familiar(lua_State*); // familiar on pet

    int32 addPetMod(lua_State*);
    int32 setPetMod(lua_State*);
    int32 delPetMod(lua_State*);

    int32 hasAttachment(lua_State*);
    int32 getAutomatonName(lua_State*);
    int32 getAutomatonFrame(lua_State* L);
    int32 getAutomatonHead(lua_State* L);
    int32 unlockAttachment(lua_State* L);
    int32 getActiveManeuvers(lua_State*);
    int32 removeOldestManeuver(lua_State*);
    int32 removeAllManeuvers(lua_State*);
    int32 updateAttachments(lua_State*);

    // Mob Entity-Specific
    int32 setMobLevel(lua_State*);
    int32 getSystem(lua_State*);
    int32 getFamily(lua_State*);
    int32 isMobType(lua_State*); // True if mob is of type passed to function
    int32 isUndead(lua_State*);  // True if mob is undead
    int32 isNM(lua_State* L);

    int32 getModelSize(lua_State* L); // Gets model size
    int32 setMobFlags(lua_State*);    // Used to manipulate the mob's flags for testing.
    int32 getMobFlags(lua_State*);

    int32 spawn(lua_State* L);
    int32 isSpawned(lua_State*);
    int32 getSpawnPos(lua_State*); // Get Mob spawn position (x,y,z)
    int32 setSpawn(lua_State*);    // Sets spawn point
    int32 getRespawnTime(lua_State*);
    int32 setRespawnTime(lua_State*); // set respawn time

    int32 instantiateMob(lua_State* L);

    int32 hasTrait(lua_State*);
    int32 hasImmunity(lua_State*); // Check if the mob has immunity for a type of spell (list at mobentity.h)

    int32 setAggressive(lua_State* L);
    int32 setTrueDetection(lua_State* L);
    void  setUnkillable(bool unkillable);
    int32 untargetable(lua_State* L);

    int32 setDelay(lua_State*);  // sets a mobs weapon delay
    int32 setDamage(lua_State*); // sets a mobs weapon damage
    int32 hasSpellList(lua_State*);
    int32 setSpellList(lua_State*);
    int32 SetAutoAttackEnabled(lua_State*);   // halts/resumes auto attack of entity
    int32 SetMagicCastingEnabled(lua_State*); // halt/resumes casting magic
    int32 SetMobAbilityEnabled(lua_State*);   // halt/resumes mob skills
    int32 SetMobSkillAttack(lua_State*);      // enable/disable using mobskills as regular attacks

    int32 getMobMod(lua_State*);
    int32 setMobMod(lua_State*);
    int32 addMobMod(lua_State*);
    int32 delMobMod(lua_State*);

    int32 getBattleTime(lua_State*); // Get the time in second of the battle

    int32 getBehaviour(lua_State* L);
    int32 setBehaviour(lua_State* L);

    int32 getTarget(lua_State*);
    int32 updateTarget(lua_State*); // Force mob to update target from enmity container (ie after updateEnmity)
    int32 getEnmityList(lua_State* L);
    int32 getTrickAttackChar(lua_State*); // true if TA target is available

    int32 actionQueueEmpty(lua_State*); // returns whether the action queue is empty or not

    int32 castSpell(lua_State*);     // forces a mob to cast a spell (parameter = spell ID, otherwise picks a spell from its list)
    int32 useJobAbility(lua_State*); // forces a job ability use (players/pets only)
    int32 useMobAbility(lua_State*); // forces a mob to use a mobability (parameter = skill ID)
    int32 hasTPMoves(lua_State*);

    int32 weaknessTrigger(lua_State* L);
    int32 hasPreventActionEffect(lua_State*);
    int32 stun(lua_State* L);

    int32 getPool(lua_State* L); // Returns a mobs pool ID. If entity is not a mob, returns nil.
    int32 getDropID(lua_State* L);
    int32 setDropID(lua_State* L);
    int32 addTreasure(lua_State*);      // Add item to directly to treasure pool
    int32 getStealItem(lua_State*);     // gets ItemID of droplist steal item from mob
    int32 getDespoilItem(lua_State*);   // gets ItemID of droplist despoil item from mob (steal item if no despoil item)
    int32 getDespoilDebuff(lua_State*); // gets the status effect id to apply to the mob on successful despoil
    int32 itemStolen(lua_State*);       // sets mob's ItemStolen var = true
    int32 getTHlevel(lua_State*);       // Returns the Monster's current Treasure Hunter Tier

    static void Register();
};

#endif
