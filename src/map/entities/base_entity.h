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
#include "common/timer.h"
#include "entities/entity_id.h"
#include "los_cache.h"
#include "packets/basic.h"

#include "data/enums/allegiance.h"
#include "data/enums/animation.h"
#include "data/enums/entity_flags.h"
#include "data/enums/name_vis.h"
#include "data/enums/spawn_animation.h"
#include "data/enums/status.h"
#include "data/enums/zone.h"

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
    MOUNT_NOBLE_CHOCOBO  = 34, // NOTE: This uses Chocobo animation, and CustomProperties[1] set to 1
    MOUNT_IXION          = 35,
    MOUNT_PHUABO         = 36,
    MOUNT_CRACKLAW       = 37,
    //
    MOUNT_MAX = 38,
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

class CBaseEntity;
class CAIContainer;
class CBattlefield;
class CInstance;
class CZone;

struct location_t
{
    position_t p;           // Position of entity
    xi::ZoneId destination; // Destination zone while zoning
    CZone*     zone;        // Current zone
    xi::ZoneId prevzone;    // Previous zone (Not used for monsters and NPCs)
    uint16     boundary;    // A certain area in the zone in which the entity is located (used by characters and transport)

    location_t()
    : destination(xi::ZoneId::Unknown)
    , zone(nullptr)
    , prevzone(xi::ZoneId::Unknown)
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

    virtual const std::string& getName() const; // Internal name of entity
    virtual const std::string& getPacketName(); // Name of entity sent to the client

    auto          getZone() const -> xi::ZoneId; // Current zone
    float         GetXPos() const;               // Position of co-ordinate X
    float         GetYPos() const;               // Position of co-ordinate Y
    float         GetZPos() const;               // Position of co-ordinate Z
    uint8         GetRotPos() const;
    uint8         GetSpeed() const;
    virtual uint8 UpdateSpeed(bool run = false);

    void         HideName(bool hide);     // hide / show name
    void         GhostPhase(bool ghost);  // makes mob semi transparent
    bool         IsNameHidden() const;    // checks if name is hidden
    virtual bool GetUntargetable() const; // checks if entity is untargetable
    virtual bool isWideScannable();       // checks if the entity should show up on wide scan

    bool CanSeeTarget(CBaseEntity* target);
    bool CanSeeTarget(const position_t& targetPoint);

    CBaseEntity* GetEntity(uint16 targid, uint8 filter = -1) const;
    void         SendZoneUpdate();

    void   ResetLocalVars();
    uint32 GetLocalVar(const std::string& var);
    void   SetLocalVar(const std::string& var, uint32 val);
    auto   GetLocalVars() -> std::map<std::string, uint32>&;

    // pre-tick update
    virtual auto Tick(timer::time_point) -> Task<void> = 0;

    // post-tick update
    virtual void PostTick() = 0;

    void   SetModelId(uint16 modelId); // Set new modelid
    uint16 GetModelId() const;         // Get the modelid

    virtual void HandleErrorMessage(std::unique_ptr<CBasicPacket>&) {};

    bool IsDynamicEntity() const;

    auto           serial() const -> uint64;
    auto           entityId() const -> EntityId;
    uint32         id;             // global identifier unique on the server
    uint16         targid;         // local identifier unique to the zone
    ENTITYTYPE     objtype;        // Type of entity
    xi::Status     status;         // Entity status (different entities - different statuses)
    uint16         m_TargID;       // the targid of the object the entity is looking at
    std::string    name;           // Entity name
    std::string    packetName;     // Used to override name when being sent to the client
    look_t         look;           //
    look_t         mainlook;       // only used if mob use changeSkin() or player /lockstyle
    location_t     loc;            // Location of entity
    xi::Animation  animation;      // animation
    uint8          animationsub;   // Additional animation parameter
    uint8          baseSpeed;      // base movement speed
    uint8          animationSpeed; // speed of movement animation
    xi::NameVis    namevis;
    xi::Allegiance allegiance;     // what types of targets the entity can fight
    uint8          updatemask;     // what to update next server tick to players nearby
    bool           priorityRender; // CliPriorityFlag, will force this entity to render on clients if set. See https://github.com/atom0s/XiPackets/tree/main/world/server/0x0037 (also applies to 0x00E)

    float modelHitboxSize = 0.0f; // used for distance calculations and is in packets
    uint8 modelSize       = 0;

    bool isRenamed; // tracks if the entity's name has been overidden. Defaults to false.

    bool m_bReleaseTargIDOnDisappear;

    xi::SpawnAnimation spawnAnimation;

    std::unique_ptr<CAIContainer> PAI;          // AI container
    CBattlefield*                 PBattlefield; // pointer to battlefield (if in one)
    CInstance*                    PInstance;

    timer::time_point m_nextUpdateTimer; // next time the entity should push an update packet

protected:
    std::map<std::string, uint32> localVars_;
    uint8                         speed; // speed of movement

    LineOfSightCache losCache_;

private:
    uint64 serial_{ 0 };
};

#endif // _BASEENTITY_H
