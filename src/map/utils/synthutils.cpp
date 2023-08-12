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

#include "common/logging.h"
#include "common/socket.h"
#include "common/utils.h"
#include "common/vana_time.h"

#include <cmath>
#include <cstring>

#include "packets/char_skills.h"
#include "packets/char_update.h"
#include "packets/inventory_assign.h"
#include "packets/inventory_finish.h"
#include "packets/inventory_item.h"
#include "packets/message_basic.h"
#include "packets/synth_animation.h"
#include "packets/synth_message.h"
#include "packets/synth_result.h"

#include "anticheat.h"
#include "item_container.h"
#include "map.h"
#include "roe.h"
#include "trade_container.h"

#include "charutils.h"
#include "itemutils.h"
#include "zoneutils.h"

namespace synthutils
{
    /********************************************************************************************************************************
     * We check the availability of the recipe and the possibility of its synthesis.                                                 *
     * If its difficulty is 15 levels higher than character skill then recipe is considered too difficult and the synth is canceled. *
     * We also collect all the necessary information about the recipe, to avoid contacting the database repeatedly.                  *
     *                                                                                                                               *
     * In the itemID fields of the ninth cell, we save the recipe ID                                                                 *
     * In the quantity fields of 9-16 cells, write the required skills values                                                        *
     * In the fields itemID and slotID of 10-14 cells, we write the results of the synthesis                                         *
     ********************************************************************************************************************************/

