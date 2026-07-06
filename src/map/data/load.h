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

#pragma once

#include "common/cbasetypes.h"
#include "common/logging.h"

#include <common/types/hash_map.h>

#include "data/node.h"

#include <charconv>
#include <fmt/format.h>
#include <fstream>
#include <span>
#include <sstream>
#include <stdexcept>
#include <string>
#include <string_view>
#include <type_traits>
#include <utility>
#include <vector>

namespace xi::data
{

// Describe where the "primary key" of the object is located.
enum class IdSource
{
    YAMLField, // The `id:` field is used as PK
    YAMLKey,   // The map key itself is the PK
};

// Shared body for codegen'd populateMaps; per-type bits go in populateOne.
// Data backend is provided at compilation time, we just want something that deals with a tree-like structure
template <class T, class B, class PopulateOne>
auto populateMapDriver(const Node<B> root, const std::string_view sectionName, const IdSource idSource, const std::string_view source, PopulateOne populateOne) -> HashMap<decltype(T::Id), T>
{
    using KeyT = decltype(T::Id);

    HashMap<KeyT, T> result;

    // Section is the top level key where the records are stored
    if (!root.has(sectionName))
    {
        return result;
    }

    const auto section = root.child(sectionName);
    if (!section.isMap())
    {
        return result;
    }

    // Iterate every record and hand off the final parsing to the codegen'd specialization.
    for (const auto child : section.children())
    {
        // First figure out where the primary key is stored
        KeyT id{};
        if (idSource == IdSource::YAMLField)
        {
            // Nested id property is the primary key
            //
            // weakness:
            //   id: 1 < HERE
            id = child.template read<KeyT>("id");
        }
        else
        {
            // Map key IS the primary key
            //
            // 16555: < HERE
            //   name: { en: ridill }
            const std::string_view keyStr = child.key();
            const auto             ec     = std::from_chars(keyStr.data(), keyStr.data() + keyStr.size(), id).ec;
            if (ec != std::errc{})
            {
                throw std::runtime_error(fmt::format("{}: bad integer key '{}' in section '{}'", source, keyStr, sectionName));
            }
        }

        T data = populateOne(child, id);                          // Ask the specialized function to parse the record
        if (!result.try_emplace(data.Id, std::move(data)).second) // Any duplicate is a hard fail
        {
            throw std::runtime_error(fmt::format("{}: duplicate id {} in section '{}'", source, data.Id, sectionName));
        }
    }

    return result;
}

// Must be specialized by codegen, else it's a compile-time failure
template <class T, class B>
auto populateMap(Node<B> root, std::type_identity<T>) -> HashMap<decltype(T::Id), T> = delete;

// Parse core, merge each module over it in init.txt order, populate.
// Module trees stay alive until populate ends; backend's merge references them.
template <class T, NodeBackend B>
auto loadAllOf(const std::string_view corePath, const std::span<const std::string> modulePaths) -> HashMap<decltype(T::Id), T>
{
    const auto slurp = [](std::string_view path) -> std::string
    {
        std::ifstream in(std::string{ path }, std::ios::binary);
        if (!in.is_open())
        {
            throw std::runtime_error(fmt::format("cannot open {}", path));
        }

        std::stringstream buf;
        buf << in.rdbuf();
        return buf.str();
    };

    try
    {
        typename B::Tree              coreTree{ slurp(corePath) };
        std::vector<typename B::Tree> moduleTrees;
        moduleTrees.reserve(modulePaths.size());

        for (const auto& path : modulePaths)
        {
            moduleTrees.emplace_back(slurp(path));
            B::mergeInto(coreTree.root(), moduleTrees.back().root());
        }

        return populateMap(Node<B>{ coreTree.root() }, std::type_identity<T>{});
    }
    catch (const std::exception& e)
    {
        ShowErrorFmt("loadAllOf({}) failed: {}", corePath, e.what());
        throw;
    }
}

} // namespace xi::data
