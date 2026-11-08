/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include <sol/sol.hpp>

class CLuaClientEntityPair;

class CLuaClientEntityPairNetwork
{
public:
    explicit CLuaClientEntityPairNetwork(CLuaClientEntityPair* parent);

    auto login(sol::optional<sol::table> params) const -> bool;
    void sendStaleLogin(uint16 seq, sol::optional<uint16> port) const;
    void finishLoading(sol::optional<sol::table> params) const;
    void rebind(uint16 port) const;
    void zoneIn() const;
    void exchange(sol::optional<sol::table> params) const;
    void drain() const;
    auto mode() const -> std::string;
    auto isHung() const -> bool;
    auto hangReason() const -> std::string;
    auto received() const -> sol::table;
    void clearReceived() const;
    void setStoredZone(uint16 zoneId) const;
    auto isLinkDeadAfter(uint32 seconds) const -> bool;
    auto hasSentZoneOut() const -> bool;

    static void Register();

private:
    CLuaClientEntityPair* parent_;
};
