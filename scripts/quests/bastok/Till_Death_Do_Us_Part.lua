-----------------------------------
-- Till Death Do Us Part
-----------------------------------
-- Log ID: 1, Quest ID: 18
-- Romilda : !pos 5.424 4.898 -18.699 236
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TILL_DEATH_DO_US_PART)

quest.reward =
{
    fame     = 160,
    fameArea = xi.quest.fame_area.BASTOK,
    gil      = 2000,
    title    = xi.title.QIJIS_RIVAL,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.FOREVER_TO_HOLD)
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Romilda'] =
            {
                onTrigger = function(player, npc)
                    if player:getFameLevel(xi.quest.fame_area.BASTOK) >= 3 then
                        return quest:progressEvent(128)
                    else
                        return quest:event(127)
                    end
                end,
            },

            onEventFinish =
            {
                [128] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Romilda'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.COTTON_GLOVES) then
                        return quest:progressEvent(129)
                    end
                end,
            },

            onEventFinish =
            {
                [129] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        }
    },
}

return quest
