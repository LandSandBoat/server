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

#include "meeble_grimoire.h"

#include "common/lua.h"

namespace
{

constexpr uint8_t NUM_TYPES      = 5;
constexpr uint8_t NUM_LEVELS     = 4;
constexpr uint8_t BITS_PER_LEVEL = 3;

} // namespace

void Exdata::MeebleGrimoire::toTable(sol::table& table) const
{
    sol::table clearsTable = lua.create_table();
    for (uint8_t type = 0; type < NUM_TYPES; ++type)
    {
        sol::table levelsTable = lua.create_table();
        for (uint8_t level = 0; level < NUM_LEVELS; ++level)
        {
            int32 bitOffset        = (type * NUM_LEVELS + level) * BITS_PER_LEVEL;
            levelsTable[level + 1] = static_cast<int>(unpackBitsLE(this->Clears, 0, bitOffset, BITS_PER_LEVEL));
        }
        clearsTable[type + 1] = levelsTable;
    }

    table["clears"] = clearsTable;
    table["count"]  = this->Count;
    table["zone"]   = this->Zone;
}

void Exdata::MeebleGrimoire::fromTable(const sol::table& data)
{
    if (sol::optional<sol::table> clearsOpt = data["clears"])
    {
        // Walk clears[type][level] and pack each 3-bit count back into the bitstream.
        // Missing entries keep whatever was already there.
        for (uint8_t type = 0; type < NUM_TYPES; ++type)
        {
            if (sol::optional<sol::table> levelsOpt = (*clearsOpt)[type + 1])
            {
                for (uint8_t level = 0; level < NUM_LEVELS; ++level)
                {
                    const int32   bitOffset  = (type * NUM_LEVELS + level) * BITS_PER_LEVEL;
                    const uint8_t clearCount = static_cast<uint8_t>(unpackBitsLE(this->Clears, 0, bitOffset, BITS_PER_LEVEL));
                    uint8_t       newCount   = Exdata::get_or<uint8_t>((*levelsOpt)[level + 1], clearCount);
                    packBitsLE(this->Clears, std::min<uint8_t>(newCount, 7), 0, bitOffset, BITS_PER_LEVEL);
                }
            }
        }
    }

    this->Count = Exdata::get_or<uint8_t>(data, "count", this->Count);
    this->Zone  = Exdata::get_or<uint8_t>(data, "zone", this->Zone);
}
