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
#include <filesystem>
#include <fmt/format.h>
#include <fstream>
#include <sstream>
#include <stdexcept>
#include <string>
#include <unordered_set>
#include <vector>

namespace xi::data
{

namespace
{

auto trimLine(const std::string_view line) -> std::string_view
{
    const auto first = line.find_first_not_of(" \t\r\n");
    if (first == std::string_view::npos)
    {
        return {};
    }

    const auto last = line.find_last_not_of(" \t\r\n");
    return line.substr(first, last - first + 1);
}

auto readDocument(const std::string_view text) -> glz::generic_u64
{
    glz::generic_u64 document;
    if (const auto error = glz::read_yaml(document, text))
    {
        throw std::runtime_error(glz::format_error(error, text));
    }

    return document;
}

auto applyPatches(const std::string_view core, const std::span<const std::string> modules) -> glz::generic_u64
{
    auto document = readDocument(core);
    for (const auto& module : modules)
    {
        const auto patch = readDocument(module);
        if (const auto error = glz::merge_patch(document, patch))
        {
            throw std::runtime_error(glz::format_error(error));
        }
    }

    return document;
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

auto getDataModulePaths(const std::string_view name, const std::string_view extension) -> std::vector<std::string>
{
    std::vector<std::string> modules;
    std::ifstream            file("./modules/init.txt", std::ios_base::in);
    if (!file)
    {
        return modules;
    }

    std::unordered_set<std::string> seenPaths;
    std::string                     line;
    while (std::getline(file, line))
    {
        const auto trimmed = trimLine(line);
        if (trimmed.empty() || trimmed[0] == '#')
        {
            continue;
        }

        const auto entry            = std::filesystem::path{ std::string{ trimmed } };
        const auto explicitDataRoot = std::ranges::any_of(entry, [](const auto& component)
                                                          {
                                                              return component == "data";
                                                          });

        auto dataRoot = std::filesystem::path{ "./modules" };
        if (explicitDataRoot)
        {
            dataRoot /= entry;
        }
        else
        {
            dataRoot /= *entry.begin();
            dataRoot /= "data";
        }

        const auto modulePath = (dataRoot / fmt::format("{}{}", name, extension)).generic_string();
        if (seenPaths.insert(modulePath).second && std::filesystem::exists(modulePath))
        {
            modules.emplace_back(modulePath);
        }
    }

    return modules;
}

auto mergeYaml(const std::string_view core, const std::span<const std::string> modules) -> std::string
{
    if (modules.empty())
    {
        return std::string{ core };
    }

    auto output = glz::write_yaml(applyPatches(core, modules));
    if (!output)
    {
        throw std::runtime_error("Glaze could not serialize patched YAML");
    }

    return *output;
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

auto patchZoneYaml(const std::string_view core, const std::span<const std::string> modules) -> std::string
{
    auto output = glz::write_json(applyPatches(core, modules));
    if (!output)
    {
        throw std::runtime_error("Could not serialize patched zone YAML");
    }

    return *output;
}

auto loadPatchedZoneYaml(const std::string_view corePath, const std::span<const std::string> modulePaths) -> std::string
{
    const auto               core = slurp(corePath);
    std::vector<std::string> modules;
    modules.reserve(modulePaths.size());
    for (const auto& modulePath : modulePaths)
    {
        modules.emplace_back(slurp(modulePath));
    }

    return patchZoneYaml(core, modules);
}

} // namespace xi::data
