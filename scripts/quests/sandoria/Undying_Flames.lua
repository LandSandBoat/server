-----------------------------------
-- Undying Flames
-----------------------------------
-- Log ID: 0, Quest ID: 26
-- Pagisalis: !gotoid 17723424
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.UNDYING_FLAMES)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    title    = xi.title.FAITH_LIKE_A_CANDLE,
    item   = xi.items.FRIARS_ROPE,

}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Pagisalis'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(562)
                end,
            },

            onEventFinish =
            {
                [562] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Pagisalis'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.items.LUMP_OF_BEESWAX, 2 } }) then
                        return quest:progressEvent(563)
                    else
                        return quest:event(564)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(565)
                end,
            },

            onEventFinish =
            {
                [563] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Pagisalis'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(566):replaceDefault()
                end,
            },
        },
    },
}

return quest
