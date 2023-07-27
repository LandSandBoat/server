#pragma once

#include <filesystem>
#include <functional>
#include <memory>
#include <string>
#include <vector>

#include <concurrentqueue.h>
#include <efsw/efsw.hpp>

class Filewatcher : public efsw::FileWatchListener
{
public:
    Filewatcher(std::vector<std::string> const& paths);
    void handleFileAction(efsw::WatchID watchid, std::string const& dir, std::string const& filename, efsw::Action action, std::string oldFilename) override;

    moodycamel::ConcurrentQueue<std::filesystem::path> modifiedQueue;

private:
    std::unique_ptr<efsw::FileWatcher> fileWatcher;
    std::vector<std::string>           basePaths;
};
