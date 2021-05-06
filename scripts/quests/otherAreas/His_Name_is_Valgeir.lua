-----------------------------------
-- His Name is Valgeir
-----------------------------------
-- Zone,    NPC,          POS
-- Mhaura,  Rycharde,     !pos
-- Selbina, Valgeir,      !pos
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
local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.HIS_NAME_IS_VALGEIR)
-----------------------------------

quest.reward =
{
    -- exp     = 2000,
    fame    = 120,
    gil     = 2000,
    keyItem = xi.ki.MAP_OF_THE_TORAIMARAI_CANAL,
}

quest.sections =
{
    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and player:getFameLevel(WINDURST) > 2 and
                player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.UNENDING_CHASE) == QUEST_COMPLETED
        end,

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    if player:getCharVar("UnendingChaseCompDay") + 2 < VanadielDayOfTheYear() or player:getCharVar("UnendingChaseCompYear") < VanadielYear() then
                        return quest:event(86) -- His Name is Valgeir starting event.
                    end
                end,
            },

            onEventFinish =
            {
                [86] = function(player, csid, option, npc)
                    if option == 80 then -- Accept quest option.
                        player:setCharVar("UnendingChaseCompDay", 0)  -- Delete previous quest (Unending Chase) variables
                        player:setCharVar("UnendingChaseCompYear", 0) -- Delete previous quest (Unending Chase) variables
                        player:addKeyItem(xi.ki.ARAGONEU_PIZZA) --give pizza to player
                        player:messageSpecial(mhauraID.text.KEYITEM_OBTAINED, xi.ki.ARAGONEU_PIZZA)
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepeted.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.MHAURA] =
        {
            -- TODO: Find information about the ferry free ride. NPC involved and number of times it allows for free rides.
            -- KNOWN: It isnt mandatory to take the ferry.

            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(87) -- Not given the pizza yet. Yes. Really.
                end,
            },
        },

        [xi.zone.SELBINA] =
        {
            ['Valgeir'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(100) -- Deliver Pizza.
                end,
            },

            onEventFinish =
            {
                [100] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.ARAGONEU_PIZZA)
                    player:messageSpecial(selbinaID.text.KEYITEM_LOST, xi.ki.ARAGONEU_PIZZA)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

    },

    -- Section: Finish quest.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 1
        end,

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(88) -- Finish quest.
                end,
            },

            onEventFinish =
            {
                [88] = function(player, csid, option, npc)
                    player:setCharVar("HisNameIsValgeirCompDay", VanadielDayOfTheYear()) -- Set completition day of quest.
                    player:setCharVar("HisNameIsValgeirCompYear", VanadielYear())        -- Set completition year of quest.
                    quest:complete(player)
                end,
            },
        },
    },

    -- Section: Quest completed. Change default message for Rycharde.
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_CLUE) == QUEST_AVAILABLE
        end,

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    return quest:replaceDefault(89) -- Default message after clompleting this quest and before accepting The Clue quest.
                end,
            },
        },
    },
}

return quest
