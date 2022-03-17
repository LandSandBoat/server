-----------------------------------
-- A Vessel Without a Captain
-- Promathia 3-2
-----------------------------------
-- !addmission 6 318
-----------------------------------
require('scripts/globals/interaction/mission')
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.A_VESSEL_WITHOUT_A_CAPTAIN)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.THE_ROAD_FORKS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['_6tc'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 0 then
                        player:startEvent(86)
                        return mission:progressEvent(9) -- TODO: Verify this sequence
                    end
                end,
            },

            onEventFinish =
            {
                [9] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,
            },
        },

        [xi.zone.RULUDE_GARDENS] =
        {
            onRegionEnter =
            {
                [1] = function(player, region)
                    if mission:getVar(player, 'Status') == 1 then
                        return mission:progressEvent(65, player:getNation())
                    end
                end,
            },

            onEventFinish =
            {
                [65] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
