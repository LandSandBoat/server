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
    void populatePreparedStatements(std::unique_ptr<sql::Connection>& conn);

    auto getConnection() -> std::unique_ptr<sql::Connection>;
    auto query(std::string_view query) -> std::unique_ptr<sql::ResultSet>;

    // TODO: Template voodoo
    auto preparedStmt(PreparedStatement preparedStmt, uint32 id) -> std::unique_ptr<sql::ResultSet>;
} // namespace db
