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

#include <array>

inline constexpr size_t SynthMaxIngredients = 8;

enum CRAFT_TYPE
{
    CRAFT_SYNTHESIS         = 0,
    CRAFT_DESYNTHESIS       = 1,
    CRAFT_SYNTHESIS_NO_LOSS = 2,
};

// Runtime state for synthutils to track synthesis over multiple steps
// Item ownership and mutations exclusively in SynthTransaction!
class CCraftState
{
public:
    struct Result
    {
        uint16 itemId{};
        uint8  qty{};
    };

    struct Init
    {
        uint32                                  recipeId{};
        CRAFT_TYPE                              craftMode{};
        uint16                                  crystalItemId{};
        uint8                                   element{};
        std::array<Result, 5>                   results{};
        std::array<uint8, SynthMaxIngredients>  skillRequired{};
        std::array<uint16, SynthMaxIngredients> ingredientItemIds{};
    };

    // Sets recipe data and resets runtime fields.
    void populate(const Init& data);

    void setFailingSkill(uint8 s);
    void setResult(uint8 r);
    void markBroken(uint8 idx);

    auto recipeId() const -> uint32;
    auto craftMode() const -> CRAFT_TYPE;
    auto crystalItemId() const -> uint16;
    auto resultTier(uint8 tier) const -> const Result&;
    auto skillRequired(uint8 idx) const -> uint8;
    auto element() const -> uint8;
    auto failingSkill() const -> uint8;
    auto result() const -> uint8;
    auto isBroken(uint8 idx) const -> bool;
    auto ingredientItemId(uint8 idx) const -> uint16;

private:
    uint32                                  recipeId_{};
    CRAFT_TYPE                              craftMode_{};
    uint16                                  crystalItemId_{};
    std::array<Result, 5>                   results_{};
    std::array<uint8, SynthMaxIngredients>  skillRequired_{};
    std::array<uint16, SynthMaxIngredients> ingredientItemIds_{};
    uint8                                   element_{};
    uint8                                   failingSkill_{};
    uint8                                   result_{};
    std::array<bool, SynthMaxIngredients>   ingredientBroken_{};
};
