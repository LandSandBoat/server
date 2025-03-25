/*
===========================================================================

  Copyright (c) 2022 LandSandBoat Devs

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

// Ahead of <math.h> (not <cmath>)
#ifndef _USE_MATH_DEFINES
#define _USE_MATH_DEFINES
#endif // _USE_MATH_DEFINES
#include <math.h>

#include <algorithm>
#include <any>
#include <array>
#include <atomic>
#include <bitset>
#include <cassert>
#include <cctype>
#include <cerrno>
#include <cfloat>
#include <charconv>
#include <chrono>
#include <cinttypes>
#include <climits>
#include <condition_variable>
#include <csignal>
#include <cstdarg>
#include <cstddef>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <ctime>
#include <deque>
#include <exception>
#include <filesystem>
#include <fstream>
#include <functional>
#include <initializer_list>
#include <iostream>
#include <iterator>
#include <limits>
#include <list>
#include <memory>
#include <mutex>
#include <numeric>
#include <optional>
#include <queue>
#include <ranges>
#include <regex>
#include <set>
#include <sstream>
#include <stack>
#include <stdexcept>
#include <string>
#include <string_view>
#include <thread>
#include <tuple>
#include <type_traits>
#include <typeindex>
#include <typeinfo>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <variant>
#include <vector>

#include "common/blowfish.h"
#include "common/cbasetypes.h"
#include "common/circular_buffer.h"
#include "common/database.h"
#include "common/debug.h"
#include "common/ipp.h"
#include "common/lazy.h"
#include "common/logging.h"
#include "common/lua.h"
#include "common/macros.h"
#include "common/md52.h"
#include "common/mmo.h"
#include "common/settings.h"
#include "common/singleton.h"
#include "common/sql.h"
#include "common/task_manager.h"
#include "common/timer.h"
#include "common/tracy.h"
#include "common/utils.h"
#include "common/uuid.h"
#include "common/vana_time.h"
#include "common/version.h"
#include "common/xi.h"
#include "common/xirand.h"
#include "common/zlib.h"

#include <argparse/argparse.hpp>
#include <asio.hpp>
#include <concurrentqueue.h>
#include <nonstd/jthread.hpp>

#include <fmt/chrono.h>
#include <fmt/core.h>
#include <fmt/format.h>
#include <fmt/printf.h>

#include <spdlog/common.h>
#include <spdlog/spdlog.h>

#include "map_constants.h"
