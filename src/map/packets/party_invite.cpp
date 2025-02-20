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

#include <cstring>

#include "party_invite.h"

#include "entities/charentity.h"

CPartyInvitePacket::CPartyInvitePacket(uint32 id, uint16 targid, CCharEntity* PInviter, INVITETYPE InviteType)
{
    this->setType(0xDC);
    this->setSize(0x20);

    ref<uint32>(0x04) = id;
    ref<uint16>(0x08) = targid;

    ref<uint8>(0x0B) = InviteType;

    std::memcpy(buffer_.data() + 0x0C, PInviter->getName().c_str(), PInviter->getName().size());
}
