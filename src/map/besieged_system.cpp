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

#include "besieged_system.h"

namespace besieged
{
    uint8 GetAstralCandescence()
    {
        return STRONGHOLD::ALZAHBI;
    }

    uint8 GetAlZahbiOrders()
    {
        return ORDERS_ALZAHBI_DEFENSE;
    }

    uint8 GetMamookOrders()
    {
        return ORDERS_DEFEND;
    }

    uint8 GetMamookLevel()
    {
        return STRONGHOLD_LEVEL::LEVEL1;
    }

    uint8 GetMamookForces()
    {
        return 95;
    }

    uint8 GetMamookMirrors()
    {
        return 0;
    }

    uint8 GetMamookPrisoners()
    {
        return 0;
    }

    bool GetMamookMirrorDestroyed()
    {
        return 0;
    }

    uint8 GetHalvungOrders()
    {
        return ORDERS_DEFEND;
    }

    uint8 GetHalvungLevel()
    {
        return STRONGHOLD_LEVEL::LEVEL1;
    }

    uint8 GetHalvungForces()
    {
        return 95;
    }

    uint8 GetHalvungMirrors()
    {
        return 0;
    }

    uint8 GetHalvungPrisoners()
    {
        return 0;
    }

    bool GetHalvungMirrorDestroyed()
    {
        return 0;
    }

    uint8 GetArrapagoOrders()
    {
        return ORDERS_DEFEND;
    }

    uint8 GetArrapagoLevel()
    {
        return STRONGHOLD_LEVEL::LEVEL1;
    }

    uint8 GetArrapagoForces()
    {
        return 95;
    }

    uint8 GetArrapagoMirrors()
    {
        return 0;
    }

    uint8 GetArrapagoPrisoners()
    {
        return 0;
    }

    bool GetArrapagoMirrorDestroyed()
    {
        return 0;
    }
}; // namespace besieged
