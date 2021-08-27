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

#include "blacklistutils.h"
#include "../../common/utils.h"
#include "../entities/charentity.h"
#include "../map.h"

#include "../packets/stop_downloading.h"

namespace blacklistutils
{
    bool IsBlacklisted(uint32 ownerId, uint32 targetId)
    {
        const char* sql = "SELECT * FROM char_blacklist WHERE charid_owner = %u AND charid_target = %u;";
        int32       ret = Sql_Query(SqlHandle, sql, ownerId, targetId);

        return (ret != SQL_ERROR && Sql_NumRows(SqlHandle) == 1);
    }

    bool AddBlacklisted(uint32 ownerId, uint32 targetId)
    {
        if (IsBlacklisted(ownerId, targetId))
        {
            return false;
        }

        const char* sql = "INSERT INTO char_blacklist (charid_owner, charid_target) VALUES (%u, %u);";
        return (Sql_Query(SqlHandle, sql, ownerId, targetId) != SQL_ERROR && Sql_AffectedRows(SqlHandle) == 1);
    }

    bool DeleteBlacklisted(uint32 ownerId, uint32 targetId)
    {
        if (!IsBlacklisted(ownerId, targetId))
        {
            return false;
        }

        const char* sql = "DELETE FROM char_blacklist WHERE charid_owner = %u AND charid_target = %u;";
        return (Sql_Query(SqlHandle, sql, ownerId, targetId) != SQL_ERROR && Sql_AffectedRows(SqlHandle) == 1);
    }

    void SendBlacklist(CCharEntity* PChar)
    {
        std::vector<std::pair<uint32, string_t>> blacklist;

        // Obtain this users blacklist info..
        const char* sql = "SELECT c.charid, c.charname FROM char_blacklist AS b INNER JOIN chars AS c ON b.charid_target = c.charid WHERE charid_owner = %u;";
        if (Sql_Query(SqlHandle, sql, PChar->id) == SQL_ERROR || Sql_NumRows(SqlHandle) == 0)
        {
            PChar->pushPacket(new CStopDownloadingPacket(PChar, blacklist));
            return;
        }

        // Loop and build blacklist..
        int currentCount = 0;
        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            uint32   accid_target = Sql_GetUIntData(SqlHandle, 0);
            string_t targetName   = (const char*)(Sql_GetData(SqlHandle, 1));

            blacklist.emplace_back(accid_target, targetName);
            currentCount++;

            if (currentCount >= 12)
            {
                PChar->pushPacket(new CStopDownloadingPacket(PChar, blacklist));
                blacklist.clear();
                currentCount = 0;
            }
        }

        // Push remaining entries..
        if (!blacklist.empty())
        {
            PChar->pushPacket(new CStopDownloadingPacket(PChar, blacklist));
        }
    }

} // namespace blacklistutils
