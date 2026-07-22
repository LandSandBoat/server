/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "synthutils.h"

#include "charutils.h"
#include "common/logging.h"
#include "common/timer.h"
#include "common/types/flat_hash_map.h"
#include "entities/battle_entity.h"
#include "enums/key_items.h"
#include "enums/synthesis_effect.h"
#include "enums/synthesis_result.h"
#include "items.h"
#include "items/transactions/synth.h"
#include "itemutils.h"
#include "packets/char_status.h"
#include "packets/s2c/0x029_battle_message.h"
#include "packets/s2c/0x030_effect.h"
#include "packets/s2c/0x062_clistatus2.h"
#include "packets/s2c/0x06f_combine_ans.h"
#include "packets/s2c/0x070_combine_inf.h"
#include "roe.h"
#include "zone.h"

#include <algorithm>
#include <cmath>

// TODO: This largely overlaps with SYNTHESIS_RESULT and could be simplified.
#define RESULT_SUCCESS 0x00
#define RESULT_FAIL    0x01
#define RESULT_HQ      0x02
#define RESULT_HQ2     0x03
#define RESULT_HQ3     0x04

namespace synthutils
{

struct SynthRecipe
{
    uint32  ID{};
    uint8   Desynth{};
    KeyItem RequiredKeyItem{};
    uint8   Wood{};
    uint8   Smith{};
    uint8   Gold{};
    uint8   Cloth{};
    uint8   Leather{};
    uint8   Bone{};
    uint8   Alchemy{};
    uint8   Cook{};
    uint16  Crystal{};
    uint16  HQCrystal{};
    uint16  Ingredient1{};
    uint16  Ingredient2{};
    uint16  Ingredient3{};
    uint16  Ingredient4{};
    uint16  Ingredient5{};
    uint16  Ingredient6{};
    uint16  Ingredient7{};
    uint16  Ingredient8{};
    uint16  Result{};
    uint16  ResultHQ1{};
    uint16  ResultHQ2{};
    uint16  ResultHQ3{};
    uint8   ResultQty{};
    uint8   ResultHQ1Qty{};
    uint8   ResultHQ2Qty{};
    uint8   ResultHQ3Qty{};

    std::string ResultName;
    std::string ContentTag;

    uint16 getSkillValue(xi::SkillType type) const
    {
        switch (type)
        {
            case xi::SkillType::Woodworking:
                return Wood;
            case xi::SkillType::Smithing:
                return Smith;
            case xi::SkillType::Goldsmithing:
                return Gold;
            case xi::SkillType::Clothcraft:
                return Cloth;
            case xi::SkillType::Leathercraft:
                return Leather;
            case xi::SkillType::Bonecraft:
                return Bone;
            case xi::SkillType::Alchemy:
                return Alchemy;
            case xi::SkillType::Cooking:
                return Cook;
            default:
                return 0;
        }
    }

    static auto crystalString(uint16 crystalID) -> std::string
    {
        std::string out = "None";

        switch (crystalID)
        {
            case FIRE_CRYSTAL:
            case INFERNO_CRYSTAL:
            case PYRE_CRYSTAL:
                out = "Fire";
                break;

            case ICE_CRYSTAL:
            case GLACIER_CRYSTAL:
            case FROST_CRYSTAL:
                out = "Ice";
                break;

            case WIND_CRYSTAL:
            case CYCLONE_CRYSTAL:
            case VORTEX_CRYSTAL:
                out = "Wind";
                break;

            case EARTH_CRYSTAL:
            case TERRA_CRYSTAL:
            case GEO_CRYSTAL:
                out = "Earth";
                break;

            case LIGHTNING_CRYSTAL:
            case PLASMA_CRYSTAL:
            case BOLT_CRYSTAL:
                out = "Lightning";
                break;

            case WATER_CRYSTAL:
            case TORRENT_CRYSTAL:
            case FLUID_CRYSTAL:
                out = "Water";
                break;

            case LIGHT_CRYSTAL:
            case AURORA_CRYSTAL:
            case GLIMMER_CRYSTAL:
                out = "Light";
                break;

            case DARK_CRYSTAL:
            case TWILIGHT_CRYSTAL:
            case SHADOW_CRYSTAL:
                out = "Dark";
                break;
        }

        return out;
    }

    static auto ingredientKey(uint16 crystal, const std::array<uint16, 8>& ingredients) -> std::string
    {
        return fmt::format("{}-{}-{}-{}-{}-{}-{}-{}-{}",
                           crystalString(crystal),
                           ingredients[0],
                           ingredients[1],
                           ingredients[2],
                           ingredients[3],
                           ingredients[4],
                           ingredients[5],
                           ingredients[6],
                           ingredients[7]);
    }

