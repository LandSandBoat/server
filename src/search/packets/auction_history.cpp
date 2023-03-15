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

CAHHistoryPacket::CAHHistoryPacket(ahItem item, uint8 stack)
: m_count(0)
{
    memset(m_PData, 0, sizeof(m_PData));

    // Comments and RE by atom0s
    ref<uint8>(m_PData, 0x0A)  = 0x80;        // flags, may be int8 as it's checked against negative.
    ref<uint8>(m_PData, 0x0B)  = 0x85;        // packet type, masked as val & 0x1F
    ref<uint16>(m_PData, 0x0E) = 0;           // Unknown use
    ref<uint16>(m_PData, 0x10) = item.ItemID; // may be obsolete
    ref<uint16>(m_PData, 0x12) = 0;           // Unknown use
    ref<uint16>(m_PData, 0x14) = 0;           // Unknown use
    ref<uint16>(m_PData, 0x16) = 0;           // Unknown use
    ref<uint16>(m_PData, 0x18) = item.ItemID;
    ref<uint32>(m_PData, 0x1A) = stack != 0 ? item.StackAmount : item.SingleAmount;
    ref<uint16>(m_PData, 0x1E) = item.Category;
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
