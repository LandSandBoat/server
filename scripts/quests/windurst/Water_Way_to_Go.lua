-----------------------------------
-- Water Way to Go
-----------------------------------
-- !addquest 2 16
-- Ohbiru-Dohbiru : !pos 23 -5 -193 238
-- Giddeus Spring : !pos -258 -2 -249 145
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WATER_WAY_TO_GO)

quest.reward =
{
    fame = 40,
    fameArea = xi.quest.fame_area.WINDURST,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.OVERNIGHT_DELIVERY) and
                player:getFameLevel(xi.quest.fame_area.WINDURST) >= 3 and
                not quest:getMustZone(player)
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ohbiru-Dohbiru'] = quest:progressEvent(352, 0, xi.items.CANTEEN_OF_GIDDEUS_WATER),

            onEventFinish =
            {
                [352] = function(player, csid, option, npc)
                    if
                        option == 0 and
                        npcUtil.giveItem(player, xi.items.RHINOSTERY_CANTEEN)
                    then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.GIDDEUS] =
        {
            ['Giddeus_Spring'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.RHINOSTERY_CANTEEN) then
                        return quest:progressEvent(55)
                    end
                end,
            },

            onEventFinish =
            {
                [55] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.items.CANTEEN_OF_GIDDEUS_WATER) then
                        player:confirmTrade()
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ohbiru-Dohbiru'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.CANTEEN_OF_GIDDEUS_WATER) then
                        return quest:progressEvent(355, 900)
                    end
                end,

                onTrigger = function(player, npc)
                    if
                        not player:findItem(xi.items.RHINOSTERY_CANTEEN) and
                        not player:findItem(xi.items.CANTEEN_OF_GIDDEUS_WATER)
                    then
                        return quest:progressEvent(354)
                    else
                        return quest:event(353)
                    end
                end,
            },

            onEventFinish =
            {
                [354] = function(player, csid, option, npc)
                    npcUtil.giveItem(player, xi.items.RHINOSTERY_CANTEEN)
                end,

                [355] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        -- Note: Message display for gil reward is handled by the event
                        player:setLocalVar('Quest[2][17]mustZone', 1)
                        quest:setMustZone(player)
                        player:confirmTrade()
                        player:addGil(900)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and
            not quest:getMustZone(player)
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ohbiru-Dohbiru'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.CANTEEN_OF_GIDDEUS_WATER) and
                        quest:getVar(player, "waterRepeat") == 1
                    then
                        return quest:progressEvent(355, 900)
                    end
                end,

                onTrigger = function(player, npc)
                    if
                        not player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CURSES_FOILED_A_GOLEM) ~= QUEST_ACCEPTED and
                        quest:getVar(player, "waterRepeat") == 0
                    then
                        return quest:progressEvent(352, 0, xi.items.CANTEEN_OF_GIDDEUS_WATER)
                    elseif
                        quest:getVar(player, "waterRepeat") == 1
                    then
                        if
                            not player:findItem(xi.items.RHINOSTERY_CANTEEN) and
                            not player:findItem(xi.items.CANTEEN_OF_GIDDEUS_WATER)
                        then
                            return quest:progressEvent(354)
                        else
                            return quest:event(353)
                        end
                    else
                        return quest:event(356, 0, xi.items.CANTEEN_OF_GIDDEUS_WATER)
                    end
                end,
            },

            onEventFinish =
            {
                [352] = function(player, csid, option, npc)
                    if
                        option == 0 and
                        npcUtil.giveItem(player, xi.items.RHINOSTERY_CANTEEN)
                    then
                        quest:setVar(player, "waterRepeat", 1)
                    end
                end,

                [354] = function(player, csid, option, npc)
                    npcUtil.giveItem(player, xi.items.RHINOSTERY_CANTEEN)
                end,

                [355] = function(player, csid, option, npc)
                    -- Note: Message display for gil reward is handled by the event
                    quest:setVar(player, "waterRepeat", 0)
                    quest:setMustZone(player)
                    player:confirmTrade()
                    player:addGil(900)
                end,
            },
        },

        [xi.zone.GIDDEUS] =
        {
            ['Giddeus_Spring'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.RHINOSTERY_CANTEEN) and
                        quest:getVar(player, "waterRepeat") == 1
                    then
                        return quest:progressEvent(55)
                    end
                end,
            },

            onEventFinish =
            {
                [55] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.items.CANTEEN_OF_GIDDEUS_WATER) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
