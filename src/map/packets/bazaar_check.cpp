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

#include "bazaar_check.h"

#include "entities/charentity.h"

CBazaarCheckPacket::CBazaarCheckPacket(CCharEntity* PChar, BAZAARCHECK type)
{
    this->setType(0x108);
    this->setSize(0x22);

    ref<uint32>(0x04) = PChar->id;
    ref<uint8>(0x08)  = type;
    ref<uint16>(0x0E) = PChar->targid;

    std::memcpy(buffer_.data() + 0x10, PChar->getName().c_str(), PChar->getName().size());
}
