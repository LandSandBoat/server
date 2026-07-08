/*
===========================================================================

  Copyright (c) 2021-2025 Eden Dev Team

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

  This file is part of the Eden server source code.

===========================================================================
*/

#pragma once

#include <cmath>

struct Vector3
{
    float x;
    float y;
    float z;

    constexpr Vector3 operator+(const Vector3& vec) const
    {
        return Vector3{ x + vec.x, y + vec.y, z + vec.z };
    }

    constexpr Vector3& operator+=(const Vector3& vec)
    {
        x += vec.x;
        y += vec.y;
        z += vec.z;
        return *this;
    }

    constexpr Vector3 operator-(const Vector3& vec) const
    {
        return Vector3{ x - vec.x, y - vec.y, z - vec.z };
    }

    constexpr Vector3& operator-=(const Vector3& vec)
    {
        x -= vec.x;
        y -= vec.y;
        z -= vec.z;
        return *this;
    }

    constexpr Vector3 operator*(float value) const
    {
        return Vector3{ x * value, y * value, z * value };
    }

    constexpr Vector3& operator*=(float value)
    {
        x *= value;
        y *= value;
        z *= value;
        return *this;
    }

    constexpr Vector3 operator/(float value) const
    {
        return Vector3{ x / value, y / value, z / value };
    }

    constexpr Vector3& operator/=(float value)
    {
        x /= value;
        y /= value;
        z /= value;
        return *this;
    }

    constexpr auto crossProduct(const Vector3& other) const -> Vector3
    {
        return Vector3{
            y * other.z - z * other.y,
            z * other.x - x * other.z,
            x * other.y - y * other.x,
        };
    }

    constexpr auto dotProduct(const Vector3& other) const -> float
    {
        return x * other.x + y * other.y + z * other.z;
    }

    constexpr auto magnitudeSquared() const -> float
    {
        return x * x + y * y + z * z;
    }

    // NOTE: std::sqrt is only constexpr in C++23
    auto magnitude() const -> float
    {
        return std::sqrt(magnitudeSquared());
    }
};
