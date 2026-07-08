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

#include "chocobo_card.h"

#include "common/lua.h"

namespace
{

auto statToTable(const Exdata::ChocoboStatByte& stat) -> sol::table
{
    sol::table t = lua.create_table();
    t["trait"]   = static_cast<bool>(stat.Trait);
    t["rp"]      = static_cast<uint8_t>(stat.RP);
    t["rank"]    = static_cast<uint8_t>(stat.Rank);
    return t;
}

void statFromTable(Exdata::ChocoboStatByte& stat, const sol::table& t)
{
    stat.Trait = Exdata::get_or<bool>(t, "trait", stat.Trait) ? 1 : 0;
    stat.RP    = Exdata::get_or<uint8_t>(t, "rp", stat.RP);
    stat.Rank  = Exdata::get_or<uint8_t>(t, "rank", stat.Rank);
}

} // anonymous namespace

void Exdata::ChocoboCard::toTable(sol::table& table) const
{
    table["strength"]    = statToTable(this->STR);
    table["endurance"]   = statToTable(this->END);
    table["discernment"] = statToTable(this->DSC);

    sol::table rcp       = lua.create_table();
    rcp["rp"]            = static_cast<uint8_t>(this->RCP.RP);
    rcp["rank"]          = static_cast<uint8_t>(this->RCP.Rank);
    table["receptivity"] = rcp;

    sol::table dna = lua.create_table();
    dna[1]         = static_cast<uint32_t>(this->DNA1);
    dna[2]         = static_cast<uint32_t>(this->DNA2);
    dna[3]         = static_cast<uint32_t>(this->DNA3);
    table["dna"]   = dna;

    sol::table abilities = lua.create_table();
    abilities[1]         = static_cast<uint32_t>(this->Ability1);
    abilities[2]         = static_cast<uint32_t>(this->Ability2);
    table["abilities"]   = abilities;

    table["temperament"] = static_cast<uint32_t>(this->Temperament);
    table["weather"]     = static_cast<uint32_t>(this->Weather);
    table["gender"]      = static_cast<uint32_t>(this->Gender);
    table["color"]       = static_cast<uint32_t>(this->Color);
    table["size"]        = static_cast<uint32_t>(this->Size);

    table["name"] = Exdata::decodeSignature(this->Signature);
}

void Exdata::ChocoboCard::fromTable(const sol::table& data)
{
    if (sol::optional<sol::table> strength = data["strength"])
    {
        statFromTable(this->STR, *strength);
    }

    if (sol::optional<sol::table> endurance = data["endurance"])
    {
        statFromTable(this->END, *endurance);
    }

    if (sol::optional<sol::table> discernment = data["discernment"])
    {
        statFromTable(this->DSC, *discernment);
    }

    if (sol::optional<sol::table> receptivity = data["receptivity"])
    {
        this->RCP.RP   = Exdata::get_or<uint8_t>(*receptivity, "rp", this->RCP.RP);
        this->RCP.Rank = Exdata::get_or<uint8_t>(*receptivity, "rank", this->RCP.Rank);
    }

    if (sol::optional<sol::table> dna = data["dna"])
    {
        this->DNA1 = Exdata::get_or<uint32_t>(*dna, 1, this->DNA1);
        this->DNA2 = Exdata::get_or<uint32_t>(*dna, 2, this->DNA2);
        this->DNA3 = Exdata::get_or<uint32_t>(*dna, 3, this->DNA3);
    }

    if (sol::optional<sol::table> abilities = data["abilities"])
    {
        this->Ability1 = Exdata::get_or<uint32_t>(*abilities, 1, this->Ability1);
        this->Ability2 = Exdata::get_or<uint32_t>(*abilities, 2, this->Ability2);
    }

    this->Temperament = Exdata::get_or<uint32_t>(data, "temperament", this->Temperament);
    this->Weather     = Exdata::get_or<uint32_t>(data, "weather", this->Weather);
    this->Gender      = Exdata::get_or<uint32_t>(data, "gender", this->Gender);
    this->Color       = Exdata::get_or<uint32_t>(data, "color", this->Color);
    this->Size        = Exdata::get_or<uint32_t>(data, "size", this->Size);

    if (sol::optional<std::string> name = data["name"])
    {
        Exdata::encodeSignature(*name, this->Signature);
    }
}
