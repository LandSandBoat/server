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

// Common Base Precompiled Headers (Tier 1)
// This is the foundation tier - only include headers used across ALL targets
// Target-specific PCH files should include this file first

// Platform-specific definitions (used everywhere)
#ifdef _WIN32
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#ifndef NOMINMAX
#define NOMINMAX
#endif
#include <windows.h>
#endif

// Core C++ standard library headers (universally used)
// Only the most fundamental ones - avoid low-usage headers
#include <algorithm>  // STL algorithms (frequent)
#include <cstring>    // 16.4% usage in xi_map, likely used in others
#include <functional> // Function objects (common)
#include <memory>     // Memory management (universal)
#include <string>     // String handling (universal)
#include <vector>     // Most common container

// Common project headers used across multiple targets
#include "common/database.h" // Database access (used across servers)
#include "common/logging.h"  // 11.7% usage in xi_map, 36.4% in xi_connect
#include "common/timer.h"    // Timing utilities (common infrastructure)
#include "common/utils.h"    // 13.7% usage in xi_map, 18.2% in xi_connect

// External libraries used across all targets
#include <fmt/format.h>    // Formatting library (universal)
#include <spdlog/spdlog.h> // Logging library (universal)

// Debug utilities (conditional compilation)
#ifndef NDEBUG
#include "debug.h" // Debug utilities when debugging
#endif

// Tracy profiling (conditional)
#ifdef ENABLE_TRACY
#include "tracy.h"
#endif

// REMOVED from base tier (moved to target-specific or eliminated):
// - array, cassert, chrono, cstddef, cstdint (low usage/specific)
// - iostream (not frequently used in server code)
// - mutex, optional, string_view (C++17/specific use cases)
// - unordered_map, utility (container/utility specific)
