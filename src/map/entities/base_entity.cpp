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

#include "base_entity.h"

#include "common/tracy.h"

#include "ai/ai_container.h"

#include "battlefield.h"
#include "instance.h"
#include "zone.h"

CBaseEntity::CBaseEntity()
: id(0)
, targid(0)
, objtype(ENTITYTYPE::TYPE_NONE)
, status(xi::Status::Disappear)
, m_TargID(0)
, animation(0)
, animationsub(0)
, baseSpeed(settings::get<uint8>("map.BASE_SPEED"))
, namevis(xi::NameVis::None)
, allegiance(xi::Allegiance::Mob)
, updatemask(0)
, priorityRender(false)
, isRenamed(false)
, m_bReleaseTargIDOnDisappear(false)
, spawnAnimation(xi::SpawnAnimation::Normal)
, PAI(nullptr)
, PBattlefield(nullptr)
, PInstance(nullptr)
, m_nextUpdateTimer(timer::now())
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
    status = allegiance == xi::Allegiance::Mob ? xi::Status::Update : xi::Status::Normal;
    updatemask |= UPDATE_HP;
    ResetLocalVars();
    PAI->Reset();
}

void CBaseEntity::FadeOut()
{
    status = xi::Status::Disappear;
    updatemask |= UPDATE_HP;
}

const std::string& CBaseEntity::getName() const
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
        namevis |= xi::NameVis::HideName;
    }
    else
    {
        namevis &= ~xi::NameVis::HideName;
    }
    updatemask |= UPDATE_HP;
}

void CBaseEntity::GhostPhase(bool ghost)
{
    if (ghost)
    {
        namevis |= xi::NameVis::GhostPhase;
    }
    else
    {
        namevis &= ~xi::NameVis::GhostPhase;
    }
    updatemask |= UPDATE_HP;
}

bool CBaseEntity::IsNameHidden() const
{
    return (namevis & xi::NameVis::HideName) != xi::NameVis::None;
}

bool CBaseEntity::GetUntargetable() const
{
    return false;
}

bool CBaseEntity::isWideScannable()
{
    return status != xi::Status::Disappear && !IsNameHidden() && !GetUntargetable();
}

bool CBaseEntity::CanSeeTarget(CBaseEntity* target)
{
    return CanSeeTarget(target->loc.p);
}

bool CBaseEntity::CanSeeTarget(const position_t& targetPointBase)
{
    TracyZoneScoped;

    constexpr float ENTITY_HEIGHT = 2.0f;

    // TODO: Handle:
    // if (GetTypeMask() & ZONE_TYPE::CITY || (m_miscMask & MISC_LOS_OFF))
    // -> Skip cities and zones with line of sight turned off

    const auto src = Vector3{ loc.p.x, loc.p.y - ENTITY_HEIGHT, loc.p.z };
    const auto dst = Vector3{ targetPointBase.x, targetPointBase.y - ENTITY_HEIGHT, targetPointBase.z };

    const auto now    = timer::now();
    const auto zoneId = static_cast<uint16>(this->loc.zone->GetID());
    if (const auto cached = losCache_.get(src, dst, zoneId, now))
    {
        return *cached;
    }

    const bool canSee = !this->loc.zone->xiMesh()->rayIntersect(src, dst);
    losCache_.put(src, dst, zoneId, canSee, now);
    return canSee;
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
    localVars_.clear();
}

uint32 CBaseEntity::GetLocalVar(const std::string& var)
{
    return localVars_[var];
}

std::map<std::string, uint32>& CBaseEntity::GetLocalVars()
{
    return localVars_;
}

void CBaseEntity::SetLocalVar(const std::string& var, uint32 val)
{
    localVars_[var] = val;
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
