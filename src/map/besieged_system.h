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

#include "common/cbasetypes.h"

namespace besieged
{
// TODO: enum class all of these:
// Besieged Orders - Players
#define ORDERS_ALZAHBI_DEFENSE    0x00 // Defend Al Zahbi.
#define ORDERS_ALZAHBI_INTERCEPT  0x01 // Intercept enemy forces.
#define ORDERS_ALZAHBI_INFILTRATE 0x02 // Infiltrate enemy base.

// Besieged Orders - Beastmen
#define ORDERS_TRAIN   0x00
#define ORDERS_ADVANCE 0x01
#define ORDERS_ATTACK  0x02
#define ORDERS_RETREAT 0x03
#define ORDERS_DEFEND  0x04
#define ORDERS_PREPARE 0x05

    typedef enum SH
    {
        ALZAHBI,
        MAMOOK,
        HALVUNG,
        ARRAPAGO,
    } STRONGHOLD;

    enum STRONGHOLD_LEVEL
    {
        LEVEL0,
        LEVEL1,
        LEVEL2,
        LEVEL3,
        LEVEL4,
        LEVEL5,
        LEVEL6,
        LEVEL7,
        LEVEL8,
    };

    // Return the owner of the Astral Candescence
    uint8 GetAstralCandescence();
    uint8 GetAlZahbiOrders();

    uint8 GetMamookOrders();
    uint8 GetMamookLevel();
    uint8 GetMamookForces();
    uint8 GetMamookMirrors();
    uint8 GetMamookPrisoners();
    bool  GetMamookMirrorDestroyed();

    uint8 GetHalvungOrders();
    uint8 GetHalvungLevel();
    uint8 GetHalvungForces();
    uint8 GetHalvungMirrors();
    uint8 GetHalvungPrisoners();
    bool  GetHalvungMirrorDestroyed();

    uint8 GetArrapagoOrders();
    uint8 GetArrapagoLevel();
    uint8 GetArrapagoForces();
    uint8 GetArrapagoMirrors();
    uint8 GetArrapagoPrisoners();
    bool  GetArrapagoMirrorDestroyed();
}; // namespace besieged
