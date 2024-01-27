-----------------------------------
-- Seeing Spots
-- !addquest 7 10
-- Wyatt: !pos 124 0 84 80
-- LADYBUG_WING: !additem 2506
-----------------------------------

local quest = Quest:new(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.SEEING_SPOTS)

quest.reward =
{
    gil = 3000,
    title = xi.title.LADY_KILLER,
}

quest.sections =
{
    -- After speaking with Wyatt, collect four Ladybug Wings.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Wyatt'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(2)
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Trade the wings to Wyatt to receive your reward.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED or status == QUEST_COMPLETED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Wyatt'] =
            {
                -- Reminder
                onTrigger = function(player, npc)
                    return quest:progressEvent(3)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.LADYBUG_WING, 4 } }) then
                        return quest:progressEvent(4)
                    end
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
