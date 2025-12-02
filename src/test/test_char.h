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

#include "common/ipp.h"
#include "common/macros.h"
#include "map/map_session.h"

#include <memory>

class TestChar
{
public:
    TestChar() = default;

    static auto create(uint16_t zoneId = 240) -> std::unique_ptr<TestChar>;
    static void clean(uint32_t charId = 0);

    ~TestChar();

    DISALLOW_COPY_AND_MOVE(TestChar);

    void clearPackets() const;

    auto charId() const -> uint32_t;
    auto accountId() const -> uint32_t;

    void setSession(MapSession* session);
    auto session() const -> MapSession*;

    void setBlowfish(BLOWFISH b) const;

    void setEntity(std::unique_ptr<CCharEntity> entity) const;
    auto entity() const -> CCharEntity*;

    void setIpp(IPP ipp);
    auto ipp() const -> IPP;

private:
    uint32_t    accountId_{};
    uint32_t    charId_{};
    std::string charName_{};

    IPP         ipp_{};
    MapSession* session_{ nullptr };
};
