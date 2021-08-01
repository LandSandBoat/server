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
    // TODO: Is a fat variant like this terrible?
    using data_t = std::variant<int32, uint32, int64, uint64, double, std::vector<char>>;

    struct row_t
    {
        template <typename T>
        T get(std::string const& key)
        {
            // Special handling conditions
            if constexpr (std::is_same_v<float, T>)
            {
                return static_cast<float>(std::get<double>(dataMap[key]));
            }
            else if constexpr (std::is_same_v<int8, T>)
            {
                return static_cast<int8>(std::get<int32>(dataMap[key]));
            }
            else if constexpr (std::is_same_v<int16, T>)
            {
                return static_cast<int16>(std::get<int32>(dataMap[key]));
            }
            else if constexpr (std::is_same_v<uint8, T>)
            {
                return static_cast<uint8>(std::get<uint32>(dataMap[key]));
            }
            else if constexpr (std::is_same_v<uint16, T>)
            {
                return static_cast<uint16>(std::get<uint32>(dataMap[key]));
            }
            else if constexpr (std::is_same_v<std::string, T>)
            {
                return static_cast<const char*>(std::get<std::vector<char>>(dataMap[key]));
            }
            else if constexpr (std::is_same_v<const char*, T>)
            {
                return static_cast<const char*>(std::get<std::vector<char>>(dataMap[key]));
            }
            else if constexpr (std::is_same_v<int8*, T>)
            {
                auto vec = std::get<std::vector<char>>(dataMap[key]);
                return reinterpret_cast<T>(vec.data());
            }
            else
            {
                // No need for conversion, just extract the type
                return std::get<T>(dataMap[key]);
            }
        }

        std::map<std::string, data_t> dataMap;
    };

    struct results
    {
        // Query information
        std::string query;

        // Result information
        std::vector<row_t> rows;

        auto size() const
        {
            return rows.size();
        }

        bool empty() const
        {
            return rows.empty();
        }

        auto begin()
        {
            return rows.begin();
        }

        auto end()
        {
            return rows.end();
        }

        auto cbegin() const
        {
            return rows.cbegin();
        }

        auto cend() const
        {
            return rows.cend();
        }

        // Error information
        bool error = false;
        std::string errorStr = "";
    };

    class builder
    {
    public:
        builder& select()
        {
            if (!queryType.empty())
            {
                // You shouldn't be here!
                throw;
            }
            queryType = "SELECT ";
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
            else if constexpr (std::is_same_v<double, T>)
            {
                // Sql_GetDoubleData
                fields.emplace_back(str, SqlDataType::SQLDT_DOUBLE);
            }
            else if constexpr (std::is_same_v<int8, T>)
            {
                // Sql_GetInt8Data
                fields.emplace_back(str, SqlDataType::SQLDT_INT8);
            }
            else if constexpr (std::is_same_v<int16, T>)
            {
                // Sql_GetInt16Data
                fields.emplace_back(str, SqlDataType::SQLDT_INT16);
            }
            else if constexpr (std::is_same_v<int32, T>)
            {
                // Sql_GetInt32Data
                fields.emplace_back(str, SqlDataType::SQLDT_INT32);
            }
            else if constexpr (std::is_same_v<int64, T>)
            {
                // Sql_GetInt64Data
                fields.emplace_back(str, SqlDataType::SQLDT_INT64);
            }
            else if constexpr (std::is_same_v<uint8, T>)
            {
                // Sql_GetUInt8Data
                fields.emplace_back(str, SqlDataType::SQLDT_UINT8);
            }
            else if constexpr (std::is_same_v<uint16, T>)
            {
                // Sql_GetUInt16Data
                fields.emplace_back(str, SqlDataType::SQLDT_UINT16);
            }
            else if constexpr (std::is_same_v<uint32, T>)
            {
                // Sql_GetUInt32Data
                fields.emplace_back(str, SqlDataType::SQLDT_UINT32);
            }
            else if constexpr (std::is_same_v<uint64, T>)
            {
                // Sql_GetUInt64Data
                fields.emplace_back(str, SqlDataType::SQLDT_UINT64);
            }
            else if constexpr (std::is_same_v<std::string, T>)
            {
                // Sql_GetData
                fields.emplace_back(str, SqlDataType::SQLDT_STRING);
            }
            else if constexpr (std::is_same_v<const char*, T>)
            {
                // Sql_GetData
                fields.emplace_back(str, SqlDataType::SQLDT_STRING);
            }
            else if constexpr (std::is_same_v<std::vector<char>, T>) // Blob
            {
                // Sql_GetData
                fields.emplace_back(str, SqlDataType::SQLDT_BLOB);
            }
            else if constexpr (std::is_same_v<char*, T>) // Blob
            {
                // Sql_GetData
                fields.emplace_back(str, SqlDataType::SQLDT_BLOB);
            }
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

        results execute(Sql_t* SqlHandle)
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
            res.query = query;
            int32 ret = Sql_Query(SqlHandle, query.c_str());
            if (ret == SQL_ERROR)
            {
                ShowSQL("Query failed");
                res.error = true;
                res.errorStr = "Query failed";
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
                            row.dataMap[name] = Sql_GetFloatData(SqlHandle, i);
                            break;
                        }
                        case SqlDataType::SQLDT_DOUBLE:
                        {
                            row.dataMap[name] = Sql_GetDoubleData(SqlHandle, i);
                            break;
                        }
                        case SqlDataType::SQLDT_INT8:
                        {
                            row.dataMap[name] = static_cast<int32>(Sql_GetIntData<int8>(SqlHandle, i));
                            break;
                        }
                        case SqlDataType::SQLDT_INT16:
                        {
                            row.dataMap[name] = static_cast<int32>(Sql_GetIntData<int16>(SqlHandle, i));
                            break;
                        }
                        case SqlDataType::SQLDT_INT32:
                        {
                            row.dataMap[name] = Sql_GetIntData<int32>(SqlHandle, i);
                            break;
                        }
                        case SqlDataType::SQLDT_INT64:
                        {
                            row.dataMap[name] = Sql_GetIntData<int64>(SqlHandle, i);
                            break;
                        }
                        case SqlDataType::SQLDT_UINT8:
                        {
                            row.dataMap[name] = static_cast<uint32>(Sql_GetIntData<uint8>(SqlHandle, i));
                            break;
                        }
                        case SqlDataType::SQLDT_UINT16:
                        {
                            row.dataMap[name] = static_cast<uint32>(Sql_GetIntData<uint16>(SqlHandle, i));
                            break;
                        }
                        case SqlDataType::SQLDT_UINT32:
                        {
                            row.dataMap[name] = Sql_GetIntData<uint32>(SqlHandle, i);
                            break;
                        }
                        case SqlDataType::SQLDT_UINT64:
                        {
                            row.dataMap[name] = Sql_GetIntData<uint64>(SqlHandle, i);
                            break;
                        }
                        default:
                        {
                            std::size_t length = 0;
                            char* data = nullptr;
                            Sql_GetData(SqlHandle, i, &data, &length);
                            row.dataMap[name] = std::vector<char>(data, data + length); 
                            break;
                        }
                    }
                }
                res.rows.emplace_back(row);
            }
            return res;
        }

    private:
        std::vector<field_t> fields;

        std::string queryType;
        std::string fromTable;
        std::string whereCondition;
        std::string limitStr;
    };
} // namespace query

#endif // _QUERY_BUILDER_H
