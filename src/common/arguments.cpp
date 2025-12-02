/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#include "arguments.h"

#include "application.h"
#include "logging.h"
#include "version.h"

Arguments::Arguments(const ApplicationConfig& config, const int argc, char** argv)
: argc_(argc)
, argv_(argv)
, args_(std::make_unique<argparse::ArgumentParser>(argv[0], version::GetVersionString()))
{
    //
    // Defaults
    //

    const auto description = fmt::format(
        "xi_{}: part of LandSandBoat - a server emulator for Final Fantasy XI\n\nBranch: {}",
        config.serverName,
        version::GetVersionString());

    args_->add_description(description);

    // Common arguments
    args_->add_argument("--log")
        .help(fmt::format("Specify the log file to write to, relative to the executable (default: log/{}-server.log)", config.serverName));

    args_->add_argument("--append-date", "--append_date")
        .help("Flag: Append the current date to the log file name")
        .flag();

    args_->add_argument("--ci")
        .help("Flag: Enable CI-only logic")
        .flag();

    // Specialized arguments
    for (const auto& argument : config.arguments)
    {
        switch (argument.type)
        {
            case ArgumentType::Simple:
                args_->add_argument(argument.name)
                    .help(argument.description);
                break;
            case ArgumentType::Flag:
                args_->add_argument(argument.name)
                    .flag()
                    .help(argument.description);
                break;
            case ArgumentType::Multiple:
                args_->add_argument(argument.name)
                    .append()
                    .help(argument.description);
                break;
        }
    }

    args_->add_epilog("This is free and open-source software. You may use, modify, and distribute it under the terms of the GNU GPL v3.");

    try
    {
        args_->parse_args(argc_, argv_);
    }
    catch (const std::runtime_error& err)
    {
        std::cerr << err.what() << "\n";
        std::cerr << *args_ << "\n";
        std::exit(1);
    }
}
