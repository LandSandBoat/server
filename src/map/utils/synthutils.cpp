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

#include "../../common/socket.h"
#include "../../common/showmsg.h"
#include "../../common/utils.h"

#include <math.h>
#include <string.h>

#include "../packets/char_skills.h"
#include "../packets/char_update.h"
#include "../packets/inventory_assign.h"
#include "../packets/inventory_finish.h"
#include "../packets/inventory_item.h"
#include "../packets/message_basic.h"
#include "../packets/synth_animation.h"
#include "../packets/synth_message.h"
#include "../packets/synth_result.h"

#include "../item_container.h"
#include "../map.h"
#include "../trade_container.h"
#include "../vana_time.h"
#include "../anticheat.h"

#include "charutils.h"
#include "itemutils.h"
#include "synthutils.h"
#include "zoneutils.h"

//#define _TPZ_SYNTH_DEBUG_MESSAGES_ // enable debugging messages

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

    int32 ret = Sql_Query(
        SqlHandle,
        fmtQuery,
        PChar->CraftContainer->getItemID(0),
        PChar->CraftContainer->getItemID(0),
        PChar->CraftContainer->getItemID(1),
        PChar->CraftContainer->getItemID(2),
        PChar->CraftContainer->getItemID(3),
        PChar->CraftContainer->getItemID(4),
        PChar->CraftContainer->getItemID(5),
        PChar->CraftContainer->getItemID(6),
        PChar->CraftContainer->getItemID(7),
        PChar->CraftContainer->getItemID(8));

    if (ret != SQL_ERROR &&
        Sql_NumRows(SqlHandle) != 0 &&
        Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        uint16 KeyItemID = (uint16)Sql_GetUIntData(SqlHandle,1); // Check if recipe needs KI

        if ((KeyItemID == 0) || (charutils::hasKeyItem(PChar,KeyItemID))) // If recipe doesn't need KI OR Player has the required KI
        {
            // in the ninth cell write the id of the recipe
            PChar->CraftContainer->setItem(9, Sql_GetUIntData(SqlHandle,0),0xFF,0);
            #ifdef _TPZ_SYNTH_DEBUG_MESSAGES_
            ShowDebug(CL_CYAN"Recipe matches ID %u.\n" CL_RESET, PChar->CraftContainer->getItemID(9));
            #endif

            PChar->CraftContainer->setItem(10 + 1, (uint16)Sql_GetUIntData(SqlHandle,10), (uint8)Sql_GetUIntData(SqlHandle,14), 0); // RESULT_SUCCESS
            PChar->CraftContainer->setItem(10 + 2, (uint16)Sql_GetUIntData(SqlHandle,11), (uint8)Sql_GetUIntData(SqlHandle,15), 0); // RESULT_HQ
            PChar->CraftContainer->setItem(10 + 3, (uint16)Sql_GetUIntData(SqlHandle,12), (uint8)Sql_GetUIntData(SqlHandle,16), 0); // RESULT_HQ2
            PChar->CraftContainer->setItem(10 + 4, (uint16)Sql_GetUIntData(SqlHandle,13), (uint8)Sql_GetUIntData(SqlHandle,17), 0); // RESULT_HQ3
            PChar->CraftContainer->setCraftType((uint8)Sql_GetUIntData(SqlHandle, 18)); // Store if it's a desynth

            uint16 skillValue   = 0;
            uint16 currentSkill = 0;

            for (uint8 skillID = 49; skillID < 57; ++skillID) // range for all 8 synth skills
            {
                skillValue   = (uint16)Sql_GetUIntData(SqlHandle,(skillID-49+2));
                currentSkill = PChar->RealSkills.skill[skillID];

                // skill write in the quantity field of cells 9-16
                PChar->CraftContainer->setQuantity(skillID-40, skillValue);

                #ifdef _TPZ_SYNTH_DEBUG_MESSAGES_
                ShowDebug(CL_CYAN"Current skill = %u, Recipe skill = %u\n" CL_RESET, currentSkill, skillValue*10);
                #endif
                if (currentSkill < (skillValue*10 - 150)) // Check player skill against recipe level. Range must be 14 or less. 
                {
                    PChar->pushPacket(new CSynthMessagePacket(PChar, SYNTH_NOSKILL));
                    #ifdef _TPZ_SYNTH_DEBUG_MESSAGES_
                    ShowDebug(CL_CYAN"Not enough skill. Synth aborted.\n" CL_RESET);
                    #endif
                    return false;
                }
            }
            return true;
        }
    }

    PChar->pushPacket(new CSynthMessagePacket(PChar, SYNTH_BADRECIPE));
    #ifdef _TPZ_SYNTH_DEBUG_MESSAGES_
    ShowDebug(CL_CYAN"Recipe not found. Synth aborted.\n" CL_RESET);
    ShowDebug(CL_CYAN"Ingredient1 = %u\n" CL_RESET, PChar->CraftContainer->getItemID(1));
    ShowDebug(CL_CYAN"Ingredient2 = %u\n" CL_RESET, PChar->CraftContainer->getItemID(2));
    ShowDebug(CL_CYAN"Ingredient3 = %u\n" CL_RESET, PChar->CraftContainer->getItemID(3));
    ShowDebug(CL_CYAN"Ingredient4 = %u\n" CL_RESET, PChar->CraftContainer->getItemID(4));
    ShowDebug(CL_CYAN"Ingredient5 = %u\n" CL_RESET, PChar->CraftContainer->getItemID(5));
    ShowDebug(CL_CYAN"Ingredient6 = %u\n" CL_RESET, PChar->CraftContainer->getItemID(6));
    ShowDebug(CL_CYAN"Ingredient7 = %u\n" CL_RESET, PChar->CraftContainer->getItemID(7));
    ShowDebug(CL_CYAN"Ingredient8 = %u\n" CL_RESET, PChar->CraftContainer->getItemID(8));
    #endif
    return false;
}

