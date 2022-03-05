#pragma once

#include "common/application.h"

class WorldServer final : public Application
{
public:
    WorldServer(std::unique_ptr<argparse::ArgumentParser>&& pArgParser)
    : Application("world", std::move(pArgParser))
    {
        // World server should _mostly_ be comprised of ZMQ handlers and timed tasks.

        gConsoleService->RegisterCommand("stats", "Print server runtime statistics", [&]()
        {
            fmt::print("TODO: Some stats!\n");
        });
    }

    ~WorldServer() override
    {
        // Everything should be handled with RAII
    }

    void Tick() override
    {
        Application::Tick();

        // World Server specific things
    }

private:
    // World server doesn't need external-facing sockets
};
