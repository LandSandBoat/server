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

// Map Server Precompiled Headers
// This builds upon the common PCH and adds map-specific headers

// Include the base common PCH first
#include "../common/pch_common.h"

// Map-specific headers based on usage analysis
// These are the most frequently used headers in the map server

// entities/charentity.h - 56.6% usage (252/445 files) - CRITICAL for map server
#include "entities/charentity.h"

// utils/charutils.h - 20.2% usage (90/445 files) - Very common
#include "utils/charutils.h"

// status_effect_container.h - 16.4% usage (73/445 files) - Common
#include "status_effect_container.h"

// ai/ai_container.h - 12.8% usage (57/445 files) - Map-specific
#include "ai/ai_container.h"

// lua/luautils.h - 11.7% usage (52/445 files) - Scripting system
#include "lua/luautils.h"

// utils/zoneutils.h - 8.8% usage (39/445 files) - Zone management
#include "utils/zoneutils.h"

// utils/itemutils.h - 8.5% usage (38/445 files) - Item system
#include "utils/itemutils.h"

// entities/battleentity.h - 7.6% usage (34/445 files) - Combat system
#include "entities/battleentity.h"

// entities/baseentity.h - 7.0% usage (31/445 files) - Entity base class
#include "entities/baseentity.h"

// utils/battleutils.h - 6.7% usage (30/445 files) - Battle calculations
#include "utils/battleutils.h"

// entities/mobentity.h - 6.3% usage (28/445 files) - Monster entities
#include "entities/mobentity.h"