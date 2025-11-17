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
    if (!settings::get<bool>("main.ENABLE_DAILY_TALLY"))
    {
        return;
    }
    int32 dailyTallyLimit  = std::clamp<int32>(settings::get<int32>("main.DAILY_TALLY_LIMIT"), std::numeric_limits<uint16>::min(), std::numeric_limits<uint16>::max());
    int32 dailyTallyAmount = std::clamp<int32>(settings::get<int32>("main.DAILY_TALLY_AMOUNT"), std::numeric_limits<uint16>::min(), std::numeric_limits<uint16>::max());

    if (!db::preparedStmt("UPDATE char_points "
                          "SET char_points.daily_tally = LEAST(?, char_points.daily_tally + ?) "
                          "WHERE char_points.daily_tally > -1",
                          dailyTallyLimit,
                          dailyTallyAmount))
    {
        ShowErrorFmt("Failed to update daily tally points");
    }
    else
    {
        ShowDebugFmt("Distributed daily tally points");
    }

    if (!db::preparedStmt("DELETE FROM char_vars WHERE varname = 'gobbieBoxUsed'"))
    {
        ShowErrorFmt("Failed to delete daily tally char_vars entries");
    }
}

} // namespace dailytally
