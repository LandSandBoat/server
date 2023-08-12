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
    std::unordered_map<std::string, int32> serverVarCache;
    std::unordered_set<std::string>        serverVarChanges;

    int32 GetServerVar(std::string const& name)
    {
        int32 value = 0;

        int32 ret = sql->Query("SELECT value FROM server_variables WHERE name = '%s' LIMIT 1;", name);

        if (ret != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
        {
            value = sql->GetIntData(0);
        }

        serverVarCache[name] = value;
        return value;
    }

    void SetServerVar(std::string const& name, int32 value)
    {
        PersistServerVar(name, value);
    }

    void SetVolatileServerVar(std::string const& name, int32 value)
    {
        serverVarCache[name] = value;
        serverVarChanges.insert(name);
    }

    int32 GetVolatileServerVar(std::string const& name)
    {
        if (auto var = serverVarCache.find(name); var != serverVarCache.end())
        {
            return var->second;
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
            auto value = serverVarCache[name];
            if (value == 0)
            {
                // TODO: Re-enable async
                // async_work::doQuery("DELETE FROM server_variables WHERE name = '%s' LIMIT 1;", varName);
                sql->Query("DELETE FROM server_variables WHERE name = '%s' LIMIT 1;", name);
            }
            else
            {
                // TODO: Re-enable async
                // async_work::doQuery("INSERT INTO server_variables VALUES ('%s', %i) ON DUPLICATE KEY UPDATE value = %i;", varName, value, value);
                sql->Query("INSERT INTO server_variables VALUES ('%s', %i) ON DUPLICATE KEY UPDATE value = %i;", name, value, value);
            }
        }

        serverVarChanges.clear();

        return 0;
    }

    void PersistServerVar(std::string const& name, int32 value)
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
                sql->Query("DELETE FROM server_variables WHERE name = '%s' LIMIT 1;", name);
            }
            else
            {
                sql->Query("INSERT INTO server_variables VALUES ('%s', %i) ON DUPLICATE KEY UPDATE value = %i;", name, value, value);
            }

            if (setVarMaxRetry > 0)
            {
                // Cannot usleep(microseconds) or use std::this_thread::sleep_for(std::chrono::microseconds(usec))
                // because, you guessed it, DSP design.  Close inspection of other DSP code shows sleeping is not
                // something it does.  However, we actually get the same 'effect' by simply asking to read the
                // value that was written.  The access back to the DB is just a few milliseconds.  Down side is
                // that we have to give up at some point.
                // Also, don't use GetServerVariable, as that manipulates the Lua variable stack.
                if (sql->Query("SELECT value FROM server_variables WHERE name = '%s' LIMIT 1;", name) != SQL_ERROR)
                {
                    if (sql->NumRows() > 0)
                    {
                        // Can get it, so let's make sure it matches.
                        if (sql->NextRow() == SQL_SUCCESS)
                        {
                            verify = sql->GetIntData(0);
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
