-----------------------------------
-- A Test of True Love
-----------------------------------
-- Log ID: 1, Quest ID: 62
-- Carmelo : !gotoid 17743884
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.A_TEST_OF_TRUE_LOVE)

quest.reward =
{
    fame     = 120,
    fameArea = xi.quest.fame_area.BASTOK,
    gil      = 10000,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LOVE_AND_ICE) and
                player:getFameLevel(xi.quest.fame_area.BASTOK) >= 7 and
                not player:needToZone() -- need to zone from previous quest Love and Ice
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Carmelo'] = quest:progressEvent(270),

            onEventFinish =
            {
                [270] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Carmelo'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress < 3 then
                        return quest:event(271)
                    elseif progress == 3 then
                        return quest:progressEvent(272)
                    elseif progress == 4 and player:needToZone() then
                        return quest:event(273)
                    elseif progress == 4 and not player:needToZone() then
                        return quest:progressEvent(274)
                    end
                end,
            },

            onEventFinish =
            {
                [272] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                    player:needToZone(true)
                end,

                [274] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.UN_MOMENT)
                    player:delKeyItem(xi.ki.LEPHEMERE)
                    player:delKeyItem(xi.ki.LANCIENNE)
                    quest:complete(player)
                    player:needToZone(true) -- Need to zone to trigger Lovers in the Dusk
                end,
            },
        },
    },
}

return quest
