/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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
#include "common/database.h"
#include "common/ipp.h"
#include "common/logging.h"

#include <set>
#include <unordered_map>
#include <vector>

class ZoneSettings final
{
private:
    struct ZoneSettingsEntry final
    {
        uint16 zoneid{};
        IPP    ipp{};
        uint32 misc{};
    };

public:
    ZoneSettings()
    {
        const auto rset = db::preparedStmt("SELECT zoneid, zoneip, zoneport, misc FROM zone_settings");
        if (!rset)
        {
            ShowCritical("Error loading zone settings from DB");
            throw std::runtime_error("Message Server: Failed to load zone settings from database");
        }

        // Keep track of the zones, as well as a list of unique ip / port combinations.
        std::set<IPP> mapEndpointSet;
        std::set<IPP> yellMapEndpointSet;

        while (rset->next())
        {
            uint64 ip   = str2ip(rset->get<std::string>("zoneip"));
            uint64 port = rset->get<uint64>("zoneport");

            ZoneSettingsEntry zone_settings{};
            zone_settings.zoneid = rset->get<uint16>("zoneid");
            zone_settings.ipp    = IPP(ip, port);
            zone_settings.misc   = rset->get<uint32>("misc");

            mapEndpointSet.insert(zone_settings.ipp);

            if (zone_settings.misc & ZONEMISC::MISC_YELL)
            {
                yellMapEndpointSet.insert(zone_settings.ipp);
            }

            zoneSettingsMap_[zone_settings.zoneid] = zone_settings;
        }

        std::copy(mapEndpointSet.begin(), mapEndpointSet.end(), std::back_inserter(mapEndpoints_));
        std::copy(yellMapEndpointSet.begin(), yellMapEndpointSet.end(), std::back_inserter(yellMapEndpoints_));
    }

    // TODO: Properly encapsulate this
    // private:
    std::unordered_map<uint16, ZoneSettingsEntry> zoneSettingsMap_;
    std::vector<IPP>                              mapEndpoints_;
    std::vector<IPP>                              yellMapEndpoints_;
};
