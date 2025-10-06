/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Team

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

// Search Server Precompiled Headers
// This builds upon the common PCH and adds search-specific headers

// Include the base common PCH first
#include "../common/pch_common.h"

// Search-specific headers
// The search server is typically smaller, so focus on core functionality

// Search server application
#include "search_application.h"
#include "search_engine.h"

// Data structures for search
#include <regex>         // For pattern matching
#include <set>           // For sorted results
#include <unordered_map> // For search indexing

// Search-specific utilities
// (Add specific headers based on search server analysis if needed)