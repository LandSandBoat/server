-----------------------------------
-- A Flash in the Pan
-----------------------------------
-- Log ID: 1, Quest ID: 14
-- Aquillina : !pos -97 -5 -81 235
-----------------------------------
local bastokMarketsID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.A_FLASH_IN_THE_PAN)

quest.reward =
{
    fame     = 75,
    fameArea = xi.quest.fame_area.BASTOK,
    gil      = 100,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Aquillina'] = quest:progressEvent(217),

            onEventFinish =
            {
                [217] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Aquillina'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.FLINT_STONE, 4 } }) then
                        if npc:getLocalVar('tradeCooldown') <= os.time() then
                            return quest:progressEvent(219)
                        else
                            return quest:progressEvent(218)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [219] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        GetNPCByID(bastokMarketsID.npc.AQUILLINA):setLocalVar('tradeCooldown', os.time() + 900)
                    end
                end,
            },
        },
    },
}

return quest
