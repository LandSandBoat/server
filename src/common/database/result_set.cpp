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

#include <common/database/result_set.h>

#include <common/logging.h>

#include <utility>

db::ResultSet::ResultSet(std::string query, ResultSetType type, std::size_t rowsAffected)
: query_(std::move(query))
, type_(type)
, rowsAffected_(rowsAffected)
{
}

auto db::ResultSet::type() const -> ResultSetType
{
    return type_;
}

auto db::ResultSet::query() const -> const std::string&
{
    return query_;
}

auto db::ResultSet::next() -> bool
{
    if (type_ != ResultSetType::Select)
    {
        ShowErrorFmt("ResultSet::next: Invalid type {}", static_cast<int>(type_));
        ShowErrorFmt("Query: {}", query_);
        return false;
    }

    return rawNext();
}

auto db::ResultSet::rowsCount() const -> uint32
{
    if (type_ != ResultSetType::Select)
    {
        ShowErrorFmt("ResultSet::rowsCount: Invalid type {}", static_cast<int>(type_));
        ShowErrorFmt("Query: {}", query_);
        return 0;
    }

    DebugSQLFmt("rowsCount: {}", rawRowsCount());
    return static_cast<uint32>(rawRowsCount());
}

auto db::ResultSet::rowsAffected() const -> uint32
{
    if (type_ != ResultSetType::Update)
    {
        ShowErrorFmt("ResultSet::rowsAffected: Invalid type {}", static_cast<int>(type_));
        ShowErrorFmt("Query: {}", query_);
        return 0;
    }

    DebugSQLFmt("rowsAffected: {}", rowsAffected_);
    return static_cast<uint32>(rowsAffected_);
}

auto db::ResultSet::columnCount() const -> uint32
{
    if (type_ != ResultSetType::Select)
    {
        ShowErrorFmt("ResultSet::columnCount: Invalid type {}", static_cast<int>(type_));
        ShowErrorFmt("Query: {}", query_);
        return 0;
    }

    return static_cast<uint32>(rawColumnCount());
}

auto db::ResultSet::columnName(uint32 index) const -> std::string
{
    if (type_ != ResultSetType::Select)
    {
        ShowErrorFmt("ResultSet::columnName: Invalid type {}", static_cast<int>(type_));
        ShowErrorFmt("Query: {}", query_);
        return {};
    }

    return rawColumnLabel(index + 1);
}

auto db::ResultSet::isNull(const std::string& key) const -> bool
{
    if (type_ != ResultSetType::Select)
    {
        ShowErrorFmt("ResultSet::isNull: Invalid type {}", static_cast<int>(type_));
        ShowErrorFmt("Query: {}", query_);
        return false;
    }

    return rawIsNull(key);
}

auto db::ResultSet::getBlobBytes(const std::string& key) const -> std::string
{
    if (type_ != ResultSetType::Select)
    {
        ShowErrorFmt("ResultSet::getBlobBytes: Invalid type {}", static_cast<int>(type_));
        ShowErrorFmt("Query: {}", query_);
        return {};
    }

    return rawGetBlobBytes(key);
}
