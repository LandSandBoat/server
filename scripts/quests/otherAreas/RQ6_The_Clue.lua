-----------------------------------
-- The Clue
-- Variable Prefix: [4][5]
-----------------------------------
-- ZONE,   NPC,      POS
-- Mhaura, Rycharde, !pos 17.451 -16.000 88.815 249
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/quests')
require("scripts/globals/titles")
require('scripts/globals/npc_util')
require('scripts/globals/interaction/quest')
-----------------------------------
local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_CLUE)
-----------------------------------

quest.reward =
{
    fame  = 120,
    fameArea = MHAURA,
    title = xi.title.FOURSTAR_PURVEYOR,
    gil   = 3000,
}

quest.sections =
{
    -- Section: Quest is available and never interacted.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and player:getFameLevel(WINDURST) > 4 and vars.Prog == 0 and
                player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.EXPERTISE) == QUEST_COMPLETED
        end,

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    if player:getCharVar("Quest[4][4]DayCompleted") + 7 < VanadielUniqueDay() then
                        return quest:progressEvent(90, xi.items.CRAWLER_EGG) -- Unending Chase starting event.
                    end
                end,
            },

            onEventFinish =
            {
                [90] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                    player:setCharVar("Quest[4][4]DayCompleted", 0)  -- Delete previous quest (Rycharde the Chef) variables
                    if option == 83 then -- Accept quest option.
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: (OPTIONAL) Quest available but rejected.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and vars.Prog == 1
        end,

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(91, xi.items.CRAWLER_EGG) -- Unending Chase starting event.
                end,
            },

            onEventFinish =
            {
                [91] = function(player, csid, option, npc)
                    if option == 83 then -- Accept quest option.
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 1
        end,

        [xi.zone.MHAURA] =
        {
            ['Take'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(65) -- Not goten the dish from Valgeir.
                end,
            },

            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(85) -- No hurry dialog.
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, {{xi.items.CRAWLER_EGG, 4}}) then
                        return quest:progressEvent(92) -- Quest completed.
                    else
                        local count       = trade:getItemCount()
                        local crawlerEgg  = trade:hasItemQty(xi.items.CRAWLER_EGG, trade:getItemCount())
                        if crawlerEgg == true and count < 4 then
                            return quest:event(93)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [92] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                        quest:setVar(player, 'DayCompleted', VanadielUniqueDay()) -- Set completition day of quest.
                    end
                end,
            },
        },
    },

    -- Section: Quest completed. Change default message for Take.
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_BASICS) == QUEST_AVAILABLE
        end,

        [xi.zone.MHAURA] =
        {
            ['Take'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(66):replaceDefault() -- Default message after clompleting this quest and before accepting The Basics quest.
                end,
            },
        },

        [xi.zone.SELBINA] =
        {
            ['Valgeir'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(144):replaceDefault() -- Default message after clompleting this quest and before accepting The Basics quest.
                end,
            },
        },
    },
}

return quest