/****************************************************************************
*                                                                           *
* We calculate the complexity of the synthesis for a particular skill.      *
* It is good to save the result in some cell of the container (dooble type) *
*                                                                           *
****************************************************************************/

double getSynthDifficulty(CCharEntity* PChar, uint8 skillID)
{
    Mod ModID = Mod::NONE;

    switch (skillID)
    {
        case SKILL_WOODWORKING:  ModID = Mod::WOOD;      break;
        case SKILL_SMITHING:     ModID = Mod::SMITH;     break;
        case SKILL_GOLDSMITHING: ModID = Mod::GOLDSMITH; break;
        case SKILL_CLOTHCRAFT:   ModID = Mod::CLOTH;     break;
        case SKILL_LEATHERCRAFT: ModID = Mod::LEATHER;   break;
        case SKILL_BONECRAFT:    ModID = Mod::BONE;      break;
        case SKILL_ALCHEMY:      ModID = Mod::ALCHEMY;   break;
        case SKILL_COOKING:      ModID = Mod::COOK;      break;
    }

    uint8 charSkill = PChar->RealSkills.skill[skillID]/10;  //player skill level is truncated before synth difficulty is calced
    double difficult = PChar->CraftContainer->getQuantity(skillID-40) - (double)(charSkill + PChar->getMod(ModID));

    #ifdef _TPZ_SYNTH_DEBUG_MESSAGES_
    ShowDebug(CL_CYAN"Difficulty = %g\n" CL_RESET, difficult);
    #endif

    return difficult;
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
        case SKILL_WOODWORKING:  ModID = Mod::ANTIHQ_WOOD;      break;
        case SKILL_SMITHING:     ModID = Mod::ANTIHQ_SMITH;     break;
        case SKILL_GOLDSMITHING: ModID = Mod::ANTIHQ_GOLDSMITH; break;
        case SKILL_CLOTHCRAFT:   ModID = Mod::ANTIHQ_CLOTH;     break;
        case SKILL_LEATHERCRAFT: ModID = Mod::ANTIHQ_LEATHER;   break;
        case SKILL_BONECRAFT:    ModID = Mod::ANTIHQ_BONE;      break;
        case SKILL_ALCHEMY:      ModID = Mod::ANTIHQ_ALCHEMY;   break;
        case SKILL_COOKING:      ModID = Mod::ANTIHQ_COOK;      break;
    }

    return (PChar->getMod(ModID) != 0 ? false : true);
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
    uint8 result = SYNTHESIS_SUCCESS;
    uint8 hqtier = 0;
    uint8 finalhqtier = 4;
    bool canHQ = true;

    double success = 0;
    double chance  = 0;
    double random = tpzrand::GetRandomNumber(1.);

    for(uint8 skillID = 49; skillID < 57; ++skillID)
    {
        uint8 checkSkill = PChar->CraftContainer->getQuantity(skillID-40);
        if(checkSkill != 0)
        {
            double synthDiff = getSynthDifficulty(PChar, skillID);
            hqtier = 0;

            if(synthDiff <= 0)
            {
                if (PChar->CraftContainer->getCraftType() ==  1) //if it's a desynth lower success rate
                    success = 0.45;
                else
                    success = 0.95;

                if(synthDiff > -11)       //0-10 levels over recipe
                    hqtier = 1;
                else if(synthDiff > -31)  //11-30 levels over recipe
                    hqtier = 2;
                else if(synthDiff > -51)  //31-50 levels over recipe
                    hqtier = 3;
                else                      //51+ levels over recipe
                    hqtier = 4;

                if(hqtier < finalhqtier)
                    finalhqtier = hqtier; //set var to limit possible hq if needed
            }
            else
            {
                if (PChar->CraftContainer->getCraftType() ==  1) //if it's a desynth lower success rate
                    success = 0.45 - (synthDiff / 10);
                else
                    success = 0.95 - (synthDiff / 10);

                canHQ = false;
                if(success < 0.05)
                    success = 0.05;

                #ifdef _TPZ_SYNTH_DEBUG_MESSAGES_
                ShowDebug(CL_CYAN"SkillID %u: difficulty > 0\n" CL_RESET, skillID);
                #endif
            }

            // Apply synthesis success rate modifier
            int16 modSynthSuccess = PChar->CraftContainer->getCraftType() == CRAFT_SYNTHESIS ? PChar->getMod(Mod::SYNTH_SUCCESS) : PChar->getMod(Mod::DESYNTH_SUCCESS);
            success += (double)modSynthSuccess * 0.01;

            if(!canSynthesizeHQ(PChar,skillID))
            {
                success += 0.01; //the crafting rings that block HQ synthesis all also increase their respective craft's success rate by 1%
                canHQ = false;   //assuming here that if a crafting ring is used matching a recipe's subsynth, overall HQ will still be blocked
            }

            if(success > 0.99)
            {
                // Clamp success rate to 0.99
                // Even if using kitron macaron, breaks can still happen
                // https://www.bluegartr.com/threads/120352-CraftyMath
                //   "I get a 99% success rate, so Kitron is doing something and it's not small."
                // http://www.ffxiah.com/item/5781/kitron-macaron
                //   "According to one of the Japanese wikis, it is said to decrease the minimum break rate from ~5% to 0.5%-2%."
                success = 0.99;
            }

            #ifdef _TPZ_SYNTH_DEBUG_MESSAGES_
            ShowDebug(CL_CYAN"Success: %g  Random: %g\n" CL_RESET, success, random);
            #endif

            if(random >= success) // Synthesis broke
            {
                // keep the skill, because of which the synthesis failed.
                // use the slotID of the crystal cell, because it was removed at the beginning of the synthesis
                PChar->CraftContainer->setInvSlotID(0,skillID);
                result = SYNTHESIS_FAIL;
                break;
            }
        }
    }

    if(result != SYNTHESIS_FAIL) // It has gone through the cycle without breaking
    {
        switch(finalhqtier)
        {
            case 4:  chance = 0.5;      break; // 1 in 2
            case 3:  chance = 0.25;     break; // 1 in 4
            case 2:  chance = 0.0625;   break; // 1 in 16
            case 1:  chance = 0.015625; break; // 1 in 64
            default: chance = 0.000;    break;
        }

        if (PChar->CraftContainer->getCraftType() ==  1) //if it's a desynth raise HQ chance
            chance *= 1.5;

        int16 modSynthHqRate = PChar->getMod(Mod::SYNTH_HQ_RATE);

        // Using x/512 calculation for HQ success rate modifier
        // see: https://www.bluegartr.com/threads/130586-CraftyMath-v2-Post-September-2017-Update
        chance += (double)modSynthHqRate / 512.;

        if(chance > 0 && canHQ) // if there is a chance already and it can HQ, we add myth mods
        {
            //limit max hq chance
            if (PChar->CraftContainer->getCraftType() ==  1)
                chance = std::clamp(chance, 0., 0.800);
            else
                chance = std::clamp(chance, 0., 0.500);
        }

        #ifdef _TPZ_SYNTH_DEBUG_MESSAGES_
        ShowDebug(CL_CYAN"HQ Tier: %i HQ Chance: %g Random: %g SkillID: %u\n" CL_RESET, hqtier, chance, random, skillID);
        #endif

        if(random < chance && canHQ) // we try for HQ
        {
            random = tpzrand::GetRandomNumber(0, 16);

            if (random == 0)
                result = SYNTHESIS_HQ3;
            else if (random < 4)
                result = SYNTHESIS_HQ2;
            else
                result = SYNTHESIS_HQ;

        }
        else
            result = SYNTHESIS_SUCCESS;
    }

    // the result of the synthesis is written in the quantity field of the crystal cell.
    PChar->CraftContainer->setQuantity(0, result);

    switch(result)
    {
        case SYNTHESIS_FAIL:
            result = RESULT_FAIL;
            #ifdef _TPZ_SYNTH_DEBUG_MESSAGES_
            ShowDebug(CL_CYAN"Synth failed.\n" CL_RESET);
            #endif
            break;
        case SYNTHESIS_SUCCESS:
            result = RESULT_SUCCESS;
            #ifdef _TPZ_SYNTH_DEBUG_MESSAGES_
            ShowDebug(CL_CYAN"Synth success.\n" CL_RESET);
            #endif
            break;
        case SYNTHESIS_HQ:
            result = RESULT_HQ;
            #ifdef _TPZ_SYNTH_DEBUG_MESSAGES_
            ShowDebug(CL_CYAN"Synth HQ.\n" CL_RESET);
            #endif
            break;
        case SYNTHESIS_HQ2:
            result = RESULT_HQ;
            #ifdef _TPZ_SYNTH_DEBUG_MESSAGES_
            ShowDebug(CL_CYAN"Synth HQ2.\n" CL_RESET);
            #endif
            break;
        case SYNTHESIS_HQ3:
            result = RESULT_HQ;
            #ifdef _TPZ_SYNTH_DEBUG_MESSAGES_
            ShowDebug(CL_CYAN"Synth HQ3.\n" CL_RESET);
            #endif
            break;
    }
    return result;
}

