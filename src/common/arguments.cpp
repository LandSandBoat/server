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

#include "logging.h"
#include "version.h"

Arguments::Arguments(std::string const& serverName, int argc, char** argv)
: args_(std::make_unique<argparse::ArgumentParser>(argv[0], version::GetVersionString()))
{
    //
    // Defaults
    //

    const auto description = fmt::format("xi_{}: part of LandSandBoat - a server emulator for Final Fantasy XI\n\nBranch: {}",
                                         serverName, version::GetVersionString());

    args_->add_description(description);

    args_->add_argument("--log")
        .help(fmt::format("Specify the log file to write to, relative to the executable (default: log/{}-server.log)", serverName));

    args_->add_argument("--append-date", "--append_date")
        .help("Flag: Append the current date to the log file name")
        .flag();

    args_->add_argument("--ci")
        .help("Flag: Enable CI-only logic")
        .flag();

    args_->add_epilog("This is free and open-source software. You may use, modify, and distribute it under the terms of the GNU GPL v3.");

    //
    // MapServer specific args (TODO: Move these into MapServer)
    //

    if (serverName == "map")
    {
        args_->add_argument("--ip")
            .help("Specify the IP address to bind to");

        args_->add_argument("--port")
            .help("Specify the port to bind to");
    }

    //
    // Parse
    //

    try
    {
        args_->parse_args(argc, argv);
    }
    catch (const std::runtime_error& err)
    {
        std::cerr << err.what() << "\n";
        std::cerr << *args_ << "\n";
        std::exit(1);
    }
}
