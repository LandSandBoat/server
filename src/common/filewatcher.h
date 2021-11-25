#pragma once

#include <filesystem>
#include <functional>
#include <string>
#include <memory>

#include "efsw/efsw.hpp"

class Filewatcher : public efsw::FileWatchListener
{
public:
    Filewatcher(std::string const& path, std::function<void(const std::filesystem::path& path)> _func);
    void handleFileAction(efsw::WatchID watchid, const std::string& dir, const std::string& filename, efsw::Action action, std::string oldFilename) override;

private:
    std::unique_ptr<efsw::FileWatcher> fileWatcher;
    std::string basePath;

    std::function<void(const std::filesystem::path& path)> func;
};
