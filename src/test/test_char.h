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
#include "map/map_session.h"

#include <memory>

class TestChar
{
public:
    static std::unique_ptr<TestChar> create(uint16_t zoneId = 240);
    static void                      clean(uint32_t charId = 0);

    ~TestChar();
    void clearPackets() const;

    auto getCharId() const -> uint32_t;
    auto getAccountId() const -> uint32_t;

    void setSession(MapSession* session);
    auto getSession() const -> MapSession*;

    void setBlowfish(BLOWFISH b) const;

    void setEntity(CCharEntity* entity) const;
    auto getEntity() const -> CCharEntity*;

    void setIpp(const IPP ipp)
    {
        m_ipp = ipp;
    }

    auto getIpp() const -> IPP
    {
        return m_ipp;
    }

private:
    uint32_t    accountId{};
    uint32_t    charId{};
    std::string charName{};

    IPP         m_ipp{};
    MapSession* m_session = nullptr;
};
