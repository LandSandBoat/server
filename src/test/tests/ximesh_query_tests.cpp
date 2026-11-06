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

#include "map/ximesh/ximesh_impl.h"

#include <catch2/catch_approx.hpp>
#include <catch2/catch_test_macros.hpp>

TEST_CASE("XiMesh query selects the nearer floor across a cell boundary", "[ximesh]")
{
    const XiMeshImpl mesh("ximeshes/Northern_San_dOria.ximesh");

    // The nearer floor at this stair landing is indexed by a neighboring cell.
    const auto hit = mesh.query(-135.6f, 6.15f, 181.5f);
    REQUIRE(hit);
    CHECK(hit->y == Catch::Approx(7.9921875f).margin(.01f));
}
