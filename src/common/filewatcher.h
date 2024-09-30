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

    auto getChangedLuaFiles() -> std::vector<std::pair<std::filesystem::path, Action>>;

private:
    std::unique_ptr<efsw::FileWatcher> fileWatcherImpl;
    std::vector<std::string>           basePaths;
    std::vector<long>                  registedWatchIds;

    moodycamel::ConcurrentQueue<std::pair<std::filesystem::path, Action>> actionQueue;
};
