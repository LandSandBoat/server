-----------------------------------
-- Recycling Rods
-----------------------------------
-- Log ID: 4, Quest ID: 30
-- Keshab-Menjab : !pos -15.6 -8 52 249
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.RECYCLING_RODS)

quest.reward =
{
    gil = 1500,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.MHAURA] =
        {
            ['Keshab-Menjab'] = quest:progressEvent(313),

            onEventFinish =
            {
                [313] = function(player, csid, option, npc)
                    if option == 1 then
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

        [xi.zone.MHAURA] =
        {
            ['Keshab-Menjab'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(315)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.CLEAN_SNAP_ROD) then
                        return quest:progressEvent(317)
                    else
                        return quest:event(316)
                    end
                end,
            },

            onEventFinish =
            {
                [317] = function(player, csid, option, npc)
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

        [xi.zone.MHAURA] =
        {
            ['Keshab-Menjab'] = quest:event(314),
        },
    },
}

return quest
