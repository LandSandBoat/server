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

#include "common/logging.h"
#include "common/socket.h"
#include "common/utils.h"

#include "../data_loader.h"

#include <cstring>

#include "search_list.h"

CSearchListPacket::CSearchListPacket(uint32 Total)
: m_offset(192)
{
    memset(m_data, 0, sizeof(m_data));

    ref<uint8>(m_data, (0x0A)) = 0x00;
    ref<uint8>(m_data, (0x0B)) = 0x80;

    ref<uint16>(m_data, (0x0E)) = Total; // The total number of character found (may differ from the amount that gets sent)
}

// A maximum of 20 characters can be added to a single packet.
bool CSearchListPacket::AddPlayer(SearchEntity* PPlayer)
{
    uint32 size_offset = m_offset / 8;
    if ((sizeof(m_data) - size_offset) < (20 + 67))
    {
        return false; // not enough space available, worst case.
    }

    m_offset += 8;

    auto length = std::min(PPlayer->name.size(), size_t(15));
    m_offset    = packBitsLE(m_data, SEARCH_NAME, m_offset, 5);
    m_offset    = packBitsLE(m_data, length, m_offset, 4);

    for (std::size_t c = 0; c < length; ++c)
    {
        m_offset = packBitsLE(m_data, PPlayer->name[c], m_offset, 7);
    }

    m_offset = packBitsLE(m_data, SEARCH_AREA, m_offset, 5);
    m_offset = packBitsLE(m_data, PPlayer->zone, m_offset, 10);

    if (!(PPlayer->flags1 & 0x4000))
    {
        m_offset = packBitsLE(m_data, SEARCH_NATION, m_offset, 5);
        m_offset = packBitsLE(m_data, PPlayer->nation, m_offset, 2);

        m_offset = packBitsLE(m_data, SEARCH_JOB, m_offset, 5);
        m_offset = packBitsLE(m_data, PPlayer->mjob, m_offset, 5);
        m_offset = packBitsLE(m_data, PPlayer->sjob, m_offset, 5);

        m_offset = packBitsLE(m_data, SEARCH_LEVEL, m_offset, 5);
        m_offset = packBitsLE(m_data, PPlayer->mlvl, m_offset, 8);
        m_offset = packBitsLE(m_data, PPlayer->slvl, m_offset, 8);

        m_offset = packBitsLE(m_data, SEARCH_RACE, m_offset, 5);
        m_offset = packBitsLE(m_data, PPlayer->race, m_offset, 4);

        m_offset = packBitsLE(m_data, SEARCH_RANK, m_offset, 5);
        m_offset = packBitsLE(m_data, PPlayer->rank, m_offset, 8);
    }

    m_offset = packBitsLE(m_data, SEARCH_FLAGS1, m_offset, 5);
    m_offset = packBitsLE(m_data, PPlayer->flags1, m_offset, 16);

    m_offset = packBitsLE(m_data, SEARCH_ID, m_offset, 5);
    m_offset = packBitsLE(m_data, PPlayer->id, m_offset, 20);

    // m_offset = packBitsLE(m_data, SEARCH_LINKSHELLRANK,  m_offset, 5);
    // m_offset = packBitsLE(m_data, 0, m_offset,8);

    m_offset = packBitsLE(m_data, SEARCH_UNK0x0E, m_offset, 5);
    m_offset = packBitsLE(m_data, 0, m_offset, 32);

    if (PPlayer->seacom_type != 0)
    {
        m_offset = packBitsLE(m_data, SEARCH_COMMENT, m_offset, 5);
        m_offset = packBitsLE(m_data, PPlayer->seacom_type, m_offset, 32);
    }

    m_offset = packBitsLE(m_data, SEARCH_FLAGS2, m_offset, 5);
    m_offset = packBitsLE(m_data, PPlayer->flags2, m_offset, 32);

    m_offset = packBitsLE(m_data, SEARCH_LANGUAGE, m_offset, 5);
    m_offset = packBitsLE(m_data, PPlayer->languages, m_offset, 16);

    if (m_offset % 8 > 0)
    {
        m_offset += 8 - m_offset % 8; // Byte alignment
    }

    ref<uint8>(m_data, size_offset) = m_offset / 8 - size_offset - 1; // Entity data size
    ref<uint16>(m_data, (0x08))     = m_offset / 8;                   // Size of the data to send

    destroy(PPlayer);

    return true;
}

/************************************************************************
 *                                                                       *
 *  Set the packet as final in the results                               *
 *                                                                       *
 ************************************************************************/

void CSearchListPacket::SetFinal()
{
    ref<uint8>(m_data, (0x0A)) = 0x80; // is final packet
}

/************************************************************************
 *                                                                       *
 *  Returns the packet's data.                                           *
 *                                                                       *
 ************************************************************************/

uint8* CSearchListPacket::GetData()
{
    return m_data;
}

/************************************************************************
 *                                                                       *
 *  Returns the size of the packet.                                      *
 *                                                                       *
 ************************************************************************/

uint16 CSearchListPacket::GetSize() const
{
    return m_offset / 8 + 20;
}