    bool isRightRecipe(CCharEntity* PChar)
    {
        const char* fmtQuery =

            "SELECT ID, KeyItem, Wood, Smith, Gold, Cloth, Leather, Bone, Alchemy, Cook, \
            Result, ResultHQ1, ResultHQ2, ResultHQ3, ResultQty, ResultHQ1Qty, ResultHQ2Qty, ResultHQ3Qty, Desynth \
        FROM synth_recipes \
        WHERE (Crystal = %u OR HQCrystal = %u) \
            AND Ingredient1 = %u \
            AND Ingredient2 = %u \
            AND Ingredient3 = %u \
            AND Ingredient4 = %u \
            AND Ingredient5 = %u \
            AND Ingredient6 = %u \
            AND Ingredient7 = %u \
            AND Ingredient8 = %u \
        LIMIT 1";

        int32 ret = sql->Query(fmtQuery, PChar->CraftContainer->getItemID(0), PChar->CraftContainer->getItemID(0),
                               PChar->CraftContainer->getItemID(1), PChar->CraftContainer->getItemID(2), PChar->CraftContainer->getItemID(3),
                               PChar->CraftContainer->getItemID(4), PChar->CraftContainer->getItemID(5), PChar->CraftContainer->getItemID(6),
                               PChar->CraftContainer->getItemID(7), PChar->CraftContainer->getItemID(8));

        if (ret != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
        {
            uint16 KeyItemID = (uint16)sql->GetUIntData(1); // Check if recipe needs KI

            if ((KeyItemID == 0) || (charutils::hasKeyItem(PChar, KeyItemID))) // If recipe doesn't need KI OR Player has the required KI
            {
                // in the ninth cell write the id of the recipe
                PChar->CraftContainer->setItem(9, sql->GetUIntData(0), 0xFF, 0);
                PChar->CraftContainer->setItem(10 + 1, (uint16)sql->GetUIntData(10), (uint8)sql->GetUIntData(14), 0); // RESULT_SUCCESS
                PChar->CraftContainer->setItem(10 + 2, (uint16)sql->GetUIntData(11), (uint8)sql->GetUIntData(15), 0); // RESULT_HQ
                PChar->CraftContainer->setItem(10 + 3, (uint16)sql->GetUIntData(12), (uint8)sql->GetUIntData(16), 0); // RESULT_HQ2
                PChar->CraftContainer->setItem(10 + 4, (uint16)sql->GetUIntData(13), (uint8)sql->GetUIntData(17), 0); // RESULT_HQ3
                PChar->CraftContainer->setCraftType((uint8)sql->GetUIntData(18));                                     // Store if it's a desynth

                uint16 skillValue   = 0;
                uint16 currentSkill = 0;

                for (uint8 skillID = SKILL_WOODWORKING; skillID <= SKILL_COOKING; ++skillID) // range for all 8 synth skills
                {
                    skillValue   = (uint16)sql->GetUIntData((skillID - 49 + 2));
                    currentSkill = PChar->RealSkills.skill[skillID];

                    // skill write in the quantity field of cells 9-16
                    PChar->CraftContainer->setQuantity(skillID - 40, skillValue);

                    if (currentSkill < (skillValue * 10 - 150)) // Check player skill against recipe level. Range must be 14 or less.
                    {
                        PChar->pushPacket(new CSynthMessagePacket(PChar, SYNTH_NOSKILL));
                        return false;
                    }
                }
                return true;
            }
        }

        PChar->pushPacket(new CSynthMessagePacket(PChar, SYNTH_BADRECIPE));
        return false;
    }

    /****************************************************************************
     *                                                                           *
     * We calculate the complexity of the synthesis for a particular skill.      *
     * It is good to save the result in some cell of the container (dooble type) *
     *                                                                           *
     ****************************************************************************/

    int16 getSynthDifficulty(CCharEntity* PChar, uint8 skillID)
    {
        Mod ModID = Mod::NONE;

        switch (skillID)
        {
            case SKILL_WOODWORKING:
                ModID = Mod::WOOD;
                break;
            case SKILL_SMITHING:
                ModID = Mod::SMITH;
                break;
            case SKILL_GOLDSMITHING:
                ModID = Mod::GOLDSMITH;
                break;
            case SKILL_CLOTHCRAFT:
                ModID = Mod::CLOTH;
                break;
            case SKILL_LEATHERCRAFT:
                ModID = Mod::LEATHER;
                break;
            case SKILL_BONECRAFT:
                ModID = Mod::BONE;
                break;
            case SKILL_ALCHEMY:
                ModID = Mod::ALCHEMY;
                break;
            case SKILL_COOKING:
                ModID = Mod::COOK;
                break;
        }

        uint8 charSkill  = PChar->RealSkills.skill[skillID] / 10; // Player skill level is truncated before synth difficulty is calculated
        int16 difficulty = PChar->CraftContainer->getQuantity(skillID - 40) - charSkill - PChar->getMod(ModID);

        return difficulty;
    }

    /*************************************************************
     *                                                            *
     * Checking the ability to create high quality items          *
     * This is due to the presence of specific rings in the game. *
     *                                                            *
     *************************************************************/

    bool canSynthesizeHQ(CCharEntity* PChar, uint8 skillID)
    {
        Mod ModID = Mod::NONE;

        switch (skillID)
        {
            case SKILL_WOODWORKING:
                ModID = Mod::ANTIHQ_WOOD;
                break;
            case SKILL_SMITHING:
                ModID = Mod::ANTIHQ_SMITH;
                break;
            case SKILL_GOLDSMITHING:
                ModID = Mod::ANTIHQ_GOLDSMITH;
                break;
            case SKILL_CLOTHCRAFT:
                ModID = Mod::ANTIHQ_CLOTH;
                break;
            case SKILL_LEATHERCRAFT:
                ModID = Mod::ANTIHQ_LEATHER;
                break;
            case SKILL_BONECRAFT:
                ModID = Mod::ANTIHQ_BONE;
                break;
            case SKILL_ALCHEMY:
                ModID = Mod::ANTIHQ_ALCHEMY;
                break;
            case SKILL_COOKING:
                ModID = Mod::ANTIHQ_COOK;
                break;
        }

        return (PChar->getMod(ModID) == 0);
    }

    /**************************************************************************************
     *                                                                                     *
     * Calculation of the result of the synthesis.                                         *
     *                                                                                     *
     * The result of the synthesis is written in the quantity field of the crystal cell.   *
     * Save the skill ID in the slotID of the crystal cell, due to which synthesis failed. *
     *                                                                                     *
     **************************************************************************************/

    uint8 calcSynthResult(CCharEntity* PChar)
    {
        //------------------------------
        // Section 1: Variable definitions.
        //------------------------------
        uint8 synthResult = SYNTHESIS_SUCCESS; // We assume that we succeed.
        float successRate = 95;                // We assume that success rate is maxed (95%).
        uint8 finalHQTier = 4;                 // We assume that max HQ tier is available.
        bool  canHQ       = true;              // We assume that we can HQ.

        uint8 skillID         = 0; // Current crafting skill being checked.
        uint8 recipeSkill     = 0; // Recipe current skill level, based on current skill ID being checked.
        int16 synthDifficulty = 0; // Recipe difficulty, based on current skill ID being checked from player and recipe.
        uint8 currentHQTier   = 0; // Recipe current available HQ tier, based on current skill ID being checked.
        float chanceHQ        = 0;
        uint8 maxChanceHQ     = 50;
        uint8 randomRoll      = 0; // 1 to 100.

        if (PChar->CraftContainer->getCraftType() == CRAFT_DESYNTHESIS) // If it's a desynth, lower base success rate.
        {
            successRate = 45;
            maxChanceHQ = 80;
        }

        //------------------------------
        // Section 2: Break handling
        //------------------------------
        for (skillID = SKILL_WOODWORKING; skillID <= SKILL_COOKING; ++skillID)
        {
            recipeSkill = PChar->CraftContainer->getQuantity(skillID - 40);

            // Only do stuff if the recipe actually uses that skill.
            if (recipeSkill != 0)
            {
                randomRoll      = xirand::GetRandomNumber(1, 100);    // Random call must be called for each involved skill.
                currentHQTier   = 0;                                  // This is reset at the start of every loop. "finalHQTier" is not.
                synthDifficulty = getSynthDifficulty(PChar, skillID); // Get synth difficulty again, for each skill involved.

                if (synthDifficulty <= 0)
                {
                    // Check what the current HQ tier is.
                    if (synthDifficulty >= -10) // 0-10 levels over recipe.
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
                }
                else
                {
                    canHQ       = false; // Player skill level is lower than recipe skill level. Cannot HQ.
                    successRate = successRate - synthDifficulty * 10;

                    if (successRate < 5)
                    {
                        successRate = 5;
                    }
                }

                // Apply synthesis success rate modifier, based on synth type.
                if (PChar->CraftContainer->getCraftType() == CRAFT_DESYNTHESIS)
                {
                    successRate = successRate + PChar->getMod(Mod::DESYNTH_SUCCESS);
                }
                else
                {
                    successRate = successRate + PChar->getMod(Mod::SYNTH_SUCCESS);
                }

                // Crafting ring handling.
                if (!canSynthesizeHQ(PChar, skillID))
                {
                    canHQ       = false;           // Assuming here that if a crafting ring is used matching a recipe's subsynth, overall HQ will still be blocked
                    successRate = successRate + 1; // The crafting rings that block HQ synthesis all also increase their respective craft's success rate by 1%
                }

                // Clamp success rate to 0.99
                // https://www.bluegartr.com/threads/120352-CraftyMath
                // http://www.ffxiah.com/item/5781/kitron-macaron
                if (successRate > 99)
                {
                    successRate = 99;
                }

                if (randomRoll > successRate) // Synthesis broke
                {
                    // Keep the skill because of which the synthesis failed.
                    // Use the slotID of the crystal cell, because it was removed at the beginning of the synthesis.
                    PChar->CraftContainer->setInvSlotID(0, skillID);
                    synthResult = SYNTHESIS_FAIL;

                    break;
                }
            }
        }

        //------------------------------
        // Section 3: HQ handling
        //------------------------------
        if (synthResult != SYNTHESIS_FAIL && canHQ) // It hasn't broken, so lets continue.
        {
            switch (finalHQTier)
            {
                case 4: // 1 in 2
                    chanceHQ = 50.0;
                    break;
                case 3: // 1 in 4
                    chanceHQ = 25.0;
                    break;
                case 2: // 1 in 20
                    chanceHQ = 5.0;
                    break;
                case 1: // 1 in 100
                    chanceHQ = 1.0;
                    break;
                default: // No chance
                    chanceHQ = 0.0;
                    break;
            }

            if (PChar->CraftContainer->getCraftType() == CRAFT_DESYNTHESIS) // if it's a desynth raise HQ chance
            {
                chanceHQ = chanceHQ * 1.5;
            }

            // HQ success rate modifier.
            // See: https://www.bluegartr.com/threads/130586-CraftyMath-v2-Post-September-2017-Update page 3.
            chanceHQ = chanceHQ + PChar->getMod(Mod::SYNTH_HQ_RATE) / 512;

            // limit max hq chance
            if (chanceHQ > maxChanceHQ)
            {
                chanceHQ = maxChanceHQ;
            }

            if (randomRoll <= chanceHQ) // We HQ. Proceed to selct HQ Tier
            {
                synthResult = SYNTHESIS_HQ;
                randomRoll  = xirand::GetRandomNumber(1, 100);

                if (randomRoll <= 25) // 25% Chance after HQ to upgrade to HQ2
                {
                    synthResult = SYNTHESIS_HQ2;
                    randomRoll  = xirand::GetRandomNumber(1, 100);

                    if (randomRoll <= 25) // 25% Chance after HQ2 to upgrade to HQ3
                    {
                        synthResult = SYNTHESIS_HQ3;
                    }
                }
            }
        }

        //------------------------------
        // Section 4: System handling. The result of the synthesis is written in the quantity field of the crystal cell.
        //------------------------------
        PChar->CraftContainer->setQuantity(0, synthResult);

        switch (synthResult)
        {
            case SYNTHESIS_FAIL:
                synthResult = RESULT_FAIL;
                break;
            case SYNTHESIS_SUCCESS:
                synthResult = RESULT_SUCCESS;
                break;
            case SYNTHESIS_HQ:
                synthResult = RESULT_HQ;
                break;
            case SYNTHESIS_HQ2:
                synthResult = RESULT_HQ;
                break;
            case SYNTHESIS_HQ3:
                synthResult = RESULT_HQ;
                break;
        }
        return synthResult;
    }

    /********************************************************************
     *                                                                   *
     * Do Skill Up                                                       *
     *                                                                   *
     ********************************************************************/
    int32 doSynthSkillUp(CCharEntity* PChar)
    {
        for (uint8 skillID = SKILL_WOODWORKING; skillID <= SKILL_COOKING; ++skillID) // Check for all skills involved in a recipe, to check for skill up
        {
            //------------------------------
            // Section 1: Checks
            //------------------------------

            // We don't Skill Up if the recipe doesn't involve the currently checked skill.
            if (PChar->CraftContainer->getQuantity(skillID - 40) == 0)
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

            int16 baseDiff = PChar->CraftContainer->getQuantity(skillID - 40) - charSkill / 10; // the 5 lvl difference rule for breaks does NOT consider the effects of image support/gear

            // We don't Skill Up if over 10 levels above synth skill. (Or at AND above synth skill in era)
            if ((settings::get<bool>("map.CRAFT_MODERN_SYSTEM") && (baseDiff <= -11)) || (!settings::get<bool>("map.CRAFT_MODERN_SYSTEM") && (baseDiff <= 0)))
            {
                continue; // Break current loop iteration.
            }

            // We don't Skill Up if the synth breaks outside the [-5, 0) interval
            if ((PChar->CraftContainer->getQuantity(0) == SYNTHESIS_FAIL) && ((baseDiff > 5) || (baseDiff <= 0)))
            {
                continue; // Break current loop iteration.
            }

            //------------------------------
            // Section 2: Skill up equations and penalties
            //------------------------------
            double skillUpChance = 0;

            double craftChanceMultiplier = settings::get<double>("map.CRAFT_CHANCE_MULTIPLIER");

            if (settings::get<bool>("map.CRAFT_MODERN_SYSTEM"))
            {
                if (baseDiff > 0)
                {
                    skillUpChance = (double)baseDiff * craftChanceMultiplier * (3 - (log(1.2 + charSkill / 100))) / 5; // Original skill up equation with "x2 chance" applied.
                }
                else
                {
                    skillUpChance = craftChanceMultiplier * (3 - (log(1.2 + charSkill / 100))) / (6 - baseDiff); // Equation used when over cap.
                }
            }
            else
            {
                skillUpChance = (double)baseDiff * craftChanceMultiplier * (3 - (log(1.2 + charSkill / 100))) / 10; // Original skill up equation
            }

            // Apply synthesis skill gain rate modifier before synthesis fail modifier
            int16 modSynthSkillGain = PChar->getMod(Mod::SYNTH_SKILL_GAIN);
            skillUpChance += (double)modSynthSkillGain * 0.01;

            // Chance penalties.
            uint8 penalty = 1;

            if (PChar->CraftContainer->getCraftType() == CRAFT_DESYNTHESIS) // If it's a desynth, lower skill up rate
            {
                penalty += 1;
            }

            if (PChar->CraftContainer->getQuantity(0) == SYNTHESIS_FAIL) // If synth breaks, lower skill up rate
            {
                penalty += 1;
            }

            skillUpChance = skillUpChance / penalty; // Lower skill up chance if synth breaks

            //------------------------------
            // Section 3: Calculate Skill Up and Skill Up Amount
            //------------------------------
            double random = xirand::GetRandomNumber(1.);

            if (random < skillUpChance) // If character skills up
            {
                uint8 skillUpAmount = 1;

                if (charSkill < 600) // No skill ups over 0.1 happen over level 60 normally, without some sort of buff to it.
                {
                    uint8  satier = 0;
                    double chance = 0;

                    // Set satier initial rank
                    if ((baseDiff >= 1) && (baseDiff < 3))
                    {
                        satier = 1;
                    }
                    else if ((baseDiff >= 3) && (baseDiff < 5))
                    {
                        satier = 2;
                    }
                    else if ((baseDiff >= 5) && (baseDiff < 8))
                    {
                        satier = 3;
                    }
                    else if ((baseDiff >= 8) && (baseDiff < 10))
                    {
                        satier = 4;
                    }
                    else if (baseDiff >= 10)
                    {
                        satier = 5;
                    }

                    for (uint8 i = 0; i < 4; i++) // cicle up to 4 times until cap (0.5) or break. The lower the satier, the more likely it will break
                    {
                        switch (satier)
                        {
                            case 5:
                                chance = 0.900;
                                break;
                            case 4:
                                chance = 0.700;
                                break;
                            case 3:
                                chance = 0.500;
                                break;
                            case 2:
                                chance = 0.300;
                                break;
                            case 1:
                                chance = 0.200;
                                break;
                            default:
                                chance = 0.000;
                                break;
                        }

                        random = xirand::GetRandomNumber(1.);

                        if (chance < random)
                        {
                            break;
                        }

                        skillUpAmount++;
                        satier--;
                    }
                }

                // Do skill amount multiplier
                if (settings::get<uint8>("map.CRAFT_AMOUNT_MULTIPLIER") > 1)
                {
                    skillUpAmount += skillUpAmount * settings::get<uint8>("map.CRAFT_AMOUNT_MULTIPLIER");
                    if (skillUpAmount > 9)
                    {
                        skillUpAmount = 9;
                    }
                }

                // Cap skill gain amount if character hits the current cap
                if ((skillUpAmount + charSkill) > maxSkill)
                {
                    skillUpAmount = maxSkill - charSkill;
                }

                //------------------------------
                // Section 4: Spezialization System (Craft delevel system over certain point)
                //------------------------------
                uint16 craftCommonCap    = settings::get<uint16>("map.CRAFT_COMMON_CAP");
                uint16 skillCumulation   = skillUpAmount;
                uint8  skillHighest      = skillID; // Default to lowering current skill in use, since we have to lower something if it's going past the limit... (AKA, badly configurated server)
                uint16 skillHighestValue = settings::get<uint16>("map.CRAFT_COMMON_CAP");

                if ((charSkill + skillUpAmount) > craftCommonCap) // If server is using the specialization system
                {
                    for (uint8 i = SKILL_WOODWORKING; i <= SKILL_COOKING; i++) // Cycle through all skills
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
                // Section 5: Handle messages and save results.
                //------------------------------

                // Skill Up addition:
                PChar->RealSkills.skill[skillID] += skillUpAmount;
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, skillID, skillUpAmount, 38));

                if ((charSkill / 10) < (charSkill + skillUpAmount) / 10)
                {
                    PChar->WorkingSkills.skill[skillID] += 0x20;
                    PChar->pushPacket(new CCharSkillsPacket(PChar));
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, skillID, (charSkill + skillUpAmount) / 10, 53));
                }

                charutils::SaveCharSkills(PChar, skillID);

                // Skill Up removal if using spezialization system
                if (skillCumulation > settings::get<uint16>("map.CRAFT_SPECIALIZATION_POINTS"))
                {
                    PChar->RealSkills.skill[skillHighest] -= skillUpAmount;
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, skillHighest, skillUpAmount, 310));

