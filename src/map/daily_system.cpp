#include "daily_system.h"

#include "map.h"

namespace daily
{
void UpdateDailyTallyPoints()
{
    uint16 dailyTallyLimit  = map_config.daily_tally_limit;
    uint16 dailyTallyAmount = map_config.daily_tally_amount;

    const char* fmtQuery = "UPDATE char_points \
            SET char_points.daily_tally = LEAST(%u, char_points.daily_tally + %u) \
            WHERE char_points.daily_tally > -1;";

    int32 ret = Sql_Query(SqlHandle, fmtQuery, dailyTallyLimit, dailyTallyAmount);

    if (ret == SQL_ERROR)
    {
        ShowError("Failed to update daily tally points\n");
    }
    else
    {
        ShowDebug("Distributed daily tally points\n");
    }

    fmtQuery = "DELETE FROM char_vars WHERE varname = 'gobbieBoxUsed';";

    if (Sql_Query(SqlHandle, fmtQuery, dailyTallyAmount) == SQL_ERROR)
    {
        ShowError("Failed to delete daily tally char_vars entries");
    }
}
}