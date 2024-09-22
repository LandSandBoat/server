﻿/*
===========================================================================

Copyright © 2010-2015 Darkstar Dev Teams

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

#ifndef _BASICPACKET_H
#define _BASICPACKET_H

#include "common/cbasetypes.h"
#include "common/socket.h"
#include "common/tracy.h"

#include <stdio.h>
#include <string.h>

// Max packet size
#define PACKET_SIZE 0x1FF

enum ENTITYUPDATE
{
    ENTITY_SPAWN,
    ENTITY_SHOW,
    ENTITY_UPDATE,
    ENTITY_HIDE,
    ENTITY_DESPAWN,
};

/** Base class for all packets
 *
 * Contains a 0x1FF byte sized buffer
 * Access the raw data with ref<T>(index)
 *
 */
class CBasicPacket
{
protected:
    uint8* data;

    // Mark these members as private, so that they can't be set without using their
    // specialised setters.
private:
    uint8& type;
    uint8& size;

protected:
    uint16& code;
    bool    owner;

public:
    CBasicPacket()
    : data(new uint8[PACKET_SIZE])
    , type(ref<uint8>(0))
    , size(ref<uint8>(1))
    , code(ref<uint16>(2))
    , owner(true)
    {
        TracyZoneScoped;
        std::fill(data, data + PACKET_SIZE, 0);
    }

    CBasicPacket(uint8* _data)
    : data(_data)
    , type(ref<uint8>(0))
    , size(ref<uint8>(1))
    , code(ref<uint16>(2))
    , owner(false)
    {
        TracyZoneScoped;
    }

    CBasicPacket(const CBasicPacket& other)
    : data(new uint8[PACKET_SIZE])
    , type(ref<uint8>(0))
    , size(ref<uint8>(1))
    , code(ref<uint16>(2))
    , owner(true)
    {
        TracyZoneScoped;
        std::memcpy(data, other.data, PACKET_SIZE);
    }

    CBasicPacket(CBasicPacket&& other)
    : data(other.data)
    , type(ref<uint8>(0))
    , size(ref<uint8>(1))
    , code(ref<uint16>(2))
    , owner(other.owner)
    {
        other.data = nullptr;
    }

    virtual ~CBasicPacket()
    {
        TracyZoneScoped;
        if (owner && data)
        {
            destroy_arr(data);
        }
    }

    CBasicPacket& operator=(const CBasicPacket& other) = delete;
    CBasicPacket& operator=(CBasicPacket&& other)      = delete;

    /// <summary>
    /// Copies the given packet data.
    /// </summary>
    auto copy() -> std::unique_ptr<CBasicPacket>
    {
        return std::make_unique<CBasicPacket>(data);
    }

    /* Getters for the header */

    uint16 getType()
    {
        return ref<uint16>(0) & 0x1FF;
    }

    std::size_t getSize()
    {
        return std::min<std::size_t>(2U * (ref<uint8>(1) & ~1), PACKET_SIZE);
    }

    unsigned short getSequence()
    {
        return ref<uint16>(2);
    }

    /* Setters for the header */

    // Set the first 9 bits to the ID. The highest bit overflows into the second byte.
    void setType(unsigned int new_id)
    {
        ref<uint16>(0) &= ~0x1FF;
        ref<uint16>(0) |= new_id & 0x1FF;
    }

    // The length "byte" is actually just the highest 7 bits.
    // Need to preserve the lowest bit for the ID.
    void setSize(std::size_t new_size)
    {
        ref<uint8>(1) &= 1;
        ref<uint8>(1) |= ((new_size + 3) & ~3) / 2;
    }

    void setSequence(unsigned short new_sequence)
    {
        ref<uint16>(2) = new_sequence;
    }

    /* Indexer for the data buffer */
    template <typename T>
    T& ref(std::size_t index)
    {
        return ::ref<T>(data, index);
    }

    operator uint8*()
    {
        return data;
    }

    int8* operator[](const int index)
    {
        return reinterpret_cast<int8*>(data) + index;
    }

    // used for setting "proper" packet sizes rounded to the nearest four away from zero
    uint32 roundUpToNearestFour(uint32 input)
    {
        int remainder = input % 4;
        if (remainder == 0)
        {
            return input;
        }

        return input + 4 - remainder;
    }
};

#endif
