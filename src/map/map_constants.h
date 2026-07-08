/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include <array>
#include <chrono>
#include <cstdint>

using namespace std::chrono_literals;

// TODO: Move this file to common/constants.h

//
// There are 2 types of updates, with similar names but different functions:
// - The time server tick interval is every 2400ms, and is used for things like status effect ticks, etc. (the same as the FFXI tick)
// - The server logic update interval is every 400ms, and is used for things like AI updates, etc.
//

static constexpr auto kTimeServerTickInterval = 2400ms;

// 2.5 logic updates per second
static constexpr auto kLogicUpdateRate = 2.5f;

// Tick/update every 400ms
// NOTE: Many things are tied to and balanced around this rate, so changing it will have a significant impact on gameplay.
//     : ie. DO NOT CHANGE!
static constexpr auto kLogicUpdateInterval = std::chrono::milliseconds(static_cast<uint64>(1000.0f / kLogicUpdateRate));

// Check Trigger Areas 2x as often as the server tick rate (200ms)
static constexpr auto kTriggerAreaInterval = std::chrono::milliseconds(static_cast<uint64>(1000.0f / (kLogicUpdateRate * 2.0f)));

// SpawnHandler tick interval (30s) and spawn window (half of interval)
static constexpr auto kSpawnHandlerInterval = 30s;
static constexpr auto kSpawnHandlerWindow   = kSpawnHandlerInterval / 2;

// If the main loop is more than 200ms behind, we're in trouble.
static constexpr auto kMainThreadBacklogThreshold = 200ms;

// The rate at which we cleanup timed-out and finished sessions
static constexpr auto kSessionCleanupInterval = 5s;

// The rate at which we force Lua garbage collections
static constexpr auto kGarbageCollectionInterval = 15min;

// The rate at which we persist any outstanding changes to volatile server vars
static constexpr auto kPersistVolatileServerVarsInterval = 1min;

// The rate at which we pump the ZMQ queues
static constexpr auto kIPCPumpInterval = 100ms;

// Packet & networking constants
static constexpr auto kMaxBufferSize           = 2500U;
static constexpr auto kMaxPacketPerCompression = 32U;
static constexpr auto kMaxPacketBacklogSize    = kMaxPacketPerCompression * 6U; // If we hit this number, things are going very very badly.
