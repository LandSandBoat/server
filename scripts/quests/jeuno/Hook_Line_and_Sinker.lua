-----------------------------------
-- Hook, Line, and Sinker
-- Omer, Lower Jeuno: !pos -89.43 0 -124.1 245
-- EGRET_FISHING_ROD: !additem 1726
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.HOOK_LINE_AND_SINKER)

quest.reward =
{
    gil = 3000,
    title = xi.title.ROD_RETRIEVER,
}

quest.sections =
{
    -- After completing A Vessel Without a Captain, talk to Omer to begin the quest.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.A_VESSEL_WITHOUT_A_CAPTAIN
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Omer'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(10040, 0, xi.item.THREE_EYED_FISH, xi.item.CRESCENT_FISH, 0, xi.item.EGRET_FISHING_ROD)
                end,
            },

            onEventFinish =
            {
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

        [xi.zone.LOWER_JEUNO] =
        {
            ['Omer'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(10041, 0, 0, 0, 0, xi.item.EGRET_FISHING_ROD)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.EGRET_FISHING_ROD) then
                        return quest:progressEvent(10042, 0, 0, 0, 0, xi.item.EGRET_FISHING_ROD)
                    end
                end,
            },

            onEventFinish =
            {
                [10042] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
