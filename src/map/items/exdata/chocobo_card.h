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

#pragma once

#include "base.h"

namespace Exdata
{

#pragma pack(push, 1)

// Reference: https://github.com/Ivaar/Windower-addons/tree/master/chococard
struct ChocoboStatByte
{
    uint8_t Trait : 1;
    uint8_t RP : 4;
    uint8_t Rank : 3;
};

struct ChocoboStatByteRCP
{
    uint8_t RP : 5;
    uint8_t Rank : 3;
};

struct ChocoboCard
{
    ChocoboStatByte    STR;
    ChocoboStatByte    END;
    ChocoboStatByte    DSC;
    ChocoboStatByteRCP RCP;
    uint32_t           DNA1 : 3;
    uint32_t           DNA2 : 3;
    uint32_t           DNA3 : 3;
    uint32_t           Ability1 : 4;
    uint32_t           Ability2 : 4;
    uint32_t           Temperament : 3;
    uint32_t           Weather : 4;
    uint32_t           Gender : 1;
    uint32_t           Color : 3;
    uint32_t           Size : 3;
    uint32_t           unknown00 : 1;
    uint32_t           padding00;
    uint8_t            Signature[12];

    void toTable(sol::table& table) const;
    void fromTable(const sol::table& data);
};

#pragma pack(pop)

} // namespace Exdata
