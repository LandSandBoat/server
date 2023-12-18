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

#include "map.h"

namespace serverutils
{
    std::unordered_map<std::string, std::pair<int32, uint32>> serverVarCache;
    std::unordered_set<std::string>                           serverVarChanges;

    uint32 GetServerVar(std::string const& name)
    {
        int32 ret = _sql->Query("SELECT value, expiry FROM server_variables WHERE name = '%s' LIMIT 1;", name);

        int32  value  = 0;
        uint32 expiry = 0;
        if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
        {
            value  = _sql->GetIntData(0);
            expiry = _sql->GetUIntData(1);

            uint32 currentTimestamp = CVanaTime::getInstance()->getSysTime();

            if (expiry > 0 && expiry <= currentTimestamp)
            {
                value = 0;
                _sql->Query("DELETE FROM server_variables WHERE name = '%s';", name);
            }
        }

        serverVarCache[name] = { value, expiry };
        return value;
    }

    void SetServerVar(std::string const& name, int32 value, uint32 expiry /* = 0 */)
    {
        PersistServerVar(name, value, expiry);
    }

    void SetVolatileServerVar(std::string const& name, int32 value, uint32 expiry /* = 0 */)
    {
        serverVarCache[name] = { value, expiry };
        serverVarChanges.insert(name);
    }

    int32 GetVolatileServerVar(std::string const& name)
    {
        if (auto var = serverVarCache.find(name); var != serverVarCache.end())
        {
            std::pair cachedVarData    = var->second;
            uint32    currentTimestamp = CVanaTime::getInstance()->getSysTime();

            // If the cached variable is not expired, return it.  Else, fall through so that the
            // database can be cleaned up.
            if (cachedVarData.second == 0 || cachedVarData.second > currentTimestamp)
            {
                return cachedVarData.first;
            }
        }

        return GetServerVar(name);
    }

    int32 PersistVolatileServerVars(time_point tick, CTaskMgr::CTask* PTask)
    {
        if (serverVarChanges.empty())
        {
            return 0;
        }

        for (auto&& name : serverVarChanges)
        {
            auto   cachedServerVar = serverVarCache[name];
            int32  value           = cachedServerVar.first;
            uint32 varTimestamp    = cachedServerVar.second;

            if (value == 0)
            {
                // TODO: Re-enable async
                // async_work::doQuery("DELETE FROM server_variables WHERE name = '%s' LIMIT 1;", varName);
                _sql->Query("DELETE FROM server_variables WHERE name = '%s' LIMIT 1;", name);
            }
            else
            {
                // TODO: Re-enable async
                // async_work::doQuery("INSERT INTO server_variables VALUES ('%s', %i) ON DUPLICATE KEY UPDATE value = %i;", varName, value, value);
                _sql->Query("INSERT INTO server_variables VALUES ('%s', %i, %d) ON DUPLICATE KEY UPDATE value = %i, expiry = %d;", name, value, varTimestamp, value, varTimestamp);
            }
        }

        serverVarChanges.clear();

        return 0;
    }

    void PersistServerVar(std::string const& name, int32 value, uint32 expiry /* = 0 */)
    {
        int32 tries  = 0;
        int32 verify = INT_MIN;

        auto setVarMaxRetry = settings::get<uint8>("map.SETVAR_RETRY_MAX");

        do
        {
            tries++;
            verify = INT_MIN;

            if (value == 0)
            {
                _sql->Query("DELETE FROM server_variables WHERE name = '%s' LIMIT 1;", name);
            }
            else
            {
                _sql->Query("INSERT INTO server_variables VALUES ('%s', %i, %d) ON DUPLICATE KEY UPDATE value = %i, expiry = %d;", name, value, expiry, value, expiry);
            }

            if (setVarMaxRetry > 0)
            {
                // Cannot usleep(microseconds) or use std::this_thread::sleep_for(std::chrono::microseconds(usec))
                // because, you guessed it, DSP design.  Close inspection of other DSP code shows sleeping is not
                // something it does.  However, we actually get the same 'effect' by simply asking to read the
                // value that was written.  The access back to the DB is just a few milliseconds.  Down side is
                // that we have to give up at some point.
                // Also, don't use GetServerVariable, as that manipulates the Lua variable stack.
                if (_sql->Query("SELECT value FROM server_variables WHERE name = '%s' LIMIT 1;", name) != SQL_ERROR)
                {
                    if (_sql->NumRows() > 0)
                    {
                        // Can get it, so let's make sure it matches.
                        if (_sql->NextRow() == SQL_SUCCESS)
                        {
                            verify = _sql->GetIntData(0);
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
