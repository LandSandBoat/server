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

#include <numbers>

struct position_t
{
    float  x      = 0.0f;
    float  y      = 0.0f; // Entity height, relative to "sea level"
    float  z      = 0.0f;
    uint16 moving = 0; // Something like the travel distance, the number of steps required for correct rendering in the client.

    // The angle of rotation of the entity relative to its position. A maximum rotation value of
    // 255 is used as the rotation is stored in `uint8`. Use `rotationToRadian()` and
    // `radianToRotation()` util functions to convert back and forth between the 255-encoded
    // rotation value and the radian value.
    uint8 rotation = 0;

    position_t()
    {
    }

    position_t(float _x, float _y, float _z, uint16 _moving, uint8 _rotation)
    : x(_x)
    , y(_y)
    , z(_z)
    , moving(_moving)
    , rotation(_rotation)
    {
    }
};

// Rotations are stored in a uint8, so a full turn is 256 rather than 2 pi.
inline auto rotationToRadian(uint8 rotation) -> float
{
    return static_cast<float>((rotation / 256.0f) * 2 * std::numbers::pi);
}

inline auto radianToRotation(float radian) -> uint8
{
    return static_cast<uint8>((radian / (2 * std::numbers::pi)) * 256);
}
