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
#include "xi.h"

#include <istream>
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

// @note Everything in sql:: database-land is 1-indexed, not 0-indexed.
namespace db
{
    //
    // Forward declarations
    //

    namespace detail
    {
        class ResultSetWrapper;
    }

    auto escapeString(std::string const& str) -> std::string;

    auto getConnection() -> std::unique_ptr<sql::Connection>;

    // A wrapper to ensure the underlying data, the blobstream, and the istream are all alive
    // and valid as long as they need to be.
    struct BlobWrapper
    {
        std::unique_ptr<char[]> data;
        std::size_t             size;

        // https://stackoverflow.com/a/1449527
        class blobstream : public std::streambuf
        {
        public:
            blobstream(char* buffer, std::size_t size)
            {
                setg(buffer, buffer, buffer + size);
            }
        };

        blobstream   blobStream;
        std::istream istream;

        template <typename T>
        static std::shared_ptr<BlobWrapper> create(T& source)
        {
            static_assert(std::is_trivially_copyable_v<T>, "T must be trivially copyable");
            return std::make_shared<BlobWrapper>(reinterpret_cast<char*>(&source), sizeof(T));
        }

        BlobWrapper(char* data, std::size_t size)
        : data(std::make_unique<char[]>(size))
        , size(size)
        , blobStream(data, size)
        , istream(&blobStream)
        {
            // TODO: Do we really need to guarantee that the underlying data
            //     : will outlive the original callsite? We could just get rid of
            //     : data and size and use the two streams.
            std::memcpy(this->data.get(), data, size);
        }

        auto toString() -> std::string
        {
            // Escape characters in the blob
            std::string result;
            result.reserve(size * 2); // Reserving space for maximum possible expansion

            for (const char ch : std::string_view(data.get(), size))
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
                    case '%': // Percent (reserved by sprintf, etc.)
                        result += "%%";
                        break;
                    default:
                        result += ch;
                        break;
                }
            }

