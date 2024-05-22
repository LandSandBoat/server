/*
===========================================================================

  Copyright (c) 2024 LandSandBoat Dev Teams

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
#include "mutex_guarded.h"
#include "tracy.h"

#include <memory>
#include <string>
#include <unordered_map>

// TODO: mariadb-connector-cpp triggers this. Remove once they fix it.
// 4263 'function': member function does not override any base class member functions
#ifdef WIN32
#pragma warning(push)
#pragma warning(disable : 4263)
#endif

#include <conncpp.hpp>

#ifdef WIN32
#pragma warning(pop)
#endif

// @note Everything in database-land is 1-indexed, not 0-indexed.
namespace db
{
    namespace detail
    {
        struct State
        {
            std::unique_ptr<sql::Connection>                                         connection;
            std::unordered_map<std::string, std::unique_ptr<sql::PreparedStatement>> lazyPreparedStatements;
        };

        auto getState() -> mutex_guarded<db::detail::State>&;

        auto sanitise(std::string const& query) -> std::string;

        // Helpers to provide information to the static_assert below
        template <class>
        struct always_false : std::false_type
        {
        };

        template <class T>
        inline constexpr bool always_false_v = always_false<T>::value;

        template <typename T>
        void bindValue(std::unique_ptr<sql::PreparedStatement>& stmt, int& counter, T&& value)
        {
            DebugSQL(fmt::format("binding {}: {}", counter, value));

            if constexpr (std::is_same_v<std::decay_t<T>, int32>)
            {
                stmt->setInt(counter, value);
            }
            else if constexpr (std::is_same_v<std::decay_t<T>, uint32>)
            {
                stmt->setUInt(counter, value);
            }
            else if constexpr (std::is_same_v<std::decay_t<T>, int16>)
            {
                stmt->setShort(counter, value);
            }
            else if constexpr (std::is_same_v<std::decay_t<T>, uint16>)
            {
                stmt->setShort(counter, value);
            }
            else if constexpr (std::is_same_v<std::decay_t<T>, int8>)
            {
                stmt->setByte(counter, value);
            }
            else if constexpr (std::is_same_v<std::decay_t<T>, uint8>)
            {
                stmt->setByte(counter, value);
            }
            else if constexpr (std::is_same_v<std::decay_t<T>, bool>)
            {
                stmt->setBoolean(counter, value);
            }
            else if constexpr (std::is_same_v<std::decay_t<T>, double>)
            {
                stmt->setDouble(counter, value);
            }
            else if constexpr (std::is_same_v<std::decay_t<T>, float>)
            {
                stmt->setFloat(counter, value);
            }
            else if constexpr (std::is_same_v<std::decay_t<T>, const std::string>)
            {
                stmt->setString(counter, value.c_str());
            }
            else if constexpr (std::is_same_v<std::decay_t<T>, std::string>)
            {
                stmt->setString(counter, value.c_str());
            }
            else if constexpr (std::is_same_v<std::decay_t<T>, const char*>)
            {
                stmt->setString(counter, value);
            }
            else if constexpr (std::is_same_v<std::decay_t<T>, char*>)
            {
                stmt->setString(counter, value);
            }
            else
            {
                static_assert(always_false_v<T>, "Unsupported type in binder");
            }
        }

        // Base case
        inline void binder(std::unique_ptr<sql::PreparedStatement>& stmt, int& counter)
        {
        }

        // Final case
        // TODO: Why is this needed? Why can't the regular and base case handle this?
        template <typename T>
        void binder(std::unique_ptr<sql::PreparedStatement>& stmt, int& counter, T&& first)
        {
            bindValue(stmt, ++counter, std::forward<T>(first));
            binder(stmt, counter);
        }

        // Regular case
        template <typename T, typename... Args>
        void binder(std::unique_ptr<sql::PreparedStatement>& stmt, int& counter, T&& first, Args&&... rest)
        {
            bindValue(stmt, ++counter, std::forward<T>(first));
            binder(stmt, counter, std::forward<Args>(rest)...);
        }
    } // namespace detail

    // @brief Execute a query with the given query string.
    // @param query The query string to execute.
    // @return A unique pointer to the result set of the query.
    // @note Everything in database-land is 1-indexed, not 0-indexed.
    auto query(std::string const& rawQuery) -> std::unique_ptr<sql::ResultSet>;

    // @brief Execute a prepared statement with the given query string and arguments.
    // @param query The query string to execute.
    // @param args The arguments to bind to the prepared statement.
    // @return A unique pointer to the result set of the query.
    // @note If the query hasn't been seen before it will generate a prepared statement for it to be used immediately and in the future.
    // @note Everything in database-land is 1-indexed, not 0-indexed.
    template <typename... Args>
    std::unique_ptr<sql::ResultSet> preparedStmt(std::string const& rawQuery, Args&&... args)
    {
        TracyZoneScoped;
        TracyZoneString(rawQuery);

        // clang-format off
        return detail::getState().write([&](detail::State& state) -> std::unique_ptr<sql::ResultSet>
        {
            auto& lazyPreparedStatements = state.lazyPreparedStatements;

            // TODO: combine the two versions of this function into one, with the string-handling version
            // just being a wrapped which does the lookup below and then calls the enum version.

            // If we don't have it, lazily make it
            if (lazyPreparedStatements.find(rawQuery) == lazyPreparedStatements.end())
            {
                try
                {
                    lazyPreparedStatements[rawQuery] = std::unique_ptr<sql::PreparedStatement>(state.connection->prepareStatement(rawQuery.c_str()));
                }
                catch (const std::exception& e)
                {
                    ShowError("Failed to lazy prepare query: %s", str(rawQuery.c_str()));
                    ShowError(e.what());
                    return nullptr;
                }
            }

            auto& stmt = lazyPreparedStatements[rawQuery];
            try
            {
                DebugSQL(fmt::format("preparedStmt: {}", rawQuery));

                // NOTE: Everything is 1-indexed, but we're going to increment right away insider binder!
                auto counter = 0;
                db::detail::binder(stmt, counter, std::forward<Args>(args)...);
                return std::unique_ptr<sql::ResultSet>(stmt->executeQuery());
            }
            catch (const std::exception& e)
            {
                ShowError("Query Failed: %s", str(rawQuery.c_str()));
                ShowError(e.what());
                return nullptr;
            }
        });
        // clang-format on
    }

    // @brief Execute a prepared statement with the given query string and arguments.
    // @param query The query string to execute.
    // @param args The arguments to bind to the prepared statement.
    // @return A pair of: unique pointer to the result set of the query, number of rows affected by the query as told by MariaDB's ROW_COUNT().
    // @note If the query hasn't been seen before it will generate a prepared statement for it to be used immediately and in the future.
    // @note Everything in database-land is 1-indexed, not 0-indexed.
    // @note This is a workaround for the fact that MariaDB's C++ connector hasn't yet implemented ResultSet::rowUpdated(), ResultSet::rowInserted(),
    //       and ResultSet::rowDeleted().
    template <typename... Args>
    std::pair<std::unique_ptr<sql::ResultSet>, std::size_t> preparedStmtWithAffectedRows(std::string const& rawQuery, Args&&... args)
    {
        TracyZoneScoped;
        TracyZoneString(rawQuery);

        // clang-format off
        return detail::getState().write([&](detail::State& state) -> std::pair<std::unique_ptr<sql::ResultSet>, std::size_t>
        {
            auto& lazyPreparedStatements = state.lazyPreparedStatements;

            // TODO: combine the two versions of this function into one, with the string-handling version
            // just being a wrapped which does the lookup below and then calls the enum version.

            // If we don't have it, lazily make it
            if (lazyPreparedStatements.find(rawQuery) == lazyPreparedStatements.end())
            {
                try
                {
                    lazyPreparedStatements[rawQuery] = std::unique_ptr<sql::PreparedStatement>(state.connection->prepareStatement(rawQuery.c_str()));
                }
                catch (const std::exception& e)
                {
                    ShowError("Failed to lazy prepare query: %s", str(rawQuery.c_str()));
                    ShowError(e.what());
                    return { nullptr, 0 };
                }
            }

            auto rowCountQuery = "SELECT ROW_COUNT() AS count";
            if (lazyPreparedStatements.find(rowCountQuery) == lazyPreparedStatements.end())
            {
                try
                {
                    lazyPreparedStatements[rowCountQuery] = std::unique_ptr<sql::PreparedStatement>(state.connection->prepareStatement(rowCountQuery));
                }
                catch (const std::exception& e)
                {
                    ShowError("Failed to lazy prepare query: %s", str(rowCountQuery));
                    ShowError(e.what());
                    return { nullptr, 0 };
                }
            }

            auto& stmt      = lazyPreparedStatements[rawQuery];
            auto& countStmt = lazyPreparedStatements[rowCountQuery];
            try
            {
                // NOTE: Everything is 1-indexed, but we're going to increment right away insider binder!
                auto counter = 0;
                db::detail::binder(stmt, counter, std::forward<Args>(args)...);
                auto rset  = std::unique_ptr<sql::ResultSet>(stmt->executeQuery());
                auto rset2 = std::unique_ptr<sql::ResultSet>(countStmt->executeQuery());
                if (!rset2 || !rset2->next())
                {
                    ShowError("Failed to get row count");
                    return { nullptr, 0 };
                }
                auto rowCount = rset2->getUInt("count");
                return { std::move(rset), rowCount };
            }
            catch (const std::exception& e)
            {
                ShowError("Query Failed: %s", str(rawQuery.c_str()));
                ShowError(e.what());
                return { nullptr, 0 };
            }

        });
        // clang-format on
    }

    // @brief Encode a struct to a blob string.
    // @param source The struct to encode.
    // @return A string containing the encoded struct.
    // @note This does not yet work inline with prepared statements. If you need to use
    //       encoded blobs you should encode your struct(s) and then build them into
    //       a query string with fmt::format for use with db::query.
    //       See blueutils::SaveSetSpells for an example.
    template <typename T>
    auto encodeToBlob(T& source)
    {
        static_assert(std::is_trivially_copyable_v<T>, "T must be trivially copyable");

        TracyZoneScoped;

        // Convert struct to vector of chars
        std::vector<char> blob(sizeof(T));
        std::memcpy(blob.data(), &source, sizeof(T));

        // Escape characters in the blob
        std::string result;
        result.reserve(blob.size() * 2); // Reserving space for maximum possible expansion

        for (const char ch : blob)
        {
            switch (ch)
            {
                case '\0': // Null character
                    result += "\\0";
                    break;
                case '\'': // Single quote
                    result += "\\'";
                    break;
                case '\"': // Double quote
                    result += "\\\"";
                    break;
                case '\b': // Backspace
                    result += "\\b";
                    break;
                case '\n': // Newline
                    result += "\\n";
                    break;
                case '\r': // Carriage return
                    result += "\\r";
                    break;
                case '\t': // Tab
                    result += "\\t";
                    break;
                case '\x1A': // Ctrl-Z
                    result += "\\Z";
                    break;
                case '\\': // Backslash
                    result += "\\\\";
                    break;
                default:
                    result += ch;
                    break;
            }
        }

        return result;
    }

    // @brief Extract a struct from a blob string.
    // @param rset The result set to extract the blob from.
    // @param blobKey The key of the blob in the result set.
    // @param destination The struct to extract the blob into.
    template <typename T>
    void extractFromBlob(std::unique_ptr<sql::ResultSet>& rset, std::string const& blobKey, T& destination)
    {
        static_assert(std::is_trivially_copyable_v<T>, "T must be trivially copyable");

        TracyZoneScoped;

        // If we use getString on a null blob we will get back garbage data.
        // This will introduce difficult to track down crashes.
        if (!rset->isNull(blobKey.c_str()))
        {
            auto blobStr = rset->getString(blobKey.c_str());
            // Login server creates new chars with null blobs. Map server then initializes.
            // We don't want to overwrite the initialized map data with null blobs / 0 values.
            // See: login_helpers.cpp saveCharacter() and charutils::LoadChar
            std::memset(&destination, 0x00, sizeof(T));
            std::memcpy(&destination, blobStr.c_str(), std::min(sizeof(T), blobStr.length()));
        }
    }
} // namespace db
