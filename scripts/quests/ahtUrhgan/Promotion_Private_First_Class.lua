-----------------------------------
-- Promotion: Private First Class
-- Log ID: 6, Quest ID: 90
-- Naja Salaheem !pos 26 -8 -45.5 50
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.PROMOTION_PRIVATE_FIRST_CLASS)

quest.reward =
{
    keyItem = xi.ki.PFC_WILDCAT_BADGE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and player:getCharVar('AssaultPromotion') >= 25
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] = quest:progressEvent(5000, { text_table = 0 }),

            onEventFinish =
            {
                [5000] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(5001, { text_table = 0 })
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.IMP_WING) then
                        return quest:progressEvent(5002, { text_table = 0 })
                    end
                end,
            },

            onEventFinish =
            {
                [5002] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:setCharVar('AssaultPromotion', 0)
                        player:confirmTrade()
                        player:delKeyItem(xi.ki.PSC_WILDCAT_BADGE)
                    end
                end,
            },
        },
    },
}

return quest
