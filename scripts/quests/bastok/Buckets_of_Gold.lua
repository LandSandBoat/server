-----------------------------------
-- Buckets of Gold
-----------------------------------
-- Log ID: 1, Quest ID: 41
-- Foss : !pos -283 -12 -37 235
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BUCKETS_OF_GOLD)

quest.reward =
{
    fame     = 8,
    fameArea = xi.quest.fame_area.BASTOK,
    gil      = 300,
    title    = xi.title.BUCKET_FISHER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Foss'] = quest:progressEvent(271),

            onEventFinish =
            {
                [271] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status ~= QUEST_AVAILABLE
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Foss'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.RUSTY_BUCKET, 5 } }) then
                        return quest:progressEvent(272)
                    end
                end,
            },

            onEventFinish =
            {
                [272] = function(player, csid, option, npc)
                    player:confirmTrade()

                    -- From previous implementation, award 75 fame (67 + 8) on first completion,
                    -- and 8 fame for any subsequent trade.
                    if player:getQuestStatus(quest.areaId, quest.questId) == QUEST_ACCEPTED then
                        player:addFame(xi.quest.fame_area.BASTOK, 67)
                    end

                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
