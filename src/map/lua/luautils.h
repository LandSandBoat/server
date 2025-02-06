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

#ifndef _LUAUTILS_H
#define _LUAUTILS_H

#include <optional>

#include "common/cbasetypes.h"
#include "common/taskmgr.h"

#include "common/lua.h"
extern sol::state lua;

// Sol compilation definitions are in the base CMakeLists file
// SOL_ALL_SAFETIES_ON = 1
// SOL_NO_CHECK_NUMBER_PRECISION = 1
#include "sol/sol.hpp"

// sol changes this behavior to return 0 rather than truncating
// we rely on that, so change it back
#undef lua_tointeger
#define lua_tointeger(L, n) static_cast<lua_Integer>(std::floor(lua_tonumber(L, n)))

#define SOL_USERTYPE(TypeName, BindingTypeName) \
    std::string className = TypeName;           \
    lua.new_usertype<BindingTypeName>(className)
#define SOL_REGISTER(FuncName, Func) lua[className][FuncName] = &Func

#include "items/item_equipment.h"
#include "spell.h"

#include "lua_ability.h"
#include "lua_action.h"
#include "lua_attack.h"
#include "lua_baseentity.h"
#include "lua_battlefield.h"
#include "lua_instance.h"
#include "lua_item.h"
#include "lua_mobskill.h"
#include "lua_petskill.h"
#include "lua_spell.h"
#include "lua_statuseffect.h"
#include "lua_trade_container.h"
#include "lua_trigger_area.h"
#include "lua_zone.h"

enum class SendToDBoxReturnCode : uint8
{
    SUCCESS                       = 0,
    SUCCESS_LIMITED_TO_STACK_SIZE = 1,
    PLAYER_NOT_FOUND              = 2,
    ITEM_NOT_FOUND                = 3,
    QUERY_ERROR                   = 4
};

class CAbility;
class CSpell;
class CBaseEntity;
class CBattleEntity;
class CAutomatonEntity;
class CPetEntity;
class CCharEntity;
class CBattlefield;
class CItem;
class CInstance;
class CMobSkill;
class CPetSkill;
class ITriggerArea;
class CStatusEffect;
class CTradeContainer;
class CItemPuppet;
class CItemWeapon;
class CItemEquipment;
class CItemFurnishing;
class CInstance;
class CWeaponSkill;
class CZone;
class CZoneInstance;

class CLuaAbility;
class CLuaAction;
class CLuaBaseEntity;
class CLuaBattlefield;
class CLuaInstance;
class CLuaItem;
class CLuaMobSkill;
class CLuaPetSkill;
class CLuaTriggerArea;
class CLuaSpell;
class CLuaStatusEffect;
class CLuaTradeContainer;
class CLuaZone;

struct action_t;
struct actionList_t;
struct actionTarget_t;

enum ConquestUpdate : uint8;
enum class Emote : uint8;

namespace luautils
{
    void init();
    void garbageCollectStep();
    void garbageCollectFull();
    void cleanup();

    void ReloadFilewatchList();

    auto GetContainerFilenamesList() -> std::vector<std::string>;

    // Cache helpers
    auto getEntityCachedFunction(CBaseEntity* PEntity, std::string funcName) -> sol::function;
    void CacheLuaObjectFromFile(std::string const& filename, bool overwriteCurrentEntry = false);
    auto GetCacheEntryFromFilename(std::string const& filename) -> sol::table;
    void OnEntityLoad(CBaseEntity* PEntity);

    void PopulateIDLookupsByFilename(std::optional<std::string> maybeFilename = std::nullopt);
    void PopulateIDLookupsByZone(std::optional<uint16> maybeZoneId = std::nullopt);

