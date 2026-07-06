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

#include "npc_entity.h"

#include "ai/ai_container.h"

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

CNpcEntity::CNpcEntity()
{
    TracyZoneScoped;

    objtype    = TYPE_NPC;
    look.face  = 0x32;
    allegiance = xi::Allegiance::Mob;

    PAI = std::make_unique<CAIContainer>(this);
}

CNpcEntity::~CNpcEntity()
{
    TracyZoneScoped;
}

uint32 CNpcEntity::entityFlags() const
{
    return m_flags;
}

void CNpcEntity::setEntityFlags(uint32 EntityFlags)
{
    m_flags = EntityFlags;
}

void CNpcEntity::hideHP(bool hide)
{
    if (hide)
    {
        m_flags |= 0x100;
    }
    else
    {
        m_flags &= ~0x100;
    }
}

bool CNpcEntity::hpHidden() const
{
    return (m_flags & 0x800) == 0x800;
}

void CNpcEntity::setUntargetable(bool untargetable)
{
    if (untargetable)
    {
        m_flags |= FLAG_UNTARGETABLE;
    }
    else
    {
        m_flags &= ~FLAG_UNTARGETABLE;
    }
}

bool CNpcEntity::GetUntargetable() const
{
    return (m_flags & FLAG_UNTARGETABLE) == FLAG_UNTARGETABLE;
}

bool CNpcEntity::triggerable() const
{
    return triggerable_;
}

void CNpcEntity::setTriggerable(bool triggerable)
{
    triggerable_ = triggerable;
}

auto CNpcEntity::widescan() const -> uint8
{
    return widescan_;
}

void CNpcEntity::setWidescan(uint8 widescan)
{
    widescan_ = widescan;
}

bool CNpcEntity::alwaysRelevant() const
{
    return alwaysRelevant_;
}

void CNpcEntity::setAlwaysRelevant(bool alwaysRelevant)
{
    alwaysRelevant_ = alwaysRelevant;
}

bool CNpcEntity::isWideScannable()
{
    return widescan_ == 1 && status == xi::Status::Normal && CBaseEntity::isWideScannable();
}

void CNpcEntity::PostTick()
{
    timer::time_point now = timer::now();
    if (loc.zone && updatemask && status != xi::Status::Disappear && now > m_nextUpdateTimer)
    {
        m_nextUpdateTimer = now + 250ms;
        loc.zone->UpdateEntityPacket(this, ENTITY_UPDATE, updatemask);
        updatemask = 0;
    }
}
