/*
===========================================================================

  Copyright (c) 2021 Eden Dev Teams

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

#ifndef _LOS_COMMON_H
#define _LOS_COMMON_H

#include "common/cbasetypes.h"
#include "common/logging.h"

#include <optional>

enum class Axis : uint8
{
    None = 255,
    X    = 0,
    Y    = 1,
    Z    = 2,
};

struct BoundingBox
{
    float coords[6];

    float getAxisMin(Axis axis)
    {
        return coords[((int)axis) * 2];
    }

    float getAxisMax(Axis axis)
    {
        return coords[((int)axis) * 2 + 1];
    }

    float getAxisSize(Axis axis)
    {
        return getAxisMax(axis) - getAxisMin(axis);
    }

    float getAxisMiddle(Axis axis)
    {
        float axisMin = getAxisMin(axis);
        return (getAxisMax(axis) - axisMin) / 2 + axisMin;
    }

    void expandTo(BoundingBox const& other)
    {
        if (other.coords[0] < coords[0])
        {
            coords[0] = other.coords[0];
        }
        if (other.coords[1] > coords[1])
        {
            coords[1] = other.coords[1];
        }

        if (other.coords[3] > coords[3])
        {
            coords[3] = other.coords[3];
        }
        if (other.coords[4] < coords[4])
        {
            coords[4] = other.coords[4];
        }

        if (other.coords[5] < coords[5])
        {
            coords[5] = other.coords[5];
        }
        if (other.coords[5] > coords[5])
        {
            coords[5] = other.coords[5];
        }
    }
};

struct Vector3D
{
    float x;
    float y;
    float z;

    // Addition
    Vector3D operator+(Vector3D const& vec)
    {
        return Vector3D{ x + vec.x, y + vec.y, z + vec.z };
    }

    Vector3D& operator+=(Vector3D const& vec)
    {
        x += vec.x;
        y += vec.y;
        z += vec.z;
        return *this;
    }

    // Subtraction
    Vector3D operator-(Vector3D const& vec)
    {
        return Vector3D{ x - vec.x, y - vec.y, z - vec.z };
    }

    Vector3D& operator-=(Vector3D const& vec)
    {
        x -= vec.x;
        y -= vec.y;
        z -= vec.z;
        return *this;
    }

    // Scalar multiplication
    Vector3D operator*(float value)
    {
        return Vector3D{ x * value, y * value, z * value };
    }

    Vector3D& operator*=(float value)
    {
        x *= value;
        y *= value;
        z *= value;
        return *this;
    }

    // Scalar division
    Vector3D operator/(float value)
    {
        return Vector3D{ x / value, y / value, z / value };
    }

    Vector3D& operator/=(float value)
    {
        x /= value;
        y /= value;
        z /= value;
        return *this;
    }

    // Misc other
    Vector3D crossProduct(Vector3D const& other) const
    {
        float ni = y * other.z - z * other.y;
        float nj = z * other.x - x * other.z;
        float nk = x * other.y - y * other.x;
        return Vector3D{ ni, nj, nk };
    }

    float dotProduct(Vector3D const& other) const
    {
        return x * other.x + y * other.y + z * other.z;
    }

    float magnitude() const
    {
        return sqrt(x * x + y * y + z * z);
    }
};

struct Triangle
{
    Vector3D vertices[3];

    BoundingBox getBoundingBox()
    {
        return BoundingBox{
            std::min(std::min(vertices[0].x, vertices[1].x), vertices[2].x),
            std::max(std::max(vertices[0].x, vertices[1].x), vertices[2].x),
            std::min(std::min(vertices[0].y, vertices[1].y), vertices[2].y),
            std::max(std::max(vertices[0].y, vertices[1].y), vertices[2].y),
            std::min(std::min(vertices[0].z, vertices[1].z), vertices[2].z),
            std::max(std::max(vertices[0].z, vertices[1].z), vertices[2].z),
        };
    }

    // Taken from: https://en.wikipedia.org/wiki/M%C3%B6ller%E2%80%93Trumbore_intersection_algorithm#C++_implementation
    std::optional<Vector3D> doesRayIntersect(Vector3D rayOrigin, Vector3D rayVector)
    {
        constexpr float EPSILON = 0.0000001f;

        Vector3D edge1;
        Vector3D edge2;
        Vector3D h;
        Vector3D s;
        Vector3D q;

        float a;
        float f;
        float u;
        float v;

        edge1 = vertices[1] - vertices[0];
        edge2 = vertices[2] - vertices[0];
        h     = rayVector.crossProduct(edge2);
        a     = edge1.dotProduct(h);

        if (a > -EPSILON && a < EPSILON)
        {
            return std::nullopt; // This ray is parallel to this triangle.
        }

        f = 1.0f / a;
        s = rayOrigin - vertices[0];
        u = f * s.dotProduct(h);

        if (u < 0.0 || u > 1.0)
        {
            return std::nullopt;
        }

        q = s.crossProduct(edge1);
        v = f * rayVector.dotProduct(q);

        if (v < 0.0 || u + v > 1.0)
        {
            return std::nullopt;
        }

        // At this stage we can compute t to find out where the intersection point is on the line.
        float t = f * edge2.dotProduct(q);
        if (t > EPSILON && t <= 1.f) // ray intersection
        {
            Vector3D outIntersectionPoint = rayOrigin + rayVector * t;
            return outIntersectionPoint;
        }
        else // This means that there is a line intersection but not a ray intersection.
        {
            return std::nullopt;
        }
    }
};

#endif // _LOS_COMMON_H
