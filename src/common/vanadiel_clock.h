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

#include <chrono>

#include "cbasetypes.h"
#include "earth_time.h"

namespace xi
{

class vanadiel_clock
{
private:
    using millisecond_ratio = std::ratio<1, 25000>; // (1Vms/25000ms) * 1000Vms * 60Vs = 1 Vmin
    using second_ratio      = std::ratio_multiply<millisecond_ratio, std::ratio<1000>>;
    using minute_ratio      = std::ratio_multiply<second_ratio, std::ratio<60>>; // 2.4 Earth seconds
    using hour_ratio        = std::ratio_multiply<minute_ratio, std::ratio<60>>; //  60 Vana'diel minutes
    using day_ratio         = std::ratio_multiply<hour_ratio, std::ratio<24>>;   //  24 Vana'diel hours
    using week_ratio        = std::ratio_multiply<day_ratio, std::ratio<8>>;     //   8 Vana'diel days
    using month_ratio       = std::ratio_multiply<day_ratio, std::ratio<30>>;    //  30 Vana'diel days
    using year_ratio        = std::ratio_multiply<day_ratio, std::ratio<360>>;   // 360 Vana'diel days

public:
    using milliseconds = std::chrono::duration<long long, millisecond_ratio>;
    using seconds      = std::chrono::duration<long long, second_ratio>;
    using minutes      = std::chrono::duration<long long, minute_ratio>;
    using hours        = std::chrono::duration<long long, hour_ratio>;
    using days         = std::chrono::duration<long long, day_ratio>;
    using weeks        = std::chrono::duration<long long, week_ratio>;
    using months       = std::chrono::duration<long long, month_ratio>;
    using years        = std::chrono::duration<long long, year_ratio>;

    using duration              = milliseconds;
    using rep                   = duration::rep;
    using period                = duration::period;
    using time_point            = std::chrono::time_point<vanadiel_clock>;
    static const bool is_steady = false;

    static time_point now() noexcept
    {
        return time_point{ std::chrono::duration_cast<duration>(earth_time::now() - earth_time::vanadiel_epoch) };
    }
};

} // namespace xi
