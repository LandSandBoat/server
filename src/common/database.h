/*
===========================================================================

  Copyright (c) 2023 LandSandBoat Dev Teams

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

#pragma once

#include "cbasetypes.h"

#include <memory>
#include <string>

#include <conncpp.hpp>

enum class PreparedStatement
{
    Search_GetSearchComment,
};

// TODO: Rename this namespace from db to sql when migration is complete.
// mariadb-connector-cpp uses sql namespace for all of its classes, so it
// will be clearer if we use it too.
namespace db
{
    namespace detail
    {
        std::unordered_map<PreparedStatement, std::pair<std::string, std::unique_ptr<sql::PreparedStatement>>>& getPreparedStatements();
        std::unordered_map<std::string, std::unique_ptr<sql::PreparedStatement>>&                               getLazyPreparedStatements();

        void populatePreparedStatements(std::shared_ptr<sql::Connection> conn);

        auto getConnection() -> std::shared_ptr<sql::Connection>;

        // Base case
        inline void binder(std::unique_ptr<sql::PreparedStatement>&, int&)
        {
        }

        template <typename T, typename... Args>
        void binder(std::unique_ptr<sql::PreparedStatement>& stmt, int& counter, const T& first, const Args&&... rest)
        {
            if constexpr (std::is_same_v<std::decay_t<T>, signed int>)
            {
                stmt->setInt(counter, first);
            }
            else if constexpr (std::is_same_v<std::decay_t<T>, unsigned int>)
            {
                stmt->setUInt(counter, first);
            }
            else if constexpr (std::is_same_v<std::decay_t<T>, signed short>)
            {
                stmt->setShort(counter, first);
            }
            else if constexpr (std::is_same_v<std::decay_t<T>, int8>)
            {
                stmt->setByte(counter, first);
            }
            else if constexpr (std::is_same_v<std::decay_t<T>, std::string>)
            {
                stmt->setString(counter, first);
            }
            else if constexpr (std::is_same_v<std::decay_t<T>, bool>)
            {
                stmt->setBoolean(counter, first);
            }
            else if constexpr (std::is_same_v<std::decay_t<T>, double>)
            {
                stmt->setDouble(counter, first);
            }
            else if constexpr (std::is_same_v<std::decay_t<T>, float>)
            {
                stmt->setFloat(counter, first);
            }
            else if constexpr (std::is_convertible_v<T, const char*>)
            {
                stmt->setString(counter, first);
            }

            ++counter;

            binder(stmt, counter, rest...);
        }
    } // namespace detail

    // If called with a PreparedStatement enum the query was prepared ahead of time, so it
    // will be looked up and executed.
    template <typename... Args>
    std::unique_ptr<sql::ResultSet> preparedStmt(PreparedStatement preparedStmt, Args&&... args)
    {
        TracyZoneScoped;

        // TODO: Check this is pooled. If not; make it pooled.
        static thread_local auto conn = db::detail::getConnection();

        auto& preparedStatements = db::detail::getPreparedStatements();

        if (preparedStatements.find(preparedStmt) == preparedStatements.end())
        {
            ShowError("Bad prepared stmt");
            return nullptr;
        }

        auto& stmt = preparedStatements[preparedStmt].second;
        try
        {
            // NOTE: 1-indexed!
            auto counter = 1;
            binder(stmt, counter, std::forward<Args>(args)...);
            return std::unique_ptr<sql::ResultSet>(stmt->executeQuery());
        }
        catch (const std::exception& e)
        {
            ShowError("Query Failed: %s", str(preparedStatements[preparedStmt].first.c_str()));
            ShowError(e.what());
            return nullptr;
        }
    }

    // If called with a string query the query will be lazily prepared/looked up and executed.
    template <typename... Args>
    std::unique_ptr<sql::ResultSet> preparedStmt(std::string const& query, Args&&... args)
    {
        TracyZoneScoped;

        // TODO: Check this is pooled. If not; make it pooled.
        static thread_local auto conn = db::detail::getConnection();

        auto& lazyPreparedStatements = db::detail::getLazyPreparedStatements();

        // TODO: combine the two versions of this function into one, with the string-handling version
        // just being a wrapped which does the lookup below and then calls the enum version.

        // If we don't have it, lazily make it
        if (lazyPreparedStatements.find(query) == lazyPreparedStatements.end())
        {
            try
            {
                lazyPreparedStatements[query] = std::unique_ptr<sql::PreparedStatement>(conn->prepareStatement(query.c_str()));
            }
            catch (const std::exception& e)
            {
                ShowError("Failed to lazy prepare query: %s", str(query.c_str()));
                ShowError(e.what());
                return nullptr;
            }
        }

        auto& stmt = lazyPreparedStatements[query];
        try
        {
            // NOTE: 1-indexed!
            auto counter = 1;
            db::detail::binder(stmt, counter, std::forward<Args>(args)...);
            return std::unique_ptr<sql::ResultSet>(stmt->executeQuery());
        }
        catch (const std::exception& e)
        {
            ShowError("Query Failed: %s", str(query.c_str()));
            ShowError(e.what());
            return nullptr;
        }
    }

    template <typename T>
    void extractBlob(std::unique_ptr<sql::ResultSet>& rset, std::string const& blobKey, T* destination)
    {
        TracyZoneScoped;

        std::unique_ptr<std::istream> inStr(rset->getBlob(blobKey.c_str()));
        if (!inStr)
        {
            std::memset(destination, 0x00, sizeof(T));
            return;
        }

        char buff[sizeof(T)];
        while (!inStr->eof())
        {
            inStr->read(buff, sizeof(buff));
        }

        std::memcpy(destination, buff, sizeof(T));
    }

    // WARNING: Everything in database-land is 1-indexed, not 0-indexed.
    auto query(std::string_view query) -> std::unique_ptr<sql::ResultSet>;
} // namespace db
