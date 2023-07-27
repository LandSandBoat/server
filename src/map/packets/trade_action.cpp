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

#include "common/socket.h"

#include "entities/charentity.h"

#include "trade_action.h"

CTradeActionPacket::CTradeActionPacket(CCharEntity* PChar, uint32 action)
{
    this->setType(0x22);
    this->setSize(0x10);

    ref<uint32>(0x04) = PChar->id;
    ref<uint32>(0x08) = action;
    ref<uint32>(0x0C) = PChar->targid;
}
