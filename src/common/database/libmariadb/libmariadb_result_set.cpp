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

db::LibMariaDBResultSet::LibMariaDBResultSet(std::string_view query, std::shared_ptr<const ColumnSchema> schema, std::vector<Cell> cells)
: ResultSet(std::string(query), ResultSetType::Select)
, schema_(std::move(schema))
, cells_(std::move(cells))
{
    if (schema_ != nullptr)
    {
        columnCount_ = schema_->names.size();
    }

    if (columnCount_ != 0)
    {
        rowCount_ = cells_.size() / columnCount_;
    }
}

db::LibMariaDBResultSet::LibMariaDBResultSet(std::size_t rowsAffected, std::string_view query)
: ResultSet(std::string(query), ResultSetType::Update, rowsAffected)
{
}

auto db::LibMariaDBResultSet::rawNext() -> bool
{
    ++cursor_;
    return cursor_ >= 0 && static_cast<std::size_t>(cursor_) < rowCount_;
}

auto db::LibMariaDBResultSet::rawRowsCount() const -> std::size_t
{
    return rowCount_;
}

auto db::LibMariaDBResultSet::rawColumnCount() const -> std::size_t
{
    return columnCount_;
}

auto db::LibMariaDBResultSet::rawColumnIndex(std::string_view key) const -> std::optional<std::size_t>
{
    if (schema_ == nullptr)
    {
        return std::nullopt;
    }

    const auto it = schema_->index.find(key);
    if (it == schema_->index.end())
    {
        return std::nullopt;
    }

    return it->second;
}

auto db::LibMariaDBResultSet::rawColumnLabel(std::size_t index) const -> std::string
{
    if (schema_ != nullptr && index < schema_->names.size())
    {
        return schema_->names[index];
    }

    return {};
}

auto db::LibMariaDBResultSet::rawIsNull(std::size_t index) const -> bool
{
    return std::holds_alternative<std::monostate>(cellAt(index));
}

auto db::LibMariaDBResultSet::rawGetInt64(std::size_t index) const -> int64
{
    return toInt64(cellAt(index));
}

auto db::LibMariaDBResultSet::rawGetUInt64(std::size_t index) const -> uint64
{
    return toUInt64(cellAt(index));
}

auto db::LibMariaDBResultSet::rawGetInt32(std::size_t index) const -> int32
{
    return static_cast<int32>(toInt64(cellAt(index)));
}

auto db::LibMariaDBResultSet::rawGetUInt32(std::size_t index) const -> uint32
{
    return static_cast<uint32>(toUInt64(cellAt(index)));
}

auto db::LibMariaDBResultSet::rawGetInt16(std::size_t index) const -> int16
{
    return static_cast<int16>(toInt64(cellAt(index)));
}

auto db::LibMariaDBResultSet::rawGetUInt16(std::size_t index) const -> uint16
{
    return static_cast<uint16>(toUInt64(cellAt(index)));
}

auto db::LibMariaDBResultSet::rawGetInt8(std::size_t index) const -> int8
{
    return static_cast<int8>(toInt64(cellAt(index)));
}

auto db::LibMariaDBResultSet::rawGetUInt8(std::size_t index) const -> uint8
{
    return static_cast<uint8>(toUInt64(cellAt(index)));
}

auto db::LibMariaDBResultSet::rawGetBool(std::size_t index) const -> bool
{
    return toInt64(cellAt(index)) != 0;
}

auto db::LibMariaDBResultSet::rawGetFloat(std::size_t index) const -> float
{
    return static_cast<float>(toDouble(cellAt(index)));
}

auto db::LibMariaDBResultSet::rawGetDouble(std::size_t index) const -> double
{
    return toDouble(cellAt(index));
}

auto db::LibMariaDBResultSet::rawGetString(std::size_t index) const -> std::string
{
    return toText(cellAt(index));
}

auto db::LibMariaDBResultSet::rawGetBlobBytes(std::size_t index) const -> std::string
{
    // Blob/text columns are stored as a std::string holding the full bytes.
    return toText(cellAt(index));
}

auto db::LibMariaDBResultSet::cellAt(std::size_t index) const -> const Cell&
{
    static const Cell nullCell{};

    if (cursor_ < 0 || static_cast<std::size_t>(cursor_) >= rowCount_ || index >= columnCount_)
    {
        return nullCell;
    }

    return cells_[static_cast<std::size_t>(cursor_) * columnCount_ + index];
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
