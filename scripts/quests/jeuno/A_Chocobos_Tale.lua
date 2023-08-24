-----------------------------------
-- A Chocobo's Tale
-----------------------------------
-- Log ID: 3, Quest ID: 72
-- Nevela       !pos -60 0 80
-- Wobke        !pos
-- Outpost Gate !pos
-- ???          !pos
-----------------------------------
require('scripts/globals/quests')
require("scripts/globals/missions")
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs/IDs")
-----------------------------------
local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_CHOCOBOS_TALE)

quest.reward =
{
    gil = 5200,
    fame = 50,
    fameArea = xi.quest.fame_area.JEUNO,
    title = xi.title.CHOCOBO_LOVE_GURU,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.A_VESSEL_WITHOUT_A_CAPTAIN
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Nevela'] = quest:progressEvent(10015),

            onEventFinish =
            {
                [10015] = function(player, csid, option, npc)
                    quest:begin(player)
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
            ['Nevela'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SILVER_COMETS_COLLAR) then
                        return quest:progressEvent(10017)
                    else
                        return quest:event(10016)
                    end
                end,
            },

            onEventFinish =
            {
                [10017] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.SILVER_COMETS_COLLAR)
                    end
                end,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Wobke'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(245)
                    elseif quest:getVar(player, 'Prog') == 1 then
                        return quest:event(246) -- Additional dialogue
                    elseif quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(247, { [1] = xi.items.BOTTLE_OF_WARDING_OIL })
                    elseif quest:getVar(player, 'Prog') == 4 then
                        return quest:event(248) -- Additional dialogue
                    end
                end,
            },

            onEventFinish =
            {
                [245] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
                [247] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },

        [xi.zone.PASHHOW_MARSHLANDS] =
        {
            ['Outpost_Gate'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(21, { [1] = xi.items.BOTTLE_OF_WARDING_OIL })
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.items.BOTTLE_OF_WARDING_OIL, 3 } }) and
                        quest:getVar(player, 'Prog') == 2
                    then
                        return quest:progressEvent(22)
                    end
                end,
            },
            onEventFinish =
            {
                [21] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
                [22] = function(player, csid, option, npc)
                    player:tradeComplete()
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },

        [xi.zone.BATALLIA_DOWNS] =
        {
            ['qm_chocobos_tale'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 4 and
                        npcUtil.popFromQM(player, npc, ID.mob.BADSHAHS, { claim = true, hide = 0 })
                    then
                        return quest:message(ID.text.BEING_ATTACKED)
                    elseif quest:getVar(player, 'Prog') == 5 and not player:hasKeyItem(xi.ki.SILVER_COMETS_COLLAR) then
                        return quest:progressEvent(2)
                    end
                end,
            },

            ['Badshah'] =
            {
                onMobDeath = function(mob, player)
                    if quest:getVar(player, 'Prog') == 4 then
                        quest:setVar(player, 'Prog', 5)
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.SILVER_COMETS_COLLAR)
                end,
            },
        },
    },
     {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Nevela'] = quest:event(10018):replaceDefault(),
        },
    },
}

return quest
