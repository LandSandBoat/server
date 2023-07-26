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

#include "item_puppet.h"

CItemPuppet::CItemPuppet(uint16 id)
: CItem(id)
, m_equipSlot(0)
, m_elementSlots(0)
{
    setType(ITEM_PUPPET);
}

CItemPuppet::~CItemPuppet() = default;

uint8 CItemPuppet::getEquipSlot() const
{
    return m_equipSlot;
}
void CItemPuppet::setEquipSlot(uint32 slot)
{
    m_equipSlot = slot;
}
uint32 CItemPuppet::getElementSlots() const
{
    return m_elementSlots;
}
void CItemPuppet::setElementSlots(uint32 slots)
{
    m_elementSlots = slots;
}
