/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include <common/cbasetypes.h>
#include <common/logging.h>
#include <common/tracy.h>

#include <common/database/traits.h>

#include <algorithm>
#include <cstring>
#include <exception>
#include <iterator>
#include <optional>
#include <string>
#include <string_view>
#include <type_traits>

// @note Bind parameters in database-land are 1-indexed; result-set columns are 0-indexed.
namespace db
{

enum class ResultSetType
{
    Select,  // We can query the rset for data
    Update,  // The rset only has rowsCount()/rowsAffected() populated
    Invalid, // The query is invalid and we can't do anything with it
};

// Copy raw blob bytes over a trivially-copyable destination, zero-filling any tail the
// blob does not cover.
template <typename T>
auto copyBlobBytes(std::string_view bytes, T& destination) -> void
{
    static_assert(std::is_trivially_copyable_v<T>, "T must be trivially copyable");

    // Zero-initialize the destination object
    if constexpr (std::is_array_v<T>)
    {
        using Element = std::remove_extent_t<T>;
        std::fill(std::begin(destination), std::end(destination), Element{});
    }
    else if constexpr (std::is_assignable_v<T&, T>)
    {
        destination = T{};
    }
    else
    {
        std::fill_n(reinterpret_cast<uint8*>(&destination), sizeof(T), 0);
    }

    // Copy the blob into the destination object
    std::memcpy(&destination, bytes.data(), std::min(sizeof(T), bytes.size()));
}

// Forward declaration so ResultSet::get<T>() can reference it.
template <typename WrapperPtrT, typename T>
auto extractFromBlob(const WrapperPtrT& rset, std::string_view blobKey, T& destination) -> void;

class ResultSet
{
public:
    ResultSet(std::string query, ResultSetType type, std::size_t rowsAffected = 0);
    virtual ~ResultSet() = default;

    ResultSet(const ResultSet&)            = delete;
    ResultSet& operator=(const ResultSet&) = delete;

    auto type() const -> ResultSetType;
    auto query() const -> const std::string&;

    auto next() -> bool;

    auto rowsCount() const -> uint32;
    auto rowsAffected() const -> uint32;
    auto columnCount() const -> uint32;

    auto columnName(uint32 index) const -> std::string;

    auto isNull(std::string_view key) const -> bool;

    // Get the raw, untruncated bytes of a blob column.
    // Unlike get<std::string>, this preserves embedded nulls and the full length.
    auto getBlobBytes(std::string_view key) const -> std::string;

    // Get the value of the associated key.
    template <typename T>
    auto get(std::string_view key) const -> T;

    // Get the value of the 0-indexed column.
    template <typename T>
    auto get(uint32 index) const -> T;

    // Get the value of the associated key, or the default value if it is null/not-populated.
    template <typename T>
    auto getOrDefault(std::string_view key, T defaultValue) const -> T;

    // Get the value of the 0-indexed column, or the default value if it is null/not-populated.
    template <typename T>
    auto getOrDefault(uint32 index, T defaultValue) const -> T;

protected:
    // The raw accessors are 0-indexed. Names resolve to indices exactly once, in the public
    // key-based methods, so per-cell access does no string hashing.
    virtual auto rawNext() -> bool                                                        = 0;
    virtual auto rawRowsCount() const -> std::size_t                                      = 0;
    virtual auto rawColumnCount() const -> std::size_t                                    = 0;
    virtual auto rawColumnIndex(std::string_view key) const -> std::optional<std::size_t> = 0;
    virtual auto rawColumnLabel(std::size_t index) const -> std::string                   = 0;
    virtual auto rawIsNull(std::size_t index) const -> bool                               = 0;

