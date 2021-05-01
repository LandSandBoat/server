-----------------------------------
-- Regaining Trust
-- Omer !pos -80.5 0 -113.5 245
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/items')
require('scripts/globals/quests')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
-----------------------------------


local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.HOOK_LINE_AND_SINKER)

quest.reward = {
    gil = 3000,
    title = xi.title.ROD_RETRIEVER,
}

quest.sections = {

    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.LOWER_JEUNO] = {
            ['Omer'] = {
                onTrigger = function(player, npc)
                    if player:getCurrentMission(COP) > A_VESSEL_WITHOUT_A_CAPTAIN then
                        return quest:progressEvent(10040, {[1] = xi.items.THREE_EYED_FISH, [2] = xi.items.CRESCENT_FISH})
                    else
                        return quest:progressEvent(206)
                    end
                end,
            },

            onEventFinish = {
                [10040] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] = {
            ['Omer'] = {
                onTrigger = function(player, npc)
                    return quest:progressEvent(10041, {[4] = xi.items.EGRET_FISHING_ROD})
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.EGRET_FISHING_ROD) then
                        return quest:progressEvent(10042, {[4] = xi.items.EGRET_FISHING_ROD})
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
