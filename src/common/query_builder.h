/*
===========================================================================

  Copyright (c) 2021 LandSandBoat Dev Teams

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

#ifndef _QUERY_BUILDER_H
#define _QUERY_BUILDER_H

/*
This helper is designed to abstract away the manual field and index tracking of our SQL query building.
One day, we will rewrite all of our database access to not build queries on the fly, but that
is a problem for future us!

THIS IS NOT A SILVER BULLET FOR OUR DATABASE ACCESS PATTERNS/PROBLEMS.
It's just to make our lives a little easier until we do a rewrite.
*/

#include "cbasetypes.h"
#include "logging.h"
#include "sql.h"

#include <map>
#include <string>
#include <variant>
#include <vector>

namespace query
{
    using field_t = std::pair<std::string, SqlDataType>;
    using data_t = std::variant<uint32, int32, float, int8*>;

    struct row_t
    {
        template <typename T>
        T& get(std::string const& key)
        {
            return std::get<T>(dataMap[key]);
        }

        std::map<std::string, data_t> dataMap;
    };

    struct results
    {
        // Query information
        std::string m_query;

        // Result information
        std::vector<row_t> m_rows;

        // Error information
        bool m_error = false;
        std::string m_errorStr = "";
    };

    class builder
    {
    public:
        builder(Sql_t* handle)
        : SqlHandle(handle)
        {
        }

        builder& select()
        {
            if (!queryType.empty())
            {
                // You shouldn't be here!
                throw;
            }
            queryType = "SELECT";
            return *this;
        }

        template <typename T>
        builder& field(std::string const& str)
        {
            if constexpr (std::is_same_v<float, T>)
            {
                // Sql_GetFloatData
                fields.emplace_back(str, SqlDataType::SQLDT_FLOAT);
            }
            else if constexpr (std::is_same_v<unsigned int, T>)
            {
                // Sql_GetUIntData
                fields.emplace_back(str, SqlDataType::SQLDT_UINT32);
            }
            else if constexpr (std::is_same_v<int, T>)
            {
                // Sql_GetIntData
                fields.emplace_back(str, SqlDataType::SQLDT_INT32);
            }
            else if constexpr (std::is_same_v<std::string, T>)
            {
                // Sql_GetData
                fields.emplace_back(str, SqlDataType::SQLDT_STRING);
            }
            // TODO: blob
            // TODO: datetime (uint32?)
            else
            {
                // You shouldn't be here!
                throw;
            }
            return *this;
        }

        builder& from(std::string const& str)
        {
            if (!fromTable.empty())
            {
                // You shouldn't be here!
                throw;
            }
            fromTable = str;
            return *this;
        }

        template <typename... Args>
        builder& where(Args&&... args)
        {
            if (!whereCondition.empty())
            {
                // You shouldn't be here!
                throw;
            }
            whereCondition = fmt::format(std::forward<Args>(args)...);
            return *this;
        }

        builder& limit(std::size_t sz)
        {
            limitStr = fmt::format("LIMIT {}", sz);
            return *this;
        }

        results execute()
        {
            std::string query;

            query += fmt::format("{} ", queryType);

            // Build comma-delimited list of fields
            // TODO: Do this better
            for (int i = 0; i < fields.size(); ++i)
            {
                query += fields[i].first;
                query += (i == fields.size() - 1) ? " " : ", ";
            }

            query += fmt::format("FROM {} ", fromTable);

            if (!whereCondition.empty())
            {
                query += fmt::format("WHERE {}", whereCondition);
            }

            if (!limitStr.empty())
            {
                query += fmt::format(" {}", limitStr);
            }

            query += ";";

            results res;
            res.m_query = query;
            int32 ret = Sql_Query(SqlHandle, query.c_str());
            if (ret == SQL_ERROR)
            {
                ShowSQL("Query failed");
                res.m_error = true;
                res.m_errorStr = "Query failed";
                return res;
            }

            if (Sql_NumRows(SqlHandle) == 0)
            {
                return res;
            }

            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                row_t row;
                for (int i = 0; i < fields.size(); ++i)
                {
                    auto name = fields[i].first;
                    auto type = fields[i].second;
                    switch (type)
                    {
                        case SqlDataType::SQLDT_FLOAT:
                        {
                            row.dataMap[name] = static_cast<float>(Sql_GetFloatData(SqlHandle, i));
                            break;
                        }
                        case SqlDataType::SQLDT_UINT32:
                        {
                            row.dataMap[name] = static_cast<uint32>(Sql_GetUIntData(SqlHandle, i));
                            break;
                        }
                        case SqlDataType::SQLDT_INT32:
                        {
                            row.dataMap[name] = static_cast<int32>(Sql_GetIntData(SqlHandle, i));
                            break;
                        }
                        default:
                        {
                            row.dataMap[name] = Sql_GetData(SqlHandle, i);
                            break;
                        }
                    }
                }
                res.m_rows.emplace_back(row);
            }
            return res;
        }

    private:
        Sql_t* SqlHandle;

        std::vector<field_t> fields;

        std::string queryType;
        std::string fromTable;
        std::string whereCondition;
        std::string limitStr;
    };
} // namespace query

#endif // _QUERY_BUILDER_H
