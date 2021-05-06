-----------------------------------
-- The Basics
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
local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_BASICS)
-----------------------------------

quest.reward =
{
    -- exp     = 2000,
    fame    = 120,
    item    = xi.items.TEA_SET,
    title   = xi.title.FIVESTAR_PURVEYOR,
}

quest.sections =
{
    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and player:getFameLevel(WINDURST) > 4 and
                player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_CLUE) == QUEST_COMPLETED
        end,

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    if player:getCharVar("TheClueCompDay") + 7 < VanadielDayOfTheYear() or player:getCharVar("TheClueCompYear") < VanadielYear() then
                        return quest:event(94) -- Quest starting event.
                    end
                end,
            },

            onEventFinish =
            {
                [94] = function(player, csid, option, npc)
                    if option == 85 then -- Accept quest option.
                        player:setCharVar("TheClueCompDay", 0)  -- Delete previous quest (The clue) variables.
                        player:setCharVar("TheClueCompYear", 0) -- Delete previous quest (The clue) variables.
                        player:addKeyItem(xi.ki.MHAURAN_COUSCOUS) -- Give Key Item to player.
                        player:messageSpecial(mhauraID.text.KEYITEM_OBTAINED, xi.ki.MHAURAN_COUSCOUS)
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
                    return quest:event(95) -- Not delivered the Key Item yet.
                end,
            },
        },

        [xi.zone.SELBINA] =
        {
            ['Valgeir'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(106) -- Deliver Key Item.
                end,
            },

            onEventFinish =
            {
                [106] = function(player, csid, option, npc)
                    npcUtil.giveItem(player, xi.items.BAKED_POPOTO)
                    player:delKeyItem(xi.ki.MHAURAN_COUSCOUS)
                    player:messageSpecial(selbinaID.text.KEYITEM_LOST, xi.ki.MHAURAN_COUSCOUS)
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
                    return quest:progressEvent(97) -- Commentary.
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, {xi.items.BAKED_POPOTO}) then
                        return quest:event(96) -- Quest completed.
                    end
                end,

            },

            onEventFinish =
            {
                [96] = function(player, csid, option, npc)
                    player:tradeComplete()
                    quest:complete(player)
                    player:setCharVar("TheBasicsCommentaryValgeir", 1)
                    player:setCharVar("TheBasicsCommentaryRycharde", 1)
                end,
            },
        },
    },

    -- Section: Quest completed.
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    if player:getCharVar("TheBasicsCommentaryRycharde") == 1 then
                        return quest:event(97) -- Optional dialog.
                    else
                        return quest:replaceDefault(98) -- Default message after clompleting this quest.
                    end
                end,
            },

            ['Take'] =
            {
                onTrigger = function(player, npc)
                    return quest:replaceDefault(67) -- Default message after clompleting this quest.
                end,
            },

            onEventFinish =
            {
                [97] = function(player, csid, option, npc)
                    player:setCharVar("TheBasicsCommentaryRycharde", 0)
                end,
            },
        },

        [xi.zone.SELBINA] =
        {
            ['Valgeir'] =
            {
                onTrigger = function(player, npc)
                    if player:getCharVar("TheBasicsCommentaryValgeir") == 1 then
                        return quest:event(107) -- Optional dialog.
                    -- else
                        -- return quest:replaceDefault(140) -- Default message after clompleting this quest. TODO: Investigate if this is truly the one. This one is already the default.
                    end
                end,
            },

            onEventFinish =
            {
                [107] = function(player, csid, option, npc)
                    player:setCharVar("TheBasicsCommentaryValgeir", 0)
                end,
            },
        },
    },
}

return quest
