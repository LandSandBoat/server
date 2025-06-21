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
#include "sol/forward.hpp"

class MapServer;
class CBasicPacket;
class CLuaBaseEntity;
class CLuaSimulation;
class TestChar;

class CLuaSimClient
{
public:
    CLuaSimClient(std::unique_ptr<TestChar> testChar, CLuaSimulation* simulation, MapServer* mapServer);
    ~CLuaSimClient();

    auto createPacket(uint16 packetType) -> std::unique_ptr<CBasicPacket>;
    void sendBasicPacket(CBasicPacket& packet) const;
    void sendPacket(sol::table dataTable);
    void sendZonePackets();
    void parseIncomingPackets();
    auto getIncomingPackets() const -> sol::table;
    void tick();
    auto getPlayer() const -> CLuaBaseEntity;
    auto getCurrentEventId() const -> uint16;
    auto getItemInvSlot(uint16 itemId, uint8 quantity) const -> std::optional<uint16>;
    void gotoZone(uint16 zoneId);
    auto isPendingZone() const -> bool;

    static void Register();

private:
    std::unique_ptr<TestChar> m_testChar;
    CLuaSimulation*           m_simulation;
    uint16                    m_sequenceNum = 0;
    MapServer*                m_engine      = nullptr;
};
