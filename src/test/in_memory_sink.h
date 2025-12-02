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

#include <mutex>
#include <spdlog/sinks/base_sink.h>
#include <string>
#include <vector>

class InMemorySink final : public spdlog::sinks::base_sink<std::mutex>
{
public:
    void clear()
    {
        logs_.clear();
    }

    auto logs() const -> const std::vector<std::string>&
    {
        return logs_;
    }

protected:
    void sink_it_(const spdlog::details::log_msg& msg) override
    {
        spdlog::memory_buf_t formatted;
        formatter_->format(msg, formatted);
        logs_.emplace_back(fmt::to_string(formatted));
    }

    void flush_() override
    {
    }

private:
    std::vector<std::string> logs_;
};
