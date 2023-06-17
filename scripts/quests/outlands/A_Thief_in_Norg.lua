-----------------------------------
-- Yomi Okuri
-----------------------------------
-- Log ID: 5, Quest ID: 142
-- Jaucribaix      : !pos 91 -7 -8 252
-- Sanosuke        : !pos -63 7 0 246
-- Phoochuchu      : !pos -4 -4 69 249
-- _6i8 (Door)     : !pos 70 7 2 234
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.A_THIEF_IN_NORG)

quest.reward =
{
    fame = 60,
    fameArea = xi.quest.fame_area.NORG,
    item = xi.items.MYOCHIN_KABUTO,
    title = xi.title.PARAGON_OF_SAMURAI_EXCELLENCE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.YOMI_OKURI) and
                player:getMainJob() == xi.job.SAM and
                player:getMainLvl() >= xi.settings.main.AF3_QUEST_LEVEL
        end,

        [xi.zone.NORG] =
        {
            ['Jaucribaix'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(quest:getMustZone(player) and 157 or 158)
                end,
            },

            onEventFinish =
            {
                [158] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.BASTOK_MINES] =
        {
            ['_6i8'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(186)
                    end
                end,
            },

            onEventFinish =
            {
                [186] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },

        [xi.zone.MHAURA] =
        {
            ['Phoochuchu'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 2 then
                        return quest:progressEvent(301)
                    elseif questProgress == 3 then
                        return quest:progressEvent(303)
                    elseif questProgress >= 4 then
                        return quest:progressEvent(302)
                    end
                end,
            },

            onEventFinish =
            {
                [301] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },

        [xi.zone.NORG] =
        {
            ['Jaucribaix'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        player:hasKeyItem(xi.ki.CHARRED_HELM) and
                        npcUtil.tradeHasExactly(trade, xi.items.GOLD_THREAD)
                    then
                        return quest:progressEvent(162)
                    end
                end,

                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress <= 4 then
                        return quest:progressEvent(159)
                    elseif questProgress == 5 then
                        return quest:progressEvent(166)
                    elseif questProgress == 6 then
                        return quest:progressEvent(player:findItem(xi.items.BANISHING_CHARM) and 167 or 168)
                    elseif questProgress == 7 then
                        return quest:progressEvent(160)
                    elseif questProgress == 8 then
                        return quest:progressEvent(161)
                    elseif questProgress == 9 then
                        return quest:progressEvent(quest:getMustZone(player) and 163 or 164)
                    end
                end,
            },

            onEventFinish =
            {
                [160] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 8)
                end,

                [162] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:delKeyItem(xi.ki.CHARRED_HELM)
                    quest:setVar(player, 'Prog', 9)
                    quest:setMustZone(player)
                end,

                [164] = function(player, csid, option, npc)
                    quest:complete(player)
                end,

                [166] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.items.BANISHING_CHARM) then
                        quest:setVar(player, 'Prog', 6)
                    end
                end,

                [168] = function(player, csid, option, npc)
                    npcUtil.giveItem(player, xi.items.BANISHING_CHARM)
                end,
            },
        },

        [xi.zone.PORT_JEUNO] =
        {
            ['Sanosuke'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 1 then
                        return quest:progressEvent(304)
                    elseif questProgress == 2 then
                        return quest:progressEvent(305)
                    elseif questProgress >= 3 then
                        return quest:progressEvent(306)
                    end
                end,
            },

            onEventFinish =
            {
                [304] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.WAUGHROON_SHRINE] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Prog') == 4 then
                        return 2
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                end,

                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == 68 then
                        npcUtil.giveKeyItem(player, xi.ki.CHARRED_HELM)
                        quest:setVar(player, 'Prog', 7)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.NORG] =
        {
            ['Jaucribaix'] = quest:event(165):replaceDefault()
        },
    },
}

return quest
