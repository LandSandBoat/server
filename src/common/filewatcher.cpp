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
        fileWatcherImpl->addWatch(path, this, true);
    }
    fileWatcherImpl->watch();
}

// cppcheck-suppress passedByValue
void Filewatcher::handleFileAction(efsw::WatchID watchid, std::string const& dir, std::string const& filename, efsw::Action action, std::string oldFilename)
{
    TracySetThreadName("Filewatcher Thread");
    TracyZoneScoped;
    std::filesystem::path fullPath = dir + "/" + filename;
    switch (action)
    {
        case efsw::Actions::Add:
            actionQueue.enqueue({fullPath, Action::Add});
            break;
        case efsw::Actions::Delete:
            actionQueue.enqueue({fullPath, Action::Delete});
            break;
        case efsw::Actions::Modified:
            actionQueue.enqueue({fullPath, Action::Modified});
            break;
        case efsw::Actions::Moved:
            actionQueue.enqueue({fullPath, Action::Moved});
            break;
        default:
            break;
    }
}

auto Filewatcher::getActionQueue() -> std::vector<std::pair<std::filesystem::path, Action>>
{
    std::set<std::pair<std::filesystem::path, Action>> actions; // For de-duping

    std::pair<std::filesystem::path, Action> action;
    while (actionQueue.try_dequeue(action))
    {
        if (action.first.extension() == ".lua")
        {
            std::string filename = action.first.relative_path().generic_string();
            actions.insert({filename, action.second});
        }
    }

    std::vector<std::pair<std::filesystem::path, Action>> results;
    results.reserve(actions.size());

    for (auto const& [filename, action] : actions)
    {
        results.emplace_back(filename, action);
    }

    return results;
}
