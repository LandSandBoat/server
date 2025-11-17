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

  This file is part of DarkStar-server source code.

===========================================================================
*/

#include <chrono>
#include <iostream>
#include <time.h>
#include <unordered_map>
#include <unordered_set>

#include "utils/serverutils.h"

#include "common/database.h"

namespace serverutils
{

std::unordered_map<std::string, std::pair<int32, uint32>> serverVarCache;
std::unordered_set<std::string>                           serverVarChanges;

uint32 GetServerVar(const std::string& name)
{
    const auto rset = db::preparedStmt("SELECT value, expiry FROM server_variables WHERE name = ? LIMIT 1", name);

    int32  value  = 0;
    uint32 expiry = 0;
    if (rset && rset->rowsCount() > 0 && rset->next())
    {
        value  = rset->get<int32>("value");
        expiry = rset->get<uint32>("expiry");

        if (expiry > 0 && expiry <= earth_time::timestamp())
        {
            value = 0;
            db::preparedStmt("DELETE FROM server_variables WHERE name = ? LIMIT 1", name);
        }
    }

    serverVarCache[name] = { value, expiry };
    return value;
}

void SetServerVar(const std::string& name, int32 value, uint32 expiry /* = 0 */)
{
    PersistServerVar(name, value, expiry);
}

void SetVolatileServerVar(const std::string& name, int32 value, uint32 expiry /* = 0 */)
{
    serverVarCache[name] = { value, expiry };
    serverVarChanges.insert(name);
}

int32 GetVolatileServerVar(const std::string& name)
{
    if (auto var = serverVarCache.find(name); var != serverVarCache.end())
    {
        std::pair cachedVarData = var->second;

        // If the cached variable is not expired, return it.  Else, fall through so that the
        // database can be cleaned up.
        if (cachedVarData.second == 0 || cachedVarData.second > earth_time::timestamp())
        {
            return cachedVarData.first;
        }
    }

    return GetServerVar(name);
}

int32 PersistVolatileServerVars(timer::time_point tick, CTaskManager::CTask* PTask)
{
    if (serverVarChanges.empty())
    {
        return 0;
    }

    for (const auto& name : serverVarChanges)
    {
        auto   cachedServerVar = serverVarCache[name];
        int32  value           = cachedServerVar.first;
        uint32 varTimestamp    = cachedServerVar.second;

        if (value == 0)
        {
            db::preparedStmt("DELETE FROM server_variables WHERE name = ? LIMIT 1", name);
        }
        else
        {
            db::preparedStmt("INSERT INTO server_variables VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE value = ?, expiry = ?", name, value, varTimestamp, value, varTimestamp);
        }
    }

    serverVarChanges.clear();

    return 0;
}

void PersistServerVar(const std::string& name, int32 value, uint32 expiry /* = 0 */)
{
    int32 tries  = 0;
    int32 verify = INT_MIN;

    const auto setVarMaxRetry = settings::get<uint8>("map.SETVAR_RETRY_MAX");

    do
    {
        tries++;
        verify = INT_MIN;

        if (value == 0)
        {
            db::preparedStmt("DELETE FROM server_variables WHERE name = ? LIMIT 1", name);
        }
        else
        {
            db::preparedStmt("INSERT INTO server_variables VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE value = ?, expiry = ?", name, value, expiry, value, expiry);
        }

        if (setVarMaxRetry > 0)
        {
            const auto rset = db::preparedStmt("SELECT value FROM server_variables WHERE name = ? LIMIT 1", name);
            if (rset)
            {
                if (rset->rowsCount() > 0)
                {
                    // Can get it, so let's make sure it matches.
                    if (rset->next())
                    {
                        verify = rset->get<int32>("value");
                    }
                }
                else
                {
                    // Can't get it, but if it were 0, that's what we want.
                    if (value == 0)
                    {
                        verify = value;
                    }
                }
            }
        }
        else
        {
            break;
        }
    } while (verify != value && tries < setVarMaxRetry);
}

} // namespace serverutils
