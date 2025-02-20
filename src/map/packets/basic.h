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

#ifndef _BASICPACKET_H
#define _BASICPACKET_H

#include "common/cbasetypes.h"
#include "common/socket.h"
#include "common/tracy.h"

#include <stdio.h>
#include <string.h>

// Max packet size
constexpr size_t PACKET_SIZE = 0x1FF;

enum ENTITYUPDATE
{
    ENTITY_SPAWN,
    ENTITY_SHOW,
    ENTITY_UPDATE,
    ENTITY_HIDE,
    ENTITY_DESPAWN,
};

//
// Base class for all packets
//
// Contains a 0x1FF byte sized buffer
// Access the raw data with ref<T>(index)
//
class CBasicPacket
{
protected:
    std::array<uint8, PACKET_SIZE> buffer_;

public:
    CBasicPacket()
    {
        TracyZoneScoped;
        std::fill(buffer_.data(), buffer_.data() + PACKET_SIZE, 0);
    }

    explicit CBasicPacket(const CBasicPacket& other)
    {
        TracyZoneScoped;
        std::memcpy(buffer_.data(), other.buffer_.data(), PACKET_SIZE);
    }

    explicit CBasicPacket(const std::unique_ptr<CBasicPacket>& other)
    {
        TracyZoneScoped;
        std::memcpy(buffer_.data(), other->buffer_.data(), PACKET_SIZE);
    }

    static auto createFromBuffer(const uint8* buffer) -> std::unique_ptr<CBasicPacket>
    {
        auto packet = std::make_unique<CBasicPacket>();
        std::memcpy(packet->buffer_.data(), buffer, PACKET_SIZE);
        return packet;
    }

    virtual ~CBasicPacket() = default;

    // Copy and move operators
    CBasicPacket& operator=(const CBasicPacket& other)     = delete;
    CBasicPacket& operator=(CBasicPacket&& other) noexcept = delete;

    auto copy() -> std::unique_ptr<std::remove_pointer_t<decltype(this)>>
    {
        return std::make_unique<std::remove_pointer_t<decltype(this)>>(*this);
    }

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

    // Indexer for the buffer's data
    template <typename T>
    T& ref(std::size_t index)
    {
        return ::ref<T>(buffer_.data(), index);
    }

    // Reinterpret and use the underlying buffer as a different type
    template <typename T>
    auto as() -> std::remove_pointer_t<T>*
    {
        static_assert(std::is_standard_layout_v<T>, "Type must be standard layout (No virtual functions, inheritance, etc.)");
        return reinterpret_cast<std::remove_pointer_t<T>*>(buffer_.data());
    }

    // Reinterpret the underlying buffer as a different type and apply a function to it
    template <typename T>
    void as(const auto& fn)
    {
        static_assert(std::is_standard_layout_v<T>, "Type must be standard layout (No virtual functions, inheritance, etc.)");
        fn(reinterpret_cast<std::remove_pointer_t<T>*>(buffer_.data()));
    }

    operator uint8*()
    {
        return buffer_.data();
    }

    uint8* operator[](const std::size_t index)
    {
        return reinterpret_cast<uint8*>(buffer_.data()) + index;
    }

    // Used for setting "proper" packet sizes rounded to the nearest four away from zero
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

#endif // _BASICPACKET_H
