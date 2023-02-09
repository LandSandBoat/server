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
#include <cstring>

#include "common/logging.h"
#include "common/socket.h"

#include "../data_loader.h"

#include "auction_history.h"

CAHHistoryPacket::CAHHistoryPacket(uint16 ItemID)
: m_count(0)
{
    memset(m_PData, 0, sizeof(m_PData));

    ref<uint8>(m_PData, (0x0A)) = 0x80;
    ref<uint8>(m_PData, (0x0B)) = 0x85; // packet type
    ref<uint16>(m_PData, 0x10)  = ItemID;
}

void CAHHistoryPacket::AddItem(ahHistory* item)
{
    if (m_count < 10)
    {
        ref<uint32>(m_PData, (0x20 + 40 * m_count) + 0x00) = item->Price;
        ref<uint32>(m_PData, (0x20 + 40 * m_count) + 0x04) = item->Data;

        memcpy(m_PData + 0x20 + 40 * m_count + 0x08, item->Name1.c_str(), 15);
        memcpy(m_PData + 0x20 + 40 * m_count + 0x18, item->Name2.c_str(), 15);

        ref<uint16>(m_PData, (0x08)) = 0x20 + 40 * ++m_count;
    }

    destroy(item);
}

/************************************************************************
 *                                                                       *
 *  Returns the packet's data.                                           *
 *                                                                       *
 ************************************************************************/

uint8* CAHHistoryPacket::GetData()
{
    return m_PData;
}

/************************************************************************
 *                                                                       *
 *  Returns the size of the packet.                                      *
 *                                                                       *
 ************************************************************************/

uint16 CAHHistoryPacket::GetSize() const
{
    return 0x20 + 40 * m_count + 28;
}
