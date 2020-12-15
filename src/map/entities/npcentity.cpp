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

#include "../../common/taskmgr.h"

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
    objtype    = TYPE_NPC;
    look.face  = 0x32;
    widescan   = 1;
    allegiance = ALLEGIANCE_MOB;
    PAI        = std::make_unique<CAIContainer>(this);
}

CNpcEntity::~CNpcEntity()
{
}

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

void CNpcEntity::Untargetable(bool untargetable)
{
    if (untargetable)
    {
        m_flags |= 0x800;
    }
    else
    {
        m_flags &= ~0x800;
    }
}

bool CNpcEntity::IsUntargetable() const
{
    return (m_flags & 0x800) == 0x800;
}

bool CNpcEntity::isWideScannable()
{
    return widescan == 1 && status == STATUS_NORMAL && CBaseEntity::isWideScannable();
}

void CNpcEntity::PostTick()
{
    if (loc.zone && updatemask)
    {
        loc.zone->PushPacket(this, CHAR_INRANGE, new CEntityUpdatePacket(this, ENTITY_UPDATE, updatemask));
        updatemask = 0;
    }
}
