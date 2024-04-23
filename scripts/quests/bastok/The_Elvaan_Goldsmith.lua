-----------------------------------
-- The Elvaan Goldsmith
-----------------------------------
-- Log ID: 1, Quest ID: 13
-- Michea : !pos -298 -16 -157 235
-----------------------------------

local quest = Quest:new(xi.questLog.BASTOK, xi.quest.id.bastok.THE_ELVAAN_GOLDSMITH)

quest.reward =
{
    fame     = 30,
    fameArea = xi.fameArea.BASTOK,
    gil      = 180,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Michea'] = quest:progressEvent(215),

            onEventFinish =
            {
                [215] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED or
                (
                    status == xi.questStatus.QUEST_COMPLETED and
                    player:getFameLevel(xi.fameArea.BASTOK) == 1 and
                    not quest:getMustZone(player)
                )
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Michea'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.COPPER_INGOT) then
                        return quest:progressEvent(216)
                    end
                end,

                onTrigger = quest:event(215),
            },

            onEventFinish =
            {
                [216] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()

                        quest:setMustZone(player)
                    end
                end,
            },
        },
    },
}

return quest
