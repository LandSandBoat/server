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

#include <common/database/result_set.h>

#include <common/types/hash_map.h>

#include <cstddef>
#include <memory>
#include <string>
#include <variant>

namespace db
{

struct ColumnSchema
{
    std::vector<std::string>          names;
    HashMap<std::string, std::size_t> index;
};

class LibMariaDBResultSet final : public ResultSet
{
public:
    using Cell = std::variant<std::monostate, int64, uint64, double, std::string>;
    using Row  = std::vector<Cell>;

    // SELECT-like result. The schema is shared (and owned) across all result sets of one statement.
    LibMariaDBResultSet(const std::string& query, std::shared_ptr<const ColumnSchema> schema, std::vector<Row> rows);

    // UPDATE-like result.
    LibMariaDBResultSet(std::size_t rowsAffected, const std::string& query);

protected:
    auto rawNext() -> bool override;
    auto rawRowsCount() const -> std::size_t override;
    auto rawColumnCount() const -> std::size_t override;
    auto rawIsNull(const std::string& key) const -> bool override;
    auto rawColumnLabel(uint32 index) const -> std::string override;

    auto rawGetInt64(const std::string& key) const -> int64 override;
    auto rawGetUInt64(const std::string& key) const -> uint64 override;
    auto rawGetInt32(const std::string& key) const -> int32 override;
    auto rawGetUInt32(const std::string& key) const -> uint32 override;
    auto rawGetInt16(const std::string& key) const -> int16 override;
    auto rawGetUInt16(const std::string& key) const -> uint16 override;
    auto rawGetInt8(const std::string& key) const -> int8 override;
    auto rawGetUInt8(const std::string& key) const -> uint8 override;
    auto rawGetBool(const std::string& key) const -> bool override;
    auto rawGetFloat(const std::string& key) const -> float override;
    auto rawGetDouble(const std::string& key) const -> double override;
    auto rawGetString(const std::string& key) const -> std::string override;
    auto rawGetBlobBytes(const std::string& key) const -> std::string override;

private:
    auto cellAt(const std::string& key) const -> const Cell&;

    static auto toInt64(const Cell& cell) -> int64;
    static auto toUInt64(const Cell& cell) -> uint64;
    static auto toDouble(const Cell& cell) -> double;
    static auto toText(const Cell& cell) -> std::string;

    std::shared_ptr<const ColumnSchema> schema_;
    std::vector<Row>                    rows_;
    std::ptrdiff_t                      cursor_ = -1;
};

} // namespace db