    void SendEntityVisualPacket(uint32 npcid, const char* command);
    void InitInteractionGlobal();
    auto GetZone(uint16 zoneId) -> std::optional<CLuaZone>;
    auto GetItemByID(uint32 itemId) -> std::optional<CLuaItem>;
    auto GetNPCByID(uint32 npcid, sol::object const& instanceObj) -> std::optional<CLuaBaseEntity>;
    auto GetMobByID(uint32 mobid, sol::object const& instanceObj) -> std::optional<CLuaBaseEntity>;
    auto GetEntityByID(uint32 mobid, sol::object const& instanceObj, sol::object const& arg3) -> std::optional<CLuaBaseEntity>;

    void  WeekUpdateConquest(uint8 updateType);
    uint8 GetRegionOwner(uint8 type);
    uint8 GetRegionInfluence(uint8 type); // Return influence graphics
    uint8 GetNationRank(uint8 nation);
    uint8 GetConquestBalance();
    bool  IsConquestAlliance();
    void  SetRegionalConquestOverseers(uint8 regionID); // Update NPC Conquest Guard
    void  SendLuaFuncStringToZone(uint16 zoneId, std::string const& str);

    auto GetReadOnlyItem(uint32 id) -> std::optional<CLuaItem>; // Returns a read only lookup item object of the specified ID
    auto GetAbility(uint16 id) -> std::optional<CLuaAbility>;
    auto GetSpell(uint16 id) -> std::optional<CLuaSpell>;

    auto   SpawnMob(uint32 mobid, sol::object const& arg2, sol::object const& arg3) -> std::optional<CLuaBaseEntity>; // Spawn Mob By Mob Id - NMs, BCNM...
    void   DespawnMob(uint32 mobid, sol::object const& arg2);                                                         // Despawn (Fade Out) Mob By Id
    auto   GetPlayerByName(std::string const& name) -> std::optional<CLuaBaseEntity>;
    auto   GetPlayerByID(uint32 pid) -> std::optional<CLuaBaseEntity>;
    bool   PlayerHasValidSession(uint32 playerId);
    uint32 GetPlayerIDByName(std::string const& name);
    void   SendToJailOffline(uint32 playerId, int8 cellId, float posX, float posY, float posZ, uint8 rot);
    void   DrawIn(CLuaBaseEntity* PLuaBaseEntity, sol::table const& table, float offset, float degrees);

    uint32 GetSystemTime();
    uint32 JstMidnight();
    uint32 JstWeekday();
    uint32 NextGameTime(uint32 intervalSeconds);
    uint32 NextJstWeek();
    uint32 VanadielTime();
    uint8  VanadielTOTD();
    uint32 VanadielHour();
    uint32 VanadielMinute();
    uint32 VanadielDayOfTheYear();  // Gets Integer Value for Day of the Year (Jan 01 = Day 1)
    uint32 VanadielDayOfTheMonth(); // Gets day of the month (Feb 6 = Day 6)
    uint32 VanadielDayOfTheWeek();  // Gets day of the week (Fire Earth Water Wind Ice Lightning Light Dark)
    uint32 VanadielYear();
    uint32 VanadielMonth();
    uint32 VanadielUniqueDay();  // Gets the unique day number. (Vanadiel year * 360 + VanadielDayOfTheYear)
    uint8  VanadielDayElement(); // Gets element of the day (1: Fire  2: Ice  3: Wind  4: Earth  5: Lightning  6: Water  7: Light  8: Dark)
    uint32 VanadielMoonPhase();
    uint8  VanadielMoonDirection();
    uint8  VanadielRSERace();
    uint8  VanadielRSELocation();
    bool   SetVanadielTimeOffset(int32 offset);
    bool   IsMoonNew();
    bool   IsMoonFull();
    void   StartElevator(uint32 ElevatorID);
    int16  GetElevatorState(uint8 id); // Returns -1 if elevator is not found. Otherwise, returns the uint8 state.

