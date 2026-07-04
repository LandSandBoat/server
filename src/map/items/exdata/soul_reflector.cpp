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

#include "soul_reflector.h"

#include "common/lua.h"

namespace
{

constexpr uint32_t SKILL_ID_BITS    = 12;                               // 12 bits per skill ID
constexpr uint32_t SKILL_LEVEL_BITS = 7;                                // 7 bits per skill level
constexpr uint32_t BITS_PER_SLOT    = SKILL_ID_BITS + SKILL_LEVEL_BITS; // 19 bits per feral skill slot
constexpr uint32_t FERAL_SLOTS      = 7;                                // 5 equipped + 2 innate species abilities
constexpr int32_t  FERAL_BIT_OFFSET = 59;                               // Feral Skills start

// Bit-by-bit helpers for the feral skill bitstream that spans the uint64_t/uint8_t boundary.
// packBitsLE cannot be used here: it corrupts adjacent bits when fields straddle byte boundaries.
void setBitsLE(uint8_t* buf, uint64_t value, int32_t bitOffset, const uint8_t numBits)
{
    for (uint8_t i = 0; i < numBits; ++i, ++bitOffset, value >>= 1)
    {
        const auto mask = static_cast<uint8_t>(1 << (bitOffset & 7));
        if (value & 1)
        {
            buf[bitOffset >> 3] |= mask;
        }
        else
        {
            buf[bitOffset >> 3] &= ~mask;
        }
    }
}

auto getBitsLE(const uint8_t* buf, int32_t bitOffset, const uint8_t numBits) -> uint32_t
{
    uint32_t result = 0;
    for (uint8_t i = 0; i < numBits; ++i, ++bitOffset)
    {
        if (buf[bitOffset >> 3] & 1 << (bitOffset & 7))
        {
            result |= 1u << i;
        }
    }

    return result;
}

} // anonymous namespace

void Exdata::SoulReflector::toTable(sol::table& table) const
{
    table["nameFirst"]      = this->NameFirst;
    table["nameLast"]       = this->NameLast;
    table["poolId"]         = this->PoolId;
    table["exp"]            = this->Exp;
    table["discipline"]     = this->Discipline;
    table["temperament"]    = this->Temperament;
    table["aggressiveness"] = this->Aggressiveness;
    table["level"]          = this->Level;

    const auto* raw = reinterpret_cast<const uint8_t*>(this);

    sol::table skills = lua.create_table();
    for (uint32_t i = 0; i < FERAL_SLOTS; ++i)
    {
        const int32_t base = FERAL_BIT_OFFSET + i * BITS_PER_SLOT;
        sol::table    slot = lua.create_table();
        slot["skillId"]    = getBitsLE(raw, base, SKILL_ID_BITS);
        slot["level"]      = getBitsLE(raw, base + SKILL_ID_BITS, SKILL_LEVEL_BITS);
        skills[i + 1]      = slot;
    }

    table["feralSkills"] = skills;
}

void Exdata::SoulReflector::fromTable(const sol::table& data)
{
    this->NameFirst      = Exdata::get_or<uint8_t>(data, "nameFirst", this->NameFirst);
    this->NameLast       = Exdata::get_or<uint8_t>(data, "nameLast", this->NameLast);
    this->PoolId         = Exdata::get_or<uint16_t>(data, "poolId", this->PoolId);
    this->Exp            = Exdata::get_or<uint8_t>(data, "exp", this->Exp);
    this->Discipline     = Exdata::get_or<uint8_t>(data, "discipline", this->Discipline);
    this->Temperament    = Exdata::get_or<uint8_t>(data, "temperament", this->Temperament);
    this->Aggressiveness = Exdata::get_or<uint8_t>(data, "aggressiveness", this->Aggressiveness);
    this->Level          = Exdata::get_or<uint8_t>(data, "level", this->Level);

    // Caution: Feral Skills bitstream straddles the uint64 used above.
    auto* raw = reinterpret_cast<uint8_t*>(this);
    if (sol::optional<sol::table> feralSkills = data["feralSkills"])
    {
        for (uint32_t i = 0; i < FERAL_SLOTS; ++i)
        {
            if (sol::optional<sol::table> slot = (*feralSkills)[i + 1])
            {
                const int32_t  base       = FERAL_BIT_OFFSET + i * BITS_PER_SLOT;
                const uint32_t curSkillId = getBitsLE(raw, base, SKILL_ID_BITS);
                const uint32_t curLevel   = getBitsLE(raw, base + SKILL_ID_BITS, SKILL_LEVEL_BITS);

                setBitsLE(raw, Exdata::get_or<uint32_t>(*slot, "skillId", curSkillId), base, SKILL_ID_BITS);
                setBitsLE(raw, Exdata::get_or<uint32_t>(*slot, "level", curLevel), base + SKILL_ID_BITS, SKILL_LEVEL_BITS);
            }
        }
    }
}
