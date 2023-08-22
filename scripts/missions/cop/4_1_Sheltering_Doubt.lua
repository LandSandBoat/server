-----------------------------------
-- Sheltering Doubt
-- Promathia 4-1
-----------------------------------
-- !addmission 6 368
-- Despachiaire     : !pos 108 -40 -83 26
-- Justinius        : !pos 76 -34 68 26
-- Dilapidated Gate : !pos 260 9 -435 25
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.SHELTERING_DOUBT)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.THE_SAVAGE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Despachiaire'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = mission:getVar(player, 'Status')

                    if missionStatus == 1 then
                        return mission:progressEvent(108)
                    end
                end,
            },

            ['Justinius'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = mission:getVar(player, 'Status')

                    if missionStatus == 2 then
                        return mission:event(109):importantEvent()
                    elseif missionStatus == 3 then
                        return mission:event(266):replaceDefault()
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 0 then
                        return 107
                    end
                end,
            },

            onEventFinish =
            {
                [107] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,

                [108] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)
                end,

                [109] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 3)
                end,
            },
        },

        [xi.zone.MISAREAUX_COAST] =
        {
            ['_0p0'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') >= 2 then
                        return mission:progressEvent(7)
                    end
                end,
            },

            onEventFinish =
            {
                [7] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Justinius'] = mission:event(266):replaceDefault(),
        },
    },
}

return mission
