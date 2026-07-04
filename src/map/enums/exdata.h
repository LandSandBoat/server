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

#include <cstdint>
#include <magic_enum/magic_enum.hpp>

namespace Exdata
{

enum class AugmentKindFlags : uint8_t
{
    HasAugments = 0x02, // Standard/trial/serialized/crafting shield/evolith
    Bundled     = 0x03, // Odyssey, Dyna-D JSE necks
};

// AugmentSubKind (byte 1 of augment exdata)
// When Kind=2: bitflags select the augment format
enum class AugmentSubKindFlags : uint8_t
{
    Standard   = 0x03, // Base flags for standard augments
    Escutcheon = 0x08, // Crafting shields
    Serialized = 0x10, // Serialized number + server name (Lu Shang +1, Ebisu +1)
    Mezzotint  = 0x20, // Mezzotinting (Geas Fete, Delve)
    Trial      = 0x40, // Magian trial
    Evolith    = 0x80,
};

} // namespace Exdata

template <>
struct magic_enum::customize::enum_range<Exdata::AugmentSubKindFlags>
{
    static constexpr bool is_flags = true;
};

template <>
struct magic_enum::customize::enum_range<Exdata::AugmentKindFlags>
{
    static constexpr bool is_flags = true;
};

using namespace magic_enum::bitwise_operators;

namespace Exdata
{

// Numbers are meaningless, new types can be added at the tail end.
enum class Type : uint8_t
{
    None               = 0,
    Augment            = 1,
    Usable             = 2,
    Mannequin          = 3,
    Furniture          = 4,
    FlowerPot          = 5,
    Linkshell          = 6,
    Fish               = 7,
    BettingSlip        = 8,
    SoulPlate          = 9,
    SoulReflector      = 10,
    AssaultLog         = 11,
    LotteryTicket      = 12,
    Tabula             = 13,
    Evolith            = 14,
    CraftingSet        = 15,
    BrennerBook        = 16,
    GlowingLamp        = 17,
    LegionPass         = 18,
    Serialized         = 19,
    PerpetualHourglass = 20,
    ChocoboEgg         = 21,
    ChocoboCard        = 22,
    Escutcheon         = 23,
    RaceCertificate    = 24,
    MeebleGrimoire     = 25,
    HoneymoonTicket    = 26,
    WeaponUnlock       = 27,
};

} // namespace Exdata
