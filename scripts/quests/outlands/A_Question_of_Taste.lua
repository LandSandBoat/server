-----------------------------------
-- A Question of Taste
-----------------------------------
-- Log ID: 5, Quest ID: 140
-- Etteh Sulae: !gotoid 17801225
-- Jakoh Wahcondalo !gotoid 17801224
-- Angelica: !gotoid 17752153
-- Stone_Picture_Frame: !gotoid 17428936
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local templeID = require("scripts/zones/Temple_of_Uggalepih/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.A_QUESTION_OF_TASTE)

quest.reward =
{
    fame = 50,
    fameArea = xi.quest.fame_area.SELBINA_RABAO,
    gil = 3000,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.A_POSE_BY_ANY_OTHER_NAME) and
                player:getFameLevel(xi.quest.fame_area.SELBINA_RABAO) >= 6
        end,

        [xi.zone.KAZHAM] =
        {
            ['Etteh_Sulaej'] = quest:progressEvent(44),

            onEventFinish =
            {
                [44] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 1)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_TO_ANGELICA)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 1
        end,

        [xi.zone.KAZHAM] =
        {
            ['Etteh_Sulaej'] = quest:event(45):replaceDefault(),
            ['Jakoh_Wahcondalo'] = quest:event(46):replaceDefault(),
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Angelica'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.LETTER_TO_ANGELICA) then
                        return quest:progressEvent(772)
                    end
                end,
            },

            onEventFinish =
            {
                [772] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.FINAL_FANTASY)
                    npcUtil.giveKeyItem(player, xi.ki.ANGELICAS_LETTER)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 2
        end,

        [xi.zone.KAZHAM] =
        {
            ['Etteh_Sulaej'] = quest:progressEvent(47),
            ['Jakoh_Wahcondalo'] = quest:event(46):replaceDefault(),

            onEventFinish =
            {
                [47] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    player:delKeyItem(xi.ki.LETTER_TO_ANGELICA)
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Angelica'] = quest:event(772):replaceDefault(),
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 3
        end,

        [xi.zone.KAZHAM] =
        {
            ['Etteh_Sulaej'] = quest:event(49):replaceDefault(),
            ['Jakoh_Wahcondalo'] = quest:event(48):replaceDefault(),

            onEventFinish =
            {
                [49] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Angelica'] = quest:event(772):replaceDefault(),
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 4
        end,

        [xi.zone.KAZHAM] =
        {
            ['Etteh_Sulaej'] = quest:event(49):replaceDefault(),
            ['Jakoh_Wahcondalo'] = quest:event(48):replaceDefault(),
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Angelica'] = quest:event(772):replaceDefault(),
        },

        [xi.zone.TEMPLE_OF_UGGALEPIH] =
        {
            ['Stone_Picture_Frame_SW'] = -- change to _1 or whatever DB has
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.FINAL_FANTASY) and
                        not GetMobByID(templeID.mob.TROMPE_LOEIL):isSpawned()
                    then
                        return quest:progressEvent(50, xi.ki.FINAL_FANTASY)
                    elseif quest:getVar(player, 'nmKilled') == 0 then
                        return quest:messageSpecial(templeID.text.RIPPED_STILL_HANGING, xi.ki.RIPPED_FINAL_FANTASY_PAINTING)
                    elseif
                        quest:getVar(player, 'nmKilled') == 1 and
                        not player:hasKeyItem(xi.ki.FINAL_FANTASY)
                    then
                        npcUtil.giveKeyItem(player, xi.ki.RIPPED_FINAL_FANTASY_PAINTING)
                        quest:setVar(player, 'nmKilled', 0)
                        quest:setVar(player, 'Prog', 5)
                    end
                end,
            },

            onEventFinish =
            {
                [50] = function(player, csid, option, npc)
                    if option == 1 then
                        SpawnMob(templeID.mob.TROMPE_LOEIL):updateClaim(player)
                        return quest:messageSpecial(templeID.text.SLASHES_PAINTING)
                    end
                end,
            },

            ['Trompe_LOeil'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'nmKilled') == 0 then
                        quest:setVar(player, 'nmKilled', 1)
                        player:delKeyItem(xi.ki.FINAL_FANTASY)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 5
        end,

        [xi.zone.KAZHAM] =
        {
            ['Etteh_Sulaej'] = quest:progressEvent(50),

            onEventFinish =
            {
                [50] = function(player, csid, option, npc)
                    quest:complete(player)
                    player:needToZone(true)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.KAZHAM] =
        {
            ['Etteh_Sulaej'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasCompletedQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.EVERYONES_GRUDGING) then
                        return quest:event(51)
                    elseif
                        player:hasCompletedQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.EVERYONES_GRUDGING) and
                        not player:needToZone()
                    then
                        if quest:getVar(player, 'Repeat') == 0 then
                            return quest:progressEvent(53)
                        elseif
                            quest:getVar(player, 'nmKilled') == 0 and
                            quest:getVar(player, 'Repeat') == 1
                        then
                            return quest:event(55)
                        elseif quest:getVar(player, 'nmKilled') == 1 then
                            return quest:progressEvent(57)
                        end
                    end
                end,
            },

            ['Jakoh_Wahcondalo'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Repeat') == 1 then
                        return quest:event(56)
                    end
                end,
            },

            onEventFinish =
            {
                [53] = function(player, csid, option, npc)
                    if option == 1 then
                        npcUtil.giveKeyItem(player, xi.ki.FINAL_FANTASY_PART_II)
                        quest:setVar(player, 'Repeat', 1)
                    end
                end,

                [57] = function(player, csid, option, npc)
                    quest:setVar(player, 'nmKilled', 0)
                    quest:setVar(player, 'Repeat', 0)
                    player:delKeyItem(xi.ki.RIPPED_FINAL_FANTASY_PAINTING)
                    player:needToZone(true)
                    npcUtil.giveCurrency(player, 'gil', xi.settings.main.GIL_RATE * 3000)
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Angelica'] = quest:event(773):replaceDefault(),
        },

        [xi.zone.TEMPLE_OF_UGGALEPIH] =
        {
            ['Stone_Picture_Frame_SW'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'nmKilled') == 0 then
                        return quest:event(51, xi.ki.FINAL_FANTASY_PART_II)
                    elseif quest:getVar(player, 'nmKilled') == 1 then
                        npcUtil.giveKeyItem(player, xi.ki.RIPPED_FINAL_FANTASY_PAINTING)
                    end
                end,
            },

            onEventFinish =
            {
                [51] = function(player, csid, option, npc)
                    if option == 1 then
                        SpawnMob(templeID.mob.TROMPE_LOEIL):updateClaim(player)
                        return quest:messageSpecial(templeID.text.SLASHES_PAINTING)
                    end
                end,
            },

            ['Trompe_LOeil'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'nmKilled') == 0 then
                        quest:setVar(player, 'nmKilled', 1)
                        player:delKeyItem(xi.ki.FINAL_FANTASY_PART_II)
                    end
                end,
            },
        },
    },
}

return quest
