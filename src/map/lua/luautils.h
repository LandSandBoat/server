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

// sol changes this behaviour to return 0 rather than truncating
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

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

class CAbility;
class CSpell;
class CBaseEntity;
class CBattleEntity;
class CAutomatonEntity;
class CPetEntity;
class CCharEntity;
class CBattlefield;
class CItem;
class CMobSkill;
class CPetSkill;
class CTriggerArea;
class CStatusEffect;
class CTradeContainer;
class CItemPuppet;
class CItemWeapon;
class CItemEquipment;
class CItemFurnishing;
class CInstance;
class CWeaponSkill;
class CZone;

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
    void SafeApplyFunc_ReloadList(std::function<void(std::map<std::string, uint64>&)> func);

    int32 init();
    int32 garbageCollectStep();
    int32 garbageCollectFull();
    void  cleanup();

    void ReloadFilewatchList();

    std::vector<std::string> GetContainerFilenamesList();

    // Cache helpers
    auto getEntityCachedFunction(CBaseEntity* PEntity, std::string funcName) -> sol::function;
    void CacheLuaObjectFromFile(std::string filename, bool overwriteCurrentEntry = false);
    auto GetCacheEntryFromFilename(std::string filename) -> sol::table;
    void OnEntityLoad(CBaseEntity* PEntity);

    void PopulateIDLookups(std::optional<uint16> maybeZoneId = std::nullopt);

    void SendEntityVisualPacket(uint32 npcid, const char* command);
    void InitInteractionGlobal();
    auto GetZone(uint16 zoneId) -> std::optional<CLuaZone>;
    auto GetNPCByID(uint32 npcid, sol::object const& instanceObj) -> std::optional<CLuaBaseEntity>;
    auto GetMobByID(uint32 mobid, sol::object const& instanceObj) -> std::optional<CLuaBaseEntity>;
    auto GetEntityByID(uint32 mobid, sol::object const& instanceObj, sol::object const& arg3) -> std::optional<CLuaBaseEntity>;

    void  WeekUpdateConquest(sol::variadic_args va);
    uint8 GetRegionOwner(uint8 type);
    uint8 GetRegionInfluence(uint8 type); // Return influence graphics
    uint8 GetNationRank(uint8 nation);
    uint8 GetConquestBalance();
    bool  IsConquestAlliance();
    int32 SetRegionalConquestOverseers(uint8 regionID); // Update NPC Conquest Guard
    void  SendLuaFuncStringToZone(uint16 zoneId, std::string const& str);

    auto GetReadOnlyItem(uint32 id) -> std::optional<CLuaItem>; // Returns a read only lookup item object of the specified ID
    auto GetAbility(uint16 id) -> std::optional<CLuaAbility>;
    auto GetSpell(uint16 id) -> std::optional<CLuaSpell>;

    auto SpawnMob(uint32 mobid, sol::object const& arg2, sol::object const& arg3) -> std::optional<CLuaBaseEntity>; // Spawn Mob By Mob Id - NMs, BCNM...
    void DespawnMob(uint32 mobid, sol::object const& arg2);                                                         // Despawn (Fade Out) Mob By Id
    auto GetPlayerByName(std::string const& name) -> std::optional<CLuaBaseEntity>;
    auto GetPlayerByID(uint32 pid) -> std::optional<CLuaBaseEntity>;
    auto GetMagianTrial(sol::variadic_args va) -> sol::table;
    auto GetMagianTrialsWithParent(int32 parentTrial) -> sol::table;

    uint32 JstMidnight();
    uint32 JstWeekday();
    uint32 VanadielTime();          // Gets the current Vanadiel Time in timestamp format (SE epoch in earth seconds)
    uint8  VanadielTOTD();          // текущее игровое время суток
    uint32 VanadielHour();          // текущие Vanadiel часы
    uint32 VanadielMinute();        // текущие Vanadiel минуты
    uint32 VanadielDayOfTheYear();  // Gets Integer Value for Day of the Year (Jan 01 = Day 1)
    uint32 VanadielDayOfTheMonth(); // Gets day of the month (Feb 6 = Day 6)
    uint32 VanadielDayOfTheWeek();  // Gets day of the week (Fire Earth Water Wind Ice Lightning Light Dark)
    uint32 VanadielYear();          // Gets the current Vanadiel Year
    uint32 VanadielMonth();         // Gets the current Vanadiel Month
    uint32 VanadielUniqueDay();     // Gets the unique day number. (Vanadiel year * 360 + VanadielDayOfTheYear)
    uint8  VanadielDayElement();    // Gets element of the day (1: fire, 2: ice, 3: wind, 4: earth, 5: thunder, 6: water, 7: light, 8: dark)
    uint32 VanadielMoonPhase();     // Gets the current Vanadiel Moon Phase
    uint8  VanadielMoonDirection(); // Gets the current Vanadiel Moon Phasing direction (waxing, waning, neither)
    uint8  VanadielRSERace();       // Gets the current Race for RSE gear quest
    uint8  VanadielRSELocation();   // Gets the current Location for RSE gear quest
    bool   SetVanadielTimeOffset(int32 offset);
    bool   IsMoonNew();  // Returns true if the moon is new
    bool   IsMoonFull(); // Returns true if the moon is full
    void   StartElevator(uint32 ElevatorID);
    int16  GetElevatorState(uint8 id); // Returns -1 if elevator is not found. Otherwise, returns the uint8 state.

    int32 GetServerVariable(std::string const& name);
    void  SetServerVariable(std::string const& name, int32 value);
    int32 GetVolatileServerVariable(std::string const& varName);
    void  SetVolatileServerVariable(std::string const& varName, int32 value);
    int32 GetCharVar(uint32 charId, std::string const& varName);              // Get player var directly from SQL DB
    void  SetCharVar(uint32 charId, std::string const& varName, int32 value); // Set player var in SQL DB using charId
    void  ClearCharVarFromAll(std::string const& varName);                    // Deletes a specific player variable from all players
    void  Terminate();                                                        // Logs off all characters and terminates the server

    int32 GetTextIDVariable(uint16 ZoneID, const char* variable); // загружаем значение переменной TextID указанной зоны
    bool  IsContentEnabled(const char* content);                  // Check if the content is enabled in settings.lua

    int32 OnGameDay(CZone* PZone);  // Automatic action of NPC every game day
    int32 OnGameHour(CZone* PZone); // Automatic action of NPC every game hour
    int32 OnZoneWeatherChange(uint16 ZoneID, uint8 weather);
    int32 OnTOTDChange(uint16 ZoneID, uint8 TOTD);

    int32 OnGameIn(CCharEntity* PChar, bool zoning);
    void  OnZoneIn(CCharEntity* PChar);                                       // triggers when a player zones into a zone
    void  OnZoneOut(CCharEntity* PChar);                                      // triggers when a player leaves a zone
    void  AfterZoneIn(CBaseEntity* PChar);                                    // triggers after a player has finished zoning in
    int32 OnZoneInitialise(uint16 ZoneID);                                    // triggers when zone is loaded
    void  OnZoneTick(CZone* PZone);                                           // triggers when the zone is ticked
    int32 OnTriggerAreaEnter(CCharEntity* PChar, CTriggerArea* PTriggerArea); // when player enters a trigger area in a zone
    int32 OnTriggerAreaLeave(CCharEntity* PChar, CTriggerArea* PTriggerArea); // when player leaves a trigger area in a zone
    int32 OnTransportEvent(CCharEntity* PChar, uint32 TransportID);
    void  OnTimeTrigger(CNpcEntity* PNpc, uint8 triggerID);
    int32 OnConquestUpdate(CZone* PZone, ConquestUpdate type); // hourly conquest update

    void OnServerStart();
    void OnJSTMidnight();
    void OnTimeServerTick();

    int32 OnTrigger(CCharEntity* PChar, CBaseEntity* PNpc);                                // triggered when user targets npc and clicks action button
    int32 OnEventUpdate(CCharEntity* PChar, uint16 eventID, uint32 result, uint16 extras); // triggered when game triggers event update during cutscene with extra parameters (battlefield)
    int32 OnEventUpdate(CCharEntity* PChar, uint16 eventID, uint32 result);                // triggered when game triggers event update during cutscene
    int32 OnEventUpdate(CCharEntity* PChar, std::string const& updateString);              // triggered when game triggers event update during cutscene
    int32 OnEventFinish(CCharEntity* PChar, uint16 eventID, uint32 result);                // triggered when cutscene/event is completed
    int32 OnTrade(CCharEntity* PChar, CBaseEntity* PNpc);                                  // triggers when a trade completes with an npc

    int32 OnNpcSpawn(CBaseEntity* PNpc); // triggers when a patrol npc spawns

    int32 OnEffectGain(CBattleEntity* PEntity, CStatusEffect* StatusEffect); // triggers when an effect is applied to pc/npc
    int32 OnEffectTick(CBattleEntity* PEntity, CStatusEffect* StatusEffect); // triggers when effect tick timer has been reached
    int32 OnEffectLose(CBattleEntity* PEntity, CStatusEffect* StatusEffect); // triggers when effect has been lost

    int32 OnAttachmentEquip(CBattleEntity* PEntity, CItemPuppet* attachment);
    int32 OnAttachmentUnequip(CBattleEntity* PEntity, CItemPuppet* attachment);
    int32 OnManeuverGain(CBattleEntity* PEntity, CItemPuppet* attachment, uint8 maneuvers);
    int32 OnManeuverLose(CBattleEntity* PEntity, CItemPuppet* attachment, uint8 maneuvers);
    int32 OnUpdateAttachment(CBattleEntity* PEntity, CItemPuppet* attachment, uint8 maneuvers);

    int32 OnItemUse(CBaseEntity* PUser, CBaseEntity* PTarget, CItem* PItem);                                                                                     // triggers when item is used
    auto  OnItemCheck(CBaseEntity* PTarget, CItem* PItem, ITEMCHECK param = ITEMCHECK::NONE, CBaseEntity* PCaster = nullptr) -> std::tuple<int32, int32, int32>; // check to see if item can be used
    int32 OnItemDrop(CBaseEntity* PUser, CItem* PItem);                                                                                                          // trigger when an item is dropped
    int32 OnItemEquip(CBaseEntity* PUser, CItem* PItem);
    int32 OnItemUnequip(CBaseEntity* PUser, CItem* PItem);
    int32 CheckForGearSet(CBaseEntity* PTarget); // check for gear sets

    int32 OnMagicCastingCheck(CBaseEntity* PChar, CBaseEntity* PTarget, CSpell* PSpell);                                                       // triggers when a player attempts to cast a spell
    int32 OnSpellCast(CBattleEntity* PCaster, CBattleEntity* PTarget, CSpell* PSpell);                                                         // triggered when casting a spell
    int32 OnSpellPrecast(CBattleEntity* PCaster, CSpell* PSpell);                                                                              // triggered just before casting a spell
    auto  OnMobMagicPrepare(CBattleEntity* PCaster, CBattleEntity* PTarget, std::optional<SpellID> startingSpellId) -> std::optional<SpellID>; // triggered when monster wants to use a spell on target
    int32 OnMagicHit(CBattleEntity* PCaster, CBattleEntity* PTarget, CSpell* PSpell);                                                          // triggered when spell cast on monster
    int32 OnWeaponskillHit(CBattleEntity* PMob, CBaseEntity* PAttacker, uint16 PWeaponskill);                                                  // Triggered when Weaponskill strikes monster
    bool  OnTrustSpellCastCheckBattlefieldTrusts(CBattleEntity* PCaster);                                                                      // Triggered if spell is a trust spell during onCast to determine to interrupt spell or not

    int32 OnMobInitialize(CBaseEntity* PMob); // Used for passive trait
    int32 ApplyMixins(CBaseEntity* PMob);
    int32 ApplyZoneMixins(CBaseEntity* PMob);
    int32 OnMobSpawn(CBaseEntity* PMob);      // triggers on mob spawn
    int32 OnMobRoamAction(CBaseEntity* PMob); // triggers when event mob is ready for a custom roam action
    int32 OnMobRoam(CBaseEntity* PMob);
    int32 OnMobEngaged(CBaseEntity* PMob, CBaseEntity* PTarget); // triggers on mob engaging a target
    int32 OnMobDisengage(CBaseEntity* PMob);                     // triggers on mob disengaging (no more targets)
    int32 OnMobDrawIn(CBaseEntity* PMob, CBaseEntity* PTarget);
    int32 OnMobFight(CBaseEntity* PMob, CBaseEntity* PTarget); // Сalled every 3 sec when a player fight monster
    int32 OnCriticalHit(CBattleEntity* PMob, CBattleEntity* PAttacker);
    int32 OnMobDeath(CBaseEntity* PMob, CBaseEntity* PKiller); // triggers on mob death
    int32 OnMobDespawn(CBaseEntity* PMob);                     // triggers on mob despawn (death not assured)

    int32 OnPetLevelRestriction(CBaseEntity* PMob); // Triggers onPetLevelRestriction in global pet script

    int32 OnPath(CBaseEntity* PEntity);         // triggers when an entity is on a pathfind point
    int32 OnPathPoint(CBaseEntity* PEntity);    // triggers when an entity stops on a path point and has finished waiting at it
    int32 OnPathComplete(CBaseEntity* PEntity); // triggers when an entity finishes its pathing

    int32 OnBattlefieldHandlerInitialise(CZone* PZone);
    int32 OnBattlefieldInitialise(CBattlefield* PBattlefield); // what to do when initialising battlefield, battlefield:setLocalVar("lootId") here for any which have loot
    int32 OnBattlefieldTick(CBattlefield* PBattlefield);
    int32 OnBattlefieldStatusChange(CBattlefield* PBattlefield);

    void OnBattlefieldEnter(CCharEntity* PChar, CBattlefield* PBattlefield);                  // triggers when enter a bcnm
    void OnBattlefieldLeave(CCharEntity* PChar, CBattlefield* PBattlefield, uint8 LeaveCode); // see battlefield.h BATTLEFIELD_LEAVE_CODE
    void OnBattlefieldKick(CCharEntity* PChar);

    void OnBattlefieldRegister(CCharEntity* PChar, CBattlefield* PBattlefield); // triggers when successfully registered a bcnm
    void OnBattlefieldDestroy(CBattlefield* PBattlefield);                      // triggers when BCNM is destroyed

    uint16 OnMobWeaponSkillPrepare(CBattleEntity* PMob, CBattleEntity* PTarget);
    int32  OnMobWeaponSkill(CBaseEntity* PChar, CBaseEntity* PMob, CMobSkill* PMobSkill, action_t* action); // triggers when mob weapon skill is used
    int32  OnMobSkillCheck(CBaseEntity* PChar, CBaseEntity* PMob, CMobSkill* PMobSkill);                    // triggers before mob weapon skill is used, returns 0 if the move is valid
    auto   OnMobSkillTarget(CBattleEntity* PTarget, CBaseEntity* PMob, CMobSkill* PMobSkill) -> CBattleEntity*;
    int32  OnAutomatonAbilityCheck(CBaseEntity* PChar, CAutomatonEntity* PAutomaton, CMobSkill* PMobSkill);
    int32  OnAutomatonAbility(CBaseEntity* PTarget, CBaseEntity* PMob, CMobSkill* PMobSkill, CBaseEntity* PMobMaster, action_t* action);

    int32 OnAbilityCheck(CBaseEntity* PChar, CBaseEntity* PTarget, CAbility* PAbility, CBaseEntity** PMsgTarget);                                                                               // triggers when a player attempts to use a job ability or roll
    int32 OnPetAbility(CBaseEntity* PTarget, CBaseEntity* PMob, CMobSkill* PMobSkill, CBaseEntity* PPetMaster, action_t* action);                                                               // triggers when pet uses an ability
    int32 OnPetAbility(CBaseEntity* PTarget, CPetEntity* PPet, CPetSkill* PMobSkill, CBaseEntity* PPetMaster, action_t* action);                                                                // triggers when pet uses an ability, specialized for pets
    auto  OnUseWeaponSkill(CBattleEntity* PUser, CBaseEntity* PMob, CWeaponSkill* wskill, uint16 tp, bool primary, action_t& action, CBattleEntity* taChar) -> std::tuple<int32, uint8, uint8>; // returns: damage, tphits landed, extra hits landed
    int32 OnUseAbility(CBattleEntity* PUser, CBattleEntity* PTarget, CAbility* PAbility, action_t* action);                                                                                     // triggers when job ability is used
    int32 OnSteal(CBattleEntity* PChar, CBattleEntity* PTarget, CAbility* PAbility, action_t* action);

    bool OnCanUseSpell(CBattleEntity* PChar, CSpell* Spell); // triggers when CanUseSpell is invoked on spell.cpp for PCs only

    auto GetCachedInstanceScript(uint16 instanceId) -> sol::table;

    int32 OnInstanceZoneIn(CCharEntity* PChar, CInstance* PInstance);            // triggered on zone in to instance
    void  AfterInstanceRegister(CBaseEntity* PChar);                             // triggers after a character is registered and zoned into an instance (the first time)
    int32 OnInstanceLoadFailed(CZone* PZone);                                    // triggers when an instance load is failed (ie. instance no longer exists)
    int32 OnInstanceTimeUpdate(CZone* PZone, CInstance* PInstance, uint32 time); // triggers every second for an instance
    int32 OnInstanceFailure(CInstance* PInstance);                               // triggers when an instance is failed
    int32 OnInstanceCreatedCallback(CCharEntity* PChar, CInstance* PInstance);   // triggers when an instance is created (per character - waiting outside for entry)
    int32 OnInstanceCreated(CInstance* PInstance);                               // triggers when an instance is created (instance setup)
    int32 OnInstanceProgressUpdate(CInstance* PInstance);                        // triggers when progress is updated in an instance
    int32 OnInstanceStageChange(CInstance* PInstance);                           // triggers when stage is changed in an instance
    int32 OnInstanceComplete(CInstance* PInstance);                              // triggers when an instance is completed

    uint32 GetMobRespawnTime(uint32 mobid);                        // get the respawn time of a mob
    void   DisallowRespawn(uint32 mobid, bool allowRespawn);       // Allow or prevent a mob from spawning
    void   UpdateNMSpawnPoint(uint32 mobid);                       // Update the spawn point of an NM
    void   SetDropRate(uint16 dropid, uint16 itemid, uint16 rate); // Set drop rate of a mob SetDropRate(dropid,itemid,newrate)
    int32  UpdateServerMessage();                                  // update server message, first modify in conf and update

    int32 OnAdditionalEffect(CBattleEntity* PAttacker, CBattleEntity* PDefender, actionTarget_t* Action, int32 damage);                                      // for mobs with additional effects
    int32 OnSpikesDamage(CBattleEntity* PDefender, CBattleEntity* PAttacker, actionTarget_t* Action, int32 damage);                                          // for mobs with spikes
    int32 additionalEffectAttack(CBattleEntity* PAttacker, CBattleEntity* PDefender, CItemWeapon* PItem, actionTarget_t* Action, int32 baseAttackDamage);    // for items with additional effects
    int32 additionalEffectSpikes(CBattleEntity* PDefender, CBattleEntity* PAttacker, CItemEquipment* PItem, actionTarget_t* Action, int32 baseAttackDamage); // for armor with spikes

    auto NearLocation(sol::table const& table, float radius, float theta) -> sol::table;
    auto GetFurthestValidPosition(CLuaBaseEntity* fromTarget, float distance, float theta) -> sol::table;

    void OnPlayerDeath(CCharEntity* PChar);
    void OnPlayerLevelUp(CCharEntity* PChar);
    void OnPlayerLevelDown(CCharEntity* PChar);
    void OnPlayerMount(CCharEntity* PChar);
    void OnPlayerEmote(CCharEntity* PChar, Emote EmoteID);
    void OnPlayerVolunteer(CCharEntity* PChar, std::string text);

    bool OnChocoboDig(CCharEntity* PChar, bool pre); // chocobo digging, pre = check

    // Utility method: checks for and loads a lua function for events
    auto LoadEventScript(CCharEntity* PChar, const char* functionName) -> sol::function;

    uint16 GetDespoilDebuff(uint16 itemId); // Ask the database for an effectId based on Item despoiled (returns 0 if not in db)

    void OnFurniturePlaced(CCharEntity* PChar, CItemFurnishing* itemId);
    void OnFurnitureRemoved(CCharEntity* PChar, CItemFurnishing* itemId);

    uint16 SelectDailyItem(CLuaBaseEntity* PLuaBaseEntity, uint8 dial);

    auto SetCustomMenuContext(CCharEntity* PChar, sol::table table) -> std::string;
    bool HasCustomMenuContext(CCharEntity* PChar);
    void HandleCustomMenu(CCharEntity* PChar, std::string selection);

    // Retrive the first itemId that matches a name
    uint16 GetItemIDByName(std::string const& name);

    template <typename... Targs>
    int32 invokeBattlefieldEvent(uint16 battlefieldId, const std::string& eventName, Targs... args)
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

}; // namespace luautils

#endif // _LUAUTILS_H -
