-----------------------------------
-- A Taste for Meat
-----------------------------------
-- Log ID: 0, Quest ID: 100
-- Antreneau : !pos -71 -5 -39 232
-- Thierride : !pos -67 -5 -28 232
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_TASTE_FOR_MEAT)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    gil = 150,
    title = xi.title.RABBITER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        -- This entire quest is not flagged; however, the quest is accepted and
        -- completed in the same step (on trading 5 hare meat after progressing).
        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Antreneau'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        npcUtil.tradeHas(trade, xi.item.SLICE_OF_HARE_MEAT)
                    then
                        return quest:progressEvent(531)
                    else
                        return quest:event(532)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(527)
                    else
                        return quest:event(525)
                    end
                end,
            },

            ['Thierride'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        npcUtil.tradeHasExactly(trade, { { xi.item.SLICE_OF_HARE_MEAT, 5 } })
                    then
                        return quest:progressEvent(528)
                    else
                        return quest:event(529)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(526)
                    end
                end,
            },

            onEventFinish =
            {
                [527] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [528] = function(player, csid, option, npc)
                    quest:begin(player)
                    if quest:complete(player) then
                        player:confirmTrade()

                        -- This variable is set after quest has been cleared, and is cleaned
                        -- up after receiving Grilled Hare item from Antreneau.
                        quest:setVar(player, 'Option', 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Antreneau'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Option') == 1 then
                        return quest:progressEvent(530)
                    end
                end,
            },

            ['Thierride'] = quest:event(524):replaceDefault(),

            onEventFinish =
            {
                [530] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.SLICE_OF_GRILLED_HARE) then
                        quest:setVar(player, 'Option', 0)
                    else
                        player:startEvent(538)
                    end
                end,
            },
        },
    },
}

return quest
