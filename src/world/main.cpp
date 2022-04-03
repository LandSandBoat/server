
#include "world_server.h"
#include "argparse/argparse.hpp"

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
        std::cerr << *argParser;
        std::exit(1);
    }

    auto pWorldServer = std::make_unique<WorldServer>(std::move(argParser));

    while (pWorldServer->IsRunning())
    {
        pWorldServer->Tick();
    }

    return 0;
}
