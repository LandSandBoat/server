-----------------------------------
-- Expertise
-----------------------------------
-- Zone,    NPC,     POS
-- Mhaura,  Take,    !pos
-- Selbina, Valgeir, !pos
-----------------------------------
require('scripts/globals/items')
require("scripts/globals/keyitems")
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require("scripts/globals/titles")
require('scripts/globals/interaction/quest')
-----------------------------------
local mhauraID  = require("scripts/zones/Mhaura/IDs")
local selbinaID = require("scripts/zones/Selbina/IDs")
-----------------------------------
local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.EXPERTISE)
local daysPassed = 0
local hoursLeft  = 0
-----------------------------------

quest.reward =
{
    item  = {xi.items.TABLEWARE_SET},
    title = xi.title.THREESTAR_PURVEYOR,
}

quest.sections =
{
    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and player:getFameLevel(WINDURST) > 2 and
                player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.HIS_NAME_IS_VALGEIR) == QUEST_COMPLETED
        end,

        [xi.zone.MHAURA] =
        {
            ['Take'] =
            {
                onTrigger = function(player, npc)
                    if player:getCharVar("HisNameIsValgeirCompDay") + 8 < VanadielDayOfTheYear() or player:getCharVar("HisNameIsValgeirCompYear") < VanadielYear() then
                        return quest:event(61) -- Quest starting event.
                    end
                end,
            },

            onEventFinish =
            {
                [61] = function(player, csid, option, npc)
                    player:setCharVar("HisNameIsValgeirCompDay", 0) -- Delete Variable
                    player:setCharVar("HisNameIsValgeirCompYear", 0)  -- Delete Variable
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Quest accepeted. Ask Valgeir to cook.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.MHAURA] =
        {
            ['Take'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(63) -- Not goten the dish from Valgeir.
                end,
            },
        },

        [xi.zone.SELBINA] =
        {
            ['Valgeir'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(102, xi.items.SCREAM_FUNGUS, xi.items.LAND_CRAB_MEAT) -- Ask for ingredients to cook.
                end,
            },

            onEventFinish =
            {
                [102] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

    },

    -- Section: Give ingredients. Begin 1 Vanadiel day wait for food to complete.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 1
        end,

        [xi.zone.MHAURA] =
        {
            ['Take'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(63) -- Not goten the dish from Valgeir.
                end,
            },
        },

        [xi.zone.SELBINA] =
        {
            ['Valgeir'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(104) -- Get the ingredients.
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, {xi.items.SCREAM_FUNGUS, xi.items.LAND_CRAB_MEAT}) then
                        return quest:event(103) -- Give ingredients.
                    end
                end,
            },

            onEventFinish =
            {
                [103] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    player:setCharVar("ExpertiseHourStarted", VanadielHour())
                    player:setCharVar("ExpertiseDayStarted", VanadielDayOfTheYear())
                    player:confirmTrade()
                end,
            },
        },
    },

    -- Section: Get food.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 2
        end,

        [xi.zone.MHAURA] =
        {
            ['Take'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(63) -- Not goten the dish from Valgeir.
                end,
            },
        },

        [xi.zone.SELBINA] =
        {
            ['Valgeir'] =
            {
                onTrigger = function(player, npc)
                    daysPassed = VanadielDayOfTheYear() - player:getCharVar("ExpertiseDayStarted")
                    hoursLeft  = 24 - VanadielHour() - (daysPassed * 24) + player:getCharVar("ExpertiseHourStarted")
                    if hoursLeft < 0 then -- Done waiting
                        return quest:event(105) -- Get food.
                    end
                end,
            },

            onEventFinish =
            {
                [105] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    player:setCharVar("ExpertiseHourStarted", 0) -- Delete Variable
                    player:setCharVar("ExpertiseDayStarted", 0)  -- Delete Variable
                    npcUtil.giveKeyItem(player, xi.ki.LAND_CRAB_BISQUE)
                end,
            },
        },
    },

    -- Section: Complete quest.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 3
        end,

        [xi.zone.MHAURA] =
        {
            ['Take'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(62, xi.items.TABLEWARE_SET) -- Give dish from Valgeir.
                end,
            },

            onEventFinish =
            {
                [62] = function(player, csid, option, npc)
                    player:setCharVar("ExpertiseCompDay", VanadielDayOfTheYear()) -- Completition day of Expertise quest.
                    player:setCharVar("ExpertiseCompYear", VanadielYear())        -- Completition year of Expertise quest.
                    player:delKeyItem(xi.ki.LAND_CRAB_BISQUE)                     -- Give Land Crab Bisque from Valgeir.
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
