/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include "map_session.h"

#include "common/md52.h"

void MapSession::incrementBlowfish()
{
    prev_blowfish = blowfish;

    blowfish.key[4] += 2;

    initBlowfish();
}

void MapSession::initBlowfish()
{
    md5((uint8*)(blowfish.key), blowfish.hash, 20);

    for (uint32 i = 0; i < 16; ++i)
    {
        if (blowfish.hash[i] == 0)
        {
            std::memset(blowfish.hash + i, 0, 16 - i);
            break;
        }
    }
    blowfish_init((int8*)blowfish.hash, 16, blowfish.P, blowfish.S[0]);
}

auto MapSession::toString() -> std::string
{
    return fmt::format("MapSession: client_ipp: {}", client_ipp.toString());
}
