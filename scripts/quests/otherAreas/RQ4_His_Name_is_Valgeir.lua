-----------------------------------
-- His Name is Valgeir
-- Variable Prefix: [4][3]
-----------------------------------
-- ZONE,    NPC,      POS
-- Mhaura,  Rycharde, !pos 17.451 -16.000 88.815 249
-- Selbina, Valgeir,  !pos 57.496 -15.273 20.229 248
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
    fame    = 120,
    fameArea = MHAURA,
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
                    if player:getCharVar("Quest[4][2]DayCompleted") + 2 < VanadielUniqueDay() then
                        return quest:progressEvent(86) -- His Name is Valgeir starting event.
                    end
                end,
            },

            onEventFinish =
            {
                [86] = function(player, csid, option, npc)
                    if option == 80 then -- Accept quest option.
                        player:setCharVar("Quest[4][2]DayCompleted", 0)  -- Delete previous quest (Unending Chase) variables
                        npcUtil.giveKeyItem(player, xi.ki.ARAGONEU_PIZZA)   --give pizza to player
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepeted.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED  and vars.Prog == 0
        end,

        [xi.zone.MHAURA] =
        {
            -- TODO: Find information about the ferry free ride. NPC involved and number of times it allows for free rides.
            -- KNOWN: It isnt mandatory to take the ferry.

            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(87) -- Not delivered the pizza yet.
                end,
            },
        },

        [xi.zone.SELBINA] =
        {
            ['Valgeir'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(100) -- Deliver Pizza.
                end,
            },

            onEventFinish =
            {
                [100] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.ARAGONEU_PIZZA)
                    player:messageSpecial(selbinaID.text.KEYITEM_OBTAINED + 1, xi.ki.ARAGONEU_PIZZA)
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
                    if quest:complete(player) then
                        player:addExp(2000)
                        quest:setVar(player, 'DayCompleted', VanadielUniqueDay()) -- Set completition day of quest.
                    end
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
                    return quest:event(89):replaceDefault() -- Default message after clompleting this quest and before accepting The Clue quest.
                end,
            },
        },
    },
}

return quest
