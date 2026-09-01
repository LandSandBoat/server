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

#include "data/enums/elevator.h"
#include "data/enums/elevator_state.h"
#include "entities/npc_entity.h"

// A platform between two floors. A timed lift runs itself off the clock, a lever one waits to be pulled.
struct Elevator
{
    xi::Elevator      id{};                 // the lever that drives it, or timed_automatic when it runs itself
    xi::ElevatorState state{};              // which floor it is at, or which way it is moving
    xi::ZoneId        zoneID{};             // zone the platform and both doors live in
    uint64            legStarted{};         // milliseconds since the Vana'diel epoch, when the current leg began
    uint32            period{};             // how long a leg takes, in milliseconds because retail runs them on fractions of a second
    uint32            movetime{};           // seconds between floors, which is also what the client animates against
    uint32            doorDelay{};          // milliseconds the shut door waits before the platform leaves
    CNpcEntity*       platform{};           // the floor that carries players
    CNpcEntity*       lowerDoor{};          // door at the bottom of the shaft
    CNpcEntity*       upperDoor{};          // door at the top
    bool              activated{};          // whether it is mid-leg; a lever lift falls back to false once it arrives
    bool              isPermanent{};        // timed lifts never stop, so they realign to the clock instead of to the pull
    bool              animationsReversed{}; // some shafts play the up animation to go down

    // Set the appropriate animation and broadcast it
    void closeDoor(CNpcEntity* PDoor) const;
    void openDoor(CNpcEntity* PDoor) const;
};
