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

#include "linkshell.h"

#include "common/lua.h"
#include "common/utils.h"

void Exdata::Linkshell::toTable(sol::table& table) const
{
    table["groupId"]  = this->GroupId;
    table["groupKey"] = this->GroupKey;

    sol::table color = lua.create_table();
    color["r"]       = this->Color.R;
    color["g"]       = this->Color.G;
    color["b"]       = this->Color.B;
    color["a"]       = this->Color.A;
    table["color"]   = color;

    table["flag"] = this->Flag;

    char decoded[21] = {};
    DecodeStringLinkshell(std::string(reinterpret_cast<const char*>(this->Name), sizeof(this->Name)), decoded);
    table["name"] = std::string(decoded);
}

void Exdata::Linkshell::fromTable(const sol::table& data)
{
    this->GroupId  = Exdata::get_or<uint32_t>(data, "groupId", this->GroupId);
    this->GroupKey = Exdata::get_or<uint16_t>(data, "groupKey", this->GroupKey);

    sol::optional<sol::table> color = data["color"];
    if (color)
    {
        this->Color.R = Exdata::get_or<uint8_t>(*color, "r", this->Color.R);
        this->Color.G = Exdata::get_or<uint8_t>(*color, "g", this->Color.G);
        this->Color.B = Exdata::get_or<uint8_t>(*color, "b", this->Color.B);
        this->Color.A = Exdata::get_or<uint8_t>(*color, "a", this->Color.A);
    }

    this->Flag = Exdata::get_or<uint8_t>(data, "flag", this->Flag);

    sol::optional<std::string> name = data["name"];
    if (name)
    {
        std::memset(this->Name, 0, sizeof(this->Name));
        char encoded[LinkshellStringLength] = {};
        EncodeStringLinkshell(*name, encoded);
        std::memcpy(this->Name, encoded, sizeof(this->Name));
    }
}
