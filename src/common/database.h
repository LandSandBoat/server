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

// Umbrella header for the database layer.
//
// The real implementations live under common/database/. Consumers should keep including
// <common/database.h>; this pulls in the connector-agnostic public interface: the abstract
// Database/ResultSet/PreparedStatement, the templated preparedStmt/get<T> binding, the blob
// helpers and the free functions.
//
// The concrete MariaDB Connector/C++ backend is deliberately NOT included here, so the
// connector header (and its warning workaround) no longer leaks into every translation unit.

#include <common/database/database.h>
