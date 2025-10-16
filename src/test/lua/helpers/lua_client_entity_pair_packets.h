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
#include <memory>
#include <sol/sol.hpp>

enum class PacketC2S : uint16_t;
class CBasicPacket;
class CLuaClientEntityPair;
class CLuaClientEntityPairPackets
{
public:
    CLuaClientEntityPairPackets(CLuaClientEntityPair* parent);
    ~CLuaClientEntityPairPackets() = default;

    auto createPacket(PacketC2S packetType) -> std::unique_ptr<CBasicPacket>;
    void sendBasicPacket(CBasicPacket& packet) const;
    void send(PacketC2S packetId, const sol::object& ffiData, size_t ffiSize);
    void sendZonePackets();

    void parseIncoming();
    auto getIncoming() const -> sol::table;

    static void Register();

private:
    CLuaClientEntityPair* parent_;
    uint8                 sequenceNum_{ 0 };
};
