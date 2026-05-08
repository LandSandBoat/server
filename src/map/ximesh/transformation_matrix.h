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

#include "vector3.h"

// clang-format off
struct TransformationMatrix
{
    float elements[4][3];

    constexpr float determinant() const
    {
        const auto el = this->elements;

        return el[0][0] * el[1][1] * el[2][2]
               + el[0][1] * el[1][2] * el[2][0]
               + el[0][2] * el[1][0] * el[2][1]
               - el[0][0] * el[1][2] * el[2][1]
               - el[0][1] * el[1][0] * el[2][2]
               - el[0][2] * el[1][1] * el[2][0];
    }

    constexpr TransformationMatrix getInverted() const
    {
        const auto el = this->elements;

        TransformationMatrix inv;
        auto el_inv = inv.elements;

        float t11 = -el[1][2] * el[2][1] + el[1][1] * el[2][2];
        float t12 = el[0][2] * el[2][1] - el[0][1] * el[2][2];
        float t13 = -el[0][2] * el[1][1] + el[0][1] * el[1][2];

        float det = el[0][0] * t11 + el[1][0] * t12 + el[2][0] * t13;

        if (det == 0)
        {
            return inv;
        }

        float inv_det = 1 / det;

        el_inv[0][0] = t11 * inv_det;
        el_inv[1][0] = (el[1][2] * el[2][0] - el[1][0] * el[2][2]) * inv_det;
        el_inv[2][0] = (-el[1][1] * el[2][0] + el[1][0] * el[2][1]) * inv_det;
        el_inv[3][0] = (el[1][2] * el[2][1] * el[3][0] - el[1][1] * el[2][2] * el[3][0] - el[1][2] * el[2][0] * el[3][1] + el[1][0] * el[2][2] * el[3][1] + el[1][1] * el[2][0] * el[3][2] - el[1][0] * el[2][1] * el[3][2]) * inv_det;

        el_inv[0][1] = t12 * inv_det;
        el_inv[1][1] = (-el[0][2] * el[2][0] + el[0][0] * el[2][2]) * inv_det;
        el_inv[2][1] = (el[0][1] * el[2][0] - el[0][0] * el[2][1]) * inv_det;
        el_inv[3][1] = (el[0][1] * el[2][2] * el[3][0] - el[0][2] * el[2][1] * el[3][0] + el[0][2] * el[2][0] * el[3][1] - el[0][0] * el[2][2] * el[3][1] - el[0][1] * el[2][0] * el[3][2] + el[0][0] * el[2][1] * el[3][2]) * inv_det;

        el_inv[0][2] = t13 * inv_det;
        el_inv[1][2] = (el[0][2] * el[1][0] - el[0][0] * el[1][2]) * inv_det;
        el_inv[2][2] = (-el[0][1] * el[1][0] + el[0][0] * el[1][1]) * inv_det;
        el_inv[3][2] = (el[0][2] * el[1][1] * el[3][0] - el[0][1] * el[1][2] * el[3][0] - el[0][2] * el[1][0] * el[3][1] + el[0][0] * el[1][2] * el[3][1] + el[0][1] * el[1][0] * el[3][2] - el[0][0] * el[1][1] * el[3][2]) * inv_det;

        return inv;
    }

    constexpr Vector3 applyToCopy(const Vector3& vec) const
    {
        Vector3 out = vec;
        applyTo(out);
        return out;
    }

    constexpr void applyTo(Vector3& vec) const
    {
        const auto* el = this->elements;

        const Vector3 vecCopy = vec;

        vec.x = el[0][0] * vecCopy.x + el[1][0] * vecCopy.y + el[2][0] * vecCopy.z + el[3][0];
        vec.y = el[0][1] * vecCopy.x + el[1][1] * vecCopy.y + el[2][1] * vecCopy.z + el[3][1];
        vec.z = el[0][2] * vecCopy.x + el[1][2] * vecCopy.y + el[2][2] * vecCopy.z + el[3][2];
    }

    constexpr float applyGetY(const Vector3& vec) const
    {
        const auto* el = this->elements;

        return el[0][1] * vec.x + el[1][1] * vec.y + el[2][1] * vec.z + el[3][1];
    }
};
// clang-format on
