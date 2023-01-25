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

#ifndef _ZONE_LOS_H
#define _ZONE_LOS_H

#include "common/mmo.h"
#include "los_tree.h"

class CBaseEntity;

class ZoneLos
{
public:
    static ZoneLos* Load(uint16 zoneId, std::string pathToObj);

    bool CanEntitySee(CBaseEntity* source, CBaseEntity* target) const;
    bool CanEntitySee(CBaseEntity* source, position_t const& targetPointBase) const;

    std::optional<Vector3D> Raycast(CBaseEntity* source, CBaseEntity* target) const;
    std::optional<Vector3D> Raycast(position_t const& source, position_t const& target) const;

private:
    ZoneLos(Triangle* elements, int elementCount);

    std::optional<Vector3D> DoesRayCollide(Vector3D rayOrigin, Vector3D rayEnd) const;

    LosTree tree;
};

#endif // _ZONE_LOS_H
