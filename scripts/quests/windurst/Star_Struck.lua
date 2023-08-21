-----------------------------------
-- Star Struck
-----------------------------------
-- Log ID: 2, Quest ID: 10
-- Koru-Moru : !pos -120 -6 124 239
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.STAR_STRUCK)

quest.reward =
{
    fame     = 20,
    fameArea = xi.quest.fame_area.WINDURST,
    item     = xi.item.COMPOUND_EYE_CIRCLET,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Koru-Moru'] =
            {
                onTrigger = function(player, npc)
                    if player:hasItem(xi.item.TORN_EPISTLE) then
                        return quest:progressEvent(197)
                    end
                end,
            },

            onEventFinish =
            {
                [197] = function(player, csid, option, npc)
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

        [xi.zone.WINDURST_WALLS] =
        {
            ['Koru-Moru'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.TORN_EPISTLE) then
                        return quest:progressEvent(199)
                    elseif npcUtil.tradeHasExactly(trade, xi.item.METEORITE) then
                        return quest:progressEvent(211)
                    end
                end,

                onTrigger = quest:event(198),
            },

            ['Luuh_Koplehn'] = quest:event(200),

            onEventFinish =
            {
                [199] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveCurrency(player, 'gil', 50)
                end,

                [211] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()

                        xi.quest.setMustZone(player, xi.quest.log_id.WINDURST, xi.quest.id.windurst.BLAST_FROM_THE_PAST)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and
                not player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_PUPPET_MASTER)
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Koru-Moru'] = quest:event(213):replaceDefault(),
        },
    },
}

return quest
