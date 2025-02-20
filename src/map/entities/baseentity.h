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

#ifndef _BASEENTITY_H
#define _BASEENTITY_H

#include "common/cbasetypes.h"
#include "common/mmo.h"
#include "packets/message_basic.h"

#include <map>
#include <memory>
#include <vector>

enum ENTITYTYPE : uint8
{
    TYPE_NONE   = 0x00,
    TYPE_PC     = 0x01,
    TYPE_NPC    = 0x02,
    TYPE_MOB    = 0x04,
    TYPE_PET    = 0x08,
    TYPE_SHIP   = 0x10,
    TYPE_TRUST  = 0x20,
    TYPE_FELLOW = 0x40,
};
DECLARE_FORMAT_AS_UNDERLYING(ENTITYTYPE);

enum class STATUS_TYPE : uint8
{
    NORMAL        = 0,
    UPDATE        = 1,
    DISAPPEAR     = 2,
    INVISIBLE     = 3,
    STATUS_4      = 4,
    CUTSCENE_ONLY = 6,
    STATUS_18     = 18,
    SHUTDOWN      = 20,
};
DECLARE_FORMAT_AS_UNDERLYING(STATUS_TYPE);

enum ANIMATIONTYPE : uint8
{
    ANIMATION_NONE    = 0,
    ANIMATION_ATTACK  = 1,
    ANIMATION_DESPAWN = 2,
    ANIMATION_DEATH   = 3,
    ANIMATION_EVENT   = 4,
    ANIMATION_CHOCOBO = 5,
    ANIMATION_FISHING = 6,
    // Healing                      = 7,
    ANIMATION_OPEN_DOOR     = 8,
    ANIMATION_CLOSE_DOOR    = 9,
    ANIMATION_ELEVATOR_UP   = 10,
    ANIMATION_ELEVATOR_DOWN = 11,
    // seems to be WALLHACK                     = 28,
    // seems to be WALLHACK also..              = 31,
    ANIMATION_HEALING                = 33,
    ANIMATION_FISHING_FISH_OLD       = 38,
    ANIMATION_FISHING_CAUGHT_OLD     = 39,
    ANIMATION_FISHING_ROD_BREAK_OLD  = 40,
    ANIMATION_FISHING_LINE_BREAK_OLD = 41,
    ANIMATION_FISHING_MONSTER_OLD    = 42,
    ANIMATION_FISHING_STOP_OLD       = 43,
    ANIMATION_SYNTH                  = 44,
    ANIMATION_SIT                    = 47,
    ANIMATION_RANGED                 = 48,
    ANIMATION_FISHING_START_OLD      = 50,
    ANIMATION_FISHING_START          = 56,
    ANIMATION_FISHING_FISH           = 57,
    ANIMATION_FISHING_CAUGHT         = 58,
    ANIMATION_FISHING_ROD_BREAK      = 59,
    ANIMATION_FISHING_LINE_BREAK     = 60,
    ANIMATION_FISHING_MONSTER        = 61,
    ANIMATION_FISHING_STOP           = 62,
    // 63 through 72 are used with /sitchair
    ANIMATION_SITCHAIR_0  = 63,
    ANIMATION_SITCHAIR_1  = 64,
    ANIMATION_SITCHAIR_2  = 65,
    ANIMATION_SITCHAIR_3  = 66,
    ANIMATION_SITCHAIR_4  = 67,
    ANIMATION_SITCHAIR_5  = 68,
    ANIMATION_SITCHAIR_6  = 69,
    ANIMATION_SITCHAIR_7  = 70,
    ANIMATION_SITCHAIR_8  = 71,
    ANIMATION_SITCHAIR_9  = 72,
    ANIMATION_SITCHAIR_10 = 73,
    // 74 through 83 sitting on air (guessing future use for more chairs..)
    ANIMATION_MOUNT = 85,
    // ANIMATION_TRUST              = 90 // This is the animation for a trust NPC spawning in.
};

