-----------------------------------
-- The Call of the Wyrmking
-- Promathia 3-1
-----------------------------------
-- !addmission 6 258
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.THE_CALL_OF_THE_WYRMKING)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.A_VESSEL_WITHOUT_A_CAPTAIN },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.SOUTH_GUSTABERG] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 0 then
                        return 906
                    end
                end,
            },

            onEventFinish =
            {
                [906] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            onRegionEnter =
            {
                [1] = function(player, region)
                    if mission:getVar(player, 'Status') == 1 then
                        return mission:progressEvent(305)
                    end
                end,
            },

            onEventFinish =
            {
                [305] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)
                end,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Cid'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 2 then
                        return mission:progressEvent(845)
                    end
                end,
            },

            onEventFinish =
            {
                [845] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