    auto key() const
    {
        return ingredientKey(Crystal,
                             { Ingredient1, Ingredient2, Ingredient3, Ingredient4, Ingredient5, Ingredient6, Ingredient7, Ingredient8 });
    }
};

FlatHashMap<std::string, SynthRecipe> synthRecipes;

struct CrystalProps
{
    uint8           element;
    SynthesisEffect effect;
};

auto crystalProps(uint16 itemId) -> CrystalProps
{
    switch (itemId)
    {
        case FIRE_CRYSTAL:
        case INFERNO_CRYSTAL:
        case PYRE_CRYSTAL:
            return { ELEMENT_FIRE, SynthesisEffect::Fire };
        case ICE_CRYSTAL:
        case GLACIER_CRYSTAL:
        case FROST_CRYSTAL:
            return { ELEMENT_ICE, SynthesisEffect::Ice };
        case WIND_CRYSTAL:
        case CYCLONE_CRYSTAL:
        case VORTEX_CRYSTAL:
            return { ELEMENT_WIND, SynthesisEffect::Wind };
        case EARTH_CRYSTAL:
        case TERRA_CRYSTAL:
        case GEO_CRYSTAL:
            return { ELEMENT_EARTH, SynthesisEffect::Earth };
        case LIGHTNING_CRYSTAL:
        case PLASMA_CRYSTAL:
        case BOLT_CRYSTAL:
            return { ELEMENT_LIGHTNING, SynthesisEffect::Lightning };
        case WATER_CRYSTAL:
        case TORRENT_CRYSTAL:
        case FLUID_CRYSTAL:
            return { ELEMENT_WATER, SynthesisEffect::Water };
        case LIGHT_CRYSTAL:
        case AURORA_CRYSTAL:
        case GLIMMER_CRYSTAL:
            return { ELEMENT_LIGHT, SynthesisEffect::Light };
        case DARK_CRYSTAL:
        case TWILIGHT_CRYSTAL:
        case SHADOW_CRYSTAL:
            return { ELEMENT_DARK, SynthesisEffect::Dark };
    }
    return { 0, SynthesisEffect::None };
}

void LoadSynthRecipes()
{
    TracyZoneScoped;

    ShowInfo("Loading synth recipes");

    synthRecipes.clear();

    // TODO: If we limit by ID ranges, we could use multiple threads to load the recipes

    const auto rset = db::preparedStmt("SELECT "
                                       "ID, "
                                       "Desynth, "
                                       "KeyItem, "
                                       "Wood, "
                                       "Smith, "
                                       "Gold, "
                                       "Cloth, "
                                       "Leather, "
                                       "Bone, "
                                       "Alchemy, "
                                       "Cook, "
                                       "Crystal, "
                                       "HQCrystal, "
                                       "Ingredient1, "
                                       "Ingredient2, "
                                       "Ingredient3, "
                                       "Ingredient4, "
                                       "Ingredient5, "
                                       "Ingredient6, "
                                       "Ingredient7, "
                                       "Ingredient8, "
                                       "Result, "
                                       "ResultHQ1, "
                                       "ResultHQ2, "
                                       "ResultHQ3, "
                                       "ResultQty, "
                                       "ResultHQ1Qty, "
                                       "ResultHQ2Qty, "
                                       "ResultHQ3Qty, "
                                       "ResultName, "
                                       "content_tag "
                                       "FROM synth_recipes");

    if (!rset || !rset->rowsCount())
    {
        ShowError("Failed to load synth recipes");
        return;
    }

    while (rset->next())
    {
        const auto recipe = SynthRecipe{
            .ID              = rset->get<uint32>("ID"),
            .Desynth         = rset->get<uint8>("Desynth"),
            .RequiredKeyItem = rset->get<KeyItem>("KeyItem"),
            .Wood            = rset->get<uint8>("Wood"),
            .Smith           = rset->get<uint8>("Smith"),
            .Gold            = rset->get<uint8>("Gold"),
            .Cloth           = rset->get<uint8>("Cloth"),
            .Leather         = rset->get<uint8>("Leather"),
            .Bone            = rset->get<uint8>("Bone"),
            .Alchemy         = rset->get<uint8>("Alchemy"),
            .Cook            = rset->get<uint8>("Cook"),
            .Crystal         = rset->get<uint16>("Crystal"),
            .HQCrystal       = rset->get<uint16>("HQCrystal"),
            .Ingredient1     = rset->get<uint16>("Ingredient1"),
            .Ingredient2     = rset->get<uint16>("Ingredient2"),
            .Ingredient3     = rset->get<uint16>("Ingredient3"),
            .Ingredient4     = rset->get<uint16>("Ingredient4"),
            .Ingredient5     = rset->get<uint16>("Ingredient5"),
            .Ingredient6     = rset->get<uint16>("Ingredient6"),
            .Ingredient7     = rset->get<uint16>("Ingredient7"),
            .Ingredient8     = rset->get<uint16>("Ingredient8"),
            .Result          = rset->get<uint16>("Result"),
            .ResultHQ1       = rset->get<uint16>("ResultHQ1"),
            .ResultHQ2       = rset->get<uint16>("ResultHQ2"),
            .ResultHQ3       = rset->get<uint16>("ResultHQ3"),
            .ResultQty       = rset->get<uint8>("ResultQty"),
            .ResultHQ1Qty    = rset->get<uint8>("ResultHQ1Qty"),
            .ResultHQ2Qty    = rset->get<uint8>("ResultHQ2Qty"),
            .ResultHQ3Qty    = rset->get<uint8>("ResultHQ3Qty"),
            .ResultName      = rset->get<std::string>("ResultName"),
            .ContentTag      = rset->getOrDefault<std::string>("content_tag", ""),
        };

        synthRecipes[recipe.key()] = recipe;
    }
}

/********************************************************************************************************************************
 * We check the availability of the recipe and the possibility of its synthesis.                                                 *
 * If its difficulty is 15 levels higher than character skill then recipe is considered too difficult and the synth is canceled. *
 * We also collect all the necessary information about the recipe, to avoid contacting the database repeatedly.                  *
 *                                                                                                                               *
 * In the itemID fields of the ninth cell, we save the recipe ID                                                                 *
 * In the quantity fields of 9-16 cells, write the required skills values                                                        *
 * In the fields itemID and slotID of 10-14 cells, we write the results of the synthesis                                         *
 ********************************************************************************************************************************/
// Used in: startSynth
auto resolveRecipe(CCharEntity* PChar, const SynthOffer& offer) -> bool
{
    TracyZoneScoped;

    std::array<uint16, 8> ingredientIds{};
    for (size_t i = 0; i < ingredientIds.size(); ++i)
    {
        ingredientIds[i] = offer.ingredients[i].itemId;
    }

    const auto possibleRecipeKey = SynthRecipe::ingredientKey(offer.crystal.itemId, ingredientIds);

    auto it = synthRecipes.find(possibleRecipeKey);
    if (it == synthRecipes.end())
    {
        PChar->pushPacket<GP_SERV_COMMAND_COMBINE_ANS>(PChar, SynthesisResult::CancelBadRecipe);
        return false;
    }

    const auto& recipe = it->second;

    if (!luautils::IsContentEnabled(recipe.ContentTag))
    {
        PChar->pushPacket<GP_SERV_COMMAND_COMBINE_ANS>(PChar, SynthesisResult::CancelBadRecipe);
        return false;
    }

    const CItem* PItem = xi::items::lookup(recipe.Result);
    if (PItem && PItem->hasFlag(ItemFlag::Rare) && charutils::HasItem(PChar, recipe.Result))
    {
        PChar->pushPacket<GP_SERV_COMMAND_COMBINE_ANS>(PChar, SynthesisResult::CancelRareItem);
        return false;
    }

    if (recipe.RequiredKeyItem != KeyItem::NONE && !charutils::hasKeyItem(PChar, recipe.RequiredKeyItem))
    {
        PChar->pushPacket<GP_SERV_COMMAND_COMBINE_ANS>(PChar, SynthesisResult::CancelBadRecipe);
        return false;
    }

    CCraftState::Init data{
        .recipeId      = recipe.ID,
        .craftMode     = static_cast<CRAFT_TYPE>(recipe.Desynth),
        .crystalItemId = offer.crystal.itemId,
        .element       = crystalProps(offer.crystal.itemId).element,
        .results       = { {
            {},
            { recipe.Result, recipe.ResultQty },
            { recipe.ResultHQ1, recipe.ResultHQ1Qty },
            { recipe.ResultHQ2, recipe.ResultHQ2Qty },
            { recipe.ResultHQ3, recipe.ResultHQ3Qty },
        } },
    };

    for (size_t i = 0; i < offer.ingredients.size(); ++i)
    {
        data.ingredientItemIds[i] = offer.ingredients[i].itemId;
    }

    for (uint8 skillID = static_cast<uint8>(xi::SkillType::Woodworking); skillID <= static_cast<uint8>(xi::SkillType::Cooking); ++skillID)
    {
        const uint16 skillValue   = recipe.getSkillValue(static_cast<xi::SkillType>(skillID));
        const uint16 currentSkill = PChar->RealSkills.skill[skillID];

        data.skillRequired[skillID - static_cast<uint8>(xi::SkillType::Woodworking)] = static_cast<uint8>(skillValue);

        if (currentSkill < (skillValue * 10 - 150))
        {
            PChar->pushPacket<GP_SERV_COMMAND_COMBINE_ANS>(PChar, SynthesisResult::CancelSkillTooLow);
            return false;
        }
    }

    PChar->craftState().populate(data);
    return true;
}

// Used in: LOCAL handleSynthResult
auto getSynthDifficulty(CCharEntity* PChar, uint8 skillID) -> int16
{
    Mod ModID = Mod::NONE;

    switch (static_cast<xi::SkillType>(skillID))
    {
        case xi::SkillType::Woodworking:
            ModID = Mod::WOOD;
            break;
        case xi::SkillType::Smithing:
            ModID = Mod::SMITH;
            break;
        case xi::SkillType::Goldsmithing:
            ModID = Mod::GOLDSMITH;
            break;
        case xi::SkillType::Clothcraft:
            ModID = Mod::CLOTH;
            break;
        case xi::SkillType::Leathercraft:
            ModID = Mod::LEATHER;
            break;
        case xi::SkillType::Bonecraft:
            ModID = Mod::BONE;
            break;
        case xi::SkillType::Alchemy:
            ModID = Mod::ALCHEMY;
            break;
        case xi::SkillType::Cooking:
            ModID = Mod::COOK;
            break;
        default:
            break;
    }

    const uint8 charSkill  = static_cast<uint8>(PChar->RealSkills.skill[skillID] / 10); // Player skill level is truncated before synth difficulty is calculated
    const int16 difficulty = static_cast<int16>(PChar->craftState().skillRequired(skillID - static_cast<uint8>(xi::SkillType::Woodworking)) - charSkill - PChar->getMod(ModID));

    return difficulty;
}

// Used in: LOCAL handleSynthResult
auto canSynthesizeHQ(CCharEntity* PChar, uint8 skillID) -> bool
{
    Mod ModID = Mod::NONE;

    switch (static_cast<xi::SkillType>(skillID))
    {
        case xi::SkillType::Woodworking:
            ModID = Mod::SYNTH_ANTI_HQ_WOODWORKING;
            break;
        case xi::SkillType::Smithing:
            ModID = Mod::SYNTH_ANTI_HQ_SMITHING;
            break;
        case xi::SkillType::Goldsmithing:
            ModID = Mod::SYNTH_ANTI_HQ_GOLDSMITHING;
            break;
        case xi::SkillType::Clothcraft:
            ModID = Mod::SYNTH_ANTI_HQ_CLOTHCRAFT;
            break;
        case xi::SkillType::Leathercraft:
            ModID = Mod::SYNTH_ANTI_HQ_LEATHERCRAFT;
            break;
        case xi::SkillType::Bonecraft:
            ModID = Mod::SYNTH_ANTI_HQ_BONECRAFT;
            break;
        case xi::SkillType::Alchemy:
            ModID = Mod::SYNTH_ANTI_HQ_ALCHEMY;
            break;
        case xi::SkillType::Cooking:
            ModID = Mod::SYNTH_ANTI_HQ_COOKING;
            break;
        default:
            break;
    }

    return (PChar->getMod(ModID) == 0);
}

auto calculateSynthResult(CCharEntity* PChar) -> uint8
{
    uint8  synthResult     = SYNTHESIS_SUCCESS;
    uint8  skillID         = 0;
    uint8  finalHQTier     = 4;
    uint8  currentHQTier   = 0;
    int16  synthDifficulty = 0;
    double successRate     = 0.0;
    bool   canHQ           = true;

    //------------------------------
    // Section 2: Break handling
    //------------------------------
    for (skillID = static_cast<uint8>(xi::SkillType::Woodworking); skillID <= static_cast<uint8>(xi::SkillType::Cooking); ++skillID)
    {
        // Skip current iteration if skill isn't involved.
        if (PChar->craftState().skillRequired(skillID - static_cast<uint8>(xi::SkillType::Woodworking)) == 0)
        {
            continue;
        }

        // Skill is involved. Get synth difficulty for current skill.
        synthDifficulty = getSynthDifficulty(PChar, skillID);
        successRate     = 95.0;
        currentHQTier   = 0;

        if (synthDifficulty >= 4)
        {
            successRate = 80.0 - 10.0 * static_cast<double>(synthDifficulty - 3);
            canHQ       = false;
        }
        else if (synthDifficulty >= 1)
        {
            successRate = 95.0 - 5.0 * static_cast<double>(synthDifficulty);
            canHQ       = false;
        }
        else if (synthDifficulty >= -10) // 0-10 levels over recipe.
        {
            currentHQTier = 1;
        }
        else if (synthDifficulty >= -30) // 11-30 levels over recipe.
        {
            currentHQTier = 2;
        }
        else if (synthDifficulty >= -50) // 31-50 levels over recipe.
        {
            currentHQTier = 3;
        }
        else // 51 or more levels over recipe.
        {
            currentHQTier = 4;
        }

        // Set final HQ Tier available if needed.
        if (currentHQTier < finalHQTier)
        {
            finalHQTier = currentHQTier;
        }

        successRate = successRate + static_cast<double>(PChar->getMod(Mod::SYNTH_SUCCESS_RATE));

        // Crafting ring handling.
        if (!canSynthesizeHQ(PChar, skillID))
        {
            canHQ       = false;             // Assuming here that if a crafting ring is used matching a recipe's subsynth, overall HQ will still be blocked
            successRate = successRate + 1.0; // The crafting rings that block HQ synthesis all also increase their respective craft's success rate by 1%
        }

        // Clamp success rate to 99%
        // https://www.bluegartr.com/threads/120352-CraftyMath
        // http://www.ffxiah.com/item/5781/kitron-macaron
        successRate = std::min(successRate, 99.0);

        if (xirand::GetRandomNumber(0.0, 100.0) > successRate) // Synthesis broke. This is not a mistake, the break check HAS to be done per craft skill involved.
        {
            // Keep the skill because of which the synthesis failed.
            PChar->craftState().setFailingSkill(skillID);
            synthResult = SYNTHESIS_FAIL;

            break;
        }
    }

    // Early return: We broke the synth.
    if (synthResult == SYNTHESIS_FAIL)
    {
        return SYNTHESIS_FAIL;
    }

    // Early return: We cannot HQ.
    if (!canHQ)
    {
        return SYNTHESIS_SUCCESS;
    }

    double chanceHQ = 0.0;
    switch (finalHQTier)
    {
        case 4: // 1 in 2
            chanceHQ = 50.0;
            break;
        case 3: // 1 in 4
            chanceHQ = 25.0;
            break;
        case 2: // 1 in 16
            chanceHQ = 6.25;
            break;
        case 1: // 1 in 64
            chanceHQ = 1.5625;
            break;
        default: // No chance
            chanceHQ = 0.0;
            break;
    }

    // See: https://www.bluegartr.com/threads/130586-CraftyMath-v2-Post-September-2017-Update page 3.
    chanceHQ = (chanceHQ + 100.0 * static_cast<double>(PChar->getMod(Mod::SYNTH_HQ_RATE)) / 512.0) * settings::get<double>("map.CRAFT_HQ_CHANCE_MULTIPLIER");

    // Limit max hq chance
    chanceHQ = std::min(chanceHQ, 80.0);

    // Early return: We fail HQ check.
    if (xirand::GetRandomNumber(0.0, 100.0) > chanceHQ)
    {
        return SYNTHESIS_SUCCESS;
    }

    // Early return: T0 cannot upgrade HQ.
    if (finalHQTier <= 1)
    {
        return SYNTHESIS_HQ;
    }

    // Calculate HQ2 and HQ3 upgrades.
    uint8 allowedUpgrades = (finalHQTier == 2 ? 1 : 2);
    uint8 upgradeHQ       = 0;
    for (uint8 tries = 0; tries < allowedUpgrades; ++tries)
    {
        if (xirand::GetRandomNumber(0.0, 100.0) <= 25.0) // 25% Chance to upgrade HQ
        {
            upgradeHQ = upgradeHQ + 1;
        }
        else
        {
            break;
        }
    }

    return static_cast<uint8>(SYNTHESIS_HQ + upgradeHQ);
}

auto calculateDesynthResult(CCharEntity* PChar) -> uint8
{
    uint8  synthResult     = SYNTHESIS_SUCCESS;
    uint8  skillID         = 0;
    int16  synthDifficulty = 0;
    double successRate     = 0.0;
    bool   canHQ           = true;

    // Calculate success or break.
    for (skillID = static_cast<uint8>(xi::SkillType::Woodworking); skillID <= static_cast<uint8>(xi::SkillType::Cooking); ++skillID)
    {
        // Skip current iteration if skill isn't involved.
        if (PChar->craftState().skillRequired(skillID - static_cast<uint8>(xi::SkillType::Woodworking)) == 0)
        {
            continue;
        }

        // Skill is involved. Get synth difficulty for current skill.
        synthDifficulty = getSynthDifficulty(PChar, skillID);

        if (synthDifficulty >= 8)
        {
            successRate = 10.0 - 10.0 * static_cast<double>(synthDifficulty - 7) / 3.0;
        }
        else if (synthDifficulty >= 1)
        {
            successRate = 40.0 - 5.0 * static_cast<double>(synthDifficulty - 1);
        }
        else
        {
            successRate = 40.0;
        }

        successRate = successRate + static_cast<double>(PChar->getMod(Mod::SYNTH_SUCCESS_RATE_DESYNTHESIS));

        // Crafting ring handling.
        if (!canSynthesizeHQ(PChar, skillID))
        {
            successRate = successRate + 1.0; // The crafting rings that block HQ synthesis all also increase their respective craft's success rate by 1%
            canHQ       = false;             // Assuming here that if a crafting ring is used matching a recipe's subsynth, overall HQ will still be blocked
        }

        if (xirand::GetRandomNumber(0.0, 100.0) > successRate) // Synthesis broke. This is not a mistake, the break check HAS to be done per craft skill involved.
        {
            // Keep the skill because of which the synthesis failed.
            PChar->craftState().setFailingSkill(skillID);
            synthResult = SYNTHESIS_FAIL;

            break;
        }
    }

    // Early return: We broke the synth.
    if (synthResult == SYNTHESIS_FAIL)
    {
        return SYNTHESIS_FAIL;
    }

    // Early return: We cannot HQ.
    if (!canHQ)
    {
        return SYNTHESIS_SUCCESS;
    }

    // See: https://www.bluegartr.com/threads/130586-CraftyMath-v2-Post-September-2017-Update page 3.
    double chanceHQ = (60.0 + 100.0 * static_cast<double>(PChar->getMod(Mod::SYNTH_HQ_RATE)) / 512.0) * settings::get<double>("map.CRAFT_HQ_CHANCE_MULTIPLIER");

    // Limit max hq chance
    chanceHQ = std::min(chanceHQ, 80.0);

    // Early return: We fail HQ check.
    if (xirand::GetRandomNumber(0.0, 100.0) > chanceHQ)
    {
        return SYNTHESIS_SUCCESS;
    }

    // Calculate HQ2 and HQ3 upgrades.
    uint8 upgradeHQ = 0;

    // https://www.bluegartr.com/threads/135055-Extensive-Desynthesis-Rate-Research?p=7789195&viewfull=1#post7789195
    // https://wiki.ffo.jp/html/401.html
    // In order to achieve a desynth HQ rate distribution of
    // (NQ , HQ1, HQ2, HQ3)
    // (40%, 30%, 20%, 10%)
    // roll a 50% HQ2 rate, then a 33.33(...)% rate for HQ3
    if (xirand::GetRandomNumber(0.0, 100.0) < 50.0)
    {
        upgradeHQ = 1;

        if (xirand::GetRandomNumber(0.0, 100.0) < (100.0 / 3.0))
        {
            upgradeHQ = 2;
        }
    }

    return static_cast<uint8>(SYNTHESIS_HQ + upgradeHQ);
}

// Used in: startSynth
auto handleSynthResult(CCharEntity* PChar) -> uint8
{
    // Calculate synthesis result based on synthesis type.
    uint8 synthResult = SYNTHESIS_FAIL;
    if (PChar->craftState().craftMode() == CRAFT_DESYNTHESIS)
    {
        synthResult = calculateDesynthResult(PChar);
    }
    else
    {
        synthResult = calculateSynthResult(PChar);
    }

    PChar->craftState().setResult(synthResult);

    switch (synthResult)
    {
        case SYNTHESIS_FAIL:
            synthResult = RESULT_FAIL;
            break;
        case SYNTHESIS_SUCCESS:
            synthResult = RESULT_SUCCESS;
            break;
        case SYNTHESIS_HQ:
        case SYNTHESIS_HQ2:
        case SYNTHESIS_HQ3:
            synthResult = RESULT_HQ;
            break;
    }

    return synthResult;
}

// Used in: LOCAL handleSynthFail
void handleMaterialLoss(CCharEntity* PChar)
{
    auto& craftState       = PChar->craftState();
    auto& synthTransaction = *PChar->activeTransaction<SynthTransaction>();

    uint8 currentCraft = craftState.failingSkill();

    const int16 breakGlobalReduction    = PChar->getMod(Mod::SYNTH_MATERIAL_LOSS);
    const int16 breakElementalReduction = PChar->getMod(static_cast<Mod>(static_cast<int32>(Mod::SYNTH_MATERIAL_LOSS_FIRE) + craftState.element()));
    const int16 breakTypeReduction      = PChar->getMod(static_cast<Mod>(static_cast<int32>(Mod::SYNTH_MATERIAL_LOSS_WOODWORKING) + currentCraft - static_cast<uint8>(xi::SkillType::Woodworking)));
    int16       synthDifficulty         = getSynthDifficulty(PChar, currentCraft);

    synthDifficulty = std::max<int16>(synthDifficulty, 0);

    // Break Chance.
    // Clamp note: https://wiki-ffo-jp.translate.goog/html/36626.html?_x_tr_sl=ja&_x_tr_tl=en&_x_tr_hl=en&_x_tr_pto=sc
    const int16 breakChance = static_cast<int16>(std::clamp(50 - breakGlobalReduction - breakElementalReduction - breakTypeReduction + 5 * synthDifficulty, 20, 100));

    for (uint8 idx = 0; idx < SynthMaxIngredients; ++idx)
    {
        if (craftState.ingredientItemId(idx) == 0)
        {
            continue;
        }

        const uint8 random = static_cast<uint8>(1 + xirand::GetRandomNumber(100));
        if (random <= breakChance)
        {
            craftState.markBroken(idx);
        }
        else
        {
            synthTransaction.markSaved(idx);
        }
    }
}

// Used in: sendSynthDone
void handleSynthSuccess(CCharEntity* PChar)
{
    auto&       craftState       = PChar->craftState();
    auto&       synthTransaction = *PChar->activeTransaction<SynthTransaction>();
    const auto& result           = craftState.resultTier(craftState.result());

    synthTransaction.setResultDelivery(result);

    // Use appropiate message (Regular or desynthesis)
    const auto message = craftState.craftMode() == CRAFT_DESYNTHESIS ? SynthesisResult::SuccessDesynth : SynthesisResult::Success;

    PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, std::make_unique<GP_SERV_COMMAND_COMBINE_INF>(PChar, message, result));
    PChar->pushPacket<GP_SERV_COMMAND_COMBINE_ANS>(PChar, message, result);

