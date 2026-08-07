-----------------------------------
-- Water Way to Go
-----------------------------------
-- !addquest 2 16
-- Ohbiru-Dohbiru : !pos 23 -5 -193 238
-- Giddeus Spring : !pos -258 -2 -249 145
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.WATER_WAY_TO_GO)

quest.reward =
{
    fame     = 16,
    fameArea = xi.fameArea.WINDURST,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.WINDURST, xi.quest.id.windurst.OVERNIGHT_DELIVERY) and
                player:getFameLevel(xi.fameArea.WINDURST) >= 3 and
                not xi.quest.getMustZone(player, xi.questLog.WINDURST, xi.quest.id.windurst.OVERNIGHT_DELIVERY)
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ohbiru-Dohbiru'] = quest:progressEvent(352, 0, xi.item.CANTEEN_OF_GIDDEUS_WATER),

            onEventFinish =
            {
                [352] = function(player, csid, option, npc)
                    if
                        option == 0 and
                        npcUtil.giveItem(player, xi.item.RHINOSTERY_CANTEEN)
                    then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.GIDDEUS] =
        {
            ['Giddeus_Spring'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeMatches(trade, { { xi.item.RHINOSTERY_CANTEEN, 1 } }) then
                        return quest:progressEvent(55)
                    end
                end,
            },

            onEventFinish =
            {
                [55] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.CANTEEN_OF_GIDDEUS_WATER) then
                        player:tradeComplete()
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ohbiru-Dohbiru'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeMatches(trade, { { xi.item.CANTEEN_OF_GIDDEUS_WATER, 1 } }) then
                        return quest:progressEvent(355, 900)
                    end
                end,

                onTrigger = function(player, npc)
                    if
                        not player:findItem(xi.item.RHINOSTERY_CANTEEN) and
                        not player:findItem(xi.item.CANTEEN_OF_GIDDEUS_WATER)
                    then
                        return quest:progressEvent(354)
                    else
                        return quest:event(353)
                    end
                end,
            },

            onEventFinish =
            {
                [354] = function(player, csid, option, npc)
                    npcUtil.giveItem(player, xi.item.RHINOSTERY_CANTEEN)
                end,

                [355] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                        -- Note: Message display for gil reward is handled by the event
                        player:addGil(900)
                        quest:setMustZone(player)
                    end
                end,
            },
        },
    },

    -- Quest complete section.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.GIDDEUS] =
        {
            ['Giddeus_Spring'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        npcUtil.tradeMatches(trade, { { xi.item.RHINOSTERY_CANTEEN, 1 } })
                    then
                        return quest:progressEvent(55)
                    end
                end,
            },

            onEventFinish =
            {
                [55] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.CANTEEN_OF_GIDDEUS_WATER) then
                        player:tradeComplete()
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ohbiru-Dohbiru'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeMatches(trade, { { xi.item.CANTEEN_OF_GIDDEUS_WATER, 1 } }) then
                        return quest:progressEvent(355, 900)
                    end
                end,

                onTrigger = function(player, npc)
                    -- Default after completing without zoning.
                    if quest:getMustZone(player) then
                        return quest:event(356, 0, xi.item.CANTEEN_OF_GIDDEUS_WATER)
                    end

                    local questProgress = quest:getVar(player, 'Prog')

                    -- Re-start quest.
                    if questProgress == 0 then
                        if player:getFameLevel(xi.fameArea.WINDURST) < 5 then
                            return quest:progressEvent(352, 0, xi.item.CANTEEN_OF_GIDDEUS_WATER)
                        end

                    -- Quest re-started.
                    elseif questProgress == 1 then
                        if
                            not player:findItem(xi.item.RHINOSTERY_CANTEEN) and
                            not player:findItem(xi.item.CANTEEN_OF_GIDDEUS_WATER)
                        then
                            return quest:progressEvent(354)
                        else
                            return quest:event(353)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [352] = function(player, csid, option, npc)
                    if
                        option == 0 and
                        npcUtil.giveItem(player, xi.item.RHINOSTERY_CANTEEN)
                    then
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                [354] = function(player, csid, option, npc)
                    npcUtil.giveItem(player, xi.item.RHINOSTERY_CANTEEN)
                end,

                [355] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                        player:addGil(900)
                        quest:setMustZone(player)
                    end
                end,
            },
        },
    },
}

return quest
