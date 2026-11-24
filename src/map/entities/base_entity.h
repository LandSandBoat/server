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
#include "common/macros.h"
#include "common/mmo.h"
#include "common/scheduler/scheduler.h"
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

    DISALLOW_COPY_AND_MOVE(CBaseEntity);

    virtual void Spawn();
    virtual void FadeOut();

    virtual auto getName() const -> const std::string&; // Internal name of entity
    virtual auto getPacketName() -> const std::string&; // Name of entity sent to the client

    auto         getZone() const -> xi::ZoneId; // Current zone
    auto         GetXPos() const -> float;      // Position of co-ordinate X
    auto         GetYPos() const -> float;      // Position of co-ordinate Y
    auto         GetZPos() const -> float;      // Position of co-ordinate Z
    auto         GetRotPos() const -> uint8;
    auto         GetSpeed() const -> uint8;
    virtual auto UpdateSpeed(bool run = false) -> uint8;

    void         HideName(bool hide);             // hide / show name
    void         GhostPhase(bool ghost);          // makes mob semi transparent
    auto         IsNameHidden() const -> bool;    // checks if name is hidden
    virtual auto GetUntargetable() const -> bool; // checks if entity is untargetable
    virtual auto isWideScannable() -> bool;       // checks if the entity should show up on wide scan

    auto CanSeeTarget(CBaseEntity* target) -> bool;
    auto CanSeeTarget(const position_t& targetPoint) -> bool;

    auto GetEntity(uint16 targid, uint8 filter = -1) const -> CBaseEntity*;
    void SendZoneUpdate();

    void ResetLocalVars();
    auto GetLocalVar(const std::string& var) const -> uint32;
    void SetLocalVar(const std::string& var, uint32 val);
    auto GetLocalVars() -> std::map<std::string, uint32>&;

    // pre-tick update
    virtual auto Tick(timer::time_point) -> Task<void> = 0;

    // post-tick update
    virtual void PostTick() = 0;

    void SetModelId(uint16 modelId);   // Set new modelid
    auto GetModelId() const -> uint16; // Get the modelid

    virtual void HandleErrorMessage(std::unique_ptr<CBasicPacket>&) {};

    auto IsDynamicEntity() const -> bool;

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
