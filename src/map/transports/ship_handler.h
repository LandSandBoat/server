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

#include "common/singleton.h"

#include "data/datasets/zones/settings/dataset.h"
#include "ship.h"
#include "voyage.h"

#include <vector>

class CZone;

class ShipHandler : public Singleton<ShipHandler>
{
public:
    void InitializeShips();
    void tick();

protected:
    ShipHandler() = default;

private:
    void registerShip(const xi::data::TransportData& entry, CZone* PDockZone);
    void registerVoyage(const xi::data::TransportData& entry);

    std::vector<Ship>   ships_;
    std::vector<Voyage> voyages_;
};