enum MOUNTTYPE : uint8
{
    MOUNT_CHOCOBO        = 0,
    MOUNT_QUEST_RAPTOR   = 1,
    MOUNT_RAPTOR         = 2,
    MOUNT_TIGER          = 3,
    MOUNT_CRAB           = 4,
    MOUNT_RED_CRAB       = 5,
    MOUNT_BOMB           = 6,
    MOUNT_RAM            = 7,
    MOUNT_MORBOL         = 8,
    MOUNT_CRAWLER        = 9,
    MOUNT_FENRIR         = 10,
    MOUNT_BEETLE         = 11,
    MOUNT_MOOGLE         = 12,
    MOUNT_MAGIC_POT      = 13,
    MOUNT_TULFAIRE       = 14,
    MOUNT_WARMACHINE     = 15,
    MOUNT_XZOMIT         = 16,
    MOUNT_HIPPOGRYPH     = 17,
    MOUNT_SPECTRAL_CHAIR = 18,
    MOUNT_SPHEROID       = 19,
    MOUNT_OMEGA          = 20,
    MOUNT_COEURL         = 21,
    MOUNT_GOOBBUE        = 22,
    MOUNT_RAAZ           = 23,
    MOUNT_LEVITUS        = 24,
    MOUNT_ADAMANTOISE    = 25,
    MOUNT_DHAMEL         = 26,
    MOUNT_DOLL           = 27,
    MOUNT_GOLDEN_BOMB    = 28,
    MOUNT_BUFFALO        = 29,
    MOUNT_WIVRE          = 30,
    MOUNT_RED_RAPTOR     = 31,
    MOUNT_IRON_GIANT     = 32,
    MOUNT_BYAKKO         = 33,
    MOUNT_NOBLE_CHOCOBO  = 34, // NOTE: This is currently blank, probably needs additional packets sent
    MOUNT_IXION          = 35,
    MOUNT_PHUABO         = 36,
    //
    MOUNT_MAX = 37,
};

enum class ALLEGIANCE_TYPE : uint8
{
    MOB       = 0,
    PLAYER    = 1,
    SAN_DORIA = 2,
    BASTOK    = 3,
    WINDURST  = 4,
    WYVERNS   = 5,
    GRIFFONS  = 6,
};

enum UPDATETYPE : uint8
{
    UPDATE_NONE     = 0x00,
    UPDATE_POS      = 0x01,
    UPDATE_STATUS   = 0x02,
    UPDATE_HP       = 0x04,
    UPDATE_COMBAT   = 0x07,
    UPDATE_NAME     = 0x08,
    UPDATE_ALL_MOB  = 0x0F,
    UPDATE_LOOK     = 0x10,
    UPDATE_ALL_CHAR = 0x1F,
    UPDATE_DESPAWN  = 0x20,
};

enum ENTITYFLAGS : uint16
{
    FLAG_NONE      = 0x000,
    FLAG_INFO_ICON = 0x001, // (I) Icon next to name

    // TODO: Flags 0x002, 0x004 and 0x008 do different things for different entities.
    //     : It isn't one-size-fits-all, and different combinations may do different things.
    //     : It'll need to researched more.
    // FLAG_ALT_APPEARANCE = 0x002,

    FLAG_HIDE_NAME     = 0x008,
    FLAG_CALL_FOR_HELP = 0x020,
    FLAG_HIDE_MODEL    = 0x080,
    FLAG_HIDE_HP       = 0x100,
    FLAG_UNTARGETABLE  = 0x800,
};

enum NAMEVIS : uint8
{
    VIS_NONE        = 0x00,
    VIS_ICON        = 0x01,
    VIS_HIDE_NAME   = 0x08,
    VIS_GHOST_PHASE = 0x80,
};

enum class SPAWN_ANIMATION : uint8
{
    NORMAL  = 0,
    SPECIAL = 1,
};

// TODO: It is possible to make this structure part of the class, instead of the current ID and Targid, but without the clean() method.
struct EntityID_t
{
    // TODO: Add a constructor that takes an id and targid.
    // TODO: Clean with a destructor.
    void clean()
    {
        id     = 0;
        targid = 0;
    }

    // TODO: Globally rename targid to index, zoneIndex, etc.

    uint32 id;     // "Long" global ID of the entity. Built from 0x10000000 | (zoneId << 16) | targid.
    uint16 targid; // The "index" of the entity in the current zone. Used for local targeting and referencing.

    // TODO: Store the zoneId of this entity's zone. We can then use the targid (index) and the zoneId to build the global id.
    // TODO: Store an incremental u64 as a UUID for the entity for disambiguation in the case of dynamic entities that might have the same targid.
};

class CAIContainer;
class CBattlefield;
class CInstance;
class CZone;

