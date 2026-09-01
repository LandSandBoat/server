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

#include "elevator_handler.h"

#include "common/earth_time.h"

#include <algorithm>
#include <stdexcept>

#include "utils/zoneutils.h"
#include "zone.h"

namespace
{

void closeStandingDoor(Elevator* elevator)
{
    if (elevator->state == xi::ElevatorState::Top)
    {
        elevator->closeDoor(elevator->upperDoor);
    }
    else if (elevator->state == xi::ElevatorState::Bottom)
    {
        elevator->closeDoor(elevator->lowerDoor);
    }
}

void start(Elevator* elevator)
{
    const auto now = earth_time::vanadiel_timestamp_ms();

    switch (elevator->state)
    {
        case xi::ElevatorState::Top: // Elevator is now descending
        {
            elevator->state               = xi::ElevatorState::Descend;
            elevator->platform->animation = [&]() -> xi::Animation
            {
                if (elevator->animationsReversed)
                {
                    return xi::Animation::ElevatorUp;
                }

                return xi::Animation::ElevatorDown;
            }();
        }
        break;
        case xi::ElevatorState::Bottom: // Elevator is now ascending
        {
            elevator->state               = xi::ElevatorState::Ascend;
            elevator->platform->animation = [&]() -> xi::Animation
            {
                if (elevator->animationsReversed)
                {
                    return xi::Animation::ElevatorDown;
                }

                return xi::Animation::ElevatorUp;
            }();
        }
        break;
        default:
            return;
    }

    if (elevator->isPermanent)
    {
        // Timed lifts follow the clock, not whenever they last ran.
        elevator->legStarted = now - (now % elevator->period);
    }
    else
    {
        elevator->legStarted = now;
        elevator->activated  = true;
    }

    // The wire field is whole seconds.
    elevator->platform->SetLocalVar("TransportTimestamp", static_cast<uint32>(elevator->legStarted / 1000));

    zoneutils::GetZone(elevator->zoneID)->UpdateEntityPacket(elevator->platform, ENTITY_UPDATE, UPDATE_COMBAT, true);
}

void arrive(Elevator* elevator)
{
    if (!elevator->isPermanent)
    {
        elevator->activated = false;
    }

    elevator->state = [&]() -> xi::ElevatorState
    {
        if (elevator->state == xi::ElevatorState::Ascend)
        {
            return xi::ElevatorState::Top;
        }

        return xi::ElevatorState::Bottom;
    }();

    if (elevator->state == xi::ElevatorState::Bottom)
    {
        elevator->openDoor(elevator->lowerDoor);
    }
    else
    {
        elevator->openDoor(elevator->upperDoor);
    }
}

} // namespace

