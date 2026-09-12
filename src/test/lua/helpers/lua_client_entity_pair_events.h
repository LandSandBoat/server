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
#include <optional>
#include <sol/sol.hpp>
#include <tuple>

class CLuaClientEntityPair;

class CLuaClientEntityPairEvents
{
public:
    CLuaClientEntityPairEvents(CLuaClientEntityPair* parent);
    ~CLuaClientEntityPairEvents() = default;

    void finish(sol::optional<uint16> eventId, sol::optional<uint32> option) const;
    void update(sol::optional<uint16> eventId, sol::optional<uint32> option) const;
    auto updateWithPosition(sol::optional<uint16> eventId, sol::optional<uint32> option, const sol::optional<sol::table>& position) const -> std::tuple<sol::object, bool>;
    void expectNotInEvent() const;
    void expect(sol::table expectedEvent) const;

    static void Register();

private:
    auto currentId() const -> uint16;
    auto resolveEventId(sol::optional<uint16> eventId) const -> std::optional<uint16>;
    void sendEventPacket(sol::optional<uint16> eventId, sol::optional<uint32> option, bool isUpdate) const;

    CLuaClientEntityPair* parent_;
};
