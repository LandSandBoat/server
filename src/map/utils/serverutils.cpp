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

#include "../utils/serverutils.h"

#include "../map.h"

namespace serverutils
{
    std::unordered_map<std::string, int32> varCache;
    std::unordered_set<std::string>        varChanges;

    int32 GetVar(td::string const& varName)
    {
        int32 value = 0;

        int32 ret = sql->Query((SqlHandle, "SELECT value FROM server_variables WHERE name = '%s' LIMIT 1;", varName);

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            value = (int32)Sql_GetIntData(SqlHandle, 0);
        }

        varCache[varName] = value;
        return value;
    }

    void SetVar(td::string const& varName, int32 value)
    {
        PersistVar(varName, value);
    }

    void SetVolatileVar(td::string const& varName, int32 value)
    {
        varCache[varName] = value;
        varChanges.insert(varName);
    }

    int32 GetVolatileVar(td::string const& varName)
    {
        if (auto var = varCache.find(varName); var != varCache.end())
        {
            return var->second;
        }

        return GetVar(varName);
    }

    int32 PersistVolatile(time_point tick, CTaskMgr::CTask* PTask)
    {
        if (varChanges.empty())
        {
            return 0;
        }

        for (auto&& varName : varChanges)
        {
            auto value = varCache[varName];
            if (value == 0)
            {
                async_work::doQuery("DELETE FROM server_variables WHERE name = '%s' LIMIT 1;", varName);
            }
            else
            {
                async_work::doQuery("INSERT INTO server_variables VALUES ('%s', %i) ON DUPLICATE KEY UPDATE value = %i;", varName, value, value);
            }
        }
        varChanges.clear();

        return 0;
    }

    void PersistVar(td::string const& varName, int32 value)
    {
        int32 tries  = 0;
        int32 verify = INT_MIN;

        do
        {
            tries++;
            verify = INT_MIN;

            if (value == 0)
            {
                sql->Query((SqlHandle, "DELETE FROM server_variables WHERE name = '%s' LIMIT 1;", varName);
            }
            else
            {
                sql->Query((SqlHandle, "INSERT INTO server_variables VALUES ('%s', %i) ON DUPLICATE KEY UPDATE value = %i;", varName, value, value);
            }

            if (map_config.setVar_retry_max > 0)
            {
                // Cannot usleep(microseconds) or use std::this_thread::sleep_for(std::chrono::microseconds(usec))
                // because, you guessed it, DSP design.  Close inspection of other DSP code shows sleeping is not
                // something it does.  However, we actually get the same 'effect' by simply asking to read the
                // value that was written.  The access back to the DB is just a few milliseconds.  Down side is
                // that we have to give up at some point.
                // Also, don't use GetServerVariable, as that manipulates the Lua variable stack.
                if (sql->Query((SqlHandle, "SELECT value FROM server_variables WHERE name = '%s' LIMIT 1;", varName) != SQL_ERROR)
                {
                    if (Sql_NumRows(SqlHandle) > 0)
                    {
                        // Can get it, so let's make sure it matches.
                        if (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                        {
                            verify = (int32)Sql_GetIntData(SqlHandle, 0);
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
        } while (verify != value && tries < map_config.setVar_retry_max);
    }
} // namespace serverutils
