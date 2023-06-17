-----------------------------------
-- A Clock Most Delicate
-----------------------------------
-- Log ID: 3, Quest ID: 2
-- Collet : !pos -44 0 107 244
-- _6s2   : !pos -80 0 104 244
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_CLOCK_MOST_DELICATE)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.JEUNO,
    gil      = 1200,
    item     = xi.items.ENGINEERS_GLOVES,
    title    = xi.title.PROFESSIONAL_LOAFER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getFameLevel(xi.quest.fame_area.JEUNO) >= 5
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['_6s2'] =
            {
                onTrigger = function(player, npc)
                    local questOption = quest:getVar(player, 'Option')

                    if questOption == 1 then
                        return quest:progressEvent(119)
                    elseif questOption == 2 then
                        return quest:progressEvent(118)
                    end
                end,
            },

            ['Collet'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Option') == 0 then
                        return quest:progressEvent(112)
                    end
                end,
            },

            onEventFinish =
            {
                [112] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 1)
                end,

                [118] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,

                [119] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    else
                        quest:setVar(player, 'Option', 2)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['_6s2'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.CLOCK_TOWER_OIL) then
                        return quest:progressEvent(202)
                    else
                        return quest:event(117)
                    end
                end,
            },

            onEventFinish =
            {
                [202] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.CLOCK_TOWER_OIL)
                    end
                end,
            },
        },
    }
}

return quest
