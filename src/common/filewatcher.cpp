#include "filewatcher.h"

#include "tracy.h"

#include <filesystem>
#include <functional>
#include <string>
#include <memory>

#include "efsw/efsw.hpp"

Filewatcher::Filewatcher(std::string const& path)
#ifdef USE_GENERIC_FILEWATCHER
: fileWatcher(std::make_unique<efsw::FileWatcher>(true))
#else
: fileWatcher(std::make_unique<efsw::FileWatcher>(false))
#endif
, basePath(path)
{
    fileWatcher->addWatch(path, this, true);
    fileWatcher->watch();
}

// cppcheck-suppress passedByValue
void Filewatcher::handleFileAction(efsw::WatchID watchid, const std::string& dir, const std::string& filename, efsw::Action action, std::string oldFilename)
{
    TracyZoneScoped;
    std::filesystem::path fullPath = dir + "/" + filename;
    switch (action)
    {
        case efsw::Actions::Add:
            break;
        case efsw::Actions::Delete:
            break;
        case efsw::Actions::Modified:
            modifiedQueue.enqueue(fullPath);
            break;
        case efsw::Actions::Moved:
            break;
        default:
            break;
    }
}
