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

#include "0x069_chocobo_racing.h"

#include "common/lua.h"

#include <algorithm>
#include <bit>

namespace GP_SERV_COMMAND_CHOCOBO_RACING
{

auto ChocoboParam::fromLua(const sol::table& data) -> ChocoboParam
{
    ChocoboParam param{};

    param.Item        = data.get_or<uint8_t>("item", 0);        // xi.chocoboRacing.sectionEvent
    param.Orders      = data.get_or<uint8_t>("orders", 0);      // xi.chocoboRacing.order
    param.Size        = data.get_or<uint8_t>("size", 0);        // xi.chocoboRacing.jockeySize
    param.Color       = data.get_or<uint8_t>("color", 0);       // xi.chocoboRaising.color
    param.Gender      = data.get_or<uint8_t>("gender", 0);      // xi.chocoboRaising.gender
    param.Weather     = data.get_or<uint8_t>("weather", 0);     // xi.chocoboRaising.weather
    param.Temperament = data.get_or<uint8_t>("temperament", 0); // xi.chocoboRaising.temperament
    param.Ability1    = data.get_or<uint8_t>("ability1", 0);    // xi.chocoboRaising.ability
    param.Ability2    = data.get_or<uint8_t>("ability2", 0);    // xi.chocoboRaising.ability

    // stats str/end/dsc/rcp: raw 0-255 stats, which are the stat bytes as sent
    if (const auto stats = data.get<sol::optional<sol::table>>("stats"))
    {
        param.STR = std::bit_cast<Exdata::ChocoboStatByte>(stats->get_or<uint8_t>("str", 0));
        param.END = std::bit_cast<Exdata::ChocoboStatByte>(stats->get_or<uint8_t>("end", 0));
        param.DSC = std::bit_cast<Exdata::ChocoboStatByte>(stats->get_or<uint8_t>("dsc", 0));
        param.RCP = std::bit_cast<Exdata::ChocoboStatByteRCP>(stats->get_or<uint8_t>("rcp", 0));
    }

    return param;
}

auto ChocoboParam::toLua() const -> sol::table
{
    sol::table stats = lua.create_table();
    stats["str"]     = std::bit_cast<uint8_t>(STR);
    stats["end"]     = std::bit_cast<uint8_t>(END);
    stats["dsc"]     = std::bit_cast<uint8_t>(DSC);
    stats["rcp"]     = std::bit_cast<uint8_t>(RCP);

    sol::table data     = lua.create_table();
    data["item"]        = static_cast<uint8_t>(Item);
    data["orders"]      = static_cast<uint8_t>(Orders);
    data["size"]        = static_cast<uint8_t>(Size);
    data["color"]       = static_cast<uint8_t>(Color);
    data["gender"]      = static_cast<uint8_t>(Gender);
    data["weather"]     = static_cast<uint8_t>(Weather);
    data["temperament"] = static_cast<uint8_t>(Temperament);
    data["ability1"]    = static_cast<uint8_t>(Ability1);
    data["ability2"]    = static_cast<uint8_t>(Ability2);
    data["stats"]       = stats;

    return data;
}

auto SectionParam::fromLua(const sol::table& data) -> SectionParam
{
    SectionParam section{};
    packNibbles(section.From, readNibbles(data.get<sol::table>("from")));
    packNibbles(section.To, readNibbles(data.get<sol::table>("to")));

    if (const auto event = data.get<sol::optional<sol::table>>("trigger"))
    {
        section.Trigger.User    = event->get_or<uint8_t>("user", 0);
        section.Trigger.Targets = event->get_or<uint8_t>("targets", 0);
        section.Trigger.Param   = event->get_or<uint8_t>("param", 0);
        section.Trigger.Type    = static_cast<SectionEventType>(event->get_or<uint8_t>("type", 0));
    }

    return section;
}

auto SectionParam::toLua() const -> sol::table
{
    const auto writeNibbles = [](const uint8_t in[4]) -> sol::table
    {
        sol::table out    = lua.create_table();
        const auto values = unpackNibbles(in);
        for (std::size_t racer = 0; racer < kNumRacers; ++racer)
        {
            out[racer + 1] = values[racer];
        }

        return out;
    };

    sol::table trigger = lua.create_table();
    trigger["user"]    = Trigger.User;
    trigger["targets"] = Trigger.Targets;
    trigger["param"]   = Trigger.Param;
    trigger["type"]    = static_cast<uint8_t>(Trigger.Type);

    sol::table data = lua.create_table();
    data["from"]    = writeNibbles(From);
    data["to"]      = writeNibbles(To);
    data["trigger"] = trigger;

    return data;
}

auto readNibbles(const sol::table& values) -> std::array<uint8_t, kNumRacers>
{
    std::array<uint8_t, kNumRacers> out{};
    for (std::size_t racer = 0; racer < kNumRacers; ++racer)
    {
        out[racer] = values.get_or<uint8_t>(racer + 1, 0);
    }

    return out;
}

// Various fields pack 2 chocobos per uint8, the even chocobo in the low nibble.
void packNibbles(uint8_t out[4], const std::array<uint8_t, kNumRacers>& nibbles)
{
    for (size_t i = 0; i < kNumRacers / 2; ++i)
    {
        const uint8_t lo = nibbles[i * 2] & 0x0F;
        const uint8_t hi = nibbles[i * 2 + 1] & 0x0F;
        out[i]           = static_cast<uint8_t>(hi << 4 | lo);
    }
}

auto unpackNibbles(const uint8_t in[4]) -> std::array<uint8_t, kNumRacers>
{
    std::array<uint8_t, kNumRacers> out{};
    for (size_t i = 0; i < kNumRacers / 2; ++i)
    {
        out[i * 2]     = in[i] & 0x0F;
        out[i * 2 + 1] = in[i] >> 4;
    }

    return out;
}

RACINGPARAMS::RACINGPARAMS(const uint32_t weather, const uint32_t entrants, const uint32_t raceCounter)
{
    auto& packet = this->data();

    packet.Mode          = 1;
    packet.ParamSize     = static_cast<uint8_t>(sizeof(packet.RaceParams));
    packet.RaceParams[0] = (weather << 5) | entrants;        // xi.weather id, then the number of chocobos racing
    packet.RaceParams[1] = 0x80000000 | (raceCounter & 0x3); // high bit + 2-bit rolling counter
}

CHOCOBOPARAMS::CHOCOBOPARAMS(const std::vector<ChocoboParam>& chocobos)
{
    auto&      packet = this->data();
    const auto count  = std::min<size_t>(chocobos.size(), kNumRacers); // Up to 8 chocobos. Some races use less.

    packet.Mode      = 2;
    packet.ParamSize = static_cast<uint8_t>(count * sizeof(ChocoboParam));

    for (size_t i = 0; i < count; ++i)
    {
        packet.Chocobos[i] = chocobos[i];
    }
}

SECTIONPARAMS::SECTIONPARAMS(const uint8_t startIndex, const std::vector<SectionParam>& sections)
{
    auto&      packet = this->data();
    const auto count  = std::min<size_t>(sections.size(), kSectionsPerPacket);

    packet.Mode       = 3;
    packet.ParamIndex = startIndex; // This can be 0 or 16
    packet.ParamSize  = static_cast<uint8_t>(count * sizeof(SectionParam));

    for (size_t i = 0; i < count; ++i)
    {
        packet.Sections[i] = sections[i];
    }
}

RESULTPARAMS::RESULTPARAMS(const std::array<uint8_t, kNumRacers>& places)
{
    auto& packet = this->data();

    packet.Mode      = 4;
    packet.ParamSize = static_cast<uint8_t>(sizeof(packet.Places));
    packNibbles(packet.Places, places);
}

END::END()
{
    auto& packet = this->data();

    packet.Mode = 5;
}

} // namespace GP_SERV_COMMAND_CHOCOBO_RACING