    // Calculate what craft this recipe "belongs" to based on highest skill required
    uint32 skillType    = 0;
    uint32 highestSkill = 0;
    for (uint8 skillID = static_cast<uint8>(xi::SkillType::Woodworking); skillID <= static_cast<uint8>(xi::SkillType::Cooking); ++skillID)
    {
        uint8 skillRequired = craftState.skillRequired(skillID - static_cast<uint8>(xi::SkillType::Woodworking));
        if (skillRequired > highestSkill)
        {
            skillType    = skillID;
            highestSkill = skillRequired;
        }
    }

    RoeDatagram     roeItemId    = RoeDatagram("itemid", result.itemId);
    RoeDatagram     roeSkillType = RoeDatagram("skillType", skillType);
    RoeDatagramList roeSynthResult({ roeItemId, roeSkillType });

    roeutils::event(ROE_EVENT::ROE_SYNTHSUCCESS, PChar, roeSynthResult);
}

// Used in: sendSynthDone
void handleSynthFail(CCharEntity* PChar)
{
    auto& craftState       = PChar->craftState();
    auto& synthTransaction = *PChar->activeTransaction<SynthTransaction>();

    if (craftState.craftMode() != CRAFT_SYNTHESIS_NO_LOSS)
    {
        handleMaterialLoss(PChar);
    }
    else
    {
        // No-loss recipe: every claimed ingredient survives intact.
        for (uint8 idx = 0; idx < SynthMaxIngredients; ++idx)
        {
            if (craftState.ingredientItemId(idx) != 0)
            {
                synthTransaction.markSaved(idx);
            }
        }
    }

    // Push "Synthesis failed" messages.
    uint16 currentZone = PChar->loc.zone->GetID();

    if (currentZone &&
        currentZone != ZONE_MONORAIL_PRE_RELEASE &&
        currentZone != ZONE_49 &&
        currentZone < MAX_ZONEID)
    {
        PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, std::make_unique<GP_SERV_COMMAND_COMBINE_INF>(PChar, SynthesisResult::Failed));
    }

    PChar->pushPacket<GP_SERV_COMMAND_COMBINE_ANS>(PChar, SynthesisResult::Failed, CCraftState::Result{ MANGLED_MESS, 0 });
}

