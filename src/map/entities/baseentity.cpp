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

#include "baseentity.h"

#include "ai/ai_container.h"
#include "battlefield.h"
#include "instance.h"
#include "map.h"
#include "zone.h"

#include <cstring>

CBaseEntity::CBaseEntity()
: id(0)
, targid(0)
, objtype(ENTITYTYPE::TYPE_NONE)
, status(STATUS_TYPE::DISAPPEAR)
, m_TargID(0)
, animation(0)
, animationsub(0)
, speed(50 + settings::get<int8>("map.SPEED_MOD")) // It is downright dumb to init every entity at PLAYER speed, but until speed is reworked this hack stays.
, speedsub(50)                                     // Retail does NOT adjust this when speed is adjusted.
, namevis(0)
, allegiance(ALLEGIANCE_TYPE::MOB)
, updatemask(0)
, isRenamed(false)
, m_bReleaseTargIDOnDisappear(false)
, spawnAnimation(SPAWN_ANIMATION::NORMAL)
, PAI(nullptr)
, PBattlefield(nullptr)
, PInstance(nullptr)
, m_nextUpdateTimer(std::chrono::steady_clock::now())
{
}

CBaseEntity::~CBaseEntity()
{
    if (PBattlefield)
    {
        PBattlefield->RemoveEntity(this, BATTLEFIELD_LEAVE_CODE_WARPDC);
    }
}

void CBaseEntity::Spawn()
{
    status = allegiance == ALLEGIANCE_TYPE::MOB ? STATUS_TYPE::MOB : STATUS_TYPE::NORMAL;
    updatemask |= UPDATE_HP;
    ResetLocalVars();
    PAI->Reset();
    PAI->EventHandler.triggerListener("SPAWN", CLuaBaseEntity(this));
}

void CBaseEntity::FadeOut()
{
    status = STATUS_TYPE::DISAPPEAR;
    updatemask |= UPDATE_HP;
}

const std::string& CBaseEntity::GetName()
{
    return name;
}

const std::string& CBaseEntity::GetPacketName()
{
    return packetName;
}

uint16 CBaseEntity::getZone() const
{
    return loc.zone != nullptr ? (uint16)loc.zone->GetID() : (uint16)loc.destination;
}

float CBaseEntity::GetXPos() const
{
    return loc.p.x;
}

float CBaseEntity::GetYPos() const
{
    return loc.p.y;
}

float CBaseEntity::GetZPos() const
{
    return loc.p.z;
}

uint8 CBaseEntity::GetRotPos() const
{
    return loc.p.rotation;
}

void CBaseEntity::HideName(bool hide)
{
    if (hide)
    {
        // I totally guessed this number
        namevis |= FLAG_HIDE_NAME;
    }
    else
    {
        namevis &= ~FLAG_HIDE_NAME;
    }
    updatemask |= UPDATE_HP;
}

void CBaseEntity::GhostPhase(bool ghost)
{
    if (ghost)
    {
        namevis |= VIS_GHOST_PHASE;
    }
    else
    {
        namevis &= ~VIS_GHOST_PHASE;
    }
    updatemask |= UPDATE_HP;
}

bool CBaseEntity::IsNameHidden() const
{
    return namevis & FLAG_HIDE_NAME;
}

bool CBaseEntity::GetUntargetable() const
{
    return false;
}

bool CBaseEntity::isWideScannable()
{
    return status != STATUS_TYPE::DISAPPEAR && !IsNameHidden() && !GetUntargetable();
}

bool CBaseEntity::CanSeeTarget(CBaseEntity* target, bool fallbackNavMesh)
{
    return CanSeeTarget(target->loc.p, fallbackNavMesh);
}

bool CBaseEntity::CanSeeTarget(const position_t& targetPointBase, bool fallbackNavMesh)
{
    if (loc.zone->lineOfSight)
    {
        return loc.zone->lineOfSight->CanEntitySee(this, targetPointBase);
    }
    else if (fallbackNavMesh && loc.zone->m_navMesh)
    {
        return loc.zone->m_navMesh->raycast(loc.p, targetPointBase);
    }

    return true;
}

CBaseEntity* CBaseEntity::GetEntity(uint16 targid, uint8 filter) const
{
    if (targid == 0)
    {
        return nullptr;
    }
    else if (PInstance)
    {
        return PInstance->GetEntity(targid, filter);
    }
    else
    {
        return loc.zone->GetEntity(targid, filter);
    }
}

void CBaseEntity::SendZoneUpdate()
{
    loc.zone->UpdateEntityPacket(this, ENTITY_SPAWN, UPDATE_ALL_MOB, true);
}

void CBaseEntity::ResetLocalVars()
{
    m_localVars.clear();
}

uint32 CBaseEntity::GetLocalVar(const char* var)
{
    return m_localVars[var];
}

void CBaseEntity::SetLocalVar(const char* var, uint32 val)
{
    m_localVars[var] = val;
}

void CBaseEntity::SetModelId(uint16 modelid)
{
    look.modelid = modelid;
}

uint16 CBaseEntity::GetModelId() const
{
    return look.modelid;
}

bool CBaseEntity::IsDynamicEntity() const
{
    return this->targid >= 0x700;
}
