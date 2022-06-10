#pragma once

#include <filesystem>
#include <functional>
#include <memory>
#include <string>

#include <concurrentqueue.h>
#include <efsw/efsw.hpp>

class Filewatcher : public efsw::FileWatchListener
{
public:
    Filewatcher(std::string const& path);
    void handleFileAction(efsw::WatchID watchid, const std::string& dir, const std::string& filename, efsw::Action action, std::string oldFilename) override;

    moodycamel::ConcurrentQueue<std::filesystem::path> modifiedQueue;

private:
    std::unique_ptr<efsw::FileWatcher> fileWatcher;
    std::string                        basePath;
};
