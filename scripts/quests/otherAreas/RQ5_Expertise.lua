-----------------------------------
-- Expertise
-- Variable Prefix: [4][4]
-----------------------------------
-- ZONE,    NPC,     POS
-- Mhaura,  Take,    !pos 20.616  -8.000 69.757 249
-- Selbina, Valgeir, !pos 57.496 -15.273 20.229 248
-----------------------------------
require('scripts/globals/items')
require("scripts/globals/keyitems")
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require("scripts/globals/titles")
require('scripts/globals/interaction/quest')
-----------------------------------
local mhauraID  = require("scripts/zones/Mhaura/IDs")
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
                    if player:getCharVar("Quest[4][3]DayCompleted") + 8 < VanadielUniqueDay() then
                        return quest:progressEvent(61) -- Quest starting event.
                    end
                end,
            },

            onEventFinish =
            {
                [61] = function(player, csid, option, npc)
                    player:setCharVar("Quest[4][3]DayCompleted", 0) -- Delete Variable
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Quest accepeted. Ask Valgeir to cook.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED  and vars.Prog == 0
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
                    return quest:progressEvent(102, xi.items.SCREAM_FUNGUS, xi.items.LAND_CRAB_MEAT) -- Ask for ingredients to cook.
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
                        return quest:progressEvent(103) -- Give ingredients.
                    end
                end,
            },

            onEventFinish =
            {
                [103] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    quest:setVar(player, 'HourStarted', VanadielHour())
                    quest:setVar(player, 'DayStarted', VanadielDayOfTheYear())
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
                    daysPassed = VanadielDayOfTheYear() - quest:getVar(player, "DayStarted")
                    hoursLeft  = 24 - VanadielHour() - (daysPassed * 24) + quest:getVar(player, "HourStarted")
                    if hoursLeft < 0 then -- Done waiting
                        return quest:progressEvent(105) -- Get food.
                    else
                        return quest:event(141)
                    end
                end,
            },

            onEventFinish =
            {
                [105] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
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
                    return quest:progressEvent(62, xi.items.TABLEWARE_SET) -- Give dish from Valgeir.
                end,
            },

            onEventFinish =
            {
                [62] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.LAND_CRAB_BISQUE) -- Give Land Crab Bisque from Valgeir.
                        player:messageSpecial(mhauraID.text.KEYITEM_OBTAINED + 1, xi.ki.LAND_CRAB_BISQUE) 
                        quest:setVar(player, 'DayCompleted', VanadielUniqueDay()) -- Completition day of Expertise quest.
                    end
                end,
            },
        },

        [xi.zone.SELBINA] =
        {
            ['Valgeir'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(142)
                end,
            },
        },
    },

    -- Section: Quest completed. Change default message for Take.
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_CLUE) == QUEST_AVAILABLE
        end,

        [xi.zone.MHAURA] =
        {
            ['Take'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(64):replaceDefault() -- Default message after clompleting Expertise quest and before accepting The Clue quest.
                end,
            },
        },

        [xi.zone.SELBINA] =
        {
            ['Valgeir'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(143):replaceDefault() -- Default message after clompleting Expertise quest and before accepting The Clue quest.
                end,
            },
        },
    },
}

return quest
