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

#include <c4/yml/error.hpp>
#include <ryml.hpp>
#include <ryml_std.hpp>

#include <string>
#include <string_view>

namespace xi::data::backends
{

class YAMLBackend
{
public:
    using node_t         = ryml::ConstNodeRef;
    using mutable_node_t = ryml::NodeRef;

    static constexpr std::string_view kExtension{ ".yaml" };

    class Tree
    {
    public:
        explicit Tree(std::string&& text);

        auto root() const -> node_t;
        auto root() -> mutable_node_t;

    private:
        ryml::Tree tree_;
    };

    static auto isMap(const node_t& n) -> bool;
    static auto isSequence(const node_t& n) -> bool;
    static auto hasValue(const node_t& n) -> bool;
    static auto hasChild(const node_t& n, std::string_view k) -> bool;
    static auto child(const node_t& n, std::string_view k) -> node_t;
    static auto key(const node_t& n) -> std::string_view;

    static auto children(const node_t& n)
    {
        return n.children();
    }

    template <class T>
    static auto scalarAs(const node_t& n) -> T
    {
        T out{};
        n >> out;
        return out;
    }

    static void mergeInto(mutable_node_t dst, node_t src);
    static void installCallbacks();

private:
    static void clearReplacedLists(mutable_node_t dst, node_t src);

    [[noreturn]] static void onErrorBasic(ryml::csubstr msg, const ryml::ErrorDataBasic& errdata, void* ud);
    [[noreturn]] static void onErrorParse(ryml::csubstr msg, const ryml::ErrorDataParse& errdata, void* ud);
    [[noreturn]] static void onErrorVisit(ryml::csubstr msg, const ryml::ErrorDataVisit& errdata, void* ud);
};

} // namespace xi::data::backends
