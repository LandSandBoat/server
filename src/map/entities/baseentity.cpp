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

#include "common/tracy.h"

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
, baseSpeed(settings::get<uint8>("map.BASE_SPEED"))
, namevis(0)
, allegiance(ALLEGIANCE_TYPE::MOB)
, updatemask(0)
, priorityRender(false)
, isRenamed(false)
, m_bReleaseTargIDOnDisappear(false)
, spawnAnimation(SPAWN_ANIMATION::NORMAL)
, PAI(nullptr)
, PBattlefield(nullptr)
, PInstance(nullptr)
, m_nextUpdateTimer(std::chrono::steady_clock::now())
{
    TracyZoneScoped;
    speed          = baseSpeed;
    animationSpeed = static_cast<uint8>(std::clamp<float>((baseSpeed / settings::get<float>("map.ANIMATION_SPEED_DIVISOR")), std::numeric_limits<uint8>::min(), std::numeric_limits<uint8>::max()));
}

CBaseEntity::~CBaseEntity()
{
    TracyZoneScoped;
    if (PBattlefield)
    {
        PBattlefield->RemoveEntity(this, BATTLEFIELD_LEAVE_CODE_WARPDC);
    }
}

void CBaseEntity::Spawn()
{
    status = allegiance == ALLEGIANCE_TYPE::MOB ? STATUS_TYPE::UPDATE : STATUS_TYPE::NORMAL;
    updatemask |= UPDATE_HP;
    ResetLocalVars();
    PAI->Reset();
    PAI->EventHandler.triggerListener("SPAWN", this);
}

void CBaseEntity::FadeOut()
{
    status = STATUS_TYPE::DISAPPEAR;
    updatemask |= UPDATE_HP;
}

const std::string& CBaseEntity::getName()
{
    return name;
}

const std::string& CBaseEntity::getPacketName()
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

uint8 CBaseEntity::GetSpeed() const
{
    return speed;
}

uint8 CBaseEntity::UpdateSpeed(bool run)
{
    std::ignore = run;
    speed       = baseSpeed;
    return speed;
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

uint32 CBaseEntity::GetLocalVar(const std::string& var)
{
    return m_localVars[var];
}

std::map<std::string, uint32>& CBaseEntity::GetLocalVars()
{
    return m_localVars;
}

void CBaseEntity::SetLocalVar(const std::string& var, uint32 val)
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
