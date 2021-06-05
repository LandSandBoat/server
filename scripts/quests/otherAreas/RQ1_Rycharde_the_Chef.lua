-----------------------------------
-- Rycharde the Chef
-- Variable Prefix: [4][0]
-----------------------------------
-- ZONE,   NPC,          POS
-- Mhaura, Rycharde,     !pos  17.451 -16.000 88.815 249
-- Mhaura, Take,         !pos  20.616  -8.000 69.757 249
-- Mhaura, Numi Adaligo, !pos -80.332 -24.050 34.794 249
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/quests')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.RYCHARDE_THE_CHEF)

quest.reward =
{
    fame  = 120,
    fameArea = MHAURA,
    title = xi.title.PURVEYOR_IN_TRAINING,
    gil   = 1500,
}

quest.sections =
{
    -- Section: Talk to Numi Adaligo and ask for work.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and vars.Prog == 0
        end,

        [xi.zone.MHAURA] =
        {
            onEventFinish =
            {
                [50] = function(player, csid, option, npc)
                    if option == 2 then -- Ask for work.
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },
    },

    -- Section: Talk with Take
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and vars.Prog == 1
        end,

        [xi.zone.MHAURA] =
        {
            ['Take'] = quest:progressEvent(60),

            onEventFinish =
            {
                [60] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },

    -- Section: Talk with Rycharde. Get quest (or decline). Handle "Take" optional dialog.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and vars.Prog == 2
        end,

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] = quest:progressEvent(70, xi.items.DHALMEL_MEAT),
            ['Take'] = quest:progressEvent(68), -- Optional dialog.

            onEventFinish =
            {
                [70] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    if option == 71 or option == 72 then -- Accept quest.
                        quest:begin(player)
                    elseif option == 70 then -- Decline quest.
                        quest:setVar(player, 'Prog', 3)
                    end
                end,
            },
        },
    },

    -- Section: (OPTIONAL) Talk with Rycharde if you declined. Get quest (or decline again).
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and vars.Prog == 3
        end,

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] = quest:progressEvent(71, xi.items.DHALMEL_MEAT), -- You rejected the quest and you ask again.

            onEventFinish =
            {
                [71] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    if option == 71 or option == 72 then  -- Accept quest.
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted. Handle trade outcomes. Handle talk with Rycharde.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:event(72) -- Interaction dialog.
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, {{xi.items.DHALMEL_MEAT, 2}}) then
                        return quest:progressEvent(74) -- Quest completed dialog.
                    elseif npcUtil.tradeHasExactly(trade, {{xi.items.DHALMEL_MEAT, 1}}) then
                        return quest:event(73) -- "That's not enough!" dialog.
                    end
                end,
            },

            onEventFinish =
            {
                [74] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        quest:setVar(player, 'DayCompleted', VanadielUniqueDay()) -- Used for next quest wait time.
                    end
                end,
            },
        },
    },

        -- Section: Quest completed. Change default message for Rycharde.
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.HIS_NAME_IS_VALGEIR) == QUEST_AVAILABLE
        end,

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(75):replaceDefault() -- Default message after clompleting this quest and before accepting His name is Valgeir quest.
                end,
            },
        },
    },
}

return quest
