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
#include <optional>
#include <string>
#include <string_view>
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

    // SELECT-like result. The schema is shared (and owned) across all result sets of one statement.
    // Cells are one flat row-major grid (rows x schema columns), so a whole result set costs one
    // cell allocation rather than one per row.
    LibMariaDBResultSet(const std::string& query, std::shared_ptr<const ColumnSchema> schema, std::vector<Cell> cells);

    // UPDATE-like result.
    LibMariaDBResultSet(std::size_t rowsAffected, const std::string& query);

protected:
    auto rawNext() -> bool override;
    auto rawRowsCount() const -> std::size_t override;
    auto rawColumnCount() const -> std::size_t override;
    auto rawColumnIndex(std::string_view key) const -> std::optional<std::size_t> override;
    auto rawColumnLabel(std::size_t index) const -> std::string override;
    auto rawIsNull(std::size_t index) const -> bool override;

    auto rawGetInt64(std::size_t index) const -> int64 override;
    auto rawGetUInt64(std::size_t index) const -> uint64 override;
    auto rawGetInt32(std::size_t index) const -> int32 override;
    auto rawGetUInt32(std::size_t index) const -> uint32 override;
    auto rawGetInt16(std::size_t index) const -> int16 override;
    auto rawGetUInt16(std::size_t index) const -> uint16 override;
    auto rawGetInt8(std::size_t index) const -> int8 override;
    auto rawGetUInt8(std::size_t index) const -> uint8 override;
    auto rawGetBool(std::size_t index) const -> bool override;
    auto rawGetFloat(std::size_t index) const -> float override;
    auto rawGetDouble(std::size_t index) const -> double override;
    auto rawGetString(std::size_t index) const -> std::string override;
    auto rawGetBlobBytes(std::size_t index) const -> std::string override;

private:
    auto cellAt(std::size_t index) const -> const Cell&;

    static auto toInt64(const Cell& cell) -> int64;
    static auto toUInt64(const Cell& cell) -> uint64;
    static auto toDouble(const Cell& cell) -> double;
    static auto toText(const Cell& cell) -> std::string;

    std::shared_ptr<const ColumnSchema> schema_;
    std::vector<Cell>                   cells_;
    std::size_t                         columnCount_ = 0;
    std::size_t                         rowCount_    = 0;
    std::ptrdiff_t                      cursor_      = -1;
};

} // namespace db
