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
#include "data/enums/behavior.h"
#include "data/enums/emote.h"
#include "data/enums/emote_mode.h"
#include "data/enums/entity_flags.h"
#include "data/enums/fame_area.h"
#include "data/enums/mob_mod.h"
#include "data/enums/mob_type.h"
#include "data/enums/music_slot.h"
#include "data/enums/quest_log.h"
#include "data/enums/roam_flag.h"
#include "data/enums/terrain_type.h"
#include "data/enums/zone_misc.h"
#include "enums/mission_log.h"
#include "lua_trade_container.h"
#include "packets/s2c/0x009_message.h"
#include "utils/battleutils.h"
#include "utils/charutils.h"

#include <sol/forward.hpp>

#include <map>
#include <string>
#include <tuple>
enum class POSMODE : uint8;
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

    auto GetBaseEntity() const -> CBaseEntity*
    {
        return m_PBaseEntity;
    }

    friend auto operator<<(std::ostream& out, const CLuaBaseEntity& entity) -> std::ostream&;

    // Messaging System
    void showText(CLuaBaseEntity* entity, uint16 messageID, const sol::object& p0, const sol::object& p1, const sol::object& p2, const sol::object& p3, const sol::object& p4, const sol::object& p5, const sol::object& messageType);
    void messageText(CLuaBaseEntity* PLuaBaseEntity, uint16 messageID, const sol::object& arg2, const sol::object& arg3);
    void printToPlayer(const std::string& message, const sol::object& messageTypeObj, const sol::object& nameObj);
    void printToArea(const std::string& message, const sol::object& arg1, const sol::object& arg2, const sol::object& arg3, const sol::object& arg4);
    void messageBasic(uint16 messageID, const sol::object& p0, const sol::object& p1, const sol::object& target);
    void messageName(uint16 messageID, const sol::object& entity, const sol::object& p0, const sol::object& p1, const sol::object& p2, const sol::object& p3, const sol::object& chat, const sol::object& sender, const sol::object& showSender);
    void messagePublic(uint16 messageID, const CLuaBaseEntity* PEntity, const sol::object& arg2, const sol::object& arg3);
    void messageSpecial(uint16 messageID, sol::variadic_args va);
    void messageSystem(MsgStd messageID, const sol::object& p0, const sol::object& p1);
    void messageCombat(const sol::object& speaker, int32 p0, int32 p1, MsgBasic message) const;
    void messageStandard(uint16 messageID);

    void customMenu(const sol::object& obj);

    // Variables
    auto getCharVar(const std::string& varName) -> int32;
    auto getCharVarsWithPrefix(const std::string& prefix) -> sol::table;
    auto getCharVarsWithSuffix(const std::string& suffix) -> sol::table;
    void setCharVar(const std::string& varname, int32 value, const sol::object& expiry);
    void setCharVarExpiration(const std::string& varName, uint32 expiry); // Sets character variable expiration timestamp
    void incrementCharVar(const std::string& varname, int32 value);       // Increments/decrements/sets a character variable
    void setVolatileCharVar(const std::string& varName, int32 value, const sol::object& expiry);
    auto getLocalVars() -> sol::table;
    auto getLocalVar(const std::string& var) -> uint32;
    void setLocalVar(const std::string& var, uint32 val);
    void clearLocalVarsWithPrefix(const std::string& prefix);
    void resetLocalVars();

    auto getData() const -> sol::table;
    void resetData() const;

    void clearVarsWithPrefix(const std::string& prefix);
    auto getLastOnline() -> uint32; // Returns the unix timestamp of last time the player logged out or zoned

    // Packets, Events, and Flags
    void injectPacket(const std::string& filename); // Send the character a packet kept in a file
    void injectActionPacket(uint32 inTargetID, uint16 inCategory, uint16 inAnimationID, uint16 inInfo, uint16 inReaction, uint16 inMessage, uint16 inActionParam, uint16 inParam) const;
    void entityVisualPacket(const std::string& command, const sol::object& entity) const;
    void entityAnimationPacket(const char* command, const sol::object& target);
    void sendDebugPacket(const sol::table& packetData);
    void sendLinkshellConcierge(const sol::table& data) const;
    void sendChocoboRace(const sol::table& race) const;

    void StartEventHelper(int32 EventID, sol::variadic_args va, EVENT_TYPE eventType);
    auto ParseEvent(int32 EventID, sol::variadic_args va, EventPrep* eventPreparation, EVENT_TYPE eventType) -> EventInfo*;
    void startEvent(int32 EventID, sol::variadic_args va);
    void startEventString(int32 EventID, sol::variadic_args va);      // Begins Event with string param (0x33 packet)
    void startCutscene(int32 EventID, sol::variadic_args va);         // Begins cutscene which locks the character
    void startOptionalCutscene(int32 EventID, sol::variadic_args va); // Begins an event that can turn into a cutscene

    void updateEvent(sol::variadic_args va);
    void updateEventString(sol::variadic_args va); // (string, string, string, string, uint32, ...)
    auto getEventTarget() -> CBaseEntity*;
    auto isInEvent() -> bool;     // Returns true if the player is in an event
    void release();               // Stops event
    auto startSequence() -> bool; // Flags the player as being in a sequence
    auto didGetMessage() -> bool; // Used by interaction framework to determine if player triggered something else
    void resetGotMessage();       // Used by interaction framework to reset if player triggered something else

    auto getMoghouseFlag() -> uint16;
    void setMoghouseFlag(uint16 flag);
    auto needToZone(const sol::object& arg0) -> bool;

    // Object Identification
    auto getID() -> uint32;
    auto getTargID() -> uint16;
    auto getCursorTarget() -> CBaseEntity*;

    auto getObjType() const -> uint8;

    auto isPC() const -> bool;
    auto isNPC() const -> bool;
    auto isMob() const -> bool;
    auto isPet() const -> bool;
    auto isTrust() const -> bool;
    auto isFellow() const -> bool;
    auto isAlly() const -> bool;

    // AI and Control
    void initNpcAi();
    void resetAI();
    auto getStatus() -> xi::Status;
    void setStatus(xi::Status status);
    auto getCurrentAction() -> uint8;
    auto canUseAbilities() -> bool;

    void lookAt(const sol::object& arg0, const sol::object& arg1, const sol::object& arg2);
    void facePlayer(CLuaBaseEntity* PLuaBaseEntity, const sol::object& nonGlobal);
    void clearTargID();

    auto atPoint(sol::variadic_args va) -> bool;                                          // is at given point
    void pathTo(float x, float y, float z, const sol::object& flags);                     // set new path to point without changing action
    auto pathThrough(const sol::table& pointsTable, const sol::object& flagsObj) -> bool; // walk at normal speed through the given points
    auto isFollowingPath() -> bool;                                                       // checks if the entity is following a path
    void clearPath(const sol::object& pauseObj);                                          // removes current pathfind and stops moving
    void continuePath();                                                                  // resumes previous pathfind if it was paused
    auto checkDistance(sol::variadic_args va) -> float;                                   // Check Distance and returns distance number
    void wait(const sol::object& milliseconds);                                           // make the npc wait a number of ms and then back into roam
    void follow(CLuaBaseEntity* target, uint8 followType);                                // makes an npc follow or runaway from another target
    auto hasFollowTarget() -> bool;                                                       // checks if the mob has a target that it is currently following (via follow function)
    void unfollow();                                                                      // makes an npc stop following
    // int32 WarpTo(lua_Stat* L);           // warp to the given point -- These don't exist, breaking them just in case someone uncomments
    // int32 RoamAround(lua_Stat* L);       // pick a random point to walk to
    // int32 LimitDistance(lua_Stat* L);    // limits the current path distance to given max distance
    auto canSee(const CLuaBaseEntity* PTarget, const sol::object& ignoreInvisibleBoundaries) -> bool;
    auto inWater() -> bool;

    void openDoor(const sol::object& seconds);
    void closeDoor(const sol::object& seconds);

    void addPeriodicTrigger(uint8 id, uint16 period, uint16 minOffset); // Adds a periodic trigger to the NPC that allows time based scripting
    void showNPC(const sol::object& seconds);
    void hideNPC(const sol::object& seconds);
    void updateNPCHideTime(const sol::object& seconds); // Updates the length of time a NPC remains hidden, if shorter than the original hide time.

    auto getWeather(const sol::object& ignoreScholar) const -> uint8;
    void setWeather(xi::Weather weatherType); // Set Weather condition (GM COMMAND)

    // PC Instructions
    void changeMusic(xi::MusicSlot slotId, uint16 trackId) const;                                                  // Sets the specified music Track for specified music block.
    void sendMenu(uint32 menu);                                                                                    // Displays a menu (AH,Raise,Tractor,MH etc)
    auto sendGuild(uint16 guildId, uint8 open, uint8 close, uint8 holiday) const -> bool;                          // Sends guild shop menu
    auto openGuildShop(CLuaBaseEntity* PNpc, uint8 open, uint8 close, sol::optional<uint8> holiday) const -> bool; // Opens a lua guild shop and remembers the NPC the PC opened it with
    void clearGuildShop() const;                                                                                   // Clears the PC's open guild shop handle
    void sendGuildClose(uint8 open, uint8 close, sol::optional<bool> passive) const;                               // Sends the guild-open packet with a Close status
    void openSendBox() const;                                                                                      // Opens send box (to deliver items)
    void leaveGame();
    void sendEmote(const CLuaBaseEntity* target, xi::Emote emote, xi::EmoteMode emoteMode, bool othersOnly) const;

    // Location and Positioning
    auto getWorldAngle(sol::variadic_args va) -> int16;                                       // return angle (rot) between two points (vector from a to b), aligned to absolute cardinal degree
    auto getFacingAngle(const CLuaBaseEntity* target) -> int16;                               // return angle between entity rot and target pos, aligned to number of degrees of difference
    auto isFacing(const CLuaBaseEntity* target, const sol::object& angleArg) -> bool;         // true if you are facing the target
    auto isInfront(const CLuaBaseEntity* target, const sol::object& angleArg) -> bool;        // true if you're infront of the input target
    auto isBehind(const CLuaBaseEntity* target, const sol::object& angleArg) -> bool;         // true if you're behind the input target
    auto isBeside(const CLuaBaseEntity* target, const sol::object& angleArg) -> bool;         // true if you're to the side of the input target
    auto isToEntitysLeft(const CLuaBaseEntity* target, const sol::object& angleArg) -> bool;  // true if you're to the left side of the input target (from target's perspective)
    auto isToEntitysRight(const CLuaBaseEntity* target, const sol::object& angleArg) -> bool; // true if you're to the right side of the input target (from target's perspective)

    auto getZone(const sol::object& arg0) -> CZone*;
    auto getZoneID() -> xi::ZoneId;
    auto getZoneName() -> std::string;
    auto hasVisitedZone(uint16 zone) -> bool;
    auto getPreviousZone() -> xi::ZoneId;
    auto getPreviousZoneLineID() -> uint32;
    auto getCurrentRegion() -> uint8;
    auto getContinentID() -> uint8;
    auto inMogHouse(sol::optional<xi::MogHouse> kind) -> bool;
    auto visitMogHouse(uint32 hostId, CLuaBaseEntity* PLuaNpc) -> bool;
    auto getMogHouseOwner() -> CBaseEntity*;
    auto getMogHouseVisitors() -> sol::table;

    auto isPlayerInTriggerArea(uint32 triggerAreaId) -> bool;
    void onPlayerTriggerAreaEnter(uint32 triggerAreaId);
    void onPlayerTriggerAreaLeave(uint32 triggerAreaId);
    void clearPlayerTriggerAreas();

    void updateToEntireZone(xi::Status statusID, uint8 animation, const sol::object& matchTime); // Forces an update packet to update the NPC entity zone-wide
    void sendEntityUpdateToPlayer(CLuaBaseEntity* entityToUpdate, uint8 entityUpdate, uint8 updateMask);
    void sendEmptyEntityUpdateToPlayer(CLuaBaseEntity* entityToUpdate);

    void forceRezone();

    auto getPos() -> sol::table;
    void showPosition();
    auto getXPos() -> float;
    auto getYPos() -> float;
    auto getZPos() -> float;
    auto getRotPos() -> uint8;
    void setRotation(uint8 rotation);

    void positionSpecial(std::map<std::string, float> pos, POSMODE mode);
    void setPos(sol::variadic_args va);
    void warp();
    void teleport(std::map<std::string, float> pos, const sol::object& arg1); // Set Entity position (without entity despawn/spawn packets)

    void addTeleport(uint8 teleType, uint32 bitval, const sol::object& setval);  // Add new teleport means to char unlocks
    auto getTeleport(uint8 type, const sol::object& abysseaRegionObj) -> uint32; // Get unlocked teleport means
    auto getTeleportTable(uint8 type) -> sol::table;
    auto hasTeleport(uint8 tType, uint8 bit, const sol::object& arg2) -> bool;
    void setTeleportMenu(uint16 type, const sol::object& teleportObj);
    auto getTeleportMenu(uint8 type) -> sol::table;
    void setHomePoint();

    void learnMazeVoucher(uint8 voucherId);
    auto hasMazeVoucher(uint8 voucherId) -> bool;
    void learnMazeRune(uint16 runeId);
    auto hasMazeRune(uint16 runeId) -> bool;

    void resetPlayer(const char* charName);

    void gotoEntity(uint32 targetID, const sol::object& option);
    auto gotoPlayer(const std::string& playerName) -> bool;
    auto bringPlayer(const std::string& playerName) -> bool;

    // Items
    auto getEquipID(SLOTTYPE slot) -> uint16;
    auto getEquippedItem(uint8 slot) -> CItem*;
    auto hasEquipped(uint16 equipmentID) -> bool; // Returns true if item is equipped in any slot
    auto hasItem(uint16 itemID, const sol::object& location) -> bool;
    auto getItemCount(uint16 itemID) -> uint32;
    auto addItem(sol::variadic_args va) const -> CItem*;
    auto delItem(uint16 itemID, int32 quantity, const sol::object& containerID) -> bool;
    auto delItemAt(uint16 itemID, int32 quantity, uint8 containerId, uint8 slotId) -> bool;
    auto delContainerItems(const sol::object& containerID) -> bool;
    auto addUsedItem(uint16 itemID) -> bool;
    auto addTempItem(uint16 itemID, const sol::object& arg1) -> bool;
    auto getWornUses(uint16 itemID) const -> uint8;                      // Check if the item is already worn
    auto incrementItemWear(uint16 itemID) const -> uint8;                // Increment the item's worn value and returns it
    auto findItem(uint16 itemID, const sol::object& location) -> CItem*; // Like hasItem, but returns the item object (nil if not found)
    auto findItems(uint16 itemID, const sol::object& location) -> sol::table;
    auto getItems(const sol::object& location) -> sol::table;

    void createShop(uint8 size, const sol::object& arg1);
    void addShopItem(uint16 itemID, double rawPrice, sol::optional<sol::table> requirements) const;
    auto getCurrentGPItem(uint8 guildId) const -> std::tuple<uint16, uint16>;
    auto breakLinkshell(const std::string& lsname) -> bool;
    auto addLinkpearl(const std::string& lsname, bool equip) -> bool;

    // Trading
    auto getContainerSize(uint8 locationID) -> uint8;
    void changeContainerSize(uint8 locationID, int8 newSize);  // Increase/Decreases container size
    auto getFreeSlotsCount(const sol::object& locID) -> uint8; // Gets value of free slots in Entity inventory
    auto confirmTrade() const -> bool;                         // Complete trade with an npc, only removing confirmed items. False if any of it was not taken
    auto tradeComplete() const -> bool;                        // Complete trade with an npc. False if any of it was not taken
    auto getTrade() -> CLuaTradeContainer;

    // Equipping
    auto canEquipItem(uint16 itemID, const sol::object& chkLevel) -> bool;
    void equipItem(uint16 itemID, const sol::object& container, const sol::object& equipSlot) const;
    void unequipItem(uint8 slotID);

    void setEquipBlock(uint16 equipBlock);
    void lockEquipSlot(uint8 slot);
    void unlockEquipSlot(uint8 slot);
    auto hasSlotEquipped(uint8 slot) -> bool;

    auto getShieldSize() -> int8;
    auto getShieldDefense() -> int16;

    void addGearSetMod(uint8 setId, xi::Mod modId, uint16 modValue);
    void clearGearSetMods();

    // Storing
    auto getStorageItem(uint8 container, uint8 slotID, uint8 equipID) -> CItem*;
    auto storeWithPorterMoogle(uint16 slipId, const sol::table& extraTable, const sol::table& storableItemIdsTable) -> uint8;
    auto getRetrievableItemsForSlip(uint16 slipId) const -> sol::table;
    void retrieveItemFromSlip(uint16 slipId, uint16 itemId, uint16 extraId, uint8 extraData);

    // Player Appearance
    auto getRace() -> uint8;
    auto getFace() -> uint8;
    auto getGender() -> uint8;
    auto getSize() -> uint8;
    auto raceChange(CharRace newRace, CharFace newFace, CharSize newSize) -> bool;
    auto getName() -> std::string;
    auto getPacketName() -> std::string;
    void renameEntity(const std::string& newName, const sol::object& arg2);
    void hideName(bool isHidden);
    auto getModelId() -> uint16;
    void setModelId(uint16 modelId, const sol::object& slotObj);
    void setLook(const sol::table& look);
    auto getEquipmentModelIds() -> sol::table;
    auto getCostume() -> uint16;
    void setCostume(uint16 costume);
    auto getCostume2() -> uint16;
    void setCostume2(uint16 costume);
    auto getAnimation() -> xi::Animation;
    void setAnimation(xi::Animation animation);
    auto getAnimationSub() -> uint8;
    void setAnimationSub(uint8 animationsub, const sol::object& sendUpdate);
    void setSpawnAnimation(xi::SpawnAnimation spawnAnimation);
    auto getCallForHelpFlag() const -> bool;
    void setCallForHelpFlag(bool cfh);
    auto getCallForHelpBlocked() const -> bool;
    void setCallForHelpBlocked(bool blocked);

    // Player Status
    auto getNation() -> xi::Nation;
    void setNation(xi::Nation nation);
    auto getAllegiance() -> xi::Allegiance;
    void setAllegiance(xi::Allegiance allegiance);

    auto getCampaignAllegiance() -> uint8;
    void setCampaignAllegiance(uint8 allegiance);

    auto isSeekingParty() -> bool;
    auto getNewPlayer() -> bool;
    void setNewPlayer(bool newplayer);
    auto getMentor() const -> bool;
    void setMentor(bool mentor) const;

    auto getGMLevel() -> uint8;
    void setGMLevel(uint8 level);
    void setVisibleGMLevel(uint8 level);
    auto getVisibleGMLevel() -> uint8;
    auto getGMHidden() -> bool;
    void setGMHidden(bool isHidden);
    auto getWallhack() -> bool;
    void setWallhack(bool enable);
    void setFreezeFlag(bool isFrozen);

    auto isJailed() -> bool;
    void jail();

    auto canUseMisc(xi::ZoneMisc misc) -> bool; // Check misc flags of current zone.

    auto getSpeed() -> uint8;
    auto getBaseSpeed() -> uint8;
    void setBaseSpeed(uint8 speedVal);
    void setAnimationSpeed(uint8 speedVal);

    auto getPlaytime(const sol::object& shouldUpdate) -> uint32;
    auto getTimeCreated() -> uint32;

    // Player Jobs and Levels
    auto getMainJob() -> xi::Job;
    auto getSubJob() -> xi::Job;
    void changeJob(uint8 newJob);
    void changesJob(uint8 subJob);
    void unlockJob(uint8 JobID);
    auto hasJob(uint8 job) -> bool;

    auto getMainLvl() -> uint8;
    auto getSubLvl() -> uint8;
    auto getJobLevel(uint8 JobID) -> uint8; // Gets character job level for specified JOBTYPE
    void setLevel(uint8 level);             // sets the character's mainjob level
    void setsLevel(uint8 slevel);           // sets the character's subjob level
    auto getLevelCap() -> uint8;            // genkai
    void setLevelCap(uint8 cap);
    auto levelRestriction(const sol::object& level) -> uint8; // Establish/return current level restriction
    void addWyvernJobTraits(uint8 jobID, uint8 level);

    // Monstrosity
    auto getMonstrosityData() -> sol::table;
    void setMonstrosityData(sol::table table);
    auto getBelligerencyFlag() -> bool;
    void setBelligerencyFlag(bool flag);
    void changeMonstrositySpecies(uint16 speciesCode);
    auto getMonstrositySize() -> uint8;
    void setMonstrosityEntryData(float x, float y, float z, uint8 rot, uint16 zoneId, uint8 mjob, uint8 sjob);
    auto getMonstrosityShop() -> sol::table;
    auto getMonstrosityExits(xi::ZoneId zoneId) -> sol::table;
    auto isMonstrosityPassageZone(xi::ZoneId zoneId) -> bool;

    // Player Titles and Fame
    auto getTitle() -> uint16;
    auto hasTitle(uint16 titleID) -> bool;
    void addTitle(uint16 titleID);
    void setTitle(uint16 titleID);
    void delTitle(uint16 titleID);

    auto getFame(xi::FameArea area) const -> uint16;
    void addFame(xi::FameArea area, uint16 fame);
    void setFame(xi::FameArea area, uint16 fame);
    auto getFameLevel(xi::FameArea area) const -> uint8; // Gets Fame Level for specified nation

    auto getRank(xi::Nation nation) -> uint8;
    void setRank(uint8 rank);
    auto getRankPoints() -> uint16;
    void addRankPoints(uint16 rankpoints);
    void setRankPoints(uint16 rankpoints);

    void addQuest(xi::QuestLog logId, uint16 questId) const;
    void delCurrentQuest(xi::QuestLog logId, uint16 questID) const;
    void delQuest(xi::QuestLog logId, uint16 questID) const;
    auto getQuestStatus(xi::QuestLog logId, uint16 questID) const -> uint8;
    auto hasCompletedQuest(xi::QuestLog logId, uint16 questID) const -> bool;
    void completeQuest(xi::QuestLog logId, uint16 questID) const;

    void addMission(MissionLog logId, uint16 missionID) const;
    void delMission(MissionLog logId, uint16 missionID) const;
    auto getCurrentMission(const sol::object& missionLogObj) const -> uint16;
    auto hasCompletedMission(MissionLog logId, uint16 missionID) const -> bool;
    void completeMission(MissionLog logId, uint16 missionID) const;

    void setMissionStatus(MissionLog logId, const sol::object& arg2Obj, const sol::object& arg3Obj) const;
    auto getMissionStatus(MissionLog logId, const sol::object& missionStatusPosObj) const -> uint32;
    void sendPartialMissionLog(MissionLog logId, bool completed) const;

    void setEminenceCompleted(uint16 recordID, const sol::object& arg1, const sol::object& arg2);
    auto getEminenceCompleted(uint16 recordID) -> bool;
    auto getNumEminenceCompleted() -> uint16;
    auto setEminenceProgress(uint16 recordID, uint32 progress, const sol::object& arg2) -> bool;
    auto getEminenceProgress(uint16 recordID) -> Maybe<uint32>;
    auto hasEminenceRecord(uint16 recordID) -> bool;
    void triggerRoeEvent(uint8 eventNum, const sol::object& reqTable);
    void setUnityLeader(uint8 leaderID);
    auto getUnityLeader() -> uint8;
    auto getUnityRank(const sol::object& unityObj) -> Maybe<uint8>;
    auto getClaimedDeedMask() -> sol::table;
    void toggleReceivedDeedRewards();
    void setClaimedDeed(uint16 deedBitNum);
    void resetClaimedDeeds();

    void setUniqueEvent(uint16 uniqueEventId);
    void delUniqueEvent(uint16 uniqueEventId);
    auto hasCompletedUniqueEvent(uint16 uniqueEventId) -> bool;

    void addAssault(uint8 missionID) const;
    void delAssault(uint8 missionID);
    auto getCurrentAssault() -> uint8;
    auto hasCompletedAssault(uint8 missionID) -> bool;
    void completeAssault(uint8 missionID) const;

    void addKeyItem(xi::KeyItem keyItemID) const;
    auto hasKeyItem(xi::KeyItem keyItemID) const -> bool;
    void delKeyItem(xi::KeyItem keyItemID) const;
    auto seenKeyItem(xi::KeyItem keyItemID) const -> bool;
    void unseenKeyItem(xi::KeyItem keyItemID) const; // Attempt to remove the keyitem from the seen key item collection, only works on logout

    // Player Points
    void addExp(uint32 exp, const sol::object& allowLimitPointsObj);
    void addCapacityPoints(uint32 capacity);
    void delExp(uint32 exp);
    auto getMerit(uint16 merit) -> int32;
    auto getMeritCount() -> uint8;
    void setMerits(uint8 numPoints);

    auto getSpentJobPoints() -> uint16;
    auto getJobPointLevel(uint16 jpType) -> uint8;
    void setJobPoints(uint16 amount);
    void addJobPoints(uint8 jobID, uint16 amount);
    void delJobPoints(uint8 jobID, uint16 amount);
    auto getJobPoints(xi::Job jobID) -> uint16;
    void setCapacityPoints(uint16 amount);
    void masterJob();

    auto getGil() -> uint32;
    void addGil(int32 gil);
    void setGil(int32 amount);
    auto delGil(int32 gil) -> bool;

    auto getCurrency(const std::string& currencyType) -> int32;
    void addCurrency(const std::string& currencyType, int32 amount, const sol::object& maxObj);
    void setCurrency(const std::string& currencyType, int32 amount);
    void delCurrency(const std::string& currencyType, int32 amount);

    auto getCP() -> int32; // Conquest points, not to be confused with Capacity Points
    void addCP(int32 cp);
    void delCP(int32 cp);
    void gainConquestInfluence(int32 points);
    void addConquestMobKills(int32 count);

    auto getSeals(uint8 sealType) -> int32;
    void addSeals(int32 points, uint8 sealType);
    void delSeals(int32 points, uint8 sealType);

    auto getAssaultPoint(uint8 region) -> int32;
    void addAssaultPoint(uint8 region, int32 points);
    void delAssaultPoint(uint8 region, int32 points);

    auto addGuildPoints(uint8 guildId, uint8 slotId) const -> std::tuple<uint8, int16>;

    // Health and Status
    auto getHP() -> int32;
    auto getHPP() -> uint8;
    auto getMaxHP() -> int32;
    auto getBaseHP() -> int32;                                                                                                                    // Returns Entity base Hit Points (before modifiers)
    auto addHP(int32 hpAdd) -> int32;                                                                                                             // Increase hp of Entity
    auto addHPLeaveSleeping(int32 hpAdd) -> int32;                                                                                                // Increase hp of Entity but do not awaken the Entity
    void setHP(int32 value);                                                                                                                      // Set hp of Entity to value
    void die(const sol::object& params);                                                                                                          // Kill a player, describing the circumstances of the death
    void setMaxHP(int32 value);                                                                                                                   // Set max hp of Entity to value
    auto restoreHP(int32 restoreAmt) -> int32;                                                                                                    // Modify hp of Entity, but check if alive first
    void delHP(int32 delAmt);                                                                                                                     // Decrease hp of Entity
    void takeDamage(int32 damage, const sol::object& attacker, const sol::object& atkType, const sol::object& dmgType, const sol::object& flags); // Takes damage from the provided attacker
    void hideHP(bool value);
    auto getDeathType() -> int32;   // Returns Death Type (for Abyssea)
    void setDeathType(int32 value); // Sets Death Type (for Abyssea)

    auto getMP() -> int32;
    auto getMPP() -> uint8;
    auto getMaxMP() -> int32;
    auto getBaseMP() -> int32;             // Returns Entity base Mana Points (before modifiers)
    auto addMP(int32 amount) -> int32;     // Increase mp of Entity
    void setMP(int32 value);               // Set mp of Entity to value
    void setMaxMP(int32 value);            // Set max mp of Entity to value
    auto restoreMP(int32 amount) -> int32; // Modify mp of Entity, but check if alive first
    auto delMP(int32 amount) -> int32;     // Decrease mp of Entity

    auto getTP() -> float;
    auto addTP(int16 amount) -> int16; // Increase mp of Entity
    void setTP(int16 value);           // Set tp of Entity to value
    auto delTP(int16 amount) -> int16; // Decrease tp of Entity

    void updateHealth();
    auto getAverageItemLevel() -> uint8;

    // Skills and Abilities
    void capSkill(uint8 skill);
    void capAllSkills() const;

    auto getSkillLevel(uint16 skillId) -> uint16;
    void setSkillLevel(uint8 SkillID, uint16 SkillAmount);
    auto getMaxSkillLevel(uint8 level, uint8 jobId, uint8 skillId) -> uint16;
    auto getSkillRank(uint8 rankID) -> uint8;
    void setSkillRank(uint8 skillID, uint8 newrank);
    auto getCharSkillLevel(uint8 skillID) -> uint16;

    void addLearnedWeaponskill(uint8 wsUnlockId);
    auto hasLearnedWeaponskill(uint8 wsUnlockId) -> bool;
    void delLearnedWeaponskill(uint8 wsUnlockId);

    void trySkillUp(uint8 skill, uint8 level, const sol::object& forceSkillUpObj, const sol::object& useSubSkillObj);

    auto addWeaponSkillPoints(uint8 slotID, uint16 points) -> bool;

    void addLearnedAbility(uint16 abilityID);
    auto hasLearnedAbility(uint16 abilityID) -> bool;
    auto canLearnAbility(uint16 abilityID) -> uint32;
    void delLearnedAbility(uint16 abilityID);

    void addSpell(uint16 spellID, const sol::optional<sol::table>& paramTable);
    auto hasSpell(uint16 spellID) -> bool;
    auto canLearnSpell(uint16 spellID) -> uint32;
    void delSpell(uint16 spellID, const sol::optional<sol::table>& paramTable);
    auto getSetBlueSpells() -> sol::table;

    void recalculateSkillsTable();
    void recalculateAbilitiesTable();
    auto getEntitiesInRange(CLuaBaseEntity* PLuaEntityTarget, sol::variadic_args va) -> sol::table;

    // Parties and Alliances
    auto getParty() -> sol::table;
    auto getPartyWithTrusts() -> sol::table;
    auto getPartySize(const sol::object& arg0) -> uint8;
    auto hasPartyJob(uint8 job) -> bool;
    auto getPartyMember(uint8 member, uint8 allianceparty) -> CBaseEntity*;
    auto getPartyLeader() -> CBaseEntity*;
    auto getLeaderID() -> uint32;
    auto getPartyLastMemberJoinedTime() -> uint32;
    void forMembersInRange(float range, sol::function function);

    void addPartyEffect(sol::variadic_args va);
    auto hasPartyEffect(uint16 effectid) -> bool;
    void removePartyEffect(uint16 effectid);

    auto getAlliance() -> sol::table;
    auto getAllianceSize() -> uint8;

    void reloadParty();
    void disableLevelSync();

    auto checkSoloPartyAlliance() -> uint8; // Check if Player is in Party or Alliance (0=Solo 1=Party 2=Alliance)

    auto checkKillCredit(CLuaBaseEntity* PLuaBaseEntity, const sol::object& minRange) -> bool;

    auto checkDifficulty(CLuaBaseEntity* PLuaBaseEntity) -> uint8;

    // Instances
    auto getInstance() -> CInstance*;
    void setInstance(CLuaInstance* PLuaInstance);
    void createInstance(uint16 instanceID);
    void instanceEntry(CLuaBaseEntity* PLuaBaseEntity, uint32 response);
    // int32 isInAssault(lua_Stat*); // If player is in a Instanced Assault Dungeon returns true --- Not Implemented

    auto getConfrontationEffect() -> uint16;
    auto copyConfrontationEffect(uint16 targetID) -> uint16; // copy confrontation effect, param = targetEntity:getTargID()

    // Battlefields
    auto getBattlefield() const -> CBattlefield*;
    auto getRegisteredBattlefield() const -> CBattlefield*;                                                                                      // returns CBattlefield* or nullptr if not available
    auto getBattlefieldID() const -> int32;                                                                                                      // returns entity->PBattlefield->GetID() or -1 if not available
    auto registerBattlefield(const sol::object& arg0, const sol::object& arg1, const sol::object& arg2, const sol::object& arg3) const -> uint8; // attempt to register a battlefield, returns BATTLEFIELD_RETURNCODE
    auto battlefieldAtCapacity(int battlefieldID) const -> bool;                                                                                 // returns 1 if this battlefield is full
    auto enterBattlefield(const sol::object& area) const -> bool;
    auto leaveBattlefield(uint8 leavecode) const -> bool;
    auto isInDynamis() const -> bool;
    void setEnteredBattlefield(bool entered) const;
    auto hasEnteredBattlefield() const -> bool;

    // Battle Utilities
    auto isAlive() -> bool;
    auto isDead() -> bool;

    auto hasRaiseTractorMenu() -> bool;
    void sendRaise(uint8 raiseLevel);
    void sendReraise(uint8 raiseLevel);
    void sendTractor(float xPos, float yPos, float zPos, uint8 rotation);
    void allowSendRaisePrompt();

    void countdown(const sol::object& secondsObj) const;
    void objectiveUtility(const sol::object& obj) const;
    void enableEntities(const sol::object& obj);
    void independentAnimation(CLuaBaseEntity* PTarget, uint16 animId, uint8 mode);

    void engage(uint16 requestedTarget);
    auto isEngaged() -> bool;
    void disengage();
    void timer(int ms, sol::function func); // execute lua closure after some time
    void queue(int ms, sol::function func);
    void addRecast(uint8 recastCont, uint16 recastID, uint32 duration);
    auto hasRecast(uint8 rType, uint16 recastID, const sol::object& arg2) -> bool;
    void resetRecast(uint8 rType, uint16 recastID); // Reset one recast ID
    void resetRecasts();                            // Reset recasts for the caller

    void addListener(const std::string& eventName, const std::string& identifier, const sol::function& func);
    void removeListener(const std::string& identifier);
    void triggerListener(const std::string& eventName, sol::variadic_args args);
    auto hasListener(const std::string& eventName) -> bool;

    auto getEntity(uint16 targetID) -> CBaseEntity*;
    auto canChangeState() -> bool;

    void wakeUp();

    void setBattleID(uint16 battleID);
    auto getBattleID() -> uint16;

    void recalculateStats();
    auto checkImbuedItems() -> bool;

    auto isDualWielding() -> bool;
    auto isUsingH2H() -> bool;
    auto getBaseWeaponDelay(uint16 slot) -> uint16; // get base delay of weapon
    auto getBaseDelay() -> uint16;                  // get base delay of entity, melee only
    auto getBaseRangedDelay() -> uint16;            // get base delay of entity, ranged only

    auto checkLiementAbsorb(xi::DamageType damageType) -> float; // return 1.0 if did not absorb, return >= -1.0 if did absorb

    // Enmity
    auto getCE(const CLuaBaseEntity* target) -> int32;
    auto getVE(const CLuaBaseEntity* target) -> int32;
    void setCE(CLuaBaseEntity* target, uint16 amount);
    void setVE(CLuaBaseEntity* target, uint16 amount);
    void addBaseEnmity(CLuaBaseEntity* PEntity);
    void addEnmity(CLuaBaseEntity* PEntity, int32 CE, int32 VE); // Add specified amount of enmity (target, CE, VE)
    void lowerEnmity(CLuaBaseEntity* PEntity, uint8 percent);
    void updateEnmity(CLuaBaseEntity* PEntity);
    void transferEnmity(CLuaBaseEntity* entity, uint8 percent, float range);
    void updateEnmityFromDamage(CLuaBaseEntity* PEntity, int32 damage) const; // Adds Enmity to player for specified mob for the damage specified
    void updateEnmityFromCure(CLuaBaseEntity* PEntity, int32 amount, const sol::object& fixedCE, const sol::object& fixedVE);
    void resetEnmity(CLuaBaseEntity* PEntity);
    void setEnmityActive(CLuaBaseEntity* PEntity, bool active);
    void updateClaim(const sol::object& entity);
    auto hasClaim(CLuaBaseEntity* PTarget) -> bool;
    auto hasEnmity() -> bool;
    auto getNotorietyList() -> sol::table;
    auto getMasterThreatMob(const sol::object& rangeOverride) -> CBaseEntity*;
    void clearEnmityForEntity(CLuaBaseEntity* PEntity);

    // Status Effects
    auto addStatusEffect(xi::StatusEffect effectId, sol::table params) const -> bool;
    auto copyStatusEffect(const CLuaStatusEffect* PStatusEffect) const -> bool;
    auto getStatusEffect(xi::StatusEffect StatusID, const sol::object& SubType, const sol::object& SourceType, const sol::object& SourceTypeParam) -> CStatusEffect*;
    auto getStatusEffectBySource(xi::StatusEffect StatusID, EffectSourceType SourceType, uint16 SourceTypeParam) -> CStatusEffect*;
    auto getStatusEffects() -> sol::table;
    auto getStatusEffectElement(uint16 statusId) -> int16;
    auto canGainStatusEffect(xi::StatusEffect effect, const sol::object& powerObj) -> bool;
    auto hasStatusEffect(xi::StatusEffect StatusID, const sol::object& SubType) -> bool;
    auto hasStatusEffectByFlag(uint16 StatusID) -> bool;
    auto countEffect(xi::StatusEffect StatusID) -> uint8; // Gets the number of effects of a specific type on the entity
    auto countEffectWithFlag(uint32 flag) -> uint8;       // Gets the number of effects with a flag on the entity

    auto delStatusEffect(xi::StatusEffect StatusID, const sol::object& SubType, const sol::object& SourceType, const sol::object& SourceTypeParam) -> bool;
    void delStatusEffectsByFlag(uint32 flag, const sol::object& silent);
    void delStatusEffectsByType(uint16 type);
    auto delStatusEffectSilent(xi::StatusEffect StatusID) -> bool; // Removes Status Effect, suppresses message
    auto eraseStatusEffect() -> uint16;
    auto eraseAllStatusEffect() -> uint8;
    auto dispelStatusEffect(const sol::object& flagObj) -> int32;
    auto dispelAllStatusEffect(const sol::object& flagObj) -> uint8;
    auto stealStatusEffect(CLuaBaseEntity* PTargetEntity, const sol::object& flagObj, const sol::object& silentObj) -> uint16;

    void addMod(uint16 type, int16 amount);
    auto getMod(uint16 modID) -> int16;
    void setMod(uint16 modID, int16 value);
    void delMod(uint16 modID, int16 value);
    void printAllMods();
    auto getMaxGearMod(xi::Mod modId) -> int16;
    auto getGearModFromSlot(uint8 slot, xi::Mod modId) -> int16;

    void addLatent(uint16 condID, uint16 conditionValue, uint16 mID, int16 modValue);
    auto delLatent(uint16 condID, uint16 conditionValue, uint16 mID, int16 modValue) -> bool;
    auto hasAllLatentsActive(uint8 slot) -> bool;

    void doWildCard(CLuaBaseEntity* PEntity, uint8 total);
    auto doRandomDeal(CLuaBaseEntity* PTarget) -> bool;
    auto hasBustEffect(uint16 id) -> bool; // Checks to see if a character has a specified busted corsair roll
    auto numBustEffects() -> uint8;        // Gets the number of bust effects on the player
    auto healingWaltz() -> uint16;
    auto addBardSong(CLuaBaseEntity* PEntity, xi::StatusEffect effectID, uint16 power, uint16 tick, uint16 duration, uint16 SubType, uint16 subPower, uint16 tier) -> bool;

    void charm(const CLuaBaseEntity* target, const sol::object& p0);
    void uncharm();
    auto isCharmed() const -> bool;
    auto isTandemActive() -> bool;

    auto addBurden(uint8 element, uint8 burden) -> uint8;
    auto getOverloadChance(uint8 element) -> uint8;
    void setStatDebilitation(uint16 statDebil);

    // Damage Calculation
    auto getStat(uint16 statId, sol::variadic_args va) -> uint16; // STR,DEX,VIT,AGI,INT,MND,CHR,ATT,DEF
    auto getACC(const sol::object& maybeAttackNumber) -> uint16;
    auto getEVA() -> uint16;
    auto getRACC() -> int;
    auto getRATT() -> uint16;
    auto getILvlMacc() -> uint16;
    auto getILvlSkill() -> uint16;
    auto getILvlParry() -> uint16;

    auto physicalDmgTaken(double damage, sol::variadic_args va) -> int32;
    auto rangedDmgTaken(double damage, sol::variadic_args va) -> int32;
    void handleAfflatusMiseryDamage(double damage);

    auto isWeaponTwoHanded() -> bool;
    auto getWeaponDmg() -> uint16;                  // gets the current equipped weapons' DMG rating
    auto getWeaponDmgRank() -> uint16;              // gets the current equipped weapons' DMG rating for Rank calc
    auto getOffhandDmg() -> uint16;                 // gets the current equipped offhand's DMG rating (used in WS calcs)
    auto getOffhandDmgRank() -> uint16;             // gets the current equipped offhand's DMG rating for Rank calc
    auto getRangedDmg() -> uint16;                  // Get ranged weapon DMG rating
    auto getRangedDmgRank() -> uint16;              // Get ranged weapond DMG rating used for calculating rank
    auto getAmmoDmg() -> uint16;                    // Get ammo DMG rating
    auto getWeaponHitCount(bool offhand) -> uint16; // Get PC weapon hit count (Occasionally Attacks N times weapons)
    auto addDamageFromMultipliers(uint32 damage, PHYSICAL_ATTACK_TYPE attackType, uint8 weaponSlot, bool allowProc) -> uint32;

    void removeAmmo(const sol::object& ammoUsed) const;

    auto getWeaponSkillLevel(uint8 slotID) -> uint16;              // Get Skill for equipped weapon
    auto getWeaponDamageType(uint8 slotID) -> uint16;              // gets the type of weapon equipped
    auto getWeaponSkillType(uint8 slotID) -> uint8;                // gets the skill type of weapon equipped
    auto getWeaponSubSkillType(uint8 slotID) -> uint8;             // gets the subskill of weapon equipped
    auto getWSSkillchainProp() -> std::tuple<uint8, uint8, uint8>; // returns weapon skill's skillchain properties (up to 3)

    auto takeWeaponskillDamage(CLuaBaseEntity* attacker, int32 damage, uint8 atkType, xi::DamageType dmgType, uint8 slot, bool primary, float tpMultiplier, uint16 bonusTP, float targetTPMultiplier) -> int32;

    void takeSpellDamage(CLuaBaseEntity* caster, CLuaSpell* spell, int32 damage, uint8 atkType, uint8 dmgType);
    auto takeSwipeLungeDamage(CLuaBaseEntity* caster, int32 damage, uint8 atkType, xi::DamageType dmgType) -> int32;
    auto checkDamageCap(int32 damage) -> int32;
    auto handleSevereDamage(int32 damage, bool isPhysical) -> int32;

    // Pets and Automations
    void spawnPet(const sol::object& arg0);
    void despawnPet();
    void setJugRemainingTime(uint32 remainingSeconds);

    auto spawnTrust(uint16 trustId) -> CBaseEntity*;
    void clearTrusts();
    auto getTrustID() -> uint32;
    void trustPartyMessage(uint32 message_id) const;
    auto addGambit(uint16 targ, const sol::table& predicates, const sol::table& reactions, const sol::object& retry) -> std::string;
    void removeGambit(const std::string& id);
    void removeAllGambits();
    void setTrustTPSkillSettings(uint16 trigger, uint16 select, const sol::object& value);

    auto hasPet() -> bool;
    auto hasJugPet() -> bool;
    auto getPet() -> CBaseEntity*;
    auto getPetID() -> uint32;
    auto isAutomaton() -> bool;
    auto isAvatar() -> bool;
    auto isJugPet() -> bool;
    auto getMaster() -> CBaseEntity*;
    auto getPetElement() -> uint8;
    void setPet(const sol::object& petObj);
    void setPetStats(uint8 petId);
    auto getMinimumPetLevel() -> uint8; // Returns the minimum level of the pet, such as level 23 for Courier Carrie or 0 if non applicable.

    auto getPetName() -> const std::string;
    void setPetName(uint8 pType, uint16 value, const sol::object& arg2);
    void registerChocobo(const sol::table& chocobo) const;
    auto getFieldChocobo() const -> sol::object;
    auto getChocoboUserData() const -> sol::object;
    void setChocoboUserData(const sol::table& data) const;

    void petAttack(CLuaBaseEntity* PEntity);
    void petAbility(uint16 abilityID); // Function exists, but is not implemented.  Warning will be displayed.
    void petRetreat();
    void extendCharm(uint16 minSeconds, uint16 maxSeconds);

    void addPetMod(uint16 modID, int16 amount);
    void setPetMod(uint16 modID, int16 amount);
    void delPetMod(uint16 modID, int16 amount);

    auto hasAttachment(uint16 itemID) const -> bool;
    auto hasAttachmentSet(uint16 itemID) const -> bool;
    auto getAutomatonName() const -> std::string;
    auto getAutomatonFrame() const -> Maybe<xi::AutomatonFrame>;
    void setAutomatonFrame(xi::AutomatonFrame frame) const;
    auto getAutomatonHead() const -> Maybe<xi::AutomatonHead>;
    void setAutomatonHead(xi::AutomatonHead head) const;
    auto unlockAttachment(uint16 itemID) const -> bool;
    auto getActiveManeuverCount() const -> uint8;
    void removeOldestManeuver() const;
    void removeAllManeuvers() const;
    auto getAttachments() const -> sol::table;
    void setAttachment(uint8 attachmentItemID, uint8 slotID) const;
    void updateAttachments() const;
    void reduceBurden(float percentReduction, const sol::object& intReductionObj) const;
    auto isExceedingElementalCapacity() const -> bool;

    auto getAllRuneEffects() -> sol::table;
    auto getActiveRuneCount() -> uint8;
    auto getHighestRuneEffect() -> uint16;
    auto getNewestRuneEffect() -> uint16;
    void removeOldestRune();
    void removeNewestRune();
    void removeAllRunes();

    // Mob Entity-Specific
    void setMobLevel(uint8 level, sol::optional<bool> recover);
    auto getStatRank(uint8 statType) -> uint8;
    void setStatRank(uint8 statType, uint8 rank);
    auto getEcosystem() -> uint8;
    auto getFamily() -> uint16;
    auto getSpecies() -> uint16;
    auto isMobType(xi::MobType mobType) const -> bool; // True if mob is of type passed to function
    auto isUndead() -> bool;
    auto isNM() -> bool;

    auto getModelSize() -> uint8;
    void setModelSize(uint8 newSize);
    auto getHitboxSize() -> float;
    void setHitboxSize(float newSize);
    auto getMeleeRange(CLuaBaseEntity* target) -> float;
    void setMobFlags(xi::EntityFlags flags, const sol::object& mobId); // Used to manipulate the mob's flags, such as changing size.
    auto getMobFlags() -> xi::EntityFlags;

    void setNpcFlags(xi::EntityFlags flags);
    void setNpcAlwaysRelevant(bool alwaysRelevant);

    void spawn(const sol::object& despawnSec, const sol::object& respawnSec);
    auto isSpawned() -> bool;
    auto getSpawnPos() -> sol::table;
    void setSpawn(float x, float y, float z, const sol::object& rot);
    auto getRespawnTime() const -> uint32;
    void setRespawnTime(uint32 seconds) const;
    auto getSpawnSlotMobs() -> sol::table;

    void instantiateMob(uint32 groupID);

    auto hasTrait(uint16 traitID) -> bool;
    auto hasImmunity(xi::Immunity immunityID) -> bool; // Check if the mob has immunity for a type of spell (immunity list in mobentity.h)
    void addImmunity(xi::Immunity immunityID);
    void delImmunity(xi::Immunity immunityID);

    void setAggressive(bool aggressive);
    void setTrueDetection(bool truedetection);
    void setUnkillable(bool unkillable);
    auto getUnkillable() -> bool;
    void setUntargetable(bool untargetable);
    auto getUntargetable() -> bool;
    void setPriorityRender(bool enabled) const;
    void setIsAggroable(bool isAggroable);
    auto isAggroable() -> bool;

    void setDelay(uint16 delay);
    auto setDamage(uint16 damage, uint8 slot) -> void;
    auto getSpellListId() const -> uint16;
    auto hasSpellList() const -> bool;
    void setSpellList(uint16 spellListId) const;
    void setAutoAttackEnabled(bool state);   // halts/resumes auto attack of entity
    void setRangedAttackEnabled(bool state); // halts/resumes ranged auto attack of entity
    auto isRangedAttackEnabled() -> bool;    // returns whether ranged auto attack is enabled
    void setMagicCastingEnabled(bool state); // halt/resumes casting magic
    void setMobAbilityEnabled(bool state);   // halt/resumes mob skills
    void setMobSkillAttack(int16 listId);    // enable/disable using mobskills as regular attacks

    auto getMobMod(xi::MobMod mobModID) -> int16;
    void setMobMod(xi::MobMod mobModID, int16 value);
    void addMobMod(xi::MobMod mobModID, int16 value);
    void delMobMod(xi::MobMod mobModID, int16 value);

    auto getfTPModifierOverride(uint16 skillId) -> sol::object;
    void setfTPModifierOverride(uint16 skillId, float ftp1, float ftp2, float ftp3);

    auto getBattleTime() -> uint32;
    auto getCrystalElement() const -> ELEMENT;
    void setCrystalElement(ELEMENT crystalElement);

    auto getBehavior() -> xi::Behavior;
    void setBehavior(xi::Behavior behavior);
    auto getLink() -> uint8;
    void setLink(uint8 link);
    auto getRoamFlags() -> xi::RoamFlag;
    void setRoamFlags(xi::RoamFlag newRoamFlags);

    auto getTarget() -> CBaseEntity*;
    void updateTarget(); // Force mob to update target from enmity container (ie after updateEnmity)
    auto getEnmityList() -> sol::table;
    auto getTrickAttackChar(CLuaBaseEntity* PLuaBaseEntity) -> CBaseEntity*; // true if TA target is available

    auto actionQueueEmpty() -> bool;

    void castSpell(const sol::object& spell, const sol::object& entity); // forces a mob to cast a spell (parameter = spell ID, otherwise picks a spell from its list)
    void useJobAbility(uint16 skillID, const sol::object& pet);          // forces a job ability use (players/pets only)
    void useMobAbility(sol::variadic_args va);                           // forces a mob to use a mobability (parameter = skill ID)
    void usePetAbility(uint16 skillId, const sol::object& target) const; // forces a pet to use a pet ability
    auto getAbilityDistance(uint16 skillID) -> float;                    // Returns the specified distance for mob skill
    auto hasTPMoves() -> bool;
    void drawIn(const sol::variadic_args& va) const; // Forces a mob to draw-in the specified target, or its current target with no args

    void weaknessTrigger(uint8 level);
    void restoreFromChest(CLuaBaseEntity* PLuaBaseEntity, uint32 restoreType);
    auto hasPreventActionEffect() -> bool;
    void stun(uint32 milliseconds);
    void untargetableAndUnactionable(uint32 milliseconds);
    void tryHitInterrupt(CLuaBaseEntity* attacker);

    auto getPool() -> uint32; // Returns a mobs pool ID. If entity is not a mob, returns nil.
    auto getDropID() -> uint32;
    void setDropID(uint32 dropID);
    void addTreasure(uint16 itemID, const sol::object& arg1, const sol::object& arg2);
    auto getTreasurePool() -> CTreasurePool*;
    auto getStealItem() -> uint16;
    auto getDespoilItem() -> uint16;                // gets ItemID of droplist despoil item from mob (steal item if no despoil item)
    auto getDespoilDebuff(uint16 itemID) -> uint16; // gets the status effect id to apply to the mob on successful despoil
    void itemStolen(bool stolen);                   // sets mob's ItemStolen var
    void itemDespoiled(bool despoiled);             // sets mob's ItemDespoiled var
    auto getTHlevel() -> int16;                     // Returns the Monster's current Treasure Hunter Tier
    void setTHlevel(int16 newLevel);                // Sets the Monster's current Treasure Hunter Tier

    auto getAvailableTraverserStones() -> uint32;
    auto getTraverserEpoch() -> uint32;
    void setTraverserEpoch();
    auto getClaimedTraverserStones() -> uint32;
    void addClaimedTraverserStones(uint16 numStones);
    void setClaimedTraverserStones(uint16 totalStones);

    auto getHistory(uint8 index) -> uint32;

    auto getChocoboRaisingInfo() -> sol::table;
    auto setChocoboRaisingInfo(const sol::table& table) -> bool;
    auto deleteRaisedChocobo() -> bool;

    void clearActionQueue();
    void clearTimerQueue();

    void setMannequinPose(uint16 itemID, uint8 race, uint8 pose);
    auto getMannequinPose(uint16 itemID) -> uint8;

    void submitContestFish(uint32 score);
    void withdrawContestFish();
    auto getContestScore() -> uint32;
    auto getContestRank() -> uint8;
    auto getContestRewardStatus() -> sol::table;
    auto getContestRankHistory() -> sol::table;
    void claimContestReward();

    auto operator==(const CLuaBaseEntity& other) const -> bool
    {
        return this->m_PBaseEntity == other.m_PBaseEntity;
    }

    static void Register();
};
