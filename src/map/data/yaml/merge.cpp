/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include "data/yaml/merge.h"

#include <glaze/json/patch.hpp>
#include <glaze/yaml.hpp>

#include <algorithm>
#include <cctype>
#include <fstream>
#include <sstream>
#include <stdexcept>
#include <string>
#include <vector>

namespace xi::data
{

namespace
{

auto readDocument(const std::string_view text) -> glz::generic_u64
{
    glz::generic_u64 document;
    if (const auto error = glz::read_yaml(document, text))
    {
        throw std::runtime_error(glz::format_error(error, text));
    }

    return document;
}

// Glaze holds every generic object key as a string, so a merged document comes back with integer map
// keys quoted, which its own reader then cannot parse into anything but a string key. Dropping the
// quotes around an all-digit key reads the same for a string-keyed map and lets an integer-keyed one load.
auto unquoteNumericKeys(std::string yaml) -> std::string
{
    std::size_t line = 0;
    while (line < yaml.size())
    {
        const auto end   = yaml.find('\n', line);
        const auto start = yaml.find_first_not_of(" -", line);

        if (start != std::string::npos && start < end && yaml[start] == '\'')
        {
            const auto close = yaml.find('\'', start + 1);
            if (close != std::string::npos && close + 1 < end && yaml[close + 1] == ':' &&
                close > start + 1 &&
                std::all_of(yaml.begin() + start + 1, yaml.begin() + close, [](const char digit)
                            {
                                return std::isdigit(static_cast<unsigned char>(digit)) != 0;
                            }))
            {
                yaml.erase(close, 1);
                yaml.erase(start, 1);
            }
        }

        if (end == std::string::npos)
        {
            break;
        }

        line = end + 1;
    }

    return yaml;
}

auto slurp(const std::string_view path) -> std::string
{
    const std::ifstream input(std::string{ path }, std::ios::binary);
    if (!input.is_open())
    {
        throw std::runtime_error("cannot open " + std::string{ path });
    }

    std::stringstream buffer;
    buffer << input.rdbuf();
    return buffer.str();
}

} // namespace

auto mergeYaml(const std::string_view core, const std::span<const std::string> modules) -> std::string
{
    if (modules.empty())
    {
        return std::string{ core };
    }

    auto document = readDocument(core);
    for (const auto& module : modules)
    {
        const auto patch = readDocument(module);
        if (const auto error = glz::merge_patch(document, patch))
        {
            throw std::runtime_error(glz::format_error(error));
        }
    }

    auto output = glz::write_yaml(document);
    if (!output)
    {
        throw std::runtime_error("Glaze could not serialize patched YAML");
    }

    return unquoteNumericKeys(std::move(*output));
}

auto loadMergedYaml(const std::string_view corePath, const std::span<const std::string> modulePaths) -> std::string
{
    auto core = slurp(corePath);
    if (modulePaths.empty())
    {
        return core;
    }

    std::vector<std::string> modules;
    modules.reserve(modulePaths.size());
    for (const auto& modulePath : modulePaths)
    {
        modules.emplace_back(slurp(modulePath));
    }
    return mergeYaml(core, modules);
}

} // namespace xi::data
