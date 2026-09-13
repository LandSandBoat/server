/************************************************************************
 *
 * Phoenix Population-Based Level Sync Penalty Module
 *
 * This module provides a C++ function to query online player count
 * and exposes it to Lua for use in the penalty calculation system.
 *
 ************************************************************************/

#include "common/database.h"
#include "common/lua.h"
#include "map/utils/moduleutils.h"

class PopulationSyncPenaltyModule : public CPPModule
{
public:
    void OnInit() override
    {
        // Counts sessions, so stale rows after a crash can inflate the number
        ::lua.set_function("GetOnlinePlayerCount", []() -> uint32
                           {
                               auto rset = db::preparedStmt("SELECT COUNT(*) AS count FROM accounts_sessions");
                               if (rset && rset->next())
                               {
                                   return rset->get<uint32>("count");
                               }

                               return 0;
                           });
    }
};

REGISTER_CPP_MODULE(PopulationSyncPenaltyModule);
