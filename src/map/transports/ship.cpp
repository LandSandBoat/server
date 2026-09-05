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

#include "ship.h"

#include "utils/zoneutils.h"
#include "zone.h"

#include <algorithm>

namespace
{

// flags0, at 0x18 of the entity update.
// MovTime is how long the client takes to slide the model to the position we send.
// GroundFlag keeps it from being dropped onto the terrain, which every ship needs since they all float.
// Retail sends MovTime 1 for ships that never leave the berth, 6 to 9 for the ones that do.
constexpr uint16 kGroundFlag    = 0x8000;
constexpr uint16 kMovTimeStill  = 1;
constexpr uint16 kMovTimeMoving = 7;

} // namespace

void Ship::moveTo(const position_t& where) const
{
    this->npc->loc.p.x        = where.x;
    this->npc->loc.p.y        = where.y;
    this->npc->loc.p.z        = where.z;
    this->npc->loc.p.rotation = where.rotation;

    // Never despawned. Off schedule it waits at its staging spot.
    this->npc->status       = xi::Status::Normal;
    this->npc->loc.p.moving = kGroundFlag | [&]() -> uint16
    {
        if (this->relocates)
        {
            return kMovTimeMoving;
        }

        return kMovTimeStill;
    }();
}

void Ship::animate(const xi::Animation animation, const uint32 phaseStart) const
{
    this->npc->animation = animation;

    // The client plays forward from this stamp, so a ship met mid-phase picks the animation up part-way.
    this->npc->SetLocalVar("TransportTimestamp", phaseStart);
}

void Ship::setDoor(const xi::Animation animation) const
{
    if (this->door)
    {
        this->door->animation = animation;
    }
}

void Ship::swingDoor(const xi::Animation animation) const
{
    if (!this->door)
    {
        return;
    }

    this->setDoor(animation);
    this->dock.zone->UpdateEntityPacket(this->door, ENTITY_UPDATE, UPDATE_COMBAT, true);
}

void Ship::update() const
{
    this->dock.zone->UpdateEntityPacket(this->npc, ENTITY_UPDATE, UPDATE_COMBAT, true);
}

void Ship::enter(const size_t index, const uint32 now, const uint32 into)
{
    const auto  cycleStart = now - into;
    const auto& next       = this->phases[index];
    const auto  phaseStart = cycleStart + next.Start;

    // A docked ship is still playing the tail of its arrival, so it times from when arrival began.
    const auto arriving = std::ranges::find(this->phases, xi::TransportState::Arriving, &Phase::State);

    switch (next.State)
    {
        case xi::TransportState::Arriving:
        {
            this->animate(next.Animation, phaseStart);
            this->setDoor(xi::Animation::CloseDoor);
        }
        break;
        case xi::TransportState::Docked:
        {
            if (arriving != this->phases.end())
            {
                this->animate(arriving->Animation, cycleStart + arriving->Start);
            }

            this->swingDoor(xi::Animation::OpenDoor);
        }
        break;
        case xi::TransportState::Closing:
        {
            // Retail shuts the door a few seconds before getting under way, hence its own leg.
            if (arriving != this->phases.end())
            {
                this->animate(arriving->Animation, cycleStart + arriving->Start);
            }

            this->swingDoor(xi::Animation::CloseDoor);
        }
        break;
        case xi::TransportState::Departing:
        {
            this->animate(next.Animation, phaseStart);
            this->setDoor(xi::Animation::CloseDoor);

            // Boundary zero means "not in a sub-area", which covers all of Carpenters' Landing and Bibiki Bay.
            // The barge and the manaclipper board from it and work out who is really aboard themselves.
            this->dock.zone->TransportDepart(this->dock.boundary, this->dock.prevzone, this->name);
        }
        break;
        case xi::TransportState::Cycling:
        case xi::TransportState::Holding:
        {
            // Neither carries anyone, so both keep the berth and flags the zone gave them and only change what they play.
            // A holding ship is entered once, at startup, and stamps that moment.
            this->npc->status = xi::Status::Normal;
            const auto from   = [&]() -> uint32
            {
                if (next.State == xi::TransportState::Holding)
                {
                    return now;
                }

                return phaseStart;
            }();

            this->animate(next.Animation, from);
        }
        break;
    }

    this->phase = index;
    this->move.reset();
    this->update();
}

void Ship::conceal(const uint32 intoPhase)
{
    const auto& current = this->phases[*this->phase];
    const auto  away    = current.Hide && intoPhase >= *current.Hide;
    if (away == this->hidden)
    {
        return;
    }

    // Status lands in flags1, where Disappear is the bit the client reads as HideFlag.
    this->hidden      = away;
    this->npc->status = [&]() -> xi::Status
    {
        if (away)
        {
            return xi::Status::Disappear;
        }

        return xi::Status::Normal;
    }();
    this->update();
}

void Ship::place(const uint32 intoPhase)
{
    const auto& moves = this->phases[*this->phase].Moves;

    std::optional<size_t> wanted;
    for (size_t step = 0; step < moves.size(); ++step)
    {
        if (intoPhase >= moves[step].After)
        {
            wanted = step;
        }
    }

    // A phase with no move leaves the ship where the last one put it.
    // Retail is the same: a position only goes out when the ship actually goes somewhere.
    if (!wanted || wanted == this->move)
    {
        return;
    }

    this->move = wanted;
    this->moveTo(moves[*wanted].Where);
    this->update();
}
