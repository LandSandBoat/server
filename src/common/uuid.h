/*
===========================================================================

  Copyright (c) 2023 LandSandBoat Dev Teams

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

#include "xirand.h"

#include <string>

namespace uuid
{
    // NOTE: We aren't using the built-in Linux implementation for generating UUIDs because it
    //     : seeds the UUID using system information, so instead we're using the same implementation
    //     : on both platforms powered by the user-chosen random engine (default MT32).
    // TODO: Replace/augment this with a faster implementation on platforms that support it (SIMD, etc.)
    std::string GenerateUUID()
    {
        // https://stackoverflow.com/questions/24365331/how-can-i-generate-uuid-in-c-without-using-boost-library
        const char* v      = "0123456789abcdef";
        const bool  dash[] = { 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0 };

        std::string res;

        for (int i = 0; i < 16; i++)
        {
            if (dash[i])
            {
                res += "-";
            }

            res += v[xirand::GetRandomNumber(0, 15)];
            res += v[xirand::GetRandomNumber(0, 15)];
        }

        return res;
    }
} // namespace uuid
