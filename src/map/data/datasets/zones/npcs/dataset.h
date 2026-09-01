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
#include "common/types/maybe.h"
#include "common/types/position.h"
#include "data/enums/animation.h"
#include "data/enums/content.h"
#include "data/enums/elevator.h"
#include "data/enums/entity_flags.h"
#include "data/enums/name_vis.h"
#include "data/enums/status.h"
#include "data/enums/zone.h"

#include <array>
#include <string>
#include <string_view>
#include <vector>

namespace xi::data
{

struct ElevatorData
{
    std::string  LowerDoor; // client name, resolved once the zone's NPCs exist
    std::string  UpperDoor;
    xi::Elevator Lever{};
    bool         Reversed{};
    uint8        Travel{}; // seconds between floors, and what the client animates against
    uint32       Period{}; // milliseconds for one leg, travel and the wait at the floor together
};

struct NpcData
{
    uint32                 Id{}; // fully qualified: 0x01000000 | zone << 12 | targid
    uint16                 ActIndex{};
    std::string            Script;
    std::string            DisplayName;
    position_t             Position{};
    std::array<uint16, 10> Look{}; // a look_t laid flat, as the client reads it
    uint16                 LookAt{};
    xi::Animation          Animation{};
    uint8                  AnimationSub{};
    xi::Status             Status{};
    xi::NameVis            NameVis{};
    xi::EntityFlags        EntityFlags{};
    uint8                  NamePrefix{};
    Maybe<uint32>          DoorId;
    uint8                  ModelSize{};
    uint8                  ModelHitboxSize{};
    uint8                  Speed{};
    uint8                  AnimationSpeed{};
    bool                   Widescan{};
    xi::Content            Content{};
    Maybe<ElevatorData>    Elevator;
};

// Ordered by targid, matching the order the SQL loader saw.
using Npcs = std::vector<NpcData>;

} // namespace xi::data

namespace xi::data::datasets::zones::npcs::wire
{

struct Document;

}

namespace xi::data::datasets::zones::npcs
{

struct Dataset
{
    using Records      = xi::data::Npcs;
    using YamlDocument = wire::Document;

    static constexpr std::string_view kDataPath{ "npcs" };
    static constexpr std::string_view kTitle{ "Zone NPCs" };
    static constexpr std::string_view kDescription{ "Static NPC placements and appearance for one zone." };

    static auto decode(std::string_view text) -> Records;

    static void verifyZone(const Records& records, xi::ZoneId zoneId);
};

} // namespace xi::data::datasets::zones::npcs