    int32 GetServerVariable(std::string const& name);
    void  SetServerVariable(std::string const& name, int32 value, sol::object const& expiry);
    int32 GetVolatileServerVariable(std::string const& varName);
    void  SetVolatileServerVariable(std::string const& varName, int32 value, sol::object const& expiry);
    int32 GetCharVar(uint32 charId, std::string const& varName);                                         // Get player var directly from SQL DB
    void  SetCharVar(uint32 charId, std::string const& varName, int32 value, sol::object const& expiry); // Set player var in SQL DB using charId
    void  ClearCharVarFromAll(std::string const& varName);                                               // Deletes a specific player variable from all players
    void  Terminate();                                                                                   // Logs off all characters and terminates the server

    int32 GetTextIDVariable(uint16 ZoneID, const char* variable); // Load the value of the TextID variable of the specified zone
    bool  IsContentEnabled(const char* content);

    void OnGameDay(CZone* PZone);
    void OnGameHour(CZone* PZone);
    void OnZoneWeatherChange(uint16 ZoneID, uint8 weather);
    void OnTOTDChange(uint16 ZoneID, uint8 TOTD);

    void OnGameIn(CCharEntity* PChar, bool zoning);
    void OnZoneIn(CCharEntity* PChar);
    void OnZoneOut(CCharEntity* PChar);
    void AfterZoneIn(CBaseEntity* PChar);
    void OnZoneInitialize(uint16 ZoneID);
    void OnZoneTick(CZone* PZone);

    void OnTriggerAreaEnter(CCharEntity* PChar, std::unique_ptr<ITriggerArea> const& PTriggerArea); // when player enters a trigger area in a zone
    void OnTriggerAreaLeave(CCharEntity* PChar, std::unique_ptr<ITriggerArea> const& PTriggerArea); // when player leaves a trigger area in a zone

    void OnTransportEvent(CCharEntity* PChar, uint32 TransportID);
    void OnTimeTrigger(CNpcEntity* PNpc, uint8 triggerID);
    void OnConquestUpdate(CZone* PZone, ConquestUpdate type, uint8 influence, uint8 owner, uint8 ranking, bool isConquestAlliance); // conquest update (hourly or tally)

    void OnServerStart();
    void OnJSTMidnight();
    void OnTimeServerTick();

    int32 OnTrigger(CCharEntity* PChar, CBaseEntity* PNpc);
    int32 OnEventUpdate(CCharEntity* PChar, uint16 eventID, uint32 result);   // triggered when game triggers event update during cutscene
    int32 OnEventUpdate(CCharEntity* PChar, std::string const& updateString); // triggered when game triggers event update during cutscene
    int32 OnEventFinish(CCharEntity* PChar, uint16 eventID, uint32 result);
    void  OnTrade(CCharEntity* PChar, CBaseEntity* PNpc);

    void OnNpcSpawn(CBaseEntity* PNpc); // triggers when a patrol npc spawns

    void OnEffectGain(CBattleEntity* PEntity, CStatusEffect* StatusEffect);
    void OnEffectTick(CBattleEntity* PEntity, CStatusEffect* StatusEffect);
    void OnEffectLose(CBattleEntity* PEntity, CStatusEffect* StatusEffect);

    void OnAttachmentEquip(CBattleEntity* PEntity, CItemPuppet* attachment);
    void OnAttachmentUnequip(CBattleEntity* PEntity, CItemPuppet* attachment);
    void OnManeuverGain(CBattleEntity* PEntity, CItemPuppet* attachment, uint8 maneuvers);
    void OnManeuverLose(CBattleEntity* PEntity, CItemPuppet* attachment, uint8 maneuvers);
    void OnUpdateAttachment(CBattleEntity* PEntity, CItemPuppet* attachment, uint8 maneuvers);

    void OnItemUse(CBaseEntity* PUser, CBaseEntity* PTarget, CItem* PItem);
    auto OnItemCheck(CBaseEntity* PTarget, CItem* PItem, ITEMCHECK param = ITEMCHECK::NONE, CBaseEntity* PCaster = nullptr) -> std::tuple<int32, int32, int32>;
    void OnItemDrop(CBaseEntity* PUser, CItem* PItem);
    void OnItemEquip(CBaseEntity* PUser, CItem* PItem);
    void OnItemUnequip(CBaseEntity* PUser, CItem* PItem);
    void CheckForGearSet(CBaseEntity* PTarget);

