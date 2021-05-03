-----------------------------------
-- Rycharde the Chef
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
    title = xi.title.PURVEYOR_IN_TRAINING,
    gil   = 1500,
}

quest.sections =
{
    -- Section: Steps prior to getting the quest.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and vars.Prog == 0
        end,

        [xi.zone.MHAURA] =
        {
            onEventFinish =
            {
                [50] = function(player, csid, option, npc)
                    if option == 2 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },
    },

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

    -- Section: Get quest.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and vars.Prog == 2
        end,

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] = quest:progressEvent(70, xi.items.DHALMEL_MEAT),
            ['Take'] = quest:event(68),

            onEventFinish =
            {
                [70] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    if option == 71 or option == 72 then    --70 = answer no; 71 = answer yes!
                        quest:begin(player)
                    elseif option == 70 then
                        quest:setVar(player, 'Prog', 3)      
                    end
                end,
            },
        },
    },

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
                    if option == 71 or option == 72 then    --70 = answer no; 71 = answer yes!
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Actual questing.
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
                        return quest:event(72)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, {{xi.items.DHALMEL_MEAT, 2}}) then
                        return quest:progressEvent(74) -- Completed OK
                    elseif npcUtil.tradeHasExactly(trade, {{xi.items.DHALMEL_MEAT, 1}}) then
                        return quest:event(73) -- That's not enough!
                    end
                end,
            },

            onEventFinish =
            {
                [74] = function(player, csid, option, npc)
                    quest:complete(player)
                    player:setCharVar("QuestRychardeTCCompDay_var", VanadielDayOfTheYear()) -- Used for next quest wait time.
                    player:setCharVar("QuestRychardeTCCompYear_var", VanadielYear())        -- Used for next quest wait time.
                    player:confirmTrade()
                end,
            },
        },
    },
}

return quest