void ElevatorHandler::addElevator(const xi::ZoneId zoneId, CNpcEntity* PPlatform, const xi::data::ElevatorData& lift)
{
    auto* PZone      = zoneutils::GetZone(zoneId);
    auto* PLowerDoor = zoneutils::GetNpcByName(PZone, lift.LowerDoor);
    auto* PUpperDoor = zoneutils::GetNpcByName(PZone, lift.UpperDoor);
    if (!PLowerDoor || !PUpperDoor)
    {
        throw std::runtime_error(fmt::format("elevator {} in {} names doors '{}' and '{}', which the zone does not both hold",
                                             PPlatform->getName(),
                                             PZone->getName(),
                                             lift.LowerDoor,
                                             lift.UpperDoor));
    }

    const auto known = elevators_.read([&](const auto& lifts)
                                       {
                                           return std::ranges::any_of(lifts,
                                                                      [&](const auto& existing)
                                                                      {
                                                                          return existing.zoneID == zoneId && existing.platform->getName() == PPlatform->getName();
                                                                      });
                                       });
    if (known)
    {
        throw std::runtime_error(fmt::format("elevator {} in {} is declared twice", PPlatform->getName(), PZone->getName()));
    }

    Elevator elevator{
        .id                 = lift.Lever,
        .zoneID             = zoneId,
        .period             = lift.Period,
        .movetime           = lift.Travel,
        .doorDelay          = lift.DoorDelay,
        .platform           = PPlatform,
        .lowerDoor          = PLowerDoor,
        .upperDoor          = PUpperDoor,
        .activated          = lift.Lever == xi::Elevator::TimedAutomatic,
        .isPermanent        = lift.Lever == xi::Elevator::TimedAutomatic,
        .animationsReversed = lift.Reversed,
    };

    elevator.platform->setAlwaysRelevant(true);
    elevator.platform->SetLocalVar("TransportTravel", elevator.movetime);
    elevator.lowerDoor->setAlwaysRelevant(true);
    elevator.upperDoor->setAlwaysRelevant(true);

    // A timed lift lines its first leg up with the clock. A lever one waits to be pulled.
    const auto now = earth_time::vanadiel_timestamp_ms();
    if (elevator.period)
    {
        elevator.legStarted = now - (now % elevator.period) + elevator.period;
    }
    else
    {
        elevator.legStarted = now;
    }

    // Whichever way the data has the platform facing is the floor it starts on.
    if (elevator.platform->animation == xi::Animation::ElevatorDown)
    {
        elevator.state = xi::ElevatorState::Bottom;
    }
    else if (elevator.platform->animation == xi::Animation::ElevatorUp)
    {
        elevator.state = xi::ElevatorState::Top;
    }
    else
    {
        throw std::runtime_error(fmt::format("elevator {} rests on animation {}, which is neither of the two a platform can hold",
                                             elevator.platform->getName(),
                                             static_cast<uint32>(elevator.platform->animation)));
    }

    // Inconsistant animations throughout the elevators
    if (elevator.animationsReversed)
    {
        elevator.state = [&]() -> xi::ElevatorState
        {
            if (elevator.state == xi::ElevatorState::Top)
            {
                return xi::ElevatorState::Bottom;
            }

            return xi::ElevatorState::Top;
        }();
    }

    // Put the doors right whatever the data says.
    const auto atTop = elevator.state == xi::ElevatorState::Top;

    elevator.lowerDoor->animation = [&]() -> xi::Animation
    {
        if (atTop)
        {
            return xi::Animation::CloseDoor;
        }

        return xi::Animation::OpenDoor;
    }();

    elevator.upperDoor->animation = [&]() -> xi::Animation
    {
        if (atTop)
        {
            return xi::Animation::OpenDoor;
        }

        return xi::Animation::CloseDoor;
    }();

    elevators_.write([&](auto& lifts)
                     {
                         lifts.emplace_back(elevator);
                     });
}

void ElevatorHandler::tick()
{
    const auto now = earth_time::vanadiel_timestamp_ms();

    elevators_.write([&](auto& lifts)
                     {
                         for (auto& elevator : lifts)
                         {
                             if (!elevator.activated)
                             {
                                 continue;
                             }

                             switch (elevator.state)
                             {
                                 case xi::ElevatorState::Top:
                                 case xi::ElevatorState::Bottom:
                                 {
                                     // The leg is timed end to end, so the wait at the floor is whatever travel leaves over.
                                     if (elevator.isPermanent && now + elevator.doorDelay >= elevator.legStarted + elevator.period)
                                     {
                                         closeStandingDoor(&elevator);
                                     }

                                     if (now >= elevator.legStarted + elevator.period)
                                     {
                                         start(&elevator);
                                     }
                                 }
                                 break;
                                 case xi::ElevatorState::Ascend:
                                 case xi::ElevatorState::Descend:
                                 {
                                     if (now >= elevator.legStarted + elevator.movetime * 1000)
                                     {
                                         arrive(&elevator);
                                     }
                                 }
                                 break;
                                 default:
                                 {
                                     ShowErrorFmt("Unexpected state reached for elevator {}", elevator.platform->id);
                                 }
                                 break;
                             }
                         }
                     });
}

auto ElevatorHandler::elevatorState(const xi::Elevator elevatorID) -> std::optional<xi::ElevatorState>
{
    return elevators_.read([&](const auto& lifts) -> std::optional<xi::ElevatorState>
                           {
                               for (const auto& elevator : lifts)
                               {
                                   if (elevator.id == elevatorID)
                                   {
                                       return elevator.state;
                                   }
                               }

                               return std::nullopt;
                           });
}

void ElevatorHandler::startElevator(const xi::Elevator elevatorID)
{
    elevators_.write([&](auto& lifts)
                     {
                         for (auto& elevator : lifts)
                         {
                             if (elevator.id == elevatorID)
                             {
                                 if (elevator.activated)
                                 {
                                     return;
                                 }

                                 closeStandingDoor(&elevator);

                                 elevator.legStarted = earth_time::vanadiel_timestamp_ms() + elevator.doorDelay;
                                 elevator.activated  = true;
                                 return;
                             }
                         }
                     });
}
