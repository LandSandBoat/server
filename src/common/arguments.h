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

#pragma once

#include <optional>
#include <string>

#include <argparse/argparse.hpp>

//
// A thin wrapper around argparse, since argparse throws exceptions on missing arguments.
//
class Arguments final
{
public:
    Arguments(std::string const& serverName, int argc, char** argv);
    ~Arguments() = default;

    template <typename T = std::string>
    auto present(std::string_view arg_name) const -> std::optional<T>
    {
        try
        {
            return args_->present(arg_name);
        }
        catch (const std::exception&)
        {
            // Swallow the error
        }

        return std::nullopt;
    }

    template <typename T = std::string>
    T get(std::string_view arg_name) const
    {
        try
        {
            return args_->get<T>(arg_name);
        }
        catch (const std::exception&)
        {
            // Swallow the error
        }

        return {};
    }

private:
    std::unique_ptr<argparse::ArgumentParser> args_;
};
