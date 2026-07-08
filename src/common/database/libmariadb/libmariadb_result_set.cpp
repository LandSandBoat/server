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

#include <common/database/libmariadb/libmariadb_result_set.h>

#include <cstdlib>
#include <type_traits>
#include <utility>

db::LibMariaDBResultSet::LibMariaDBResultSet(const std::string& query, std::shared_ptr<const ColumnSchema> schema, std::vector<Row> rows)
: ResultSet(query, ResultSetType::Select)
, schema_(std::move(schema))
, rows_(std::move(rows))
{
}

db::LibMariaDBResultSet::LibMariaDBResultSet(std::size_t rowsAffected, const std::string& query)
: ResultSet(query, ResultSetType::Update, rowsAffected)
{
}

auto db::LibMariaDBResultSet::rawNext() -> bool
{
    ++cursor_;
    return cursor_ >= 0 && static_cast<std::size_t>(cursor_) < rows_.size();
}

auto db::LibMariaDBResultSet::rawRowsCount() const -> std::size_t
{
    return rows_.size();
}

auto db::LibMariaDBResultSet::rawColumnCount() const -> std::size_t
{
    return schema_ ? schema_->names.size() : 0;
}

auto db::LibMariaDBResultSet::rawIsNull(const std::string& key) const -> bool
{
    return std::holds_alternative<std::monostate>(cellAt(key));
}

auto db::LibMariaDBResultSet::rawColumnLabel(uint32 index) const -> std::string
{
    // index is 1-based.
    if (schema_ && index >= 1 && static_cast<std::size_t>(index) <= schema_->names.size())
    {
        return schema_->names[index - 1];
    }
    return {};
}

auto db::LibMariaDBResultSet::rawGetInt64(const std::string& key) const -> int64
{
    return toInt64(cellAt(key));
}

auto db::LibMariaDBResultSet::rawGetUInt64(const std::string& key) const -> uint64
{
    return toUInt64(cellAt(key));
}

auto db::LibMariaDBResultSet::rawGetInt32(const std::string& key) const -> int32
{
    return static_cast<int32>(toInt64(cellAt(key)));
}

auto db::LibMariaDBResultSet::rawGetUInt32(const std::string& key) const -> uint32
{
    return static_cast<uint32>(toUInt64(cellAt(key)));
}

auto db::LibMariaDBResultSet::rawGetInt16(const std::string& key) const -> int16
{
    return static_cast<int16>(toInt64(cellAt(key)));
}

auto db::LibMariaDBResultSet::rawGetUInt16(const std::string& key) const -> uint16
{
    return static_cast<uint16>(toUInt64(cellAt(key)));
}

auto db::LibMariaDBResultSet::rawGetInt8(const std::string& key) const -> int8
{
    return static_cast<int8>(toInt64(cellAt(key)));
}

auto db::LibMariaDBResultSet::rawGetUInt8(const std::string& key) const -> uint8
{
    return static_cast<uint8>(toUInt64(cellAt(key)));
}

auto db::LibMariaDBResultSet::rawGetBool(const std::string& key) const -> bool
{
    return toInt64(cellAt(key)) != 0;
}

auto db::LibMariaDBResultSet::rawGetFloat(const std::string& key) const -> float
{
    return static_cast<float>(toDouble(cellAt(key)));
}

auto db::LibMariaDBResultSet::rawGetDouble(const std::string& key) const -> double
{
    return toDouble(cellAt(key));
}

auto db::LibMariaDBResultSet::rawGetString(const std::string& key) const -> std::string
{
    return toText(cellAt(key));
}

auto db::LibMariaDBResultSet::rawGetBlobBytes(const std::string& key) const -> std::string
{
    // Blob/text columns are stored as a std::string holding the full bytes.
    return toText(cellAt(key));
}

auto db::LibMariaDBResultSet::cellAt(const std::string& key) const -> const Cell&
{
    static const Cell nullCell{};

    if (!schema_)
    {
        return nullCell;
    }

    const auto it = schema_->index.find(key);
    if (it == schema_->index.end())
    {
        return nullCell;
    }

    if (cursor_ < 0 || static_cast<std::size_t>(cursor_) >= rows_.size())
    {
        return nullCell;
    }

    return rows_[cursor_][it->second];
}

auto db::LibMariaDBResultSet::toInt64(const Cell& cell) -> int64
{
    return std::visit(
        [](const auto& v) -> int64
        {
            using U = std::remove_cvref_t<decltype(v)>;
            if constexpr (std::is_same_v<U, std::monostate>)
            {
                return 0;
            }
            else if constexpr (std::is_same_v<U, std::string>)
            {
                return std::strtoll(v.c_str(), nullptr, 10);
            }
            else
            {
                return static_cast<int64>(v);
            }
        },
        cell);
}

auto db::LibMariaDBResultSet::toUInt64(const Cell& cell) -> uint64
{
    return std::visit(
        [](const auto& v) -> uint64
        {
            using U = std::remove_cvref_t<decltype(v)>;
            if constexpr (std::is_same_v<U, std::monostate>)
            {
                return 0;
            }
            else if constexpr (std::is_same_v<U, std::string>)
            {
                return std::strtoull(v.c_str(), nullptr, 10);
            }
            else
            {
                return static_cast<uint64>(v);
            }
        },
        cell);
}

auto db::LibMariaDBResultSet::toDouble(const Cell& cell) -> double
{
    return std::visit(
        [](const auto& v) -> double
        {
            using U = std::remove_cvref_t<decltype(v)>;
            if constexpr (std::is_same_v<U, std::monostate>)
            {
                return 0.0;
            }
            else if constexpr (std::is_same_v<U, std::string>)
            {
                return std::strtod(v.c_str(), nullptr);
            }
            else
            {
                return static_cast<double>(v);
            }
        },
        cell);
}

auto db::LibMariaDBResultSet::toText(const Cell& cell) -> std::string
{
    return std::visit(
        [](const auto& v) -> std::string
        {
            using U = std::remove_cvref_t<decltype(v)>;
            if constexpr (std::is_same_v<U, std::monostate>)
            {
                return {};
            }
            else if constexpr (std::is_same_v<U, std::string>)
            {
                return v;
            }
            else
            {
                return std::to_string(v);
            }
        },
        cell);
}