// Used in: sendSynthDone
void doSynthSkillUp(CCharEntity* PChar)
{
    for (uint8 skillID = static_cast<uint8>(xi::SkillType::Woodworking); skillID <= static_cast<uint8>(xi::SkillType::Cooking); ++skillID) // Check for all skills involved in a recipe, to check for skill up
    {
        //------------------------------
        // Section 1: Checks
        //------------------------------

        // We don't Skill Up if the recipe doesn't involve the currently checked skill.
        if (PChar->craftState().skillRequired(skillID - static_cast<uint8>(xi::SkillType::Woodworking)) == 0)
        {
            continue; // Break current loop iteration.
        }

        uint16 maxSkill  = (PChar->RealSkills.rank[skillID] + 1) * 100; // Skill cap, depending on rank
        uint16 charSkill = PChar->RealSkills.skill[skillID];            // Compare against real character skill, without image support, gear or moghancements

        // We don't skill Up if the involved skill is caped (As a fail-safe measure, we also check if a naughty GM has set its skill over cap aswell)
        if (charSkill >= maxSkill)
        {
            continue; // Break current loop iteration.
        }

        // We don't Skill Up if the recipe isn't difficult enough.
        // Era -> Char lvl must be bellow recipe level. Retail -> Char level myst be bellow recipe level + 10.
        // Char level does NOT count the effects of image support/gear.
        const int16 baseDiff = static_cast<int16>(PChar->craftState().skillRequired(skillID - static_cast<uint8>(xi::SkillType::Woodworking)) - charSkill / 10);
        const int8  minDiff  = settings::get<bool>("map.CRAFT_MODERN_SYSTEM") ? -11 : 0;
        if (baseDiff <= minDiff)
        {
            continue; // Break current loop iteration.
        }

        // We don't Skill Up if the synth breaks outside the [-5, 0) interval
        if (PChar->craftState().result() == SYNTHESIS_FAIL && (baseDiff > 5 || baseDiff <= 0))
        {
            continue; // Break current loop iteration.
        }

        //------------------------------
        // Section 2: Skill up chance calculation
        //------------------------------
        double skillUpChance = 0.0;

        if (settings::get<bool>("map.CRAFT_MODERN_SYSTEM"))
        {
            if (baseDiff > 1)
            {
                skillUpChance = static_cast<double>(baseDiff) * (3.0 - std::log(1.2 + static_cast<double>(charSkill) / 100.0)) / 5.0; // Original skill up equation with "x2 chance" applied.
            }
            else
            {
                skillUpChance = (3.0 - std::log(1.2 + static_cast<double>(charSkill) / 100.0)) / static_cast<double>(6 - baseDiff); // Equation used when over cap.
            }
        }
        else
        {
            skillUpChance = static_cast<double>(baseDiff) * (3.0 - std::log(1.2 + static_cast<double>(charSkill) / 100.0)) / 10.0; // Original skill up equation.
        }

        // Apply synthesis skill gain rate modifier before synthesis fail modifier
        const double modSynthSkillGain = static_cast<double>(PChar->getMod(Mod::SYNTH_SKILL_GAIN)) / 100.0;
        skillUpChance                  = skillUpChance + modSynthSkillGain;

        // Apply setting multiplier.
        const double craftChanceMultiplier = settings::get<double>("map.CRAFT_CHANCE_MULTIPLIER");
        skillUpChance                      = skillUpChance * craftChanceMultiplier;

        // Chance penalties.
        uint8 penalty = 1;

        if (PChar->craftState().craftMode() == CRAFT_DESYNTHESIS) // If it's a desynth, lower skill up rate
        {
            penalty += 1;
        }

        if (PChar->craftState().result() == SYNTHESIS_FAIL) // If synth breaks, lower skill up rate
        {
            penalty += 1;
        }

        skillUpChance = skillUpChance / static_cast<double>(penalty); // Lower skill up chance if synth breaks

        //------------------------------
        // Section 3: Skill Up or break loop
        //------------------------------
        const double random = xirand::GetRandomNumber(1.0);

        if (random >= skillUpChance) // If character doesn't skill up
        {
            continue; // Break current loop iteration.
        }

        //------------------------------
        // Section 4: Calculate Skill Up Amount
        //------------------------------
        uint8 maxAllowedAmount = 1;
        if (charSkill < 600) // No skill ups over 0.1 happen over level 60.
        {
            if (baseDiff >= 12)
            {
                maxAllowedAmount = 4;
            }
            else if (baseDiff >= 6)
            {
                maxAllowedAmount = 3;
            }
            else if (baseDiff >= 3)
            {
                maxAllowedAmount = 2;
            }
        }

        // TODO: More info needed for rates. This is using what was already here since the dark ages.
        uint8 skillUpAmount = 1;
        if (maxAllowedAmount > 1)
        {
            const uint8 cicles = static_cast<uint8>(maxAllowedAmount - 1);
            double      chance = 0.0;

            for (uint8 i = 1; i <= cicles; i++) // Cicle up to 3 times until cap (0.4 skill-up value) or break. The lower the maxAllowedAmount, the more likely it will break.
            {
                chance = static_cast<double>(maxAllowedAmount) * 0.1;

                if (chance < xirand::GetRandomNumber(1.0))
                {
                    break;
                }

                skillUpAmount++;
                maxAllowedAmount--;
            }
        }

        // Settings skill amount multiplier
        if (settings::get<uint8>("map.CRAFT_AMOUNT_MULTIPLIER") > 1)
        {
            // Scaled at int width: at uint8 width a large multiplier setting wraps before the cap below can catch it.
            const int scaledAmount = skillUpAmount + skillUpAmount * settings::get<uint8>("map.CRAFT_AMOUNT_MULTIPLIER");

            skillUpAmount = static_cast<uint8>(std::min(scaledAmount, 9));
        }

        // Cap skill gain amount if character hits the current cap
        skillUpAmount = static_cast<uint8>(std::min<uint16>(skillUpAmount, maxSkill - charSkill));

        //------------------------------
        // Section 5: Spezialization System (Craft delevel system over certain point)
        //------------------------------
        uint16 craftCommonCap    = settings::get<uint16>("map.CRAFT_COMMON_CAP");
        uint16 skillCumulation   = skillUpAmount;
        uint8  skillHighest      = skillID; // Default to lowering current skill in use, since we have to lower something if it's going past the limit... (AKA, badly configurated server)
        uint16 skillHighestValue = settings::get<uint16>("map.CRAFT_COMMON_CAP");

        if ((charSkill + skillUpAmount) > craftCommonCap) // If server is using the specialization system
        {
            for (uint8 i = static_cast<uint8>(xi::SkillType::Woodworking); i <= static_cast<uint8>(xi::SkillType::Cooking); i++) // Cycle through all skills
            {
                if (PChar->RealSkills.skill[i] > craftCommonCap) // If the skill being checked is above the cap from wich spezialitation points start counting.
                {
                    skillCumulation += (PChar->RealSkills.skill[i] - craftCommonCap); // Add to the ammount of specialization points in use.

                    if (skillID != i && PChar->RealSkills.skill[i] > skillHighestValue) // Set the ID of the highest craft UNLESS it's the craft currently in use and if it's the highest skill.
                    {
                        skillHighest      = i;
                        skillHighestValue = PChar->RealSkills.skill[i];
                    }
                }
            }
        }

        //------------------------------
        // Section 6: Handle messages and save results.
        //------------------------------

        // Skill Up addition:
        PChar->RealSkills.skill[skillID] += skillUpAmount;
        PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, skillID, skillUpAmount, MsgBasic::SkillGain);

        if ((charSkill / 10) < (charSkill + skillUpAmount) / 10)
        {
            PChar->WorkingSkills.skill[skillID] += 0x20;

            if (PChar->RealSkills.skill[skillID] >= maxSkill)
            {
                PChar->WorkingSkills.skill[skillID] |= 0x8000; // blue capped text
            }

            PChar->pushPacket<GP_SERV_COMMAND_CLISTATUS2>(PChar);
            PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, skillID, (charSkill + skillUpAmount) / 10, MsgBasic::SkillLevelUp);
        }

        charutils::SaveCharSkills(PChar, skillID);

        // Skill Up removal if using spezialization system
        if (skillCumulation > settings::get<uint16>("map.CRAFT_SPECIALIZATION_POINTS"))
        {
            PChar->RealSkills.skill[skillHighest] -= skillUpAmount;
            PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, skillHighest, skillUpAmount, MsgBasic::SkillDrop);

            if ((PChar->RealSkills.skill[skillHighest] + skillUpAmount) / 10 > (PChar->RealSkills.skill[skillHighest]) / 10)
            {
                PChar->WorkingSkills.skill[skillHighest] -= 0x20;
                PChar->pushPacket<GP_SERV_COMMAND_CLISTATUS2>(PChar);
                PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, skillHighest, (PChar->RealSkills.skill[skillHighest] - skillUpAmount) / 10, MsgBasic::SkillLevelUp);
            }

            charutils::SaveCharSkills(PChar, skillHighest);
        }
    }
}

