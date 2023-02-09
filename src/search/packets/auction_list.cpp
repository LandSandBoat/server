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

#include "auction_list.h"

/************************************************************************
 *                                                                       *
 *  If the number of items exceeds 20, then we send several packets.     *
 *  The `offset` is used to denote which set of items this packet        *
 *  contains, relative to the total number of items across all           *
 *  packets in the list.                                                 *
 *                                                                       *
 ************************************************************************/

CAHItemsListPacket::CAHItemsListPacket(uint16 offset)
: m_count(0)
, m_offset(offset)
{
    memset(m_PData, 0, sizeof(m_PData));

    ref<uint8>(m_PData, (0x0B)) = 0x95; // packet type
}

/************************************************************************
 *                                                                       *
 *  Add an item to the packet (10 bytes per item).                       *
 *                                                                       *
 ************************************************************************/

void CAHItemsListPacket::AddItem(ahItem* item)
{
    ref<uint16>(m_PData, (0x18 + 0x0A * m_count) + 0) = item->ItemID;
    ref<uint32>(m_PData, (0x18 + 0x0A * m_count) + 2) = item->SingleAmount;
    ref<uint32>(m_PData, (0x18 + 0x0A * m_count) + 6) = item->StackAmount;

    m_count++;

    destroy(item);
}

/************************************************************************
 *                                                                       *
 *  Set the total number of items sent in the packet.                    *
 *                                                                       *
 ************************************************************************/

void CAHItemsListPacket::SetItemCount(uint16 count)
{
    ref<uint16>(m_PData, (0x0E)) = count;

    if ((count - m_offset) <= 20)
    {
        ref<uint8>(m_PData, (0x0A))  = 0x80;
        ref<uint16>(m_PData, (0x08)) = 0x18 + 0x0A * (count - m_offset);
    }
    else
    {
        ref<uint16>(m_PData, (0x08)) = 0x18 + 0x0A * 20;
    }
}

/************************************************************************
 *                                                                       *
 * Return the data for the packet.                                       *
 *                                                                       *
 ************************************************************************/

uint8* CAHItemsListPacket::GetData()
{
    return m_PData;
}

/************************************************************************
 *                                                                       *
 *  Return the total size of the packet.                                 *
 *                                                                       *
 ************************************************************************/

uint16 CAHItemsListPacket::GetSize() const
{
    return 0x18 + 0x0A * m_count + 28;
}