/********************************************************************
*                                                                   *
* Do Skill Up                                                       *
*                                                                   *
********************************************************************/

int32 doSynthSkillUp(CCharEntity* PChar)
{
    for(uint8 skillID = 49; skillID < 57; ++skillID) // Check for all skills involved in a recipe, to check for skill up
    {
        if (PChar->CraftContainer->getQuantity(skillID-40) == 0) // Get the required skill level for the recipe
        {
            continue;
        }

        uint8  skillRank = PChar->RealSkills.rank[skillID]; // Check character rank
        uint16 maxSkill  = (skillRank+1)*100;               // Skill cap, depending on rank        

        int32  charSkill = PChar->RealSkills.skill[skillID]; // Compare against real character skill, without image support, gear or moghancements
        int32  baseDiff   = PChar->CraftContainer->getQuantity(skillID-40) - charSkill/10; //the 5 lvl difference rule for breaks does NOT consider the effects of image support/gear

        if ((baseDiff <= 0) || ((baseDiff > 5) && (PChar->CraftContainer->getQuantity(0) == SYNTHESIS_FAIL))) // synthesis result is stored in the zero cell quantity
        {                                                                                                     // if you break a recipe higher than 5 levels, no skill ups
            continue;
        }

        if (charSkill < maxSkill) // Check if a character can skill up
        {
            double skillUpChance = (double)baseDiff * map_config.craft_chance_multiplier * (3 - (log(1.2 + charSkill/100))) / 10;

            // Apply synthesis skill gain rate modifier before synthesis fail modifier
            int16 modSynthSkillGain = PChar->getMod(Mod::SYNTH_SKILL_GAIN);
            skillUpChance += (double)modSynthSkillGain * 0.01;

            skillUpChance = skillUpChance / (1 + (PChar->CraftContainer->getQuantity(0) == SYNTHESIS_FAIL)); // Lower skill up chance if synth breaks

            if (PChar->CraftContainer->getCraftType() == 1)  // If it's a desynth lower skill up rate
                skillUpChance = skillUpChance / 2;

            double random = tpzrand::GetRandomNumber(1.);
            #ifdef _TPZ_SYNTH_DEBUG_MESSAGES_
            ShowDebug(CL_CYAN"Skill up chance: %g  Random: %g\n" CL_RESET, skillUpChance, random);
            #endif

            if (random < skillUpChance) // If character skills up
            {
                int32  skillAmount = 1;

                if (charSkill < map_config.craft_common_cap) // no skill ups over 0.1 happen over level cap
                {
                    int32  satier = 0;
                    double chance = 0;

                    // Set satier initial rank
                    if((baseDiff >= 1) && (baseDiff < 3))
                        satier = 1;
                    else if((baseDiff >= 3) && (baseDiff < 5))
                        satier = 2;
                    else if((baseDiff >= 5) && (baseDiff < 8))
                        satier = 3;
                    else if((baseDiff >= 8) && (baseDiff < 10))
                        satier = 4;
                    else if (baseDiff >= 10)
                        satier = 5;

                    for(uint8 i = 0; i < 4; i ++) // cicle up to 4 times until cap (0.5) or break. The lower the satier, the more likely it will break
                    {
                        #ifdef _TPZ_SYNTH_DEBUG_MESSAGES_
                        ShowDebug(CL_CYAN"SkillAmount Tier: %i  Random: %g\n" CL_RESET, satier, random);
                        #endif

                        switch(satier)
                        {
                            case 5:  chance = 0.900; break;
                            case 4:  chance = 0.700; break;
                            case 3:  chance = 0.500; break;
                            case 2:  chance = 0.300; break;
                            case 1:  chance = 0.200; break;
                            default: chance = 0.000; break;
                        }

                        if(chance < random)
                            break;

                        skillAmount++;
                        satier--;
                    }
                }

                // Do craft amount multiplier
                if (map_config.craft_amount_multiplier > 1)
                {
                    skillAmount += (int32)(skillAmount * map_config.craft_amount_multiplier);
                    if (skillAmount > 9)
                    {
                        skillAmount = 9;
                    }
                }

                // Cap skill gain if character hits the current cap
                if((skillAmount + charSkill) > maxSkill)
                {
                    skillAmount = maxSkill - charSkill;
                }

                uint16 skillCumulation = skillAmount;
                uint8 skillHighest = skillID;

                if ((charSkill + skillAmount) > map_config.craft_common_cap) // If character is using the specialization system
                {
                    // Cycle through all skills
                    for (int i = SKILL_WOODWORKING; i <= SKILL_COOKING; i++)
                    {
                        if (PChar->RealSkills.skill[i] > map_config.craft_common_cap) // If the skill being checked is above the cap from wich spezialitation points start counting.
                        {
                            skillCumulation += (PChar->RealSkills.skill[i] - map_config.craft_common_cap); //Add to the ammount of specialization points in use.
                            if (skillID != i && PChar->RealSkills.skill[i] > PChar->RealSkills.skill[skillHighest]) //Set the ID of the highest craft UNLESS it's the craft currently in use.
                            {
                                skillHighest = i;
                            }
                        }
                    }
                }

                PChar->RealSkills.skill[skillID] += skillAmount;
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, skillID, skillAmount, 38));

                if ((charSkill / 10) < (charSkill + skillAmount) / 10)
                {
                    PChar->WorkingSkills.skill[skillID] += 0x20;

                    PChar->pushPacket(new CCharSkillsPacket(PChar));
                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, skillID, (charSkill + skillAmount) / 10, 53));
                }

                charutils::SaveCharSkills(PChar, skillID);

                if (skillHighest != 0 && skillCumulation > map_config.craft_specialization_points)
                {
                    PChar->RealSkills.skill[skillHighest] -= skillAmount;

                    if ((PChar->RealSkills.skill[skillHighest] + skillAmount) / 10 > (PChar->RealSkills.skill[skillHighest]) / 10)
                    {
                        PChar->WorkingSkills.skill[skillHighest] -= 0x20;
                        PChar->pushPacket(new CCharSkillsPacket(PChar));
                    }

                    charutils::SaveCharSkills(PChar, skillHighest);
                }
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
    uint8 currentCraft = PChar->CraftContainer->getInvSlotID(0);
    double synthDiff = getSynthDifficulty(PChar, currentCraft);
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

    double random = 0;
    double lostItem = std::clamp(0.15 - reduction + (synthDiff > 0 ? synthDiff/20 : 0), 0.0, 1.0);

    // Translation of JP wiki for the "Synthesis failure rate" modifier is "Synthetic material loss rate"
    // see: http://wiki.ffo.jp/html/18416.html
    lostItem += (double)modSynthFailRate * 0.01;

    invSlotID = PChar->CraftContainer->getInvSlotID(1);

    for(uint8 slotID = 1; slotID <= 8; ++slotID)
    {
        if (slotID != 8)
            nextSlotID = PChar->CraftContainer->getInvSlotID(slotID+1);

        random = tpzrand::GetRandomNumber(1.);
        #ifdef _TPZ_SYNTH_DEBUG_MESSAGES_
        ShowDebug(CL_CYAN"Lost Item: %g  Random: %g\n" CL_RESET, lostItem, random);
        #endif

        if(random < lostItem)
        {
            PChar->CraftContainer->setQuantity(slotID, 0);
            lostCount++;
        }
        totalCount++;

        if(invSlotID != nextSlotID)
        {
            CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(invSlotID);

            if (PItem != nullptr)
            {
                PItem->setSubType(ITEM_UNLOCKED);
                PItem->setReserve(PItem->getReserve() - totalCount);
                totalCount = 0;

                if(lostCount > 0)
                {
                    #ifdef _TPZ_SYNTH_DEBUG_MESSAGES_
                    ShowDebug(CL_CYAN"Removing quantity %u from inventory slot %u\n" CL_RESET, lostCount, invSlotID);
                    #endif

                    charutils::UpdateItem(PChar, LOC_INVENTORY, invSlotID, -(int32)lostCount);
                    lostCount = 0;
                }
                else
                {
                    PChar->pushPacket(new CInventoryAssignPacket(PItem, INV_NORMAL));
                }
            }
            invSlotID  = nextSlotID;
        }
        nextSlotID = 0;
        if(invSlotID == 0xFF)
            break;
    }

    if(PChar->loc.zone->GetID() != 255 && PChar->loc.zone->GetID() != 0)
        PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, new CSynthResultMessagePacket(PChar, SYNTH_FAIL));

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
    uint16 effect  = 0;
    uint8  element = 0;

    uint16 crystalType = PChar->CraftContainer->getItemID(0);

    switch(crystalType)
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
            PItem->setReserve(PItem->getReserve() + 1);
        }
    }

    // remove crystal
    auto PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(PChar->CraftContainer->getInvSlotID(0));
    PItem->setReserve(PItem->getReserve() - 1);
    charutils::UpdateItem(PChar, LOC_INVENTORY, PChar->CraftContainer->getInvSlotID(0), -1);

    uint8 result = calcSynthResult(PChar);

    uint8  invSlotID  = 0;
    uint8  tempSlotID = 0;
    // uint16 itemID     = 0;
    // uint32 quantity   = 0;

    for(uint8 slotID = 1; slotID <= 8; ++slotID)
    {
        tempSlotID = PChar->CraftContainer->getInvSlotID(slotID);
        if ((tempSlotID != 0xFF) && (tempSlotID != invSlotID))
        {
            invSlotID = tempSlotID;

            CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(invSlotID);

            if (PItem != nullptr)
            {
                PItem->setSubType(ITEM_LOCKED);
                PChar->pushPacket(new CInventoryAssignPacket(PItem, INV_NOSELECT));
            }
        }
    }

    PChar->animation = ANIMATION_SYNTH;
    PChar->updatemask |= UPDATE_HP;
    PChar->pushPacket(new CCharUpdatePacket(PChar));

    if(PChar->loc.zone->GetID() != 255 && PChar->loc.zone->GetID() != 0)
    {
        PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, new CSynthAnimationPacket(PChar,effect,result));
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
    if (map_config.anticheat_enabled)
    {
        std::chrono::duration animationDuration = server_clock::now() - PChar->m_LastSynthTime;
        if (animationDuration < 5s)
        {
            // Attempted cheating - Did not spend enough time doing the synth animation.
            #ifdef _TPZ_SYNTH_DEBUG_MESSAGES_
            ShowDebug(CL_CYAN"Caught player cheating by injecting synth done packet.\n");
            #endif
            // Check whether the cheat type action requires us to actively block the cheating attempt
            // Note: Due to technical reasons jail action also forces us to break the synth
            // (player cannot be zoned while synth in progress).
            bool shouldblock = anticheat::GetCheatPunitiveAction(anticheat::CheatID::CHEAT_ID_FASTSYNTH, nullptr, 0) & (anticheat::CHEAT_ACTION_BLOCK | anticheat::CHEAT_ACTION_JAIL);
            if (shouldblock)
            {
                // Block the cheat by forcing the synth to fail
                PChar->CraftContainer->setQuantity(0, synthutils::SYNTHESIS_FAIL);
                m_synthResult = SYNTHESIS_FAIL;
                doSynthFail(PChar);
            }
            // And report the incident (will possibly jail the player)
            anticheat::ReportCheatIncident(PChar,
                anticheat::CheatID::CHEAT_ID_FASTSYNTH,
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

        for(uint8 slotID = 1; slotID <= 8; ++slotID)
        {
            nextSlotID = (slotID != 8 ? PChar->CraftContainer->getInvSlotID(slotID+1) : 0);
            removeCount++;

            if (invSlotID != nextSlotID)
            {
                if (invSlotID != 0xFF)
                {
                    #ifdef _TPZ_SYNTH_DEBUG_MESSAGES_
                    ShowDebug(CL_CYAN"Removing quantity %u from inventory slot %u\n" CL_RESET,removeCount,invSlotID);
                    #endif
                    auto PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(invSlotID);
                    PItem->setSubType(ITEM_UNLOCKED);
                    PItem->setReserve(PItem->getReserve() - removeCount);
                    charutils::UpdateItem(PChar, LOC_INVENTORY, invSlotID, -(int32)removeCount);
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
                int8 encodedSignature [12];
                PItem->setSignature(EncodeStringSignature((int8*)PChar->name.c_str(), encodedSignature));

                char signature_esc[31]; //max charname: 15 chars * 2 + 1
                Sql_EscapeStringLen(SqlHandle,signature_esc,PChar->name.c_str(),strlen(PChar->name.c_str()));

                char fmtQuery[] = "UPDATE char_inventory SET signature = '%s' WHERE charid = %u AND location = 0 AND slot = %u;\0";

                Sql_Query(SqlHandle,fmtQuery,signature_esc,PChar->id, invSlotID);
            }
            PChar->pushPacket(new CInventoryItemPacket(PItem, LOC_INVENTORY, invSlotID));
        }

        PChar->pushPacket(new CInventoryFinishPacket());
        if(PChar->loc.zone->GetID() != 255 && PChar->loc.zone->GetID() != 0)
        {
            PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, new CSynthResultMessagePacket(PChar, SYNTH_SUCCESS, itemID, quantity));
            PChar->pushPacket(new CSynthMessagePacket(PChar, SYNTH_SUCCESS, itemID, quantity));
        }
        else
        {
            PChar->pushPacket(new CSynthMessagePacket(PChar, SYNTH_SUCCESS, itemID, quantity));
        }
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

} // namespace synth