            return result;
        }
    };

    template <typename WrapperPtrT, typename T>
    void extractFromBlob(WrapperPtrT const& rset, std::string const& blobKey, T& destination);

    namespace detail
    {
        template <typename T>
        struct always_false : std::false_type
        {
        };

        template <typename T>
        inline constexpr bool always_false_v = always_false<T>::value;

        template <typename T>
        struct is_std_array : std::false_type
        {
        };

        template <typename T, std::size_t N>
        struct is_std_array<std::array<T, N>> : std::true_type
        {
        };

        template <typename T>
        inline constexpr bool is_std_array_v = is_std_array<T>::value;

        template <typename T>
        struct is_standard_trivial : std::bool_constant<std::is_standard_layout_v<T> && std::is_trivial_v<T>>
        {
        };

        template <typename T>
        inline constexpr bool is_standard_trivial_v = is_standard_trivial<T>::value;

        template <typename T>
        inline constexpr bool is_blob = (is_std_array_v<T> || std::is_array_v<T> || is_standard_trivial_v<T>) && !std::is_fundamental_v<T>;

        template <typename T>
        inline constexpr bool is_blob_v = is_blob<T>;

        struct State final
        {
            void reset()
            {
                connection = getConnection();
                lazyPreparedStatements.clear();
            }

            std::unique_ptr<sql::Connection>                                         connection;
            std::unordered_map<std::string, std::unique_ptr<sql::PreparedStatement>> lazyPreparedStatements;
        };

        class ResultSetWrapper final
        {
        public:
            ResultSetWrapper(std::unique_ptr<sql::ResultSet>&& resultSet, const std::string& query)
            : resultSet(std::move(resultSet))
            , query(query)
            {
            }

            auto next() -> bool
            {
                return resultSet->next();
            }

            auto rowsCount() -> std::size_t
            {
                return resultSet->rowsCount();
            }

            // Get the value of the associated key.
            template <typename T>
            auto get(const std::string& key) -> T
            {
                using UnderlyingT = std::decay_t<T>;

                UnderlyingT value{};

                if (!is_blob_v<UnderlyingT>)
                {
                    if (resultSet->isNull(key.c_str()))
                    {
                        ShowErrorFmt("ResultSetWrapper::get: key {} is null", key.c_str());
                        ShowErrorFmt("Query: {}", query.c_str());
                        return value;
                    }
                }

                if constexpr (std::is_same_v<UnderlyingT, int64>)
                {
                    value = static_cast<T>(resultSet->getInt64(key.c_str()));
                }
                else if constexpr (std::is_same_v<UnderlyingT, uint64>)
                {
                    value = static_cast<T>(resultSet->getUInt64(key.c_str()));
                }
                else if constexpr (std::is_same_v<UnderlyingT, int32>)
                {
                    value = static_cast<T>(resultSet->getInt(key.c_str()));
                }
                else if constexpr (std::is_same_v<UnderlyingT, uint32>)
                {
                    value = static_cast<T>(resultSet->getUInt(key.c_str()));
                }
                else if constexpr (std::is_same_v<UnderlyingT, int16>)
                {
                    value = static_cast<T>(resultSet->getInt(key.c_str()));
                }
                else if constexpr (std::is_same_v<UnderlyingT, uint16>)
                {
                    value = static_cast<T>(resultSet->getUInt(key.c_str()));
                }
                else if constexpr (std::is_same_v<UnderlyingT, int8>)
                {
                    // There is only a signed byte accessor
                    value = static_cast<T>(resultSet->getByte(key.c_str()));
                }
                else if constexpr (std::is_same_v<UnderlyingT, uint8>)
                {
                    // There isn't an unsigned byte accessor, so we'll just use getUInt
                    value = static_cast<T>(resultSet->getUInt(key.c_str()));
                }
                else if constexpr (std::is_same_v<UnderlyingT, bool>)
                {
                    value = static_cast<T>(resultSet->getBoolean(key.c_str()));
                }
                else if constexpr (std::is_same_v<UnderlyingT, double>)
                {
                    value = static_cast<T>(resultSet->getDouble(key.c_str()));
                }
                else if constexpr (std::is_same_v<UnderlyingT, float>)
                {
                    value = static_cast<T>(resultSet->getFloat(key.c_str()));
                }
                else if constexpr (std::is_same_v<UnderlyingT, std::string>)
                {
                    value = resultSet->getString(key.c_str());
                }
                else if constexpr (std::is_same_v<UnderlyingT, char*>)
                {
                    value = resultSet->getString(key.c_str());
                }
                else if constexpr (is_blob_v<UnderlyingT>)
                {
                    extractFromBlob(&*this, key, value);
                }
                else
                {
                    static_assert(always_false_v<T>, "Trying to extract unsupported type from ResultSetWrapper");
                }

                return value;
            }

            // Get the value of the 0-indexed column. Behind the scenes this is automatically converted to be 1-indexed for
            // use by the underlying database library.
            template <typename T>
            auto get(const uint32 index) -> T
            {
                const auto columnName = resultSet->getMetaData()->getColumnLabel(index + 1);
                return get<T>(columnName.c_str());
            }

            // Get the value of the associated key or the default value if the key is null/not-populated.
            template <typename T>
            auto getOrDefault(const std::string& key, T defaultValue) -> T
            {
                if (resultSet->isNull(key.c_str()))
                {
                    return defaultValue;
                }

                return get<T>(key);
            }

            // Get the value of the 0-indexed column or the default value if the column is null/not-populated.
            template <typename T>
            auto getOrDefault(const uint32 index, T defaultValue) -> T
            {
                const auto columnName = resultSet->getMetaData()->getColumnLabel(index + 1);
                return getOrDefault<T>(columnName.c_str(), defaultValue);
            }

            // Check if the value of the associated key is null/not-populated.
            auto isNull(const std::string& key) -> bool
            {
                return resultSet->isNull(key.c_str());
            }

            auto getQuery() const
            {
                return query;
            }

            //
            // Friend function declarations
            //

            template <typename WrapperPtrT, typename T>
            friend void db::extractFromBlob(WrapperPtrT const& rset, std::string const& blobKey, T& destination);

        private:
            std::unique_ptr<sql::ResultSet> resultSet;
            std::string                     query;
        };

        auto getState() -> mutex_guarded<db::detail::State>&;

        template <typename T>
        void bindValue(std::unique_ptr<sql::PreparedStatement>& stmt, int& counter, std::vector<std::shared_ptr<BlobWrapper>>& blobs, T&& value)
        {
            using UnderlyingT = std::decay_t<T>;

            if constexpr (!is_blob_v<UnderlyingT>)
            {
                DebugSQL(fmt::format("binding {}: {}", counter, value));
            }

            if constexpr (std::is_same_v<UnderlyingT, int32>)
            {
                stmt->setInt(counter, value);
            }
            else if constexpr (std::is_same_v<UnderlyingT, uint32>)
            {
                stmt->setUInt(counter, value);
            }
            else if constexpr (std::is_same_v<UnderlyingT, int16>)
            {
                stmt->setShort(counter, value);
            }
            else if constexpr (std::is_same_v<UnderlyingT, uint16>)
            {
                stmt->setShort(counter, value);
            }
            else if constexpr (std::is_same_v<UnderlyingT, int8>)
            {
                stmt->setByte(counter, value);
            }
            else if constexpr (std::is_same_v<UnderlyingT, uint8>)
            {
                stmt->setByte(counter, value);
            }
            else if constexpr (std::is_same_v<UnderlyingT, bool>)
            {
                stmt->setBoolean(counter, value);
            }
            else if constexpr (std::is_same_v<UnderlyingT, double>)
            {
                stmt->setDouble(counter, value);
            }
            else if constexpr (std::is_same_v<UnderlyingT, float>)
            {
                stmt->setFloat(counter, value);
            }
            else if constexpr (std::is_same_v<UnderlyingT, const std::string>)
            {
                stmt->setString(counter, value.c_str());
            }
            else if constexpr (std::is_same_v<UnderlyingT, std::string>)
            {
                stmt->setString(counter, value.c_str());
            }
            else if constexpr (std::is_same_v<UnderlyingT, const char*>)
            {
                stmt->setString(counter, value);
            }
            else if constexpr (std::is_same_v<UnderlyingT, char*>)
            {
                stmt->setString(counter, value);
            }
            else if constexpr (is_blob_v<UnderlyingT>)
            {
                auto blobWrapper = BlobWrapper::create(value);
                blobs.push_back(blobWrapper);

                DebugSQL(fmt::format("binding {}: {}", counter, blobWrapper->toString()));

                stmt->setBlob(counter, &blobWrapper->istream);
            }
            else
            {
                static_assert(always_false_v<T>, "Unsupported type in binder");
            }
        }

        // Base case
        inline void binder(std::unique_ptr<sql::PreparedStatement>& stmt, int& counter, std::vector<std::shared_ptr<BlobWrapper>>& blobs)
        {
        }

        // Final case
        // TODO: Why is this needed? Why can't the regular and base case handle this?
        template <typename T>
        void binder(std::unique_ptr<sql::PreparedStatement>& stmt, int& counter, std::vector<std::shared_ptr<BlobWrapper>>& blobs, T&& first)
        {
            bindValue(stmt, ++counter, blobs, std::forward<T>(first));
            binder(stmt, counter, blobs);
        }

        // Regular case
        template <typename T, typename... Args>
        void binder(std::unique_ptr<sql::PreparedStatement>& stmt, int& counter, std::vector<std::shared_ptr<BlobWrapper>>& blobs, T&& first, Args&&... rest)
        {
            bindValue(stmt, ++counter, blobs, std::forward<T>(first));
            binder(stmt, counter, blobs, std::forward<Args>(rest)...);
        }

        auto timer(std::string const& query) -> xi::final_action<std::function<void()>>;

        auto isConnectionIssue(const std::exception& e) -> bool;
    } // namespace detail

    // @brief Execute a query with the given query string.
    // @param query The query string to execute.
    // @return A unique pointer to the result set of the query.
    // @note Everything in database-land is 1-indexed, not 0-indexed.
    auto queryStr(std::string const& rawQuery) -> std::unique_ptr<db::detail::ResultSetWrapper>;

    // @brief Execute a query with the given query string and sprintf-style arguments.
    // @param query The query string to execute.
    // @param args The arguments to bind to the query string.
    // @return A unique pointer to the result set of the query.
    // @note Everything in database-land is 1-indexed, not 0-indexed.
    template <typename... Args>
    auto query(std::string const& query, Args&&... args) -> std::unique_ptr<db::detail::ResultSetWrapper>
    {
        TracyZoneScoped;
        try
        {
            const auto formattedQuery = fmt::sprintf(query, std::forward<Args>(args)...);
            return queryStr(formattedQuery);
        }
        catch (const std::exception& e)
        {
            ShowErrorFmt("Query Failed: {}", query);
            ShowErrorFmt("{}", e.what());
        }

        return nullptr;
    }

    // @brief Execute a prepared statement with the given query string and arguments.
    // @param query The query string to execute.
    // @param args The arguments to bind to the prepared statement.
    // @return A unique pointer to the result set of the query.
    // @note If the query hasn't been seen before it will generate a prepared statement for it to be used immediately and in the future.
    // @note Everything in database-land is 1-indexed, not 0-indexed.
    template <typename... Args>
    auto preparedStmt(std::string const& rawQuery, Args&&... args) -> std::unique_ptr<db::detail::ResultSetWrapper>
    {
        TracyZoneScoped;
        TracyZoneString(rawQuery);

        // clang-format off
        return detail::getState().write([&](detail::State& state) -> std::unique_ptr<db::detail::ResultSetWrapper>
        {
            const auto operation = [&]() -> std::unique_ptr<db::detail::ResultSetWrapper>
            {
                auto& lazyPreparedStatements = state.lazyPreparedStatements;

                // If we don't have it, lazily make it
                // cppcheck-suppress stlFindInsert
                if (lazyPreparedStatements.find(rawQuery) == lazyPreparedStatements.end())
                {
                    // cppcheck-suppress stlFindInsert
                    lazyPreparedStatements[rawQuery] = std::unique_ptr<sql::PreparedStatement>(state.connection->prepareStatement(rawQuery.c_str()));
                }

                DebugSQL(fmt::format("preparedStmt: {}", rawQuery));

                // NOTE: Everything is 1-indexed, but we're going to increment right away insider binder!
                auto counter = 0;

                // All blobs are stored here so they can be kept alive until the query is executed.
                std::vector<std::shared_ptr<BlobWrapper>> blobs;

                auto& stmt = lazyPreparedStatements[rawQuery];
                db::detail::binder(stmt, counter, blobs, std::forward<Args>(args)...);
                auto queryTimer = detail::timer(rawQuery);
                auto rset       = std::unique_ptr<sql::ResultSet>(stmt->executeQuery());
                return std::make_unique<db::detail::ResultSetWrapper>(std::move(rset), rawQuery);
            };

            const auto queryRetryCount = 1 + settings::get<uint32>("network.SQL_QUERY_RETRY_COUNT");
            for (auto i = 0U; i < queryRetryCount; ++i)
            {
                try
                {
                    if (i > 0)
                    {
                        ShowInfo("Connection lost, re-establishing connection and retrying query (attempt %d)", i);
                        state.reset();
                    }
                    return operation();
                }
                catch (const std::exception& e)
                {
                    if (!detail::isConnectionIssue(e))
                    {
                        ShowErrorFmt("Query Failed: {}", rawQuery.c_str());
                        ShowErrorFmt("{}", e.what());
                        return nullptr;
                    }
                }
            }

            ShowCritical("Query Failed after %d retries: %s", queryRetryCount, rawQuery.c_str());
            std::this_thread::sleep_for(std::chrono::seconds(1));
            std::terminate();
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
    auto preparedStmtWithAffectedRows(std::string const& rawQuery, Args&&... args) -> std::pair<std::unique_ptr<db::detail::ResultSetWrapper>, std::size_t>
    {
        TracyZoneScoped;
        TracyZoneString(rawQuery);

        // clang-format off
        return detail::getState().write([&](detail::State& state) -> std::pair<std::unique_ptr<db::detail::ResultSetWrapper>, std::size_t>
        {
            const auto operation = [&]() -> std::pair<std::unique_ptr<db::detail::ResultSetWrapper>, std::size_t>
            {
                auto& lazyPreparedStatements = state.lazyPreparedStatements;

                // If we don't have it, lazily make it
                // cppcheck-suppress stlFindInsert
                if (lazyPreparedStatements.find(rawQuery) == lazyPreparedStatements.end())
                {
                    try
                    {
                        // cppcheck-suppress stlFindInsert
                        lazyPreparedStatements[rawQuery] = std::unique_ptr<sql::PreparedStatement>(state.connection->prepareStatement(rawQuery.c_str()));
                    }
                    catch (const std::exception& e)
                    {
                        ShowErrorFmt("Failed to lazy prepare query: {}", rawQuery, rawQuery.size());
                        ShowErrorFmt("{}", e.what());
                        return { nullptr, 0 };
                    }
                }

                const auto rowCountQuery = "SELECT ROW_COUNT() AS count";

                // If we don't have it, lazily make it
                // cppcheck-suppress stlFindInsert
                if (lazyPreparedStatements.find(rowCountQuery) == lazyPreparedStatements.end())
                {
                    // cppcheck-suppress stlFindInsert
                    lazyPreparedStatements[rowCountQuery] = std::unique_ptr<sql::PreparedStatement>(state.connection->prepareStatement(rowCountQuery));
                }

                auto& stmt      = lazyPreparedStatements[rawQuery];
                auto& countStmt = lazyPreparedStatements[rowCountQuery];

                // NOTE: Everything is 1-indexed, but we're going to increment right away insider binder!
                auto counter = 0;

                // All blobs are stored here so they can be kept alive until the query is executed.
                std::vector<std::shared_ptr<BlobWrapper>> blobs;

                db::detail::binder(stmt, counter, blobs, std::forward<Args>(args)...);
                auto queryTimer = detail::timer(rawQuery);
                auto rset       = std::unique_ptr<sql::ResultSet>(stmt->executeQuery());
                auto rset2      = std::unique_ptr<sql::ResultSet>(countStmt->executeQuery());
                if (!rset2 || !rset2->next())
                {
                    ShowErrorFmt("Failed to get row count");
                    return { nullptr, 0 };
                }
                auto rowCount = rset2->getUInt("count");
                return { std::make_unique<db::detail::ResultSetWrapper>(std::move(rset), rawQuery), rowCount };
            };

            const auto queryRetryCount = 1 + settings::get<uint32>("network.SQL_QUERY_RETRY_COUNT");
            for (auto i = 0U; i < queryRetryCount; ++i)
            {
                try
                {
                    if (i > 0)
                    {
                        ShowInfo("Connection lost, re-establishing connection and retrying query (attempt %d)", i);
                        state.reset();
                    }
                    return operation();
                }
                catch (const std::exception& e)
                {
                    if (!detail::isConnectionIssue(e))
                    {
                        ShowErrorFmt("Query Failed: {}", rawQuery.c_str());
                        ShowErrorFmt("{}", e.what());
                        return { nullptr, 0 };
                    }
                }
            }

            ShowCritical("Query Failed after %d retries: %s", queryRetryCount, rawQuery.c_str());
            std::this_thread::sleep_for(std::chrono::seconds(1));
            std::terminate();
        });
        // clang-format on
    }

    // @brief Extract a struct from a blob string.
    // @param rset The result set to extract the blob from.
    // @param blobKey The key of the blob in the result set.
    // @param destination The struct to extract the blob into.
    template <typename WrapperPtrT, typename T>
    void extractFromBlob(WrapperPtrT const& rset, std::string const& blobKey, T& destination)
    {
        static_assert(std::is_trivially_copyable_v<T>, "T must be trivially copyable");

        TracyZoneScoped;

        // If we use getString on a null blob we will get back garbage data.
        // This will introduce difficult to track down crashes.
        if (!rset->isNull(blobKey.c_str()))
        {
            // TODO: This is kind of nasty. We can't use rset->get<std::string>(...)
            //     : because it will truncate the blob result. So we're using a friend
            //     : function to allow us to get access to the raw resultSet and
            //     : call getString directly. This does not truncate the result.
            auto blobStr = rset->resultSet->getString(blobKey.c_str());

            // Login server creates new chars with null blobs. Map server then initializes.
            // We don't want to overwrite the initialized map data with null blobs / 0 values.
            // See: login_helpers.cpp saveCharacter() and charutils::LoadChar
            std::memset(&destination, 0x00, sizeof(T));
            std::memcpy(&destination, blobStr.c_str(), std::min(sizeof(T), blobStr.length()));
        }
    }

    // @brief Escape a string for use in a query.
    // @param str The string to escape.
    // @return The escaped string.
    auto escapeString(std::string const& str) -> std::string;

    // @brief Get the database schema.
    // @return The database schema.
    // @note This is the database name, ie. xidb.
    auto getDatabaseSchema() -> std::string;

    // @brief Get the database version.
    // @return The database version.
    // @note This is the version of the database software, ie. MariaDB 10.6.12-MariaDB.
    auto getDatabaseVersion() -> std::string;

    // @brief Get the driver version.
    // @return The driver version.
    // @note This is the version of the database driver, ie. MariaDB Connector/C++ 1.0.3
    auto getDriverVersion() -> std::string;

    void checkCharset();
    void checkTriggers();

    bool setAutoCommit(bool value);
    bool getAutoCommit();

    bool transactionStart();
    bool transactionCommit();
    bool transactionRollback();

    void enableTimers();

    // Execute a transaction with the given transaction function.
    //
    // Will handle maintenance of the autocommit state and rollback the transaction if the transaction function throws.
    // Otherwise will commit the transaction. on successful completion of the transaction function.
    //
    // Returns true if the transaction was successful and committed or false if the transaction was rolled back.
    bool transaction(const std::function<void()>& transactionFn);
} // namespace db
