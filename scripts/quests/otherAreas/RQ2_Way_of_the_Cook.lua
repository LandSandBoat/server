-----------------------------------
-- Way of the Cook
-- Variable Prefix: [4][1]
-----------------------------------
-- ZONE,   NPC,      POS
-- Mhaura, Rycharde, !pos 17.451 -16.000 88.815 249
-----------------------------------

local quest          = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.WAY_OF_THE_COOK)

quest.reward =
{
    fame     = 120,
    fameArea = xi.fameArea.WINDURST,
    title    = xi.title.ONE_STAR_PURVEYOR,
}

quest.sections =
{
    -- Section: Check if quest is available.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.RYCHARDE_THE_CHEF) == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getCharVar('Quest[4][0]DayCompleted') + 8 <= VanadielUniqueDay() and
                        player:getFameLevel(xi.fameArea.WINDURST) > 2
                    then
                        return quest:progressEvent(76, xi.item.BEEHIVE_CHIP, xi.item.SLICE_OF_DHALMEL_MEAT) -- Way of the Cook starting event.
                    else
                        return quest:event(75) -- Default dialog after completing previous quest.
                    end
                end,
            },

            ['Take'] = quest:event(68),

            onEventFinish =
            {
                [76] = function(player, csid, option, npc)
                    if option == 74 then -- Accept quest option.
                        player:setCharVar('Quest[4][0]DayCompleted', 0) -- Delete previous quest (Rycharde the Chef) variables
                        quest:setVar(player, 'EndTime', VanadielTime() + (3 * xi.vanaTime.DAY)) -- Set current quest started variables
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted. Handle trade and time limit
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    local currentTime = VanadielTime()
                    local endTime     = quest:getVar(player, 'EndTime')

                    if currentTime < endTime then
                        local hoursLeft = math.ceil((endTime - currentTime) / xi.vanaTime.HOUR)
                        return quest:event(78, hoursLeft) -- You have x hours left.
                    else
                        return quest:event(79) -- Not done yet.
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { xi.item.SLICE_OF_DHALMEL_MEAT, xi.item.BEEHIVE_CHIP }) then
                        local currentTime = VanadielTime()
                        local endTime     = quest:getVar(player, 'EndTime')

                        if currentTime < endTime then
                            return quest:progressEvent(80) -- Quest completed in time.
                        else
                            return quest:progressEvent(81) -- Quest completed late.
                        end
                    elseif
                        npcUtil.tradeHasExactly(trade, { xi.item.SLICE_OF_DHALMEL_MEAT }) or
                        npcUtil.tradeHasExactly(trade, { xi.item.BEEHIVE_CHIP })
                    then
                        return quest:event(73) -- Incomplete trade.
                    end
                end,
            },

            ['Take'] = quest:event(65),

            onEventFinish =
            {
                [80] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                        npcUtil.giveCurrency(player, 'gil', 1500)
                        quest:setVar(player, 'DayCompleted', VanadielUniqueDay()) -- Set completition day of WAY_OF_THE_COOK quest.
                    end
                end,

                [81] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                        npcUtil.giveCurrency(player, 'gil', 1000)
                        quest:setVar(player, 'DayCompleted', VanadielUniqueDay()) -- Set completition day of WAY_OF_THE_COOK quest.
                    end
                end,
            },
        },
    },
}

return quest
