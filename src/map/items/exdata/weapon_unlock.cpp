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

#include "weapon_unlock.h"

void Exdata::WeaponUnlock::toTable(sol::table& table) const
{
    table["unlockPoints"] = this->UnlockPoints;
}

void Exdata::WeaponUnlock::fromTable(const sol::table& data)
{
    this->UnlockPoints = Exdata::get_or<uint16_t>(data, "unlockPoints", this->UnlockPoints);
}
