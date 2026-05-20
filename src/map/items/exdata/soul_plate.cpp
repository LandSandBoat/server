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

#include "soul_plate.h"

void Exdata::SoulPlate::toTable(sol::table& table) const
{
    table["signature"]     = UnpackSoultrapperName(this->Signature);
    table["zoneId"]        = this->ZoneId;
    table["superFamilyId"] = this->SuperFamilyId;
    table["poolId"]        = this->PoolId;
    table["level"]         = this->Level;
    table["feralSkill"]    = this->FeralSkill;
    table["feralPoints"]   = this->FeralPoints;
    table["quality"]       = this->Quality;
}

void Exdata::SoulPlate::fromTable(const sol::table& data)
{
    if (sol::optional<std::string> sig = data["signature"])
    {
        std::memset(this->Signature, 0, sizeof(this->Signature));
        PackSoultrapperName(*sig, this->Signature);
    }

    this->ZoneId        = Exdata::get_or<uint16_t>(data, "zoneId", this->ZoneId);
    this->SuperFamilyId = Exdata::get_or<uint16_t>(data, "superFamilyId", this->SuperFamilyId);
    this->PoolId        = Exdata::get_or<uint16_t>(data, "poolId", this->PoolId);
    this->Level         = Exdata::get_or<uint32_t>(data, "level", this->Level);
    this->FeralSkill    = Exdata::get_or<uint32_t>(data, "feralSkill", this->FeralSkill);
    this->FeralPoints   = Exdata::get_or<uint32_t>(data, "feralPoints", this->FeralPoints);
    this->Quality       = Exdata::get_or<uint32_t>(data, "quality", this->Quality);
}
