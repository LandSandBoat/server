-----------------------------------
-- The Antique Collector
-----------------------------------
-- Log ID: 3, Quest ID: 25
-- Imasuke : !pos -165 11 94 246
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_ANTIQUE_COLLECTOR)

-- TODO: Quest reward has conflicting information from various resources.  Need to confirm
-- that XP and Gil rewards are also given when the player does not have the KI reward.

quest.reward =
{
    exp      = 2000,
    fame     = 30,
    fameArea = xi.fameArea.JEUNO,
    gil      = 2000,
    keyItem  = xi.ki.MAP_OF_DELKFUTTS_TOWER,
    title    = xi.title.TRADER_OF_ANTIQUITIES,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.JEUNO) >= 2
        end,

        [xi.zone.PORT_JEUNO] =
        {
            ['Imasuke'] = quest:progressEvent(13),

            onEventFinish =
            {
                [13] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.PORT_JEUNO] =
        {
            ['Imasuke'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.KAISER_SWORD) then
                        return quest:progressEvent(15)
                    end
                end,

                onTrigger = quest:event(14),
            },

            onEventFinish =
            {
                [15] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
