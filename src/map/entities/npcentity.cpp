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

#include "common/taskmgr.h"

#include "../ai/ai_container.h"
#include "../utils/zoneutils.h"
#include "npcentity.h"

#include "../packets/entity_update.h"

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

CNpcEntity::CNpcEntity()
{
    objtype     = TYPE_NPC;
    look.face   = 0x32;
    widescan    = 1;
    allegiance  = ALLEGIANCE_TYPE::MOB;
    m_flags     = 0;
    name_prefix = 0;

    PAI = std::make_unique<CAIContainer>(this);
}

CNpcEntity::~CNpcEntity() = default;

uint32 CNpcEntity::getEntityFlags() const
{
    return m_flags;
}

void CNpcEntity::setEntityFlags(uint32 EntityFlags)
{
    m_flags = EntityFlags;
}

void CNpcEntity::HideHP(bool hide)
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

bool CNpcEntity::IsHPHidden() const
{
    return (m_flags & 0x800) == 0x800;
}

void CNpcEntity::SetUntargetable(bool untargetable)
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

bool CNpcEntity::IsTriggerable() const
{
    return m_triggerable;
}

bool CNpcEntity::isWideScannable()
{
    return widescan == 1 && status == STATUS_TYPE::NORMAL && CBaseEntity::isWideScannable();
}

void CNpcEntity::PostTick()
{
    std::chrono::steady_clock::time_point now = std::chrono::steady_clock::now();
    if (loc.zone && updatemask && status != STATUS_TYPE::DISAPPEAR && now > m_nextUpdateTimer)
    {
        m_nextUpdateTimer = now + 250ms;
        loc.zone->UpdateEntityPacket(this, ENTITY_UPDATE, updatemask);
        updatemask = 0;
    }
}