/************************
 * Public functions     *
 ************************/
void startSynth(CCharEntity* PChar, const SynthOffer& offer)
{
    PChar->m_LastSynthTime = timer::now();

    if (!resolveRecipe(PChar, offer))
    {
        return;
    }

    auto synthTransaction = SynthTransaction::start(PChar, offer);
    if (!synthTransaction)
    {
        ShowWarningFmt("startSynth: failed to claim ingredients for {}", PChar->getName());
        PChar->pushPacket<GP_SERV_COMMAND_COMBINE_ANS>(PChar, SynthesisResult::CancelBadRecipe);
        return;
    }

    const auto effect = crystalProps(offer.crystal.itemId).effect;

    PChar->addTransaction(std::move(synthTransaction))->consumeCrystal();

    uint8 result = handleSynthResult(PChar);

    // Calculate what craft this recipe "belongs" to based on highest skill required
    uint32 skillType    = 0;
    uint32 highestSkill = 0;
    for (uint8 skillID = static_cast<uint8>(xi::SkillType::Woodworking); skillID <= static_cast<uint8>(xi::SkillType::Cooking); ++skillID)
    {
        if (const uint8 skillRequired = PChar->craftState().skillRequired(skillID - static_cast<uint8>(xi::SkillType::Woodworking)); skillRequired > highestSkill)
        {
            skillType    = skillID;
            highestSkill = skillRequired;
        }
    }

    PChar->animation = xi::Animation::Synth;
    PChar->updatemask |= UPDATE_HP;
    PChar->pushPacket<CCharStatusPacket>(PChar);
    PChar->startSynth(static_cast<xi::SkillType>(skillType));

    PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, std::make_unique<GP_SERV_COMMAND_EFFECT>(PChar, effect, result));
}

