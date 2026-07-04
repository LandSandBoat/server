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

#include "data/backends/yaml.h"

#include <c4/yml/tree.hpp>
#include <fmt/format.h>

#include <mutex>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>

namespace xi::data::backends
{

namespace
{

// ryml can pass a null location name to the error callbacks.
auto toView(const ryml::csubstr s) -> std::string_view
{
    return s.str ? std::string_view(s.str, s.len) : std::string_view{};
}

} // namespace

void YAMLBackend::onErrorBasic(const ryml::csubstr msg, const ryml::ErrorDataBasic& errdata, void* /*ud*/)
{
    throw std::runtime_error(fmt::format("[ryml basic] {} at {}:{}",
                                         toView(msg),
                                         toView(errdata.location.name),
                                         errdata.location.line));
}

void YAMLBackend::onErrorParse(const ryml::csubstr msg, const ryml::ErrorDataParse& errdata, void* /*ud*/)
{
    throw std::runtime_error(fmt::format("[ryml parse] {} at yaml line {} (from {}:{})",
                                         toView(msg),
                                         errdata.ymlloc.line,
                                         toView(errdata.cpploc.name),
                                         errdata.cpploc.line));
}

void YAMLBackend::onErrorVisit(const ryml::csubstr msg, const ryml::ErrorDataVisit& errdata, void* /*ud*/)
{
    std::string context = fmt::format("node={}", errdata.node);
    if (errdata.tree && errdata.node != ryml::NONE)
    {
        const auto n = errdata.tree->cref(errdata.node);
        if (n.has_key())
        {
            context += fmt::format(" key='{}'", std::string_view(n.key().str, n.key().len));
        }

        if (n.has_val())
        {
            context += fmt::format(" val='{}'", std::string_view(n.val().str, n.val().len));
        }

        if (n.has_parent())
        {
            const auto p = n.parent();
            if (p.has_key())
            {
                context += fmt::format(" parent_key='{}'", std::string_view(p.key().str, p.key().len));
            }
        }
    }

    throw std::runtime_error(fmt::format("[ryml visit] {} - {} (from {}:{})",
                                         toView(msg),
                                         context,
                                         toView(errdata.cpploc.name),
                                         errdata.cpploc.line));
}

void YAMLBackend::installCallbacks()
{
    // rapidyaml violently aborts out of the box.
    // Install a few callbacks to attempt to log human-readable errors.
    auto callbacks = ryml::get_callbacks();
    callbacks.set_error_basic(&YAMLBackend::onErrorBasic);
    callbacks.set_error_parse(&YAMLBackend::onErrorParse);
    callbacks.set_error_visit(&YAMLBackend::onErrorVisit);
    ryml::set_callbacks(callbacks);
}

YAMLBackend::Tree::Tree(std::string&& text)
{
    static std::once_flag installed;
    std::call_once(installed, &YAMLBackend::installCallbacks);

    tree_ = ryml::parse_in_arena(ryml::csubstr{ text.data(), text.size() });
}

auto YAMLBackend::Tree::root() const -> node_t
{
    return tree_.rootref();
}

auto YAMLBackend::Tree::root() -> mutable_node_t
{
    return tree_.rootref();
}

auto YAMLBackend::isMap(const node_t& n) -> bool
{
    return n.is_map();
}

auto YAMLBackend::isSequence(const node_t& n) -> bool
{
    return n.is_seq();
}

auto YAMLBackend::hasValue(const node_t& n) -> bool
{
    return n.has_val();
}

auto YAMLBackend::hasChild(const node_t& n, std::string_view k) -> bool
{
    return n.has_child(ryml::csubstr{ k.data(), k.size() });
}

auto YAMLBackend::child(const node_t& n, std::string_view k) -> node_t
{
    return n[ryml::csubstr{ k.data(), k.size() }];
}

auto YAMLBackend::key(const node_t& n) -> std::string_view
{
    return { n.key().str, n.key().len };
}

// Modules: Any list redeclared has its core values dropped to enforce replace-only semantics on lists
void YAMLBackend::clearReplacedLists(ryml::NodeRef dst, const ryml::ConstNodeRef src)
{
    if (!src.is_map() || !dst.is_map())
    {
        return;
    }

    for (const auto srcChild : src.children())
    {
        const auto key = srcChild.key();
        if (!dst.has_child(key))
        {
            continue;
        }

        auto dstChild = dst[key];
        if (srcChild.is_seq() && dstChild.is_seq())
        {
            dst.tree()->remove_children(dstChild.id());
        }
        else if (srcChild.is_map() && dstChild.is_map())
        {
            clearReplacedLists(dstChild, srcChild);
        }
    }
}

// Modules: Clear redeclared lists and hand off to rapidyaml for deep merge into core tree
void YAMLBackend::mergeInto(ryml::NodeRef dst, const ryml::ConstNodeRef src)
{
    clearReplacedLists(dst, src);
    dst.tree()->merge_with(src.tree(), src.id(), dst.id());
}

} // namespace xi::data::backends
