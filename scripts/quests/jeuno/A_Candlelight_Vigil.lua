-----------------------------------
-- Candle Making
-----------------------------------
-- !addquest 3 6
-- Ilumida : !pos -75 -1 58 244
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_CANDLELIGHT_VIGIL)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.JEUNO,
    item     = xi.items.FLOWER_NECKLACE,
    title    = xi.title.ACTIVIST_FOR_KINDNESS,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getFameLevel(xi.quest.fame_area.JEUNO) >= 4
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Ilumida'] =
            {
                onTrigger = function(player, npc)
                    local questOption = quest:getVar(player, 'Option')

                    if questOption == 0 then
                        return quest:progressEvent(192)
                    elseif questOption == 1 then
                        return quest:progressEvent(193)
                    end
                end,
            },

            onEventFinish =
            {
                [192] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    else
                        quest:setVar(player, 'Option', 1)
                    end
                end,

                [193] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'Option', 0)
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
            ['Ilumida'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.HOLY_CANDLE) then
                        return quest:progressEvent(194)
                    else
                        return quest:progressEvent(191)
                    end
                end,
            },

            onEventFinish =
            {
                [194] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.HOLY_CANDLE)
                        player:setLocalVar('Quest[3][66]mustZone', 1)
                    end
                end,
            },
        },
    },
}

return quest
