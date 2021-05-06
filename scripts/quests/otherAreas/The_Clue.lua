-----------------------------------
-- The Clue
-----------------------------------
-- Zone,   NPC,          POS
-- Mhaura, Rycharde,     !pos 
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
    title = xi.title.FOURSTAR_PURVEYOR,
    gil   = 3000,
}

quest.sections =
{
    -- Section: Quest is available and never interacted.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and player:getFameLevel(WINDURST) > 4 and
                player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.EXPERTISE) == QUEST_COMPLETED
        end,

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    if player:getCharVar("ExpertiseCompDay") + 7 < VanadielDayOfTheYear() or player:getCharVar("ExpertiseCompYear") < VanadielYear() then
                        return quest:event(90, xi.items.CRAWLER_EGG) -- Unending Chase starting event.
                    end
                end,
            },

            onEventFinish =
            {
                [90] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                    player:setCharVar("ExpertiseCompDay", 0)  -- Delete previous quest (Rycharde the Chef) variables
                    player:setCharVar("ExpertiseCompYear", 0) -- Delete previous quest (Rycharde the Chef) variables
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
                        return quest:event(891, xi.items.CRAWLER_EGG) -- Unending Chase starting event.
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
                    return quest:message(65) -- Not goten the dish from Valgeir.
                end,
            },

            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(85) -- No hurry dialog.
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, {{xi.items.CRAWLER_EGG, 4}}) then
                        return quest:event(92) -- Quest completed.
                    else
                        local count       = trade:getItemCount()
                        local crawlerEgg  = trade:hasItemQty(xi-items.CRAWLER_EGG, trade:getItemCount())
                        if crawlerEgg == true and count < 4 then
                            return quest:event(93)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [92] = function(player, csid, option, npc)
                    player:tradeComplete()
                    player:setCharVar("TheClueCompDay", VanadielDayOfTheYear()) -- Set completition day of quest.
                    player:setCharVar("TheClueCompYear", VanadielYear())        -- Set completition year of quest.
                    quest:complete(player)
                end,
            },
        },
    },

    -- Section: Quest completed. Change default message for Take.
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.MHAURA] =
        {
            ['Take'] =
            {
                onTrigger = function(player, npc)
                    return quest:replaceDefault(66) -- Default message after clompleting Expertise quest and before accepting The Clue quest.
                end,
            },
        },
    },
}

return quest
