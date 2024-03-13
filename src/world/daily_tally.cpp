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

#include "daily_tally.h"

#include "common/cbasetypes.h"
#include "common/database.h"
#include "common/logging.h"
#include "common/settings.h"

namespace dailytally
{
    void UpdateDailyTallyPoints()
    {
        uint16 dailyTallyLimit  = settings::get<uint16>("main.DAILY_TALLY_LIMIT");
        uint16 dailyTallyAmount = settings::get<uint16>("main.DAILY_TALLY_AMOUNT");

        const char* fmtQuery = "UPDATE char_points \
            SET char_points.daily_tally = LEAST(%u, char_points.daily_tally + %u) \
            WHERE char_points.daily_tally > -1;";

        if (!db::query(fmt::sprintf(fmtQuery, dailyTallyLimit, dailyTallyAmount)))
        {
            ShowError("Failed to update daily tally points");
        }
        else
        {
            ShowDebug("Distributed daily tally points");
        }

        if (!db::query("DELETE FROM char_vars WHERE varname = 'gobbieBoxUsed';"))
        {
            ShowError("Failed to delete daily tally char_vars entries");
        }
    }
} // namespace dailytally
