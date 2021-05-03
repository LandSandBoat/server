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
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    quest:event(69)
                end,
            },

            ['Take'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(60)
                    end
                end,
            },

            onEventFinish =
            {
                [50] = function(player, csid, option, npc)
                    if option == 2 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
                [60] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },

    -- Section: Get quest.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and vars.Prog > 1
        end,

        [xi.zone.MHAURA] =
        {
            ['Rycharde'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(70, xi.items.DHAMEL_MEAT)
                    elseif quest:getVar(player, 'Prog') == 3 then -- You rejected the quest and you ask again.
                        return quest:progressEvent(71, xi.items.DHAMEL_MEAT)
                    end
                end,
            },

            ['Take'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:event(68)
                    end
                end,
            },

            onEventFinish =
            {
                [70] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    if (option == 71 or option == 72) then    --70 = answer no; 71 = answer yes!
                        quest:begin(player)
                    end
                end,
                [71] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    if (option == 71 or option == 72) then    --70 = answer no; 71 = answer yes!
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
                    local tradeCount  = trade:getItemCount()
                    local dhalmelMeat = trade:hasItemQty(xi.items.DHAMEL_MEAT, trade:getItemCount())
                    if dhalmelMeat  == true and tradeCount == 2 then
                        return quest:progressEvent(74) -- Completed OK
                    elseif dhalmelMeat  == true and tradeCount == 1 then
                        return quest:event(73) -- That's not enough!
                    end
                end,
            },

            onEventFinish =
            {
                [74] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:complete(player)
                    quest:setVar(player, 'Prog', 0)
                    player:setCharVar("QuestRychardeTCCompDay_var", VanadielDayOfTheYear()) -- Used for next quest wait time.
                    player:setCharVar("QuestRychardeTCCompYear_var", VanadielYear())        -- Used for next quest wait time.
                end,
            },
        },
    },
}

return quest
