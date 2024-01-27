-----------------------------------
-- Way of the Cook
-- Variable Prefix: [4][1]
-----------------------------------
-- ZONE,   NPC,      POS
-- Mhaura, Rycharde, !pos 17.451 -16.000 88.815 249
-----------------------------------

local quest          = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.WAY_OF_THE_COOK)
local daysPassed     = 0
local totalHoursLeft = 0

quest.reward =
{
    fame     = 120,
    fameArea = xi.quest.fame_area.WINDURST,
    title    = xi.title.ONE_STAR_PURVEYOR,
}

quest.sections =
{
    -- Section: Check if quest is available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.RYCHARDE_THE_CHEF) == QUEST_COMPLETED
        end,

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getCharVar('Quest[4][0]DayCompleted') + 7 < VanadielUniqueDay() and
                        player:getFameLevel(xi.quest.fame_area.WINDURST) > 2
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
                        player:setCharVar('Quest[4][0]DayCompleted', 0)            -- Delete previous quest (Rycharde the Chef) variables
                        quest:setVar(player, 'HourStarted', VanadielHour())        -- Set current quest started variables
                        quest:setVar(player, 'DayStarted', VanadielDayOfTheYear()) -- Set current quest started variables
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted. Handle trade and time limit
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    daysPassed     = VanadielDayOfTheYear() - quest:getVar(player, 'DayStarted')
                    totalHoursLeft = 72 - (VanadielHour() + daysPassed * 24) + quest:getVar(player, 'HourStarted')

                    if totalHoursLeft > 0 then
                        return quest:event(78, totalHoursLeft) -- You have x hours left.
                    else
                        return quest:event(79) -- Not done yet.
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { xi.item.SLICE_OF_DHALMEL_MEAT, xi.item.BEEHIVE_CHIP }) then
                        daysPassed     = VanadielDayOfTheYear() - quest:getVar(player, 'DayStarted')
                        totalHoursLeft = 72 - (VanadielHour() + daysPassed * 24) + quest:getVar(player, 'HourStarted')

                        if totalHoursLeft > 0 then
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
