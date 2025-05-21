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

#pragma once

#include "common/cbasetypes.h"
#include "common/tracy.h"
#include "common/utils.h"

#include <cstdio>
#include <cstring>

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

    auto getType() -> uint16
    {
        return ref<uint16>(0) & 0x1FF;
    }

    auto getSize() -> std::size_t
    {
        return std::min<std::size_t>(2U * (ref<uint8>(1) & ~1), PACKET_SIZE);
    }

    auto getSequence() -> uint16
    {
        return ref<uint16>(2);
    }

    // Set the first 9 bits to the ID. The highest bit overflows into the second byte.
    void setType(uint16 id)
    {
        ref<uint16>(0) &= ~0x1FF;
        ref<uint16>(0) |= id & 0x1FF;
    }

    // The length "byte" is actually just the highest 7 bits.
    // Need to preserve the lowest bit for the ID.
    void setSize(std::size_t size)
    {
        ref<uint8>(1) &= 1;
        ref<uint8>(1) |= ((size + 3) & ~3) / 2;
    }

    void setSequence(uint16 sequence)
    {
        ref<uint16>(2) = sequence;
    }

    // Indexer for the buffer's data
    template <typename T>
    auto ref(std::size_t index) -> T&
    {
        return ::ref<T>(buffer_.data(), index);
    }

    template <typename T>
    auto ref(std::size_t index) const -> const T&
    {
        return ::ref<T>(buffer_.data(), index);
    }

    // Reinterpret and use the underlying buffer as a different type
    template <typename T>
    auto as() -> T*
    {
        return ::as<T>(*buffer_.data());
    }

    // Reinterpret the underlying buffer as a different type and apply a function to it
    template <typename T>
    void as(const auto& fn)
    {
        fn(::as<T>(*buffer_.data()));
    }

    template <typename T>
    auto as() const -> const T*
    {
        return ::as<T>(*buffer_.data());
    }

    operator uint8*()
    {
        return buffer_.data();
    }

    uint8* operator[](const std::size_t index)
    {
        return reinterpret_cast<uint8*>(buffer_.data()) + index;
    }
};