                    if ((PChar->RealSkills.skill[skillHighest] + skillUpAmount) / 10 > (PChar->RealSkills.skill[skillHighest]) / 10)
                    {
                        PChar->WorkingSkills.skill[skillHighest] -= 0x20;
                        PChar->pushPacket(new CCharSkillsPacket(PChar));
                        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, skillHighest, (PChar->RealSkills.skill[skillHighest] - skillUpAmount) / 10, 53));
                    }

                    charutils::SaveCharSkills(PChar, skillHighest);
                }
            }
        }

        return 0;
    }

    /**************************************************************************
     *                                                                         *
     *  Synthesis failed. We decide how many ingredients will be lost.         *
     *  Probability of loss is dependent on character skill.                   *
     *  Skill ID stored in slotID of cell a crystal.                           *
     *                                                                         *
     **************************************************************************/

    int32 doSynthFail(CCharEntity* PChar)
    {
        uint8 currentCraft     = PChar->CraftContainer->getInvSlotID(0);
        int16 synthDifficulty  = getSynthDifficulty(PChar, currentCraft);
        int16 modSynthFailRate = PChar->getMod(Mod::SYNTH_FAIL_RATE);

        // We are able to get the correct elemental mod here by adding the element to it since they are in the same order
        double reduction = PChar->getMod((Mod)((int32)Mod::SYNTH_FAIL_RATE_FIRE + PChar->CraftContainer->getType()));

        // Similarly we get the correct craft mod here by adding the current craft to it since they are in the same order
        reduction += PChar->getMod((Mod)((int32)Mod::SYNTH_FAIL_RATE_WOOD + (currentCraft - SKILL_WOODWORKING)));
        reduction /= 100.0;

        uint8 invSlotID  = 0;
        uint8 nextSlotID = 0;
        uint8 lostCount  = 0;
        uint8 totalCount = 0;

        double random   = 0;
        double lostItem = std::clamp(0.15 - reduction + (synthDifficulty > 0 ? synthDifficulty / 20 : 0), 0.0, 1.0);

        // Translation of JP wiki for the "Synthesis failure rate" modifier is "Synthetic material loss rate"
        // see: http://wiki.ffo.jp/html/18416.html
        lostItem += (double)modSynthFailRate * 0.01;

        invSlotID = PChar->CraftContainer->getInvSlotID(1);

        for (uint8 slotID = 1; slotID <= 8; ++slotID)
        {
            if (slotID != 8)
            {
                nextSlotID = PChar->CraftContainer->getInvSlotID(slotID + 1);
            }

            random = xirand::GetRandomNumber(1.);

            if (random < lostItem)
            {
                PChar->CraftContainer->setQuantity(slotID, 0);
                lostCount++;
            }
            totalCount++;

            if (invSlotID != nextSlotID)
            {
                CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(invSlotID);

                if (PItem != nullptr)
                {
                    PItem->setSubType(ITEM_UNLOCKED);
                    PItem->setReserve(PItem->getReserve() - totalCount);
                    totalCount = 0;

                    if (lostCount > 0)
                    {
                        charutils::UpdateItem(PChar, LOC_INVENTORY, invSlotID, -(int32)lostCount);
                        lostCount = 0;
                    }
                    else
                    {
                        PChar->pushPacket(new CInventoryAssignPacket(PItem, INV_NORMAL));
                    }
                }
                invSlotID = nextSlotID;
            }
            nextSlotID = 0;
            if (invSlotID == 0xFF)
            {
                break;
            }
        }

        if (PChar->loc.zone->GetID() != 255 && PChar->loc.zone->GetID() != 0)
        {
            PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, new CSynthResultMessagePacket(PChar, SYNTH_FAIL));
        }

        PChar->pushPacket(new CSynthMessagePacket(PChar, SYNTH_FAIL, 29695));

        return 0;
    }

    /*********************************************************************
     *                                                                    *
     *  The beginning of the synthesis.                                   *
     *  In the type field of the container we write the synthesis element *
     *                                                                    *
     *********************************************************************/

    int32 startSynth(CCharEntity* PChar)
    {
        PChar->m_LastSynthTime = server_clock::now();
        uint16 effect          = 0;
        uint8  element         = 0;

        uint16 crystalType = PChar->CraftContainer->getItemID(0);

        switch (crystalType)
        {
            case 0x1000:
            case 0x108E:
                effect  = EFFECT_FIRESYNTH;
                element = ELEMENT_FIRE;
                break;
            case 0x1001:
            case 0x108F:
                effect  = EFFECT_ICESYNTH;
                element = ELEMENT_ICE;
                break;
            case 0x1002:
            case 0x1090:
                effect  = EFFECT_WINDSYNTH;
                element = ELEMENT_WIND;
                break;
            case 0x1003:
            case 0x1091:
                effect  = EFFECT_EARTHSYNTH;
                element = ELEMENT_EARTH;
                break;
            case 0x1004:
            case 0x1092:
                effect  = EFFECT_LIGHTNINGSYNTH;
                element = ELEMENT_LIGHTNING;
                break;
            case 0x1005:
            case 0x1093:
                effect  = EFFECT_WATERSYNTH;
                element = ELEMENT_WATER;
                break;
            case 0x1006:
            case 0x1094:
                effect  = EFFECT_LIGHTSYNTH;
                element = ELEMENT_LIGHT;
                break;
            case 0x1007:
            case 0x1095:
                effect  = EFFECT_DARKSYNTH;
                element = ELEMENT_DARK;
                break;
        }

        PChar->CraftContainer->setType(element);

        if (!isRightRecipe(PChar))
        {
            return 0;
        }

        // Reserve the items after we know we have the right recipe
        for (uint8 container_slotID = 0; container_slotID <= 8; ++container_slotID)
        {
            auto slotid = PChar->CraftContainer->getInvSlotID(container_slotID);
            if (slotid != 0xFF)
            {
                CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(slotid);
                if (PItem != nullptr)
                {
                    PItem->setReserve(PItem->getReserve() + 1);
                }
            }
        }

        // remove crystal
        auto* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(PChar->CraftContainer->getInvSlotID(0));
        if (PItem != nullptr)
        {
            PItem->setReserve(PItem->getReserve() - 1);
        }

        charutils::UpdateItem(PChar, LOC_INVENTORY, PChar->CraftContainer->getInvSlotID(0), -1);

        uint8 result = calcSynthResult(PChar);

        uint8 invSlotID  = 0;
        uint8 tempSlotID = 0;

        for (uint8 slotID = 1; slotID <= 8; ++slotID)
        {
            tempSlotID = PChar->CraftContainer->getInvSlotID(slotID);
            if ((tempSlotID != 0xFF) && (tempSlotID != invSlotID))
            {
                invSlotID = tempSlotID;

                CItem* PCraftItem = PChar->getStorage(LOC_INVENTORY)->GetItem(invSlotID);

                if (PCraftItem != nullptr)
                {
                    PCraftItem->setSubType(ITEM_LOCKED);
                    PChar->pushPacket(new CInventoryAssignPacket(PCraftItem, INV_NOSELECT));
                }
            }
        }

        PChar->animation = ANIMATION_SYNTH;
        PChar->updatemask |= UPDATE_HP;
        PChar->pushPacket(new CCharUpdatePacket(PChar));

        if (PChar->loc.zone->GetID() != 255 && PChar->loc.zone->GetID() != 0)
        {
            PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, new CSynthAnimationPacket(PChar, effect, result));
        }
        else
        {
            PChar->pushPacket(new CSynthAnimationPacket(PChar, effect, result));
        }

        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  Send the result of the synthesis to the character                    *
     *                                                                       *
     ************************************************************************/

    int32 doSynthResult(CCharEntity* PChar)
    {
        uint8 m_synthResult = PChar->CraftContainer->getQuantity(0);
        if (settings::get<bool>("map.ANTICHEAT_ENABLED"))
        {
            std::chrono::duration animationDuration = server_clock::now() - PChar->m_LastSynthTime;
            if (animationDuration < 5s)
            {
                // Attempted cheating - Did not spend enough time doing the synth animation.
                // Check whether the cheat type action requires us to actively block the cheating attempt
                // Note: Due to technical reasons jail action also forces us to break the synth
                // (player cannot be zoned while synth in progress).
                bool shouldblock = anticheat::GetCheatPunitiveAction(anticheat::CheatID::CHEAT_ID_FASTSYNTH, nullptr, 0) &
                                   (anticheat::CHEAT_ACTION_BLOCK | anticheat::CHEAT_ACTION_JAIL);
                if (shouldblock)
                {
                    // Block the cheat by forcing the synth to fail
                    PChar->CraftContainer->setQuantity(0, synthutils::SYNTHESIS_FAIL);
                    m_synthResult = SYNTHESIS_FAIL;
                    doSynthFail(PChar);
                }
                // And report the incident (will possibly jail the player)
                anticheat::ReportCheatIncident(PChar, anticheat::CheatID::CHEAT_ID_FASTSYNTH,
                                               (uint32)std::chrono::duration_cast<std::chrono::milliseconds>(animationDuration).count(),
                                               "Player attempted to bypass synth animation by injecting synth done packet.");
                if (shouldblock)
                {
                    // Blocking the cheat also means that the offender should not get any skillups
                    return 0;
                }
            }
        }

        if (m_synthResult == SYNTHESIS_FAIL)
        {
            doSynthFail(PChar);
        }
        else
        {
            uint16 itemID   = PChar->CraftContainer->getItemID(10 + m_synthResult);
            uint8  quantity = PChar->CraftContainer->getInvSlotID(10 + m_synthResult); // unfortunately, the quantity field is taken

            uint8 invSlotID   = 0;
            uint8 nextSlotID  = 0;
            uint8 removeCount = 0;

            invSlotID = PChar->CraftContainer->getInvSlotID(1);

            for (uint8 slotID = 1; slotID <= 8; ++slotID)
            {
                nextSlotID = (slotID != 8 ? PChar->CraftContainer->getInvSlotID(slotID + 1) : 0);
                removeCount++;

                if (invSlotID != nextSlotID)
                {
                    if (invSlotID != 0xFF)
                    {
                        auto* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(invSlotID);
                        if (PItem != nullptr)
                        {
                            PItem->setSubType(ITEM_UNLOCKED);
                            PItem->setReserve(PItem->getReserve() - removeCount);
                            charutils::UpdateItem(PChar, LOC_INVENTORY, invSlotID, -(int32)removeCount);
                        }
                    }
                    invSlotID   = nextSlotID;
                    nextSlotID  = 0;
                    removeCount = 0;
                }
            }

            // TODO: switch to the new AddItem function so as not to update the signature

            invSlotID = charutils::AddItem(PChar, LOC_INVENTORY, itemID, quantity);

            CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(invSlotID);

            if (PItem != nullptr)
            {
                if ((PItem->getFlag() & ITEM_FLAG_INSCRIBABLE) && (PChar->CraftContainer->getItemID(0) > 0x1080))
                {
                    char encodedSignature[SignatureStringLength];

                    memset(&encodedSignature, 0, sizeof(encodedSignature));
                    PItem->setSignature(EncodeStringSignature(PChar->name.c_str(), encodedSignature));

                    char signature_esc[31]; // max charname: 15 chars * 2 + 1
                    sql->EscapeStringLen(signature_esc, PChar->name.c_str(), strlen(PChar->name.c_str()));

                    char fmtQuery[] = "UPDATE char_inventory SET signature = '%s' WHERE charid = %u AND location = 0 AND slot = %u;\0";

                    sql->Query(fmtQuery, signature_esc, PChar->id, invSlotID);
                }
                PChar->pushPacket(new CInventoryItemPacket(PItem, LOC_INVENTORY, invSlotID));
            }

            PChar->pushPacket(new CInventoryFinishPacket());
            if (PChar->loc.zone->GetID() != 255 && PChar->loc.zone->GetID() != 0)
            {
                PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, new CSynthResultMessagePacket(PChar, SYNTH_SUCCESS, itemID, quantity));
                PChar->pushPacket(new CSynthMessagePacket(PChar, SYNTH_SUCCESS, itemID, quantity));
            }
            else
            {
                PChar->pushPacket(new CSynthMessagePacket(PChar, SYNTH_SUCCESS, itemID, quantity));
            }

            // Calculate what craft this recipe "belongs" to based on highest skill required
            uint32 skillType    = 0;
            uint32 highestSkill = 0;
            for (uint8 skillID = SKILL_WOODWORKING; skillID <= SKILL_COOKING; ++skillID)
            {
                uint8 skillRequired = PChar->CraftContainer->getQuantity(skillID - 40);
                if (skillRequired > highestSkill)
                {
                    skillType    = skillID;
                    highestSkill = skillRequired;
                }
            }

            RoeDatagram     roeItemId    = RoeDatagram("itemid", itemID);
            RoeDatagram     roeSkillType = RoeDatagram("skillType", skillType);
            RoeDatagramList roeSynthResult({ roeItemId, roeSkillType });

            roeutils::event(ROE_EVENT::ROE_SYNTHSUCCESS, PChar, roeSynthResult);
        }

        doSynthSkillUp(PChar);

        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  We complete the synthesis                                            *
     *                                                                       *
     ************************************************************************/

    int32 sendSynthDone(CCharEntity* PChar)
    {
        doSynthResult(PChar);

        PChar->animation = ANIMATION_NONE;
        PChar->updatemask |= UPDATE_HP;
        PChar->pushPacket(new CCharUpdatePacket(PChar));
        return 0;
    }

} // namespace synthutils
