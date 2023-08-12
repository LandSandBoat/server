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

#include <string>

#include "common/cbasetypes.h"
#include "common/sql.h"
#include "zone.h"

struct region_control_t
{
    uint8 current;
    uint8 prev;
};

struct influence_t
{
    uint16 sandoria_influence;
    uint16 bastok_influence;
    uint16 windurst_influence;
    uint16 beastmen_influence;
};

/**
 * Conquest Data that is cached by the map server. This data is used to avoid redundant DB reads.
 * Conquest data should be update periodically, as a result of influence / regional control updates
 * received by the world server's conquest system.
 */
class ConquestData
{
public:
    ConquestData(std::unique_ptr<SqlConnection>& sql);

    /**
     * Gets the influence points for a given nation in a given region.
     */
    int32 getInfluence(REGION_TYPE region, NATION_TYPE nation) const;

    /**
     * Gets the owner of a given region. That is, the one controlling this region since last tally.
     */
    uint8 getRegionOwner(REGION_TYPE region) const;

    /**
     * Gets the number of regions controlled by a given nation.
     */
    uint8 getRegionControlCount(NATION_TYPE nation) const;

    /**
     * Gets the number of regions controlled by a given nation in the
     * previous tally.
     */
    uint8 getPrevRegionControlCount(NATION_TYPE nation) const;

    /**
     * Gets the array of region controls, indexed by regionId.
     */
    auto getRegionControls() -> std::vector<region_control_t> const;

    /**
     * Adds the given influence points to the given nation for the given
     * region.
     */
    void addInfluencePoints(int points, NATION_TYPE nation, REGION_TYPE region);
    /**
     * Updates the influence points to match those given.
     */
    void updateInfluencePoints(std::vector<influence_t> const& influencePoints);

    /**
     * Updates region controls to match those given.
     */
    void updateRegionControls(std::vector<region_control_t> const& regionControls);

private:
    std::vector<region_control_t> regionControls;
    std::vector<influence_t>      influences;

    /**
     * Loads the latest conquest data from DB.
     * Should only ever be done on map initialization.
     * World server should be updating conquest data periodically.
     */
    void load(std::unique_ptr<SqlConnection>& sql);
};
