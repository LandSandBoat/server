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

#include "mannequin.h"

void Exdata::Mannequin::toTable(sol::table& table) const
{
    table["x"]        = this->X;
    table["z"]        = this->Z;
    table["y"]        = this->Y;
    table["rotation"] = this->Rotation;
    table["main"]     = this->EquipMain;
    table["sub"]      = this->EquipSub;
    table["ranged"]   = this->EquipRanged;
    table["head"]     = this->EquipHead;
    table["body"]     = this->EquipBody;
    table["hands"]    = this->EquipHands;
    table["legs"]     = this->EquipLegs;
    table["feet"]     = this->EquipFeet;
    table["race"]     = this->Race;
    table["pose"]     = this->Pose;
}

void Exdata::Mannequin::fromTable(const sol::table& data)
{
    this->X           = Exdata::get_or<uint8_t>(data, "x", this->X);
    this->Z           = Exdata::get_or<uint8_t>(data, "z", this->Z);
    this->Y           = Exdata::get_or<uint8_t>(data, "y", this->Y);
    this->Rotation    = Exdata::get_or<uint8_t>(data, "rotation", this->Rotation);
    this->EquipMain   = Exdata::get_or<uint8_t>(data, "main", this->EquipMain);
    this->EquipSub    = Exdata::get_or<uint8_t>(data, "sub", this->EquipSub);
    this->EquipRanged = Exdata::get_or<uint8_t>(data, "ranged", this->EquipRanged);
    this->EquipHead   = Exdata::get_or<uint8_t>(data, "head", this->EquipHead);
    this->EquipBody   = Exdata::get_or<uint8_t>(data, "body", this->EquipBody);
    this->EquipHands  = Exdata::get_or<uint8_t>(data, "hands", this->EquipHands);
    this->EquipLegs   = Exdata::get_or<uint8_t>(data, "legs", this->EquipLegs);
    this->EquipFeet   = Exdata::get_or<uint8_t>(data, "feet", this->EquipFeet);
    this->Race        = Exdata::get_or<uint8_t>(data, "race", this->Race);
    this->Pose        = Exdata::get_or<uint8_t>(data, "pose", this->Pose);
}