void sendSynthDone(CCharEntity* PChar)
{
    // forceSynthCritFail already ran, the transaction is gone -- clear the xi::Animation::Synth flag and bail.
    auto* synthTransaction = PChar->activeTransaction<SynthTransaction>();
    if (!synthTransaction)
    {
        PChar->animation = xi::Animation::None;
        PChar->updatemask |= UPDATE_HP;
        PChar->pushPacket<CCharStatusPacket>(PChar);
        return;
    }

    if (PChar->craftState().result() == SYNTHESIS_FAIL)
    {
        handleSynthFail(PChar);
    }
    else
    {
        handleSynthSuccess(PChar);
    }

    doSynthSkillUp(PChar);

    std::ignore = synthTransaction->commit();
    PChar->removeTransaction(synthTransaction);

    PChar->animation = xi::Animation::None;
    PChar->updatemask |= UPDATE_HP;
    PChar->pushPacket<CCharStatusPacket>(PChar);
}

void doSynthCriticalFail(CCharEntity* PChar)
{
    auto* synthTransaction = PChar->activeTransaction<SynthTransaction>();
    if (!synthTransaction)
    {
        return;
    }

    auto& craftState = PChar->craftState();
    for (uint8 idx = 0; idx < SynthMaxIngredients; ++idx)
    {
        if (craftState.ingredientItemId(idx) != 0)
        {
            craftState.markBroken(idx);
        }
    }

    // Push "Synthesis failed" messages.
    uint16 currentZone = PChar->loc.zone->GetID();

    if (currentZone &&
        currentZone != ZONE_MONORAIL_PRE_RELEASE &&
        currentZone != ZONE_49 &&
        currentZone < MAX_ZONEID)
    {
        PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, std::make_unique<GP_SERV_COMMAND_COMBINE_INF>(PChar, SynthesisResult::InterruptedCritical));
    }

    PChar->pushPacket<GP_SERV_COMMAND_COMBINE_ANS>(PChar, SynthesisResult::InterruptedCritical, CCraftState::Result{ MANGLED_MESS, 0 });

    std::ignore = synthTransaction->commit();
    PChar->removeTransaction(synthTransaction);

    PChar->animation = xi::Animation::None;
    PChar->updatemask |= UPDATE_HP;
    PChar->pushPacket<CCharStatusPacket>(PChar);
}

} // namespace synthutils
