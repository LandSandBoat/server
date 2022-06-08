/************************************************************************
* Economy Tracker
*
* Various queries, triggers, and tools to keep track of the economy of
* your server, to help track down dupes, cheats, abusers, RMT, etc.
*
* NOTE: There are new tables and triggers added in economy_tracker.sql!
* Make sure you run dbtool.py
 ************************************************************************/

#include "map/utils/moduleutils.h"

#include "common/cbasetypes.h"
#include "common/timer.h"
#include "map/message.h"
#include "map/utils/charutils.h"
#include "map/utils/itemutils.h"
#include "map/zone.h"

// TODO: Use these to hook incoming actions that relate to gil/trades/bazaar etc.:
// extern uint8 PacketSize[512];
// extern std::function<void(map_session_data_t* const, CCharEntity* const, CBasicPacket)> PacketParser[512];

class EconomyTrackerModule : public CPPModule
{
    time_point lastUpdate;

    void Update()
    {
        TracyZoneScoped;

        sql->Query(R"(
            INSERT INTO economy_total_gil (`timestamp`, total_gil)
            VALUES (
                NOW(),
                (SELECT SUM(quantity) from char_inventory where itemid = 65535 LIMIT 1)
            );
        )");

        lastUpdate = server_clock::now();
    }

    void OnInit() override
    {
        TracyZoneScoped;

        Update();
    }

    void OnTimeServerTick() override
    {
        TracyZoneScoped;

        if (server_clock::now() - lastUpdate > 15min)
        {
            Update();
        }
    }
};

REGISTER_CPP_MODULE(EconomyTrackerModule);
