-----------------------------------
-- A Vessel Without a Captain
-- Promathia 3-2
-----------------------------------
-- !addmission 6 318
-- Door: Neptune's Spire : !pos 35 0 -15 245
-- Ru'Lude Homepoint 1   : !pos -6 3 0.001 243
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

        [xi.zone.METALWORKS] =
        {
            ['Cid'] = mission:progressEvent(861):oncePerZone(),
        },

        [xi.zone.LOWER_JEUNO] =
        {
            ['_6tc'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = mission:getVar(player, 'Status')

                    if missionStatus == 0 then
                        return mission:progressEvent(86)
                    elseif missionStatus == 1 then
                        return mission:progressEvent(9)
                    end
                end,
            },

            onEventFinish =
            {
                [86] = function(player, csid, option, npc)
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
                        local pNation = player:getNation()
                        local hasDefeatedShadowlord = player:hasCompletedMission(pNation, xi.mission.id.nation.SHADOW_LORD)

                        return mission:progressEvent(65, pNation, hasDefeatedShadowlord)
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
