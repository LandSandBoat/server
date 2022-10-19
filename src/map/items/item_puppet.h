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

#ifndef _CITEMPUPPET_H
#define _CITEMPUPPET_H

#include "common/cbasetypes.h"

#include "item.h"

enum ITEM_PUPPET_EQUIPSLOT
{
    ITEM_PUPPET_HEAD       = 1,
    ITEM_PUPPET_FRAME      = 2,
    ITEM_PUPPET_ATTACHMENT = 3
};

class CItemPuppet : public CItem
{
public:
    CItemPuppet(uint16);
    virtual ~CItemPuppet();

    uint8  getEquipSlot() const;
    void   setEquipSlot(uint32 slot);
    uint32 getElementSlots() const;
    void   setElementSlots(uint32 slots);

private:
    uint8  m_equipSlot;
    uint32 m_elementSlots;
};

#endif
