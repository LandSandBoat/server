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

#include "cbasetypes.h"

#include <filesystem>
#include <memory>
#include <string>
#include <vector>

#include <concurrentqueue.h>
#include <efsw/efsw.hpp>

class Filewatcher : public efsw::FileWatchListener
{
public:
    Filewatcher(std::vector<std::string> const& paths);
    ~Filewatcher() override;

    DISALLOW_COPY_AND_MOVE(Filewatcher);

    // efsw::FileWatchListener
    void handleFileAction(efsw::WatchID watchid, std::string const& dir, std::string const& filename, efsw::Action action, std::string oldFilename) override;

    enum class Action
    {
        Add      = 1,
        Delete   = 2,
        Modified = 3,
        Moved    = 4,
    };

    auto popChangedLuaFilesList() -> std::vector<std::pair<std::filesystem::path, Action>>;

private:
    std::unique_ptr<efsw::FileWatcher> fileWatcherImpl;
    std::vector<std::string>           basePaths;
    std::vector<long>                  registedWatchIds;

    moodycamel::ConcurrentQueue<std::pair<std::filesystem::path, Action>> actionQueue;
};
