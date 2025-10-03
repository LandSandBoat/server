/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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
#include "enums/packet_s2c.h"
#include "packets/basic.h"
#include <cstring>

// https://github.com/atom0s/XiPackets/blob/main/world/Header.md
struct GP_SERV_HEADER
{
    uint16_t id : 9;
    uint16_t size : 7;
    uint16_t sync;
};

template <PacketS2C PacketId, typename Derived>
class GP_SERV_PACKET : public CBasicPacket
{
protected:
    GP_SERV_PACKET()
    {
        std::memset(buffer_.data(), 0, PACKET_SIZE);
        setType(static_cast<uint16_t>(PacketId));
        // Auto-set size based on PacketData
        if constexpr (std::is_empty_v<typename Derived::PacketData>)
        {
            // Handle as header-only packet
            setSize(sizeof(GP_SERV_HEADER));
        }
        else
        {
            // Set default size based on PacketData structure + header
            // Override as needed in constructors.
            // Note: Derived do not declare the header, it must be added to the size of PacketData.
            setSize(sizeof(GP_SERV_HEADER) + sizeof(typename Derived::PacketData));
        }
    }

    // Access shifted by header size so individual packets do not need to declare it
    template <typename T = Derived>
    auto data() -> typename T::PacketData&
    {
        return *reinterpret_cast<typename T::PacketData*>(buffer_.data() + sizeof(GP_SERV_HEADER));
    }

    template <typename T = Derived>
    auto data() const -> const typename T::PacketData&
    {
        return *reinterpret_cast<const typename T::PacketData*>(buffer_.data() + sizeof(GP_SERV_HEADER));
    }
};
