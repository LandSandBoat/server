#include "filewatcher.h"

#include "logging.h"
#include "tracy.h"

#include <filesystem>
#include <functional>
#include <memory>
#include <string>

Filewatcher::Filewatcher(std::vector<std::string> const& paths)
#ifdef USE_GENERIC_FILEWATCHER
: fileWatcher(std::make_unique<efsw::FileWatcher>(true))
#else
: fileWatcher(std::make_unique<efsw::FileWatcher>(false))
#endif
, basePaths(paths)
{
    for (auto& path : paths)
    {
        fileWatcher->addWatch(path, this, true);
    }
    fileWatcher->watch();
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
