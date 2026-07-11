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

#include "common/enum_traits.h"

#include "common/macros.h"

#include <concepts>
#include <string>
#include <string_view>
#include <type_traits>
#include <vector>

namespace xi::data
{

template <class T>
inline constexpr bool isVector = false;

template <class T, class A>
inline constexpr bool isVector<std::vector<T, A>> = true;

template <class>
inline constexpr bool alwaysFalse = false;

// All data backends must implement this.
template <class B>
concept NodeBackend = std::constructible_from<typename B::Tree, std::string&&> &&
                      std::convertible_to<typename B::mutable_node_t, typename B::node_t> &&
                      requires(const typename B::node_t&  node,
                               typename B::mutable_node_t mutableNode,
                               const typename B::Tree&    constTree,
                               typename B::Tree&          mutableTree,
                               std::string_view           key) {
                          typename B::node_t;
                          typename B::mutable_node_t;
                          typename B::Tree;

                          { B::kExtension } -> std::convertible_to<std::string_view>;

                          { constTree.root() } -> std::convertible_to<typename B::node_t>;
                          { mutableTree.root() } -> std::same_as<typename B::mutable_node_t>;

                          { B::isMap(node) } -> std::same_as<bool>;
                          { B::isSequence(node) } -> std::same_as<bool>;
                          { B::hasValue(node) } -> std::same_as<bool>;
                          { B::hasChild(node, key) } -> std::same_as<bool>;
                          { B::child(node, key) } -> std::same_as<typename B::node_t>;
                          { B::key(node) } -> std::convertible_to<std::string_view>;
                          B::children(node);

                          { B::template scalarAs<int>(node) } -> std::same_as<int>;
                          { B::template scalarAs<bool>(node) } -> std::same_as<bool>;
                          { B::template scalarAs<float>(node) } -> std::same_as<float>;
                          { B::template scalarAs<std::string>(node) } -> std::same_as<std::string>;

                          { B::mergeInto(mutableNode, node) } -> std::same_as<void>;
                      };

template <NodeBackend B>
class Node;

// T has a codegen'd `populate(Node<B>, type_identity<T>) -> T`.
template <class T, class B>
concept Populatable = requires(Node<B> n) {
    { populate(n, std::type_identity<T>{}) } -> std::same_as<T>;
};

template <NodeBackend B>
class Node
{
public:
    explicit Node(const B::node_t node)
    : node_(node)
    {
    }

    auto raw() const
    {
        return node_;
    }

    auto has(const std::string_view k) const
    {
        return B::hasChild(node_, k);
    }

    auto child(const std::string_view k) const
    {
        return Node{ B::child(node_, k) };
    }

    auto key() const -> std::string_view
    {
        return B::key(node_);
    }

    auto isMap() const
    {
        return B::isMap(node_);
    }

    auto isSequence() const
    {
        return B::isSequence(node_);
    }

    auto children() const -> std::vector<Node>
    {
        std::vector<Node<B>> out;
        for (const auto raw : B::children(node_))
        {
            out.emplace_back(raw);
        }

        return out;
    }

    template <class T>
    auto read(const std::string_view key) const -> T
    {
        if (!has(key))
        {
            return T{};
        }

        return Node{ B::child(node_, key) }.template as<T>();
    }

    template <class T>
    auto as() const -> T
    {
        if constexpr (std::is_arithmetic_v<T> || std::is_same_v<T, std::string>)
        {
            // Scalar leaf.
            //
            // base_sell: 39 < HERE
            if (!B::hasValue(node_))
            {
                return T{};
            }

            return B::template scalarAs<T>(node_);
        }
        else if constexpr (Nameable<T> && isFlagEnum<T>)
        {
            // Flag enum: sequence of names, OR'd together.
            //
            // flags: [mystery_box, inscribable] < HERE
            if (!B::isSequence(node_))
            {
                return T{};
            }

            using U = std::underlying_type_t<T>;
            U acc{};
            for (const auto child : children())
            {
                acc |= static_cast<U>(EnumTraits<T>::fromName(child.template as<std::string>()));
            }

            return static_cast<T>(acc);
        }
        else if constexpr (Nameable<T>)
        {
            // Scalar enum: single name.
            //
            // type: weapon < HERE
            if (!B::hasValue(node_))
            {
                return T{};
            }

            return EnumTraits<T>::fromName(B::template scalarAs<std::string>(node_));
        }
        else if constexpr (isVector<T>)
        {
            // Sequence of records.
            //
            // mods:
            //   - { id: attack, value: 10 } < HERE
            //   - { id: defense, value: 5 }
            using V = typename T::value_type;
            T out;
            if (!B::isSequence(node_))
            {
                return out;
            }

            for (const auto child : children())
            {
                out.push_back(child.template as<V>());
            }

            return out;
        }
        else if constexpr (Populatable<T, B>)
        {
            // Nested record. Hand off to the codegen'd populate.
            //
            // weapon: < HERE
            //   skill: dagger
            //   damage: 3
            return B::isMap(node_) ? populate(*this, std::type_identity<T>{}) : T{};
        }
        else
        {
            static_assert(alwaysFalse<T>, "Node<B>::as<T>: unsupported T");
            XI_UNREACHABLE();
        }
    }

private:
    B::node_t node_;
};

} // namespace xi::data
