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

#include "ship_handler.h"

#include "common/earth_time.h"
#include "common/enum_traits.h"

#include "data/loader.h"
#include "utils/zoneutils.h"
#include "zone.h"

#include <algorithm>
#include <stdexcept>

namespace
{

using ZoneSettingsDataset = xi::data::datasets::zones::settings::Dataset;

// Seconds into the current cycle.
auto cyclePosition(const uint32 now, const uint32 offset, const uint32 every) -> uint32
{
    return (now - offset) % every;
}

auto ownsZone(const CZone* PZone) -> bool
{
    return PZone && PZone->GetIP() != 0;
}

} // namespace

void ShipHandler::InitializeShips()
{
    if (!ships_.empty())
    {
        throw std::runtime_error("ships are already initialized");
    }

    // A run lives in the zone its ship docks in, but the crossing it feeds may be on another server.
    // Read every zone's file and keep whichever half is ours.
    for (const auto& [name, zoneId] : xi::data::EnumTraits<xi::ZoneId>::kEntries)
    {
        const auto settings = xi::data::loadZoneFile<ZoneSettingsDataset>(zoneId);
        if (!settings)
        {
            continue;
        }

        for (const auto& entry : settings->Transports)
        {
            registerShip(entry, zoneutils::GetZone(zoneId));
            registerVoyage(entry);
        }
    }
}

void ShipHandler::registerShip(const xi::data::TransportData& entry, CZone* PDockZone)
{
    if (!ownsZone(PDockZone))
    {
        return;
    }

    auto* PShip = dynamic_cast<CNpcEntity*>(zoneutils::GetEntity(entry.Ship, TYPE_SHIP));
    if (!PShip)
    {
        throw std::runtime_error(fmt::format("transport {} names ship {}, which is not in {}", entry.Name, entry.Ship, PDockZone->getName()));
    }

    CBaseEntity* PDoor = nullptr;
    if (!entry.Door.empty())
    {
        PDoor = zoneutils::GetNpcByName(PDockZone, entry.Door);
        if (!PDoor)
        {
            throw std::runtime_error(fmt::format("transport {} names door '{}', which is not in {}", entry.Name, entry.Door, PDockZone->getName()));
        }
    }

    // A ship only moves if some phase tells it to.
    const auto relocates = std::ranges::any_of(entry.Phases,
                                               [](const auto& phase)
                                               {
                                                   return !phase.Moves.empty();
                                               });

    Ship ship{
        .name      = entry.Name,
        .npc       = PShip,
        .door      = PDoor,
        .offset    = entry.Offset,
        .every     = entry.Every,
        .relocates = relocates,
        .phases    = entry.Phases,
    };

    ship.dock.zone     = PDockZone;
    ship.dock.p        = entry.Dock.value_or(position_t{});
    ship.dock.boundary = entry.Boundary;
    ship.dock.prevzone = [&]() -> xi::ZoneId
    {
        if (entry.Crossings.empty())
        {
            return xi::ZoneId::Unknown;
        }

        return entry.Crossings.front();
    }();

    // Start it at its berth so the phases only have to say when it leaves.
    // Decorative ships declare no berth and stay where the zone file put them.
    if (entry.Dock)
    {
        ship.moveTo(*entry.Dock);
    }

    ships_.emplace_back(std::move(ship));
}

void ShipHandler::registerVoyage(const xi::data::TransportData& entry)
{
    // No docked phase means the door never opens, so it carries nobody and the crossing is not ours to clear.
    const auto docked = std::ranges::find(entry.Phases, xi::TransportState::Docked, &Phase::State);
    if (docked == entry.Phases.end())
    {
        return;
    }

    // A ship whose destination is picked at boarding time names every zone it might cross.
    // Each one keeps its own schedule so it empties on the leg that fed it.
    for (const auto zoneId : entry.Crossings)
    {
        auto* PCrossing = zoneutils::GetZone(zoneId);
        if (!ownsZone(PCrossing))
        {
            continue;
        }

        if (!entry.Disembark)
        {
            throw std::runtime_error(fmt::format("transport {} carries riders through {} but states no disembark point", entry.Name, PCrossing->getName()));
        }

        voyages_.emplace_back(Voyage{
            .zone          = PCrossing,
            .offset        = entry.Offset,
            .every         = entry.Every,
            .disembarkFrom = entry.Disembark,
            .boardingEnds  = docked->End,
        });
    }
}

void ShipHandler::tick()
{
    const auto now = earth_time::vanadiel_timestamp();

    for (auto& ship : ships_)
    {
        const auto into = [&]() -> uint32
        {
            if (ship.every)
            {
                return cyclePosition(now, ship.offset, ship.every);
            }

            return now - ship.offset;
        }();
        const auto found = std::ranges::find_if(ship.phases,
                                                [&](const auto& phase)
                                                {
                                                    return into >= phase.Start && into < phase.End;
                                                });

        const auto index = static_cast<size_t>(found - ship.phases.begin());
        if (index != ship.phase)
        {
            ship.enter(index, now, into);
        }

        const auto intoPhase = into - ship.phases[*ship.phase].Start;

        ship.place(intoPhase);
        ship.conceal(intoPhase);
    }

    // Aboard from the moment boarding closes until they go ashore, a span that wraps past the end of the cycle on the airships.
    const auto carrying = [&](const Voyage& leg)
    {
        const auto into = cyclePosition(now, leg.offset, leg.every);
        if (leg.boardingEnds <= leg.disembarkFrom)
        {
            return into >= leg.boardingEnds && into < leg.disembarkFrom;
        }

        return into >= leg.boardingEnds || into < leg.disembarkFrom;
    };

    // Both directions cross the same zone, so it is only empty when neither leg has anyone aboard.
    // Check one leg alone and each direction throws the other's passengers out the moment they board.
    std::vector<CZone*> emptied;
    for (const auto& voyage : voyages_)
    {
        if (std::ranges::contains(emptied, voyage.zone))
        {
            continue;
        }

        const auto busy = std::ranges::any_of(voyages_,
                                              [&](const auto& leg)
                                              {
                                                  return leg.zone == voyage.zone && carrying(leg);
                                              });
        if (busy)
        {
            continue;
        }

        emptied.emplace_back(voyage.zone);
        voyage.zone->DisembarkAll();
    }
}
