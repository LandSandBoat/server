
#include "search_server.h"

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

    auto pSearchServer = std::make_unique<SearchServer>(std::move(argParser));

    while (pSearchServer->IsRunning())
    {
        pSearchServer->Tick();
    }

    return 0;
}
