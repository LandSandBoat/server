-----------------------------------
-- Crossroads of Time
-- Wings of the Goddess Mission 15
-----------------------------------
-- !addmission 5 14
-- EAST_RONFAURE_S      : !zone 81
-- SOUTHERN_SAN_DORIA_S : !zone 80
-----------------------------------
require('scripts/missions/wotg/helpers')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.CROSSROADS_OF_TIME)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.SANDSWEPT_MEMORIES },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                xi.wotg.helpers.meetsMission15Reqs(player)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if prevZone == xi.zone.EAST_RONFAURE_S then
                        return 145
                    end
                end,
            },

            onEventFinish =
            {
                [145] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
