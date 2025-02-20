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

#include "filewatcher.h"

#include "tracy.h"

#include <filesystem>
#include <memory>
#include <set>
#include <string>

Filewatcher::Filewatcher(std::vector<std::string> const& paths)
#ifdef USE_GENERIC_FILEWATCHER
: fileWatcherImpl(std::make_unique<efsw::FileWatcher>(true))
#else
: fileWatcherImpl(std::make_unique<efsw::FileWatcher>(false))
#endif
, basePaths(paths)
{
    for (auto& path : paths)
    {
        const auto watchId = fileWatcherImpl->addWatch(path, this, true);
        registedWatchIds.push_back(watchId);
    }
    fileWatcherImpl->watch();
}

Filewatcher::~Filewatcher()
{
    for (const auto watchId : registedWatchIds)
    {
        fileWatcherImpl->removeWatch(watchId);
    }
}

// cppcheck-suppress passedByValue
void Filewatcher::handleFileAction(efsw::WatchID watchid, std::string const& dir, std::string const& filename, efsw::Action action, std::string oldFilename)
{
    TracySetThreadName("Filewatcher Thread");
    TracyZoneScoped;

    const auto fullPath = std::filesystem::path(dir + filename);
    switch (action)
    {
        case efsw::Actions::Add:
            actionQueue.enqueue({ fullPath, Action::Add });
            break;
        case efsw::Actions::Delete:
            actionQueue.enqueue({ fullPath, Action::Delete });
            break;
        case efsw::Actions::Modified:
            actionQueue.enqueue({ fullPath, Action::Modified });
            break;
        case efsw::Actions::Moved:
            actionQueue.enqueue({ fullPath, Action::Moved });
            break;
        default:
            break;
    }
}

auto Filewatcher::popChangedLuaFilesList() -> std::vector<std::pair<std::filesystem::path, Action>>
{
    std::set<std::pair<std::filesystem::path, Action>> actions; // For de-duping

    {
        std::pair<std::filesystem::path, Action> actionPair;
        while (actionQueue.try_dequeue(actionPair))
        {
            const auto [path, action] = actionPair;
            if (path.extension() == ".lua")
            {
                actions.insert({ path.relative_path(), action });
            }
        }
    }

    std::vector<std::pair<std::filesystem::path, Action>> results;
    results.reserve(actions.size());

    for (auto const& [path, action] : actions)
    {
        results.emplace_back(path, action);
    }

    return results;
}
