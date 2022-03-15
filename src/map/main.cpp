
#include "zone_server.h"

int main(int argc, char** argv)
{
    auto argParser = std::make_unique<argparse::ArgumentParser>(argv[0]);

    try
    {
        argParser->parse_args(argc, argv);
    }
    catch (const std::runtime_error& err)
    {
        std::cerr << err.what() << std::endl;
        std::cerr << argParser;
        std::exit(1);
    }

    auto pZoneServer = std::make_unique<ZoneServer>(std::move(argParser));

    while (pZoneServer->IsRunning())
    {
        pZoneServer->Tick();
    }

    return 0;
}
