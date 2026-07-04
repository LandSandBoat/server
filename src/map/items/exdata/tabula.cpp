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

#include "tabula.h"
#include "common/lua.h"

namespace
{

constexpr uint8_t GRID_SIZE       = 25;                                         // 5x5 board positions
constexpr uint8_t NUM_RUNES       = 12;                                         // Max runes per tabula
constexpr uint8_t RUNE_ID_BITS    = 9;                                          // Bits per rune ID
constexpr uint8_t RUNE_ROT_BITS   = 2;                                          // Bits per rotation
constexpr uint8_t ROT_BIT_OFFSET  = NUM_RUNES * RUNE_ID_BITS;                   // Bit 108: rotations start
constexpr uint8_t USES_BIT_OFFSET = ROT_BIT_OFFSET + NUM_RUNES * RUNE_ROT_BITS; // Bit 132: uses field start
constexpr uint8_t USES_BITS       = 7;                                          // Bits for uses count

} // anonymous namespace

void Exdata::Tabula::toTable(sol::table& table) const
{
    table["voucher"] = this->Voucher;

    sol::table runes = lua.create_table();
    uint8_t    slot  = 0;
    for (uint8_t pos = 0; pos < GRID_SIZE && slot < NUM_RUNES; ++pos)
    {
        const bool hasAnchor = this->AnchorBits >> (GRID_SIZE - 1 - pos) & 1;
        if (!hasAnchor)
        {
            continue;
        }

        const uint8_t  idOffset  = slot * RUNE_ID_BITS;
        const uint8_t  rotOffset = ROT_BIT_OFFSET + slot * RUNE_ROT_BITS;
        const uint16_t runeId    = static_cast<uint16_t>(unpackBitsLE(this->RuneStream, 0, idOffset, RUNE_ID_BITS));

        if (runeId > 0)
        {
            const uint8_t rotation = static_cast<uint8_t>(unpackBitsLE(this->RuneStream, 0, rotOffset, RUNE_ROT_BITS));

            sol::table rune  = lua.create_table();
            rune["id"]       = runeId;
            rune["rotation"] = rotation;
            rune["position"] = pos;

            runes[runes.size() + 1] = rune;
        }

        ++slot;
    }

    table["runes"] = runes;
    table["uses"]  = static_cast<uint8_t>(unpackBitsLE(this->RuneStream, 0, USES_BIT_OFFSET, USES_BITS));
}

void Exdata::Tabula::fromTable(const sol::table& data)
{
    this->Voucher = Exdata::get_or<uint32_t>(data, "voucher", this->Voucher);

    if (sol::optional<sol::table> runes = data["runes"])
    {
        this->AnchorBits = 0;
        std::memset(this->RuneStream, 0, sizeof(this->RuneStream));

        uint8_t slot = 0;
        for (auto& entry : *runes)
        {
            if (slot >= NUM_RUNES)
            {
                break;
            }

            auto rune = entry.second.as<sol::optional<sol::table>>();
            if (!rune)
            {
                continue;
            }

            if (sol::optional<uint16_t> id = (*rune)["id"])
            {
                packBitsLE(this->RuneStream, *id, slot * RUNE_ID_BITS, RUNE_ID_BITS);
            }

            if (sol::optional<uint8_t> rot = (*rune)["rotation"])
            {
                packBitsLE(this->RuneStream, *rot, ROT_BIT_OFFSET + slot * RUNE_ROT_BITS, RUNE_ROT_BITS);
            }

            if (sol::optional<uint8_t> pos = (*rune)["position"])
            {
                if (*pos < GRID_SIZE)
                {
                    this->AnchorBits |= 1u << (GRID_SIZE - 1 - *pos); // Mark grid position as occupied
                }
            }

            ++slot;
        }
    }

    if (sol::optional<uint8_t> uses = data["uses"])
    {
        packBitsLE(this->RuneStream, *uses, USES_BIT_OFFSET, USES_BITS);
    }
}
