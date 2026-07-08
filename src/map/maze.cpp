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

#include "maze.h"

auto maze_t::hasVoucher(const uint8 voucherId) const -> bool
{
    if (voucherId == 0 || voucherId > vouchers.size())
    {
        return false;
    }

    return vouchers.test(voucherId - 1);
}

void maze_t::learnVoucher(const uint8 voucherId)
{
    if (voucherId == 0 || voucherId > vouchers.size())
    {
        return;
    }

    vouchers.set(voucherId - 1);
}

auto maze_t::hasRune(const uint16 runeId) const -> bool
{
    if (runeId == 0 || runeId > runes.size())
    {
        return false;
    }

    return runes.test(runeId - 1);
}

void maze_t::learnRune(const uint16 runeId)
{
    if (runeId == 0 || runeId > runes.size())
    {
        return;
    }

    runes.set(runeId - 1);
}
