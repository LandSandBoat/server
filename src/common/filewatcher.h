#pragma once

#include <filesystem>
#include <functional>
#include <string>

#include <iostream>

#include "efsw/efsw.hpp"

class Filewatcher : public efsw::FileWatchListener
{
public:
    Filewatcher(std::string const& path, std::function<void(const std::filesystem::path& path)> _func)
    {
        fileWatcher = new efsw::FileWatcher();
        fileWatcher->addWatch(path, this, true);
        fileWatcher->watch();

        func = _func;
    }

    void handleFileAction(efsw::WatchID watchid, const std::string& dir, const std::string& filename, efsw::Action action, std::string oldFilename) override
    {
        auto fullFilename = dir + filename;
        switch (action)
        {
            case efsw::Actions::Add:
                //std::cout << "DIR (" << dir << ") FILE (" << filename << ") has event Added" << std::endl;
                break;
            case efsw::Actions::Delete:
                //std::cout << "DIR (" << dir << ") FILE (" << filename << ") has event Delete" << std::endl;
                break;
            case efsw::Actions::Modified:
                //std::cout << "DIR (" << dir << ") FILE (" << filename << ") has event Modified" << std::endl;
                func(fullFilename);
                break;
            case efsw::Actions::Moved:
                //std::cout << "DIR (" << dir << ") FILE (" << filename << ") has event Moved from (" << oldFilename << ")" << std::endl;
                break;
            default:
                //std::cout << "Should never happen!" << std::endl;
                break;
        }
    }

private:
    efsw::FileWatcher* fileWatcher;
    std::function<void(const std::filesystem::path& path)> func;
};
