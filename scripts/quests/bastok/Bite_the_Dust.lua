-----------------------------------
-- Bite the Dust
-----------------------------------
-- Log ID: 1, Quest ID: 46
-- Yazan : !pos -20.06 -3.3 24.471 236
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BITE_THE_DUST)

quest.reward =
{
    fame     = 8,
    fameArea = xi.quest.fame_area.BASTOK,
    gil      = 350,
    title    = xi.title.SAND_BLASTER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getFameLevel(xi.quest.fame_area.BASTOK) >= 2
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Yazan'] = quest:progressEvent(191),

            onEventFinish =
            {
                [191] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status ~= QUEST_AVAILABLE
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Yazan'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.SAND_BAT_FANG) then
                        return quest:progressEvent(193)
                    end
                end,

                onTrigger = function(player, npc)
                    local questStatus = player:getQuestStatus(quest.areaId, quest.questId)

                    if questStatus == QUEST_ACCEPTED then
                        return quest:event(192)
                    else
                        return quest:event(194):oncePerZone()
                    end
                end,
            },

            onEventFinish =
            {
                [193] = function(player, csid, option, npc)
                    player:confirmTrade()

                    if player:getQuestStatus(quest.areaId, quest.questId) == QUEST_ACCEPTED then
                        player:addFame(xi.quest.fame_area.BASTOK, 112)
                    end

                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
