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

#include <cstring>

#include "bazaar_purchase.h"

CBazaarPurchasePacket::CBazaarPurchasePacket(CCharEntity* PChar, bool result)
{
    this->setType(0x106);
    this->setSize(0x1A);

    ref<uint8>(0x04) = !result;

    std::memcpy(buffer_.data() + 0x08, PChar->getName().c_str(), PChar->getName().size());
}
