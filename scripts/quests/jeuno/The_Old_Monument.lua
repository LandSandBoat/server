-----------------------------------
-- The Old Monument
-----------------------------------
-- Log ID: 3, Quest ID: 20
-- Mertaire    : !pos -17 0 -61 245
-- Bki Tbujhja : !pos -22 0 -60 245
-- Song Runes  : !pos -244 16 -280 118
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local buburimuID   = require('scripts/zones/Buburimu_Peninsula/IDs')
local lowerJeunoID = require('scripts/zones/Lower_Jeuno/IDs')
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
            ['Bki_Tbujhja'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') >= 1 then
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
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(102)
                    else
                        return quest:messageSpecial(lowerJeunoID.text.MERTAIRE_MALLIEBELL_LEFT)
                    end
                end,
            },

            onEventFinish =
            {
                [102] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

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
                    end
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return vars.Prog == 3 or
                status == QUEST_COMPLETED
        end,

        [xi.zone.BUBURIMU_PENINSULA] =
        {
            ['Song_Runes'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.SHEET_OF_PARCHMENT) then
                        return quest:progressEvent(2)
                    end
                end,

                onTrigger = quest:messageSpecial(buburimuID.text.SONG_RUNES_REQUIRE, xi.items.SHEET_OF_PARCHMENT),
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    player:messageSpecial(buburimuID.text.SONG_RUNES_WRITING, xi.items.SHEET_OF_PARCHMENT)

                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