struct location_t
{
    position_t p;           // Position of entity
    uint16     destination; // Destination zone while zoning
    CZone*     zone;        // Current zone
    uint16     prevzone;    // Previous zone (Not used for monsters and NPCs)
    bool       zoning;      // The flag is reset at each entrance to the new zone. We are needed to implement the logic of game tasks ("Quests")
    uint16     boundary;    // A certain area in the zone in which the entity is located (used by characters and transport)

    location_t()
    : destination(0)
    , zone(nullptr)
    , prevzone(0)
    , zoning(false)
    , boundary(0)
    {
    }
};

/************************************************************************
 *                                                                       *
 *  Basic class for all entities in the game                             *
 *                                                                       *
 ************************************************************************/

class CBaseEntity
{
public:
    CBaseEntity();
    virtual ~CBaseEntity();

    virtual void Spawn();
    virtual void FadeOut();

    virtual const std::string& getName();       // Internal name of entity
    virtual const std::string& getPacketName(); // Name of entity sent to the client

    uint16        getZone() const; // Current zone
    float         GetXPos() const; // Position of co-ordinate X
    float         GetYPos() const; // Position of co-ordinate Y
    float         GetZPos() const; // Position of co-ordinate Z
    uint8         GetRotPos() const;
    uint8         GetSpeed() const;
    virtual uint8 UpdateSpeed(bool run = false);

    void         HideName(bool hide);     // hide / show name
    void         GhostPhase(bool ghost);  // makes mob semi transparent
    bool         IsNameHidden() const;    // checks if name is hidden
    virtual bool GetUntargetable() const; // checks if entity is untargetable
    virtual bool isWideScannable();       // checks if the entity should show up on wide scan

    bool CanSeeTarget(CBaseEntity* target, bool fallbackNavMesh = true);
    bool CanSeeTarget(const position_t& targetPoint, bool fallbackNavMesh = true);

    CBaseEntity* GetEntity(uint16 targid, uint8 filter = -1) const;
    void         SendZoneUpdate();

    void   ResetLocalVars();
    uint32 GetLocalVar(const std::string& var);
    void   SetLocalVar(const std::string& var, uint32 val);
    auto   GetLocalVars() -> std::map<std::string, uint32>&;

    // pre-tick update
    virtual void Tick(time_point) = 0;
    // post-tick update
    virtual void PostTick() = 0;

    void   SetModelId(uint16 modelId); // Set new modelid
    uint16 GetModelId() const;         // Get the modelid

    virtual void HandleErrorMessage(std::unique_ptr<CBasicPacket>&) {};

    bool IsDynamicEntity() const;

    uint32          id;             // global identifier unique on the server
    uint16          targid;         // local identifier unique to the zone
    ENTITYTYPE      objtype;        // Type of entity
    STATUS_TYPE     status;         // Entity status (different entities - different statuses)
    uint16          m_TargID;       // the targid of the object the entity is looking at
    std::string     name;           // Entity name
    std::string     packetName;     // Used to override name when being sent to the client
    look_t          look;           //
    look_t          mainlook;       // only used if mob use changeSkin() or player /lockstyle
    location_t      loc;            // Location of entity
    uint8           animation;      // animation
    uint8           animationsub;   // Additional animation parameter
    uint8           baseSpeed;      // base movement speed
    uint8           animationSpeed; // speed of movement animation
    uint8           namevis;
    ALLEGIANCE_TYPE allegiance;     // what types of targets the entity can fight
    uint8           updatemask;     // what to update next server tick to players nearby
    bool            priorityRender; // CliPriorityFlag, will force this entity to render on clients if set. See https://github.com/atom0s/XiPackets/tree/main/world/server/0x0037 (also applies to 0x00E)

    bool isRenamed; // tracks if the entity's name has been overidden. Defaults to false.

    bool m_bReleaseTargIDOnDisappear;

    SPAWN_ANIMATION spawnAnimation;

    std::unique_ptr<CAIContainer> PAI;          // AI container
    CBattlefield*                 PBattlefield; // pointer to battlefield (if in one)
    CInstance*                    PInstance;

    std::chrono::steady_clock::time_point m_nextUpdateTimer; // next time the entity should push an update packet

protected:
    std::map<std::string, uint32> m_localVars;
    uint8                         speed; // speed of movement
};

#endif // _BASEENTITY_H
