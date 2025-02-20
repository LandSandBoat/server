/*
===========================================================================

  Copyright (c) 2010-2018 Darkstar Dev Teams

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
#include "common/utils.h"

#include "pet_sync.h"

#include "entities/charentity.h"

/************************************************************************
 *                                                                       *
 *  Synchronization of the pet with the owner                            *
 *                                                                       *
 ************************************************************************/

CPetSyncPacket::CPetSyncPacket(CCharEntity* PChar)
{
    this->setType(0x68);
    this->setSize(0x1C);

    ref<uint8>(0x04) |= 0x04;                            // Message Type
    packBitsBE(buffer_.data() + 0x04, (0x18), 0, 6, 10); // Message Size (0 for Despawn)
    ref<uint16>(0x06) = PChar->targid;
    ref<uint32>(0x08) = PChar->id;

    if (PChar->PPet != nullptr)
    {
        this->setSize(0x2C);
        packBitsBE(buffer_.data() + 0x04, 0x18 + PChar->PPet->getName().size(), 0, 6, 10); // Message Size
        ref<uint16>(0x0C) = PChar->PPet->targid;
        ref<uint8>(0x0E)  = PChar->PPet->GetHPP();
        ref<uint8>(0x0F)  = PChar->PPet->GetMPP();
        ref<uint16>(0x10) = PChar->PPet->health.tp;
        if (PChar->PPet->animation == ANIMATION_ATTACK)
        {
            ref<uint32>(0x14) = PChar->PPet->GetBattleTarget()->id;
        }

        std::memcpy(buffer_.data() + 0x18, PChar->PPet->getName().c_str(), PChar->PPet->getName().size());
    }
}
