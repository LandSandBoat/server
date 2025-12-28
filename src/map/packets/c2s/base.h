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
#include "validation.h"

// https://github.com/atom0s/XiPackets/blob/main/world/Header.md
struct GP_CLI_HEADER
{
    uint16_t id : 9;
    uint16_t size : 7;
    uint16_t sync;
};

#define GP_CLI_PACKET(PacketName, ...)                                                                        \
    struct MapSession;                                                                                        \
    class CCharEntity;                                                                                        \
    struct PacketName                                                                                         \
    {                                                                                                         \
        GP_CLI_HEADER header;                                                                                 \
        __VA_ARGS__                                                                                           \
                                                                                                              \
        auto        validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult; \
        void        process(MapSession* PSession, CCharEntity* PChar) const;                                  \
        inline auto getName() const -> std::string_view                                                       \
        {                                                                                                     \
            return #PacketName;                                                                               \
        }                                                                                                     \
    }
