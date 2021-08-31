-----------------------------------
-- Hook, Line, and Sinker
-- Omer, Lower Jeuno: !pos -89.43 0 -124.1 245
-- EGRET_FISHING_ROD: !additem 1726
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/items')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.HOOK_LINE_AND_SINKER)

quest.reward = {
    gil = 3000,
    title = xi.title.ROD_RETRIEVER,
}

quest.sections = {
    -- After completing A Vessel Without a Captain, talk to Omer to begin the quest.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and player:getCurrentMission(COP) > xi.mission.id.cop.A_VESSEL_WITHOUT_A_CAPTAIN
        end,

        [xi.zone.LOWER_JEUNO] = {
            ['Omer'] = {
                onTrigger = function(player, npc)
                    return quest:progressEvent(10040, 0, xi.items.THREE_EYED_FISH, xi.items.CRESCENT_FISH, 0, xi.items.EGRET_FISHING_ROD)
                end,
            },

            onEventFinish = {
                [10040] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Obtain an Egret Fishing Rod, which drops from Sea Bishops and Krakens fished up on Qufim Island. No skill is required to hook these.
    -- Return it to Omer to complete the quest.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] = {
            ['Omer'] = {
                onTrigger = function(player, npc)
                    return quest:progressEvent(10041, 0, 0, 0, 0, xi.items.EGRET_FISHING_ROD)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.EGRET_FISHING_ROD) then
                        return quest:progressEvent(10042, 0, 0, 0, 0, xi.items.EGRET_FISHING_ROD)
                    end
                end,
            },

            onEventFinish = {
                [10042] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
