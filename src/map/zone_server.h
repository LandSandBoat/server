#pragma once

#include "common/application.h"

class ZoneServer final : public Application
{
public:
    ZoneServer(std::unique_ptr<argparse::ArgumentParser>&& pArgParser)
    : Application("zone", std::move(pArgParser))
    {
    }

    ~ZoneServer() override
    {
    }

    void Tick() override
    {
        Application::Tick();
    }

private:
};
