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

#include "flower_pot.h"

void Exdata::FlowerPot::toTable(sol::table& table) const
{
    table["step"]         = this->Step;
    table["dried"]        = static_cast<bool>(this->Dried);
    table["crystal1"]     = this->Crystal1;
    table["crystal2"]     = this->Crystal2;
    table["kind"]         = this->Kind;
    table["examined"]     = static_cast<bool>(this->Examined);
    table["strength"]     = this->Strength;
    table["x"]            = this->X;
    table["z"]            = this->Z;
    table["y"]            = this->Y;
    table["rotation"]     = this->Rotation;
    table["timePlanted"]  = this->TimePlanted;
    table["timeNextStep"] = this->TimeNextStep;
}

void Exdata::FlowerPot::fromTable(const sol::table& data)
{
    this->Step         = Exdata::get_or<uint8_t>(data, "step", this->Step);
    this->Dried        = Exdata::get_or<bool>(data, "dried", this->Dried) ? 1 : 0;
    this->Crystal1     = Exdata::get_or<uint8_t>(data, "crystal1", this->Crystal1);
    this->Crystal2     = Exdata::get_or<uint8_t>(data, "crystal2", this->Crystal2);
    this->Kind         = Exdata::get_or<uint8_t>(data, "kind", this->Kind);
    this->Examined     = Exdata::get_or<bool>(data, "examined", this->Examined) ? 1 : 0;
    this->Strength     = Exdata::get_or<uint8_t>(data, "strength", this->Strength);
    this->X            = Exdata::get_or<uint8_t>(data, "x", this->X);
    this->Z            = Exdata::get_or<uint8_t>(data, "z", this->Z);
    this->Y            = Exdata::get_or<uint8_t>(data, "y", this->Y);
    this->Rotation     = Exdata::get_or<uint8_t>(data, "rotation", this->Rotation);
    this->TimePlanted  = Exdata::get_or<uint32_t>(data, "timePlanted", this->TimePlanted);
    this->TimeNextStep = Exdata::get_or<uint32_t>(data, "timeNextStep", this->TimeNextStep);
}
