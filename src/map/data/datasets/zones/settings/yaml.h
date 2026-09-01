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
#include "data/enums/animation.h"
#include "data/enums/transport_state.h"
#include "data/enums/zone.h"
#include "data/enums/zone_misc.h"
#include "data/enums/zone_type.h"
#include "data/yaml/enum_token.h"

#include <glaze/glaze.hpp>

#include <array>
#include <map>
#include <optional>
#include <string>
#include <vector>

namespace xi::data::datasets::zones::settings::wire
{

using ZoneType = std::optional<std::vector<yaml::EnumToken<xi::ZoneType>>>;
using ZoneMisc = std::optional<std::vector<yaml::EnumToken<xi::ZoneMisc>>>;

using Animation = std::optional<yaml::EnumToken<xi::Animation>>;
using Seconds   = std::optional<uint32>;
using Zone      = std::optional<yaml::EnumToken<xi::ZoneId>>;
using Zones     = std::optional<std::vector<yaml::EnumToken<xi::ZoneId>>>;
using Places    = std::optional<std::map<std::string, std::array<float, 3>>>;

struct Music
{
    std::optional<uint16> day;
    std::optional<uint16> night;
    std::optional<uint16> battle_solo;
    std::optional<uint16> battle_party;
};

struct ZoneLine
{
    std::array<float, 3>        from;
    yaml::EnumToken<xi::ZoneId> to;
    std::vector<float>          at;
    std::array<float, 2>        scale;
};

// Where the ship is put, and how far into its phase retail put it there.
struct TransportMove
{
    std::string to;
    Seconds     after;
};

// One leg of a scheduled run: how the ship looks and what it does for a stretch of the cycle.
struct TransportPhase
{
    yaml::EnumToken<xi::TransportState>       state;
    Animation                                 animation;
    Seconds                                   seconds;
    std::optional<std::vector<TransportMove>> moves;
    Seconds                                   hide;
};

struct Transport
{
    std::optional<std::string>        door;
    std::optional<std::vector<float>> dock;
    Places                            places;
    std::optional<uint16>             boundary;
    Zones                             voyage;
    Seconds                           every;
    Seconds                           offset;
    Seconds                           disembark;
    std::vector<TransportPhase>       phases;
};

// Every zone runs a single ship, so it is stated once and the runs it serves listed beneath.
struct TransportSchedule
{
    uint32                           ship;
    std::map<std::string, Transport> runs;
};

struct Document
{
    ZoneType                                       type;
    ZoneMisc                                       misc;
    std::optional<Music>                           music;
    std::optional<float>                           tax;
    std::optional<uint8>                           level_restriction;
    std::optional<std::map<std::string, ZoneLine>> zonelines;
    std::optional<TransportSchedule>               transport;
};

} // namespace xi::data::datasets::zones::settings::wire

template <>
struct glz::json_schema<xi::data::datasets::zones::settings::wire::Music>
{
    glz::schema day{ .description = "Background music by day. Defaults to 0 (silence)." };
    glz::schema night{ .description = "Background music by night. Defaults to 0 (silence)." };
    glz::schema battle_solo{ .description = "Battle music when fighting alone. Defaults to 0." };
    glz::schema battle_party{ .description = "Battle music when fighting in a party. Defaults to 0." };
};

template <>
struct glz::json_schema<xi::data::datasets::zones::settings::wire::ZoneLine>
{
    glz::schema from{ .description = "Centre of the trigger box in this zone, as x, y, z." };
    glz::schema to{ .description = "Destination zone." };
    glz::schema at{ .description = "Centre of the arrival box in the destination zone, as x, y, z and optionally a facing in radians." };
    glz::schema scale{ .description = "Arrival box dimensions along x and z. Players are spread across eight slots along the longer side." };
};

template <>
struct glz::json_schema<xi::data::datasets::zones::settings::wire::TransportPhase>
{
    glz::schema state{ .description = "What the ship is doing for this stretch." };
    glz::schema animation{ .description = "Animation the client plays, timed from the moment this phase began. Omitted leaves the previous one running." };
    glz::schema seconds{ .description = "How long this phase lasts. Omit on one phase to give it whatever is left of the cycle." };
    glz::schema moves{ .description = "Where the ship is put during this phase, in order. Omitted leaves it wherever the last move left it." };
    glz::schema hide{ .description = "Seconds into the phase after which the client stops drawing the ship, once the animation has carried it out of sight. Omitted leaves it visible throughout." };
};

template <>
struct glz::json_schema<xi::data::datasets::zones::settings::wire::TransportMove>
{
    glz::schema to{ .description = "'dock', or a name from the run's places." };
    glz::schema after{ .description = "Seconds into the phase before the ship is put there. Defaults to the start of the phase." };
};

template <>
struct glz::json_schema<xi::data::datasets::zones::settings::wire::Transport>
{
    glz::schema door{ .description = "Client name of the boarding door, as it appears in npcs.yaml. Omitted means the run has none." };
    glz::schema dock{ .description = "Where the ship sits while docked, as x, y, z and optionally a facing of 0-255. Omitted leaves it wherever the zone put it." };
    glz::schema places{ .description = "Named spots the run's moves refer to, as x, y, z. The dock is always available under that name." };
    glz::schema boundary{ .description = "Boarding area passengers stand in. They ride along when the ship departs." };
    glz::schema voyage{ .description = "Zones the passengers may travel through. A ship whose destination is chosen at boarding time names each one. Omitted means the run carries nobody." };
    glz::schema every{ .description = "Cycle length in seconds. Omitted on a single open-ended phase means it never repeats." };
    glz::schema offset{ .description = "Seconds the cycle is shifted by, so runs sharing a ship take their turn. Defaults to 0." };
    glz::schema disembark{ .description = "Seconds into the cycle when riders in the voyage zone are put ashore." };
    glz::schema phases{ .description = "The cycle in order, starting at the offset." };
};

template <>
struct glz::json_schema<xi::data::datasets::zones::settings::wire::TransportSchedule>
{
    glz::schema ship{ .description = "Entity id of the ship serving this zone, which also names the zone it docks in." };
    glz::schema runs{ .description = "Scheduled runs it serves, keyed by name. Each takes its turn through its offset." };
};

template <>
struct glz::json_schema<xi::data::datasets::zones::settings::wire::Document>
{
    glz::schema type{
        .description = "Zone classification flags. Defaults to an empty list.",
        .uniqueItems = true,
    };
    glz::schema misc{
        .description = "Abilities and systems permitted in this zone. Defaults to an empty list.",
        .uniqueItems = true,
    };
    glz::schema music{ .description = "Background and battle music. Omitted slots default to 0." };
    glz::schema tax{
        .description = "Percent added to bazaar purchases in this zone. Defaults to 0, and every zone reads 0 today.",
        .minimum     = 0.0,
        .maximum     = 100.0,
    };
    glz::schema level_restriction{
        .description = "Level cap enforced on entry. Defaults to 0, meaning uncapped.",
        .minimum     = 0L,
        .maximum     = 99L,
    };
    glz::schema zonelines{ .description = "Outbound transitions, keyed by their four-character client id such as z2s0." };
    glz::schema transport{ .description = "The ship docking in this zone and the runs it serves." };
};
