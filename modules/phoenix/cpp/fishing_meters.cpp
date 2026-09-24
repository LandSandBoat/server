/************************************************************************
 * Fishing Meters
 *
 * Hands the fishing system its daily point and fatigue storage, which lives
 * in account_vars. Needs the fishing patch applied, which adds the
 * registration point.
 ************************************************************************/

#include "account_vars.h"

#include "map/utils/fishingutils.h"
#include "map/utils/moduleutils.h"

class FishingMetersModule : public CPPModule
{
    void OnInit() override
    {
        TracyZoneScoped;

        fishingutils::SetAccountMeterAccess(accountvars::fetchAccountVar, accountvars::persistAccountVar);
    }
};

REGISTER_CPP_MODULE(FishingMetersModule);
