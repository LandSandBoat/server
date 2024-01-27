-----------------------------------
-- Empty Memories
-----------------------------------
-- !addquest 3 70
-- Harith : !pos -4.349 1 134.014 243
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.EMPTY_MEMORIES)

quest.reward =
{
    fame     = 5,
    fameArea = xi.quest.fame_area.JEUNO,
}

local rewardItems =
{
--  Awarded Item id                       Required Items for Trade
    [xi.item.BOTTLE_OF_HYSTEROANIMA] = { tradeItem = xi.item.RECOLLECTION_OF_PAIN,      gil = 2000 },
    [xi.item.BOTTLE_OF_PSYCHOANIMA ] = { tradeItem = xi.item.RECOLLECTION_OF_FEAR,      gil = 2000 },
    [xi.item.BOTTLE_OF_TERROANIMA  ] = { tradeItem = xi.item.RECOLLECTION_OF_GUILT,     gil = 2000 },
    [xi.item.HAMAYUMI              ] = { tradeItem = xi.item.RECOLLECTION_OF_SUFFERING, gil =  nil },
    [xi.item.STONE_GORGET          ] = { tradeItem = xi.item.RECOLLECTION_OF_ANXIETY,   gil =  nil },
    [xi.item.DIA_WAND              ] = { tradeItem = xi.item.RECOLLECTION_OF_ANIMOSITY, gil =  nil },
}

local memoriesOnEventFinish = function(player, csid, option, npc)
    local rewardItem = quest:getLocalVar(player, 'rewardItem')

    if npcUtil.giveItem(player, rewardItem) then
        player:confirmTrade()

        if rewardItems[rewardItem].gil then
            player:delGil(rewardItems[rewardItem].gil)
        end

        if player:getQuestStatus(quest.areaId, quest.questId) == QUEST_ACCEPTED then
            player:addFame(xi.quest.fame_area.JEUNO, 25)
        end

        quest:complete(player)
    end
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            (player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.THE_MOTHERCRYSTALS or
            xi.mission.getVar(player, xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS, 'Option') > 0)
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Harith'] = quest:progressEvent(113),

            onEventFinish =
            {
                [113] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status >= QUEST_ACCEPTED
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Harith'] =
            {
                onTrade = function(player, npc, trade)
                    for rewardItemId, requiredItems in pairs(rewardItems) do
                        if trade:hasItemQty(requiredItems.tradeItem, 1) then
                            if requiredItems.gil and trade:getGil() ~= requiredItems.gil then
                                return quest:event(108, requiredItems.gil)
                            end

                            local eventId = requiredItems.gil and 109 or 110

                            trade:confirmItem(requiredItems.tradeItem, 1)
                            quest:setLocalVar(player, 'rewardItem', rewardItemId)

                            return quest:progressEvent(eventId)
                        end
                    end
                end,

                onTrigger = quest:event(114),
            },

            onEventFinish =
            {
                [109] = memoriesOnEventFinish,
                [110] = memoriesOnEventFinish,
            },
        },
    },
}

return quest
