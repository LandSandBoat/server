/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "guildutils.h"

#include "common/database.h"
#include "common/logging.h"
#include "common/vana_time.h"

#include <vector>

#include "items/item_shop.h"

#include "charutils.h"
#include "guild.h"
#include "item_container.h"
#include "itemutils.h"
#include "serverutils.h"

std::vector<CGuild*> g_PGuildList;

namespace guildutils
{

void Initialize()
{
    auto rset = db::preparedStmt("SELECT DISTINCT id, points_name FROM guilds ORDER BY id ASC");
    if (rset)
    {
        g_PGuildList.reserve(rset->rowsCount());
    }

    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        g_PGuildList.emplace_back(new CGuild(rset->get<uint8>("id"), rset->get<std::string>("points_name")));
    }

    UpdateGuildPointsPattern();
}

void Cleanup()
{
    // Delete pointers and cleanup vectors manually
    for (auto guild : g_PGuildList)
    {
        destroy(guild);
    }

    g_PGuildList.clear();
}

void UpdateGuildPointsPattern()
{
    // TODO: This function can be faulty when dealing with multiple processes. Needs to be synchronized properly across servers.
    const auto jstDayOfYear = earth_time::jst::get_yearday();
    const bool doUpdate     = serverutils::GetServerVar("[GUILD]pattern_update") != jstDayOfYear;

    uint8 pattern = xirand::GetRandomNumber(8);
    if (doUpdate)
    {
        // write the new pattern and update time to try to prevent other servers from updating the pattern
        serverutils::SetServerVar("[GUILD]pattern_update", jstDayOfYear);
        serverutils::SetServerVar("[GUILD]pattern", pattern);
    }
    else
    {
        // load the pattern in case it was set by another server (and this server did not set it)
        pattern = serverutils::GetServerVar("[GUILD]pattern");
    }

    for (const auto PGuild : g_PGuildList)
    {
        PGuild->updateGuildPointsPattern(pattern);
    }

    ShowDebug("Guild point pattern update has finished. New pattern: %d", pattern);
}

auto GetGuild(const uint8 guildId) -> CGuild*
{
    if (guildId < g_PGuildList.size())
    {
        return g_PGuildList.at(guildId);
    }

    ShowDebug("Guild with id <%u> is not found on server", guildId);
    return nullptr;
}

} // namespace guildutils
