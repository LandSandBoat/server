-----------------------------------
-- The Return of the Adventurer
-----------------------------------
-- Log ID: 1, Quest ID: 30
-- Gwill : !pos -317.829 -15.948 -177.375 235
-----------------------------------

local quest = Quest:new(xi.questLog.BASTOK, xi.quest.id.bastok.THE_RETURN_OF_THE_ADVENTURER)

quest.reward =
{
    fame     = 80,
    fameArea = xi.fameArea.BASTOK,
    item     = xi.item.COTTON_HEADBAND,
    title    = xi.title.KULATZ_BRIDGE_COMPANION,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.FATHER_FIGURE) and
                player:getFameLevel(xi.fameArea.BASTOK) >= 3
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Gwill'] = quest:progressEvent(242),

            onEventFinish =
            {
                [242] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Gwill'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.STICK_OF_CINNAMON) then
                        return quest:progressEvent(243)
                    end
                end,
            },

            onEventFinish =
            {
                [243] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
