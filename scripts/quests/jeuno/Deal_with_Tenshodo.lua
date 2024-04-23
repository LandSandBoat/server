-----------------------------------
-- Deal with Tenshodo
-----------------------------------
-- Log ID: 3, Quest ID: 26
-- Garnev : !pos 30 4 -36 245
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.DEAL_WITH_TENSHODO)

quest.reward =
{
    fame     = 30,
    fameArea = xi.fameArea.JEUNO,
    keyItem  = xi.ki.CLOCK_TOWER_OIL,
    title    = xi.title.TRADER_OF_RENOWN,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.A_CLOCK_MOST_DELICATE) == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Garnev'] =
            {
                onTrigger = function(player, npc)
                    if player:getFameLevel(xi.fameArea.NORG) >= 2 then
                        return quest:progressEvent(167)
                    else
                        return quest:event(168)
                    end
                end,
            },

            onEventFinish =
            {
                [167] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Garnev'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.GOLD_ORCMASK) then
                        return quest:progressEvent(166)
                    end
                end,
            },

            onEventFinish =
            {
                [166] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    }
}

return quest
