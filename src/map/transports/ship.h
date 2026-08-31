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

#include "data/datasets/zones/settings/dataset.h"
#include "entities/npc_entity.h"

#include <optional>
#include <string>
#include <vector>

using Phase = xi::data::TransportPhaseData;

// One scheduled run. Several can share a ship, each taking its turn through the offset.
struct Ship
{
    std::string  name;        // passed to onTransportEvent so a zone can tell its legs apart
    CNpcEntity*  npc{};       // the ship
    CBaseEntity* door{};      // boarding door, null if the run carries nobody
    location_t   dock{};      // berth, boarding area, and the crossing it feeds
    uint32       offset{};    // shifts the cycle so runs sharing a ship take their turn
    uint32       every{};     // cycle length in seconds
    bool         relocates{}; // does it ever leave the berth; decides its MovTime

    std::vector<Phase>    phases;   // the cycle in order, from the offset
    std::optional<size_t> phase;    // phase we are in, unset until the first tick
    std::optional<size_t> move;     // last move applied in that phase
    bool                  hidden{}; // true once we tell the client to stop drawing it

    void moveTo(const position_t& where) const;
    void animate(xi::Animation animation, uint32 phaseStart) const;
    void setDoor(xi::Animation animation) const;   // quietly agree with the schedule, for a cold start with nobody watching
    void swingDoor(xi::Animation animation) const; // the two swings a cycle retail actually sends
    void update() const;

    void enter(size_t index, uint32 now, uint32 into); // apply everything a phase implies, so a cold start lands in the right state
    void place(uint32 intoPhase);                      // retail moves a ship mid-phase as often as at its start, so position is tracked apart from state
    void conceal(uint32 intoPhase);                    // stop drawing it once the departure animation has carried it out of sight
};
