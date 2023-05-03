-----------------------------------
-- The Old Monument + Hidden Quest A Minstrel in Despair
-- A Minstrel in Despair is a hidden quest - put in completed section along with a failsafe if players drop the Poetic Parchment...
-----------------------------------
-- Log ID: 3, Quest ID: 11
-- Log ID: 3, Quest ID: 12
-- Mertaire                       : !gotoid 17780764
-- Mataligeat                     : !gotoid 17780765
-- Bki Tbujhja                    : !gotoid 17780766
-- Song Runes (Buburimu_Peninsula): !gotoid 17261137
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require("scripts/zones/Buburimu_Peninsula/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_OLD_MONUMENT)

quest.reward =
{
--Fame handled in end quest due to 3 nations getting fame.
    title = xi.title.RESEARCHER_OF_CLASSICS,
    item  = xi.items.POETIC_PARCHMENT,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getMainLvl() >= xi.settings.main.ADVANCED_JOB_LEVEL
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Mertaire'] = quest:progressEvent(102),

            onEventFinish =
            {
                [102] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Bki_Tbujhja'] =
            {
                onTrigger = function(player, npc)
                    if  quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(181)
                    end
                end,
            },

            ['Mataligeat'] =
            {
                onTrigger = function(player, npc)
                    if  quest:getVar(player, 'Prog') >= 1 then
                        return quest:event(141)
                    end
                end,
            },

            ['Mertaire'] =
            {
                onTrigger = function(player, npc)
                    if  quest:getVar(player, 'Prog') >= 1 then
                        return quest:event(102)
                    end
                end,
            },

            onEventFinish =
            {
                [181] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.BUBURIMU_PENINSULA] =
        {
            ['Song_Runes'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(0)
                    elseif quest:getVar(player, 'Prog') == 3 then
                        return quest:messageSpecial(ID.text.SONG_RUNES_REQUIRE, 917)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 3 and
                        npcUtil.tradeHasExactly(trade, { xi.items.SHEET_OF_PARCHMENT })
                    then
                        return quest:progressEvent(2)
                    end
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [2] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                        player:addFame(xi.quest.fame_area.BASTOK, 10)
                        player:addFame(xi.quest.fame_area.SANDORIA, 10)
                        player:addFame(xi.quest.fame_area.WINDURST, 10)
                        return quest:messageSpecial(ID.text.SONG_RUNES_WRITING, 917)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.BUBURIMU_PENINSULA] = -- Failsafe if player drops the poetic parchment
        {
            ['Song_Runes'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        not player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_MINSTREL_IN_DESPAIR) == QUEST_COMPLETED and
                        npcUtil.tradeHasExactly(trade, { xi.items.SHEET_OF_PARCHMENT })
                    then
                        player:tradeComplete()
                        npcUtil.giveItem(player, xi.items.POETIC_PARCHMENT)
                        return quest:messageSpecial(ID.text.SONG_RUNES_WRITING, xi.items.SHEET_OF_PARCHMENT)
                    end
                end,
            },
        },

        [xi.zone.LOWER_JEUNO] =
        {
            ['Mertaire'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_MINSTREL_IN_DESPAIR) == QUEST_AVAILABLE and
                        npcUtil.tradeHasExactly(trade, { xi.items.POETIC_PARCHMENT })
                    then
                        return quest:progressEvent(101)
                    end
                end,
            },

            onEventFinish =
            {
                [101] = function(player, csid, option, npc)
                    npcUtil.giveCurrency(player, "gil", xi.settings.main.GIL_RATE * 2100)
                    player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_MINSTREL_IN_DESPAIR)
                    player:addFame(xi.quest.fame_area.JEUNO, 30)
                    player:tradeComplete()
                end,
            },
        },
    },
}

return quest
