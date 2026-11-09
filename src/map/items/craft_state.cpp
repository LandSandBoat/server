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

#include "craft_state.h"

void CCraftState::populate(const Init& data)
{
    recipeId_          = data.recipeId;
    craftMode_         = data.craftMode;
    crystalItemId_     = data.crystalItemId;
    element_           = data.element;
    results_           = data.results;
    skillRequired_     = data.skillRequired;
    ingredientItemIds_ = data.ingredientItemIds;

    failingSkill_     = 0;
    result_           = SynthesisOutcome::Fail;
    ingredientBroken_ = {};
}

void CCraftState::setFailingSkill(uint8 s)
{
    failingSkill_ = s;
}

void CCraftState::setResult(const SynthesisOutcome outcome)
{
    result_ = outcome;
}

void CCraftState::markBroken(uint8 idx)
{
    ingredientBroken_[idx] = true;
}

auto CCraftState::recipeId() const -> uint32
{
    return recipeId_;
}

auto CCraftState::craftMode() const -> CRAFT_TYPE
{
    return craftMode_;
}

auto CCraftState::crystalItemId() const -> uint16
{
    return crystalItemId_;
}

auto CCraftState::resultTier(const SynthesisOutcome outcome) const -> const Result&
{
    return results_[static_cast<std::size_t>(outcome)];
}

auto CCraftState::skillRequired(uint8 idx) const -> uint8
{
    return skillRequired_[idx];
}

auto CCraftState::element() const -> uint8
{
    return element_;
}

auto CCraftState::failingSkill() const -> uint8
{
    return failingSkill_;
}

auto CCraftState::result() const -> SynthesisOutcome
{
    return result_;
}

auto CCraftState::isBroken(uint8 idx) const -> bool
{
    return ingredientBroken_[idx];
}

auto CCraftState::ingredientItemId(uint8 idx) const -> uint16
{
    return ingredientItemIds_[idx];
}
