-----------------------------------
-- Rycharde the Chef
-----------------------------------
-- Zone,   NPC,          POS
-- Mhaura, Rycharde,     !pos 
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/quests')
require("scripts/globals/titles")
require('scripts/globals/npc_util')
require('scripts/globals/interaction/quest')
local ID = require("scripts/zones/Mhaura/IDs")
-----------------------------------
local quest          = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.WAY_OF_THE_COOK)
local questInTime    = false
local daysPassed     = 0
local totalHoursLeft = 0
-----------------------------------

quest.reward =
{
    fame  = 120,
    title = xi.title.ONESTAR_PURVEYOR,
}

quest.sections =
{
    -- Section: Check if quest is available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.MHAURA] =
        {
            onEventFinish =
            {
                [76] = function(player, csid, option, npc)
                    if option == 74 then -- Accept quest option.
                        player:setCharVar("RychardeTheChefCompDay", 0)  -- Delete previous quest (Rycharde the Chef) variables
                        player:setCharVar("RychardeTheChefCompYear", 0) -- Delete previous quest (Rycharde the Chef) variables

                        player:setCharVar("WayOfTheCookHourStarted", VanadielHour())        -- Set current quest started variables
                        player:setCharVar("WayOfTheCookDayStarted", VanadielDayOfTheYear()) -- Set current quest started variables

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
                        daysPassed     = VanadielDayOfTheYear() - player:getCharVar("WayOfTheCookDayStarted")
                        totalHoursLeft = 72 - (VanadielHour() + daysPassed * 24) + player:getCharVar("WayOfTheCookHourStarted")

                        if totalHoursLeft > 0 then
                            quest:progressEvent(78, totalHoursLeft) -- You have x hours left.
                        else
                            quest:progressEvent(79) -- Not done yet.
                        end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, {xi.items.DHALMEL_MEAT, xi.items.BEEHIVE_CHIP}) then
                        daysPassed     = VanadielDayOfTheYear() - player:getCharVar("WayOfTheCookDayStarted")
                        totalHoursLeft = 72 - (VanadielHour() + daysPassed * 24) + player:getCharVar("WayOfTheCookHourStarted")

                        if totalHoursLeft > 0 then
                            return quest:progressEvent(80) -- Quest completed in time.
                        else
                            return quest:progressEvent(81) -- Quest completed late.
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [80] = function(player, csid, option, npc)
                    player:tradeComplete()
                    player:setCharVar("WayOfTheCookHourStarted", 0) -- Delete current quest started variables
                    player:setCharVar("WayOfTheCookDayStarted", 0)  -- Delete current quest started variables
                    player:setCharVar("WayOfTheCookCompDay", VanadielDayOfTheYear()) -- Set completition day of WAY_OF_THE_COOK quest.
                    player:setCharVar("WayOfTheCookCompYear", VanadielYear())        -- Set completition day of WAY_OF_THE_COOK quest.
                    player:addGil(GIL_RATE*1500)
                    player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*1500)
                    quest:complete(player)
                end,

                [81] = function(player, csid, option, npc)
                    player:tradeComplete()
                    player:setCharVar("WayOfTheCookHourStarted", 0) -- Delete current quest started variables
                    player:setCharVar("WayOfTheCookDayStarted", 0)  -- Delete current quest started variables
                    player:setCharVar("WayOfTheCookCompDay", VanadielDayOfTheYear()) -- Set completition day of WAY_OF_THE_COOK quest.
                    player:setCharVar("WayOfTheCookCompYear", VanadielYear())        -- Set completition day of WAY_OF_THE_COOK quest.
                    player:addGil(GIL_RATE*1000)
                    player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*1000)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
