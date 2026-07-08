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

#include <common/database/bound_value.h>
#include <common/database/result_set.h>

#include <memory>
#include <string>

namespace db
{

class PreparedStatement
{
public:
    virtual ~PreparedStatement() = default;

    // Bind a single value to the given (1-indexed) parameter slot.
    virtual auto bind(int index, const BoundValue& value) -> void = 0;

    // Execute as a SELECT-like query, returning a queryable result set.
    virtual auto executeQuery(const std::string& query) -> std::unique_ptr<ResultSet> = 0;

    // Execute as an UPDATE-like query, returning a rows-affected result set.
    virtual auto executeUpdate(const std::string& query) -> std::unique_ptr<ResultSet> = 0;
};

} // namespace db
