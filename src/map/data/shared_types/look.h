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

#include <fmt/format.h>
#include <glaze/glaze.hpp>

#include <array>
#include <map>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>
#include <vector>

namespace xi::data::shared
{

// TODO: This carries a lot of technical debt and is slated for deprecation/rework!
struct Look
{
    std::string           type;
    std::optional<uint16> model; // standard, misc and automaton
    std::optional<uint8>  race;  // equipped and chocobo
    std::optional<uint8>  face;
    std::optional<uint16> head;
    std::optional<uint16> body;
    std::optional<uint16> hands;
    std::optional<uint16> legs;
    std::optional<uint16> feet;
    std::optional<uint16> main;
    std::optional<uint16> sub;
    std::optional<uint16> ranged;
};

using LookFields = std::array<uint16, 10>;

inline auto toLookFields(const Look& source, const std::string_view context) -> LookFields
{
    LookFields look{};

    // chocobos carry the same nine fields as an equipped npc, only the values are small indices rather than equipment ids
    if (source.type == "equipped" || source.type == "chocobo")
    {
        // The second field packs face in the low byte and race in the high byte.
        if (source.type == "equipped")
        {
            look[0] = 1;
        }
        else
        {
            look[0] = 7;
        }
        look[1] = static_cast<uint16>(source.face.value_or(0) | (source.race.value_or(0) << 8));
        look[2] = source.head.value_or(0);
        look[3] = source.body.value_or(0);
        look[4] = source.hands.value_or(0);
        look[5] = source.legs.value_or(0);
        look[6] = source.feet.value_or(0);
        look[7] = source.main.value_or(0);
        look[8] = source.sub.value_or(0);
        look[9] = source.ranged.value_or(0);
        return look;
    }

    static const std::map<std::string_view, uint16> kTypes{
        { "standard", 0 },
        { "door", 2 },
        { "elevator", 3 },
        { "ship", 4 },
        { "misc", 5 },
        { "automaton", 6 },
    };

    const auto entry = kTypes.find(source.type);
    if (entry == kTypes.end())
    {
        throw std::runtime_error(fmt::format("'{}' declares unknown look type '{}'", context, source.type));
    }

    look[0] = entry->second;
    look[1] = source.model.value_or(0);
    return look;
}

} // namespace xi::data::shared

template <>
struct glz::json_schema<xi::data::shared::Look>
{
    glz::schema type{
        .description = "Which look fields the client reads, matching the packet's SubKind. door, elevator and ship carry no model: the client names them from the packet. standard, misc and automaton each carry one model id under a different SubKind, so the same id means a different model in each. misc is SubKind 5, which the packet code still calls MODEL_UNK_5, and is used by Fomors; automaton is SubKind 6 and covers trolls, lamia and mamool ja despite the name. chocobo reads the same nine fields as equipped.",
        .enumeration = std::vector<std::string_view>{ "standard", "equipped", "door", "elevator", "ship", "misc", "automaton", "chocobo" },
    };
    glz::schema model{ .description = "Model id, for standard, misc and automaton." };
    glz::schema race{ .description = "Race, for equipped models. On a chocobo this pair carries its colour instead." };
    glz::schema face{ .description = "Face, for equipped models." };
    glz::schema head{ .description = "Equipped head model. Omitted means empty. On a chocobo the slots hold small barding indices, not equipment ids." };
    glz::schema body{ .description = "Equipped body model. Omitted means empty." };
    glz::schema hands{ .description = "Equipped hands model. Omitted means empty." };
    glz::schema legs{ .description = "Equipped legs model. Omitted means empty." };
    glz::schema feet{ .description = "Equipped feet model. Omitted means empty." };
    glz::schema main{ .description = "Equipped main weapon model. Omitted means empty." };
    glz::schema sub{ .description = "Equipped sub weapon model. Omitted means empty." };
    glz::schema ranged{ .description = "Equipped ranged weapon model. Omitted means empty." };
};
