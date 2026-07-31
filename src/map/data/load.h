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

template <class M, class K, class V>
void insertUnique(M& map, const K key, V&& value, const std::string_view source, const std::string_view section)
{
    if (!map.try_emplace(key, std::forward<V>(value)).second)
    {
        throw std::runtime_error(fmt::format("{}: duplicate id {} in '{}'", source, static_cast<uint32>(key), section));
    }
}

// Patch 'out' with the given 'overrides' content
// Used for schemas declaring 'x-partial' with clear inheritance semantics.
//
// 'forEachField' is provided by codegen for the templated types.
template <class Data, class Overrides>
void applyOverrides(Data& out, const Overrides& overrides)
{
    forEachField(out, overrides, [](auto& field, const auto& written)
                 {
                     if (!written)
                     {
                         return;
                     }

                     if constexpr (requires { field = *written; }) // Take assignable values as is, lists replaced whole
                     {
                         field = *written;
                     }
                     else
                     {
                         applyOverrides(field, *written); // Recurse into nested maps
                     }
                 });
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
        const std::ifstream in(std::string{ path }, std::ios::binary);
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