    virtual auto rawGetInt64(std::size_t index) const -> int64           = 0;
    virtual auto rawGetUInt64(std::size_t index) const -> uint64         = 0;
    virtual auto rawGetInt32(std::size_t index) const -> int32           = 0;
    virtual auto rawGetUInt32(std::size_t index) const -> uint32         = 0;
    virtual auto rawGetInt16(std::size_t index) const -> int16           = 0;
    virtual auto rawGetUInt16(std::size_t index) const -> uint16         = 0;
    virtual auto rawGetInt8(std::size_t index) const -> int8             = 0;
    virtual auto rawGetUInt8(std::size_t index) const -> uint8           = 0;
    virtual auto rawGetBool(std::size_t index) const -> bool             = 0;
    virtual auto rawGetFloat(std::size_t index) const -> float           = 0;
    virtual auto rawGetDouble(std::size_t index) const -> double         = 0;
    virtual auto rawGetString(std::size_t index) const -> std::string    = 0;
    virtual auto rawGetBlobBytes(std::size_t index) const -> std::string = 0;

    std::string   query_;
    ResultSetType type_;
    std::size_t   rowsAffected_{ 0 };

private:
    template <typename T>
    auto getAtIndex(std::size_t index) const -> T;
};

//
// Out-of-line template definitions
//

template <typename T>
auto ResultSet::getAtIndex(const std::size_t index) const -> T
{
    // Enum support: use underlying type to select database accessor
    using UnderlyingT = detail::enum_decay_t<T>;
    UnderlyingT value{};

    if (rawIsNull(index))
    {
        // NULL is legitimate data (e.g. LEFT JOIN columns); callers wanting a fallback should
        // use getOrDefault(). Note it at debug level rather than spamming errors.
        DebugSQLFmt("ResultSet::get: column {} is null (Query: {})", index, query_);
        if constexpr (std::is_enum_v<T>)
        {
            return static_cast<T>(value);
        }
        else
        {
            return value;
        }
    }

    //
    // If the backend gets an invalid, incorrectly sized, or incorrectly signed value, it will throw
    // an exception. So we'll wrap the whole extraction step in try/catch.
    //

    try
    {
        if constexpr (std::is_same_v<UnderlyingT, int64>)
        {
            value = static_cast<UnderlyingT>(rawGetInt64(index));
        }
        else if constexpr (std::is_same_v<UnderlyingT, uint64>)
        {
            value = static_cast<UnderlyingT>(rawGetUInt64(index));
        }
        else if constexpr (std::is_same_v<UnderlyingT, int32>)
        {
            value = static_cast<UnderlyingT>(rawGetInt32(index));
        }
        else if constexpr (std::is_same_v<UnderlyingT, uint32>)
        {
            value = static_cast<UnderlyingT>(rawGetUInt32(index));
        }
        else if constexpr (std::is_same_v<UnderlyingT, int16>)
        {
            value = static_cast<UnderlyingT>(rawGetInt16(index));
        }
        else if constexpr (std::is_same_v<UnderlyingT, uint16>)
        {
            value = static_cast<UnderlyingT>(rawGetUInt16(index));
        }
        else if constexpr (std::is_same_v<UnderlyingT, int8>)
        {
            value = static_cast<UnderlyingT>(rawGetInt8(index));
        }
        else if constexpr (std::is_same_v<UnderlyingT, uint8>)
        {
            value = static_cast<UnderlyingT>(rawGetUInt8(index));
        }
        else if constexpr (std::is_same_v<UnderlyingT, bool>)
        {
            value = static_cast<UnderlyingT>(rawGetBool(index));
        }
        else if constexpr (std::is_same_v<UnderlyingT, double>)
        {
            value = static_cast<UnderlyingT>(rawGetDouble(index));
        }
        else if constexpr (std::is_same_v<UnderlyingT, float>)
        {
            value = static_cast<UnderlyingT>(rawGetFloat(index));
        }
        else if constexpr (std::is_same_v<UnderlyingT, std::string>)
        {
            value = rawGetString(index);
        }
        else if constexpr (std::is_same_v<UnderlyingT, size_t>)
        {
            // NOTE: Preserves the historical behaviour of reading size_t as a 32-bit unsigned value.
            value = static_cast<UnderlyingT>(rawGetUInt32(index));
        }
        else if constexpr (detail::is_blob_v<UnderlyingT>)
        {
            copyBlobBytes(rawGetBlobBytes(index), value);
        }
        else
        {
            static_assert(detail::always_false_v<T>, "Trying to extract unsupported type from ResultSet");
        }
    }
    catch (std::exception& e)
    {
        ShowErrorFmt("ResultSet::get: Error: {}", e.what());
        ShowErrorFmt("Column: {}", index);
        ShowErrorFmt("Query: {}", query_);
        return T{};
    }
    catch (...)
    {
        ShowErrorFmt("ResultSet::get: Unknown error");
        ShowErrorFmt("Column: {}", index);
        ShowErrorFmt("Query: {}", query_);
        return T{};
    }

    if constexpr (std::is_enum_v<T>)
    {
        return static_cast<T>(value);
    }
    else
    {
        return value;
    }
}

template <typename T>
auto ResultSet::get(std::string_view key) const -> T
{
    if (type_ != ResultSetType::Select)
    {
        ShowErrorFmt("ResultSet::get: Invalid type {}", static_cast<int>(type_));
        ShowErrorFmt("Query: {}", query_);
        return T{};
    }

    const auto index = rawColumnIndex(key);
    if (!index.has_value())
    {
        DebugSQLFmt("ResultSet::get: unknown column {} (Query: {})", key, query_);
        return T{};
    }

    return getAtIndex<T>(*index);
}

template <typename T>
auto ResultSet::get(const uint32 index) const -> T
{
    if (type_ != ResultSetType::Select)
    {
        ShowErrorFmt("ResultSet::get: Invalid type {}", static_cast<int>(type_));
        ShowErrorFmt("Query: {}", query_);
        return T{};
    }

    return getAtIndex<T>(index);
}

template <typename T>
auto ResultSet::getOrDefault(std::string_view key, T defaultValue) const -> T
{
    if (type_ != ResultSetType::Select)
    {
        ShowErrorFmt("ResultSet::getOrDefault: Invalid type {}", static_cast<int>(type_));
        ShowErrorFmt("Query: {}", query_);
        return defaultValue;
    }

    const auto index = rawColumnIndex(key);
    if (!index.has_value() || rawIsNull(*index))
    {
        return defaultValue;
    }

    return getAtIndex<T>(*index);
}

template <typename T>
auto ResultSet::getOrDefault(const uint32 index, T defaultValue) const -> T
{
    if (type_ != ResultSetType::Select)
    {
        ShowErrorFmt("ResultSet::getOrDefault: Invalid type {}", static_cast<int>(type_));
        ShowErrorFmt("Query: {}", query_);
        return defaultValue;
    }

    if (rawIsNull(index))
    {
        return defaultValue;
    }

    return getAtIndex<T>(index);
}

// @brief Extract a struct from a blob column.
// @param rset The result set to extract the blob from.
// @param blobKey The key of the blob in the result set.
// @param destination The struct to extract the blob into.
template <typename WrapperPtrT, typename T>
auto extractFromBlob(const WrapperPtrT& rset, std::string_view blobKey, T& destination) -> void
{
    TracyZoneScoped;

    // TODO: static_assert(std::is_trivial_v<T>, "T must be trivial");
    static_assert(std::is_trivially_copyable_v<T>, "T must be trivially copyable");

    // If we read a null blob we will get back garbage data.
    // This will introduce difficult to track down crashes.
    if (!rset->isNull(blobKey))
    {
        // getBlobBytes preserves the full length (including embedded nulls), unlike get<std::string>,
        // which would truncate the blob result.
        //
        // Login server creates new chars with null blobs. Map server then initializes.
        // We don't want to overwrite the initialized map data with null blobs / 0 values.
        // See: login_helpers.cpp saveCharacter() and charutils::LoadChar
        copyBlobBytes(rset->getBlobBytes(blobKey), destination);
    }
}

} // namespace db