    int32 OnMagicCastingCheck(CBaseEntity* PChar, CBaseEntity* PTarget, CSpell* PSpell);
    int32 OnSpellCast(CBattleEntity* PCaster, CBattleEntity* PTarget, CSpell* PSpell);
    void  OnSpellPrecast(CBattleEntity* PCaster, CSpell* PSpell);
    auto  OnMobMagicPrepare(CBattleEntity* PCaster, CBattleEntity* PTarget, std::optional<SpellID> startingSpellId) -> std::optional<SpellID>;
    void  OnMagicHit(CBattleEntity* PCaster, CBattleEntity* PTarget, CSpell* PSpell);
    void  OnWeaponskillHit(CBattleEntity* PMob, CBaseEntity* PAttacker, uint16 PWeaponskill);
    bool  OnTrustSpellCastCheckBattlefieldTrusts(CBattleEntity* PCaster); // Triggered if spell is a trust spell during onCast to determine to interrupt spell or not

    void OnMobInitialize(CBaseEntity* PMob);
    void ApplyMixins(CBaseEntity* PMob);
    void ApplyZoneMixins(CBaseEntity* PMob);
    void OnMobSpawn(CBaseEntity* PMob);
    void OnMobRoamAction(CBaseEntity* PMob); // triggers when event mob is ready for a custom roam action
    void OnMobRoam(CBaseEntity* PMob);
    void OnMobEngage(CBaseEntity* PMob, CBaseEntity* PTarget);
    void OnMobDisengage(CBaseEntity* PMob);
    void OnMobFollow(CBaseEntity* PMob, CBaseEntity* PTarget);
    void OnMobUnfollow(CBaseEntity* PMob, CBaseEntity* PTarget);
    void OnMobFight(CBaseEntity* PMob, CBaseEntity* PTarget);
    void OnCriticalHit(CBattleEntity* PMob, CBattleEntity* PAttacker);
    void OnMobDeath(CBaseEntity* PMob, CBaseEntity* PKiller);
    void OnMobDespawn(CBaseEntity* PMob);

    void OnPlayerAbilityUse(CBaseEntity* PMob, CBaseEntity* PPlayer, CAbility* PAbility); // when a player uses an ability and mob is in notoriety container

    void OnPetLevelRestriction(CBaseEntity* PMob);

    void OnPath(CBaseEntity* PEntity);
    void OnPathPoint(CBaseEntity* PEntity);
    void OnPathComplete(CBaseEntity* PEntity);

    int32 OnBattlefieldHandlerInitialize(CZone* PZone);
    void  OnBattlefieldInitialize(CBattlefield* PBattlefield); // what to do when initialising battlefield, battlefield:setLocalVar("lootId") here for any which have loot
    void  OnBattlefieldTick(CBattlefield* PBattlefield);
    void  OnBattlefieldStatusChange(CBattlefield* PBattlefield);

    void OnBattlefieldEnter(CCharEntity* PChar, CBattlefield* PBattlefield);
    void OnBattlefieldLeave(CCharEntity* PChar, CBattlefield* PBattlefield, uint8 LeaveCode); // see battlefield.h BATTLEFIELD_LEAVE_CODE
    void OnBattlefieldKick(CCharEntity* PChar);

    void OnBattlefieldRegister(CCharEntity* PChar, CBattlefield* PBattlefield);
    void OnBattlefieldDestroy(CBattlefield* PBattlefield);

