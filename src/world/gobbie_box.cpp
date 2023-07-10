#include "gobbie_box.h"

namespace gobbiebox
{
    void UpdateDailyTallyPoints(WorldServer* worldServer)
    {
        uint16 dailyTallyLimit  = settings::get<uint16>("main.DAILY_TALLY_LIMIT");
        uint16 dailyTallyAmount = settings::get<uint16>("main.DAILY_TALLY_AMOUNT");

        const char* fmtQuery = "UPDATE char_points \
            SET char_points.daily_tally = LEAST(%u, char_points.daily_tally + %u) \
            WHERE char_points.daily_tally > -1;";

        int32 ret = worldServer->sql->Query(fmtQuery, dailyTallyLimit, dailyTallyAmount);

        if (ret == SQL_ERROR)
        {
            ShowError("Failed to update daily tally points");
        }
        else
        {
            ShowDebug("Distributed daily tally points");
        }

        fmtQuery = "DELETE FROM char_vars WHERE varname = 'gobbieBoxUsed';";

        if (worldServer->sql->Query(fmtQuery, dailyTallyAmount) == SQL_ERROR)
        {
            ShowError("Failed to delete daily tally char_vars entries");
        }
    }
} // namespace gobbiebox
