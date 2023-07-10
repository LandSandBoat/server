#ifndef SERVER_GOBLIN_BOX_DAILY_TALLY_H
#define SERVER_GOBLIN_BOX_DAILY_TALLY_H

#include "../common/sql.h"
#include "world_server.h"
#include <string>

namespace gobbiebox
{
    void UpdateDailyTallyPoints(WorldServer* worldServer);
}

#endif // SERVER_GOBLIN_BOX_DAILY_TALLY_H