    uint16 OnMobWeaponSkillPrepare(CBattleEntity* PMob, CBattleEntity* PTarget);
    int32  OnMobWeaponSkill(CBaseEntity* PChar, CBaseEntity* PMob, CMobSkill* PMobSkill, action_t* action);
    int32  OnMobSkillCheck(CBaseEntity* PChar, CBaseEntity* PMob, CMobSkill* PMobSkill); // triggers before mob weapon skill is used, returns 0 if the move is valid
    auto   OnMobSkillTarget(CBattleEntity* PTarget, CBaseEntity* PMob, CMobSkill* PMobSkill) -> CBattleEntity*;
    int32  OnAutomatonAbilityCheck(CBaseEntity* PChar, CAutomatonEntity* PAutomaton, CMobSkill* PMobSkill);
    int32  OnAutomatonAbility(CBaseEntity* PTarget, CBaseEntity* PMob, CMobSkill* PMobSkill, CBaseEntity* PMobMaster, action_t* action);

    auto GetMonstrosityLuaTable(CCharEntity* PChar) -> sol::table;
    void SetMonstrosityLuaTable(CCharEntity* PChar, sol::table data);
    void OnMonstrosityUpdate(CCharEntity* PChar);
    void OnMonstrosityReturnToEntrance(CCharEntity* PChar);

    int32 OnAbilityCheck(CBaseEntity* PChar, CBaseEntity* PTarget, CAbility* PAbility, CBaseEntity** PMsgTarget);
    int32 OnPetAbility(CBaseEntity* PTarget, CBaseEntity* PMob, CMobSkill* PMobSkill, CBaseEntity* PPetMaster, action_t* action);
    int32 OnPetAbility(CBaseEntity* PTarget, CPetEntity* PPet, CPetSkill* PMobSkill, CBaseEntity* PPetMaster, action_t* action);                                                                // triggers when pet uses an ability, specialized for pets
    auto  OnUseWeaponSkill(CBattleEntity* PUser, CBaseEntity* PMob, CWeaponSkill* wskill, uint16 tp, bool primary, action_t& action, CBattleEntity* taChar) -> std::tuple<int32, uint8, uint8>; // returns: damage, tphits landed, extra hits landed
    int32 OnUseAbility(CBattleEntity* PUser, CBattleEntity* PTarget, CAbility* PAbility, action_t* action);
    int32 OnSteal(CBattleEntity* PChar, CBattleEntity* PTarget, CAbility* PAbility, action_t* action);

    bool OnCanUseSpell(CBattleEntity* PChar, CSpell* Spell); // triggers when CanUseSpell is invoked on spell.cpp for PCs only

    auto GetCachedInstanceScript(uint16 instanceId) -> sol::table;

    void  OnInstanceZoneIn(CCharEntity* PChar, CInstance* PInstance);
    void  AfterInstanceRegister(CBaseEntity* PChar);                             // triggers after a character is registered and zoned into an instance (the first time)
    int32 OnInstanceLoadFailed(CZone* PZone);                                    // triggers when an instance load is failed (ie. instance no longer exists)
    void  OnInstanceTimeUpdate(CZone* PZone, CInstance* PInstance, uint32 time); // triggers every second for an instance
    void  OnInstanceFailure(CInstance* PInstance);                               // triggers when an instance is failed
    void  OnInstanceCreatedCallback(CCharEntity* PChar, CInstance* PInstance);   // triggers when an instance is created (per character - waiting outside for entry)
    void  OnInstanceCreated(CInstance* PInstance);                               // triggers when an instance is created (instance setup)
    void  OnInstanceProgressUpdate(CInstance* PInstance);
    void  OnInstanceStageChange(CInstance* PInstance);
    void  OnInstanceComplete(CInstance* PInstance);

    uint32 GetMobRespawnTime(uint32 mobid);
    void   DisallowRespawn(uint32 mobid, bool allowRespawn);
    void   UpdateNMSpawnPoint(uint32 mobid);

    std::string GetServerMessage(uint8 language);               // Get the message to be delivered to player on first zone in of a session
    auto        GetRecentFishers(uint16 minutes) -> sol::table; // returns a list of recently active fishers (that fished in the last specified minutes)

