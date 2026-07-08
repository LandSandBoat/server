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

#include "betting_slip.h"

void Exdata::BettingSlip::toTable(sol::table& table) const
{
    table["raceId"]       = this->RaceId;
    table["raceGrade"]    = this->RaceGrade;
    table["racePairingL"] = this->RacePairingL;
    table["racePairingR"] = this->RacePairingR;
    table["quills"]       = this->Quills;
}

void Exdata::BettingSlip::fromTable(const sol::table& data)
{
    this->RaceId       = Exdata::get_or<uint32_t>(data, "raceId", this->RaceId);
    this->RaceGrade    = Exdata::get_or<uint32_t>(data, "raceGrade", this->RaceGrade);
    this->RacePairingL = Exdata::get_or<uint32_t>(data, "racePairingL", this->RacePairingL);
    this->RacePairingR = Exdata::get_or<uint32_t>(data, "racePairingR", this->RacePairingR);
    this->Quills       = Exdata::get_or<uint16_t>(data, "quills", this->Quills);
}
