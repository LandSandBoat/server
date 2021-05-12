-----------------------------------
-- Unending Chase
-- Variable Prefix: [4][2]
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
local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.UNENDING_CHASE)
-----------------------------------

quest.reward =
{
    fame  = 120,
    fameArea = MHAURA,
    title = xi.title.TWOSTAR_PURVEYOR,
    gil   = 2100,
}

quest.sections =
{
    -- Section: Quest is available and never interacted.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and player:getFameLevel(WINDURST) > 2 and vars.Prog == 0 and
                player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.WAY_OF_THE_COOK) == QUEST_COMPLETED
        end,

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    if player:getCharVar("Quest[4][1]DayCompleted") + 7 < VanadielUniqueDay() then
                        return quest:progressEvent(82, xi.items.PUFFBALL) -- Unending Chase starting event.
                    end
                end,
            },

            onEventFinish =
            {
                [82] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                    player:setCharVar("Quest[4][1]DayCompleted", 0)  -- Delete previous quest (Rycharde the Chef) variables
                    if option == 77 then -- Accept quest option.
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
                    return quest:progressEvent(84, xi.items.PUFFBALL) -- Unending Chase starting event.
                end,
            },

            onEventFinish =
            {
                [84] = function(player, csid, option, npc)
                    if option == 78 then -- Accept quest option.
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
            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(85) -- No hurry dialog.
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, {xi.items.PUFFBALL}) then
                        return quest:progressEvent(83) -- Quest completed.
                    end
                end,
            },

            onEventFinish =
            {
                [83] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                        quest:setVar(player, 'DayCompleted', VanadielUniqueDay()) -- Set completition day of quest.
                    end
                end,
            },
        },
    },
}

return quest