    void  OnAdditionalEffect(CBattleEntity* PAttacker, CBattleEntity* PDefender, actionTarget_t* Action, int32 damage);                                      // for mobs with additional effects
    void  OnSpikesDamage(CBattleEntity* PDefender, CBattleEntity* PAttacker, actionTarget_t* Action, int32 damage);                                          // for mobs with spikes
    int32 additionalEffectAttack(CBattleEntity* PAttacker, CBattleEntity* PDefender, CItemWeapon* PItem, actionTarget_t* Action, int32 baseAttackDamage);    // for items with additional effects
    void  additionalEffectSpikes(CBattleEntity* PDefender, CBattleEntity* PAttacker, CItemEquipment* PItem, actionTarget_t* Action, int32 baseAttackDamage); // for armor with spikes

    auto NearLocation(sol::table const& table, float radius, float theta) -> sol::table;
    auto GetFurthestValidPosition(CLuaBaseEntity* fromTarget, float distance, float theta) -> sol::table;

    void OnPlayerDeath(CCharEntity* PChar);
    void OnPlayerLevelUp(CCharEntity* PChar);
    void OnPlayerLevelDown(CCharEntity* PChar);
    void OnPlayerMount(CCharEntity* PChar);
    void OnPlayerEmote(CCharEntity* PChar, Emote EmoteID);
    void OnPlayerVolunteer(CCharEntity* PChar, std::string const& text);

    bool OnChocoboDig(CCharEntity* PChar); // chocobo digging

    // Utility method: checks for and loads a lua function for events
    auto LoadEventScript(CCharEntity* PChar, const char* functionName) -> sol::function;

    uint16 GetDespoilDebuff(uint16 itemId); // Ask the database for an effectId based on Item despoiled (returns 0 if not in db)

    void OnFurniturePlaced(CCharEntity* PChar, CItemFurnishing* itemId);
    void OnFurnitureRemoved(CCharEntity* PChar, CItemFurnishing* itemId);

    uint16 SelectDailyItem(CLuaBaseEntity* PLuaBaseEntity, uint8 dial);

    auto SetCustomMenuContext(CCharEntity* PChar, sol::table table) -> std::string;
    bool HasCustomMenuContext(CCharEntity* PChar);
    void HandleCustomMenu(CCharEntity* PChar, const std::string& selection);

    // Retrive the first itemId that matches a name
    uint16 GetItemIDByName(std::string const& name);
    auto   SendItemToDeliveryBox(const std::string& playerName, uint16 itemId, uint32 quantity, const std::string& senderText) -> SendToDBoxReturnCode;

    std::optional<CLuaBaseEntity> GenerateDynamicEntity(CZone* PZone, CInstance* PInstance, sol::table table);

    // Fishing Contest
    auto GetFishingContest() -> sol::table;
    void InitNewFishingContest();
    void SetContestParameters(uint16 fishId, uint8 measure, uint8 criteria);
    void ProgressFishingContest();
    void InitializeFishingContestSystem();

    template <typename... Targs>
    int32 invokeBattlefieldEvent(uint16 battlefieldId, const std::string& eventName, Targs... args);

    auto GetSynergyRecipeByID(uint32 id) -> sol::table;
    auto GetSynergyRecipeByTrade(CLuaTradeContainer luaTradeContainer) -> sol::table;
}; // namespace luautils

// template impl
template <typename... Targs>
int32 luautils::invokeBattlefieldEvent(uint16 battlefieldId, const std::string& eventName, Targs... args)
{
    // Calls the Battlefield event through the interaction object if it can find it
    sol::table contents = lua["xi"]["battlefield"]["contents"];
    if (!contents.valid())
    {
        return -1;
    }

    auto battlefield = contents[battlefieldId];
    if (!battlefield.valid())
    {
        return -1;
    }

    auto content = battlefield.get<sol::table>();
    auto handler = content[eventName];
    if (!handler.valid())
    {
        return -1;
    }

    auto result = handler.get<sol::protected_function>()(content, args...);
    if (!result.valid())
    {
        sol::error err = result;
        ShowError("luautils::%s: %s", eventName, err.what());
        return -1;
    }

    return 0;
}

#endif // _LUAUTILS_H -
