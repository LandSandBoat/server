#pragma once

#include "common/application.h"

class WorldServer final : public Application
{
public:
    WorldServer(std::unique_ptr<argparse::ArgumentParser>&& pArgParser)
    : Application(std::move(pArgParser))
    {
        // World server should _mostly_ be comprised of ZMQ handlers and timed tasks.
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
