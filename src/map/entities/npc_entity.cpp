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

auto CNpcEntity::entityFlags() const -> xi::EntityFlags
{
    return m_flags;
}

void CNpcEntity::setEntityFlags(xi::EntityFlags EntityFlags)
{
    m_flags = EntityFlags;
}

void CNpcEntity::hideHP(bool hide)
{
    if (hide)
    {
        m_flags |= xi::EntityFlags::HideHp;
    }
    else
    {
        m_flags &= ~xi::EntityFlags::HideHp;
    }
}

void CNpcEntity::setUntargetable(bool untargetable)
{
    if (untargetable)
    {
        m_flags |= xi::EntityFlags::Untargetable;
    }
    else
    {
        m_flags &= ~xi::EntityFlags::Untargetable;
    }
}

bool CNpcEntity::GetUntargetable() const
{
    return (m_flags & xi::EntityFlags::Untargetable) == xi::EntityFlags::Untargetable;
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
