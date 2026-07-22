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

#include "common/cbasetypes.h"
#include "luautils.h"
#include "modifier.h"

class CTrait;

class CLuaTrait
{
    CTrait* trait_;

public:
    CLuaTrait(CTrait*);

    auto trait() const -> CTrait*
    {
        return trait_;
    }

    friend auto operator<<(std::ostream& out, const CLuaTrait& trait) -> std::ostream&;

    auto getID() const -> uint16;
    auto getJob() const -> uint8;
    auto getLevel() const -> uint8;
    auto getMod() const -> xi::Mod;
    auto getValue() const -> int16;
    auto getRank() const -> uint8;
    auto getMeritID() const -> uint32;

    auto operator==(const CLuaTrait& other) const -> bool
    {
        return trait_ == other.trait_;
    }

    static void Register();
};
