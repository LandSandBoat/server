-----------------------------------
-- Take Wing
-- Rhapsodies of Vana'diel Mission 2-7
-----------------------------------
-- !addmission 13 66
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/rhapsodies')
require('scripts/globals/zone')
require('scripts/globals/interaction/mission')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.TAKE_WING)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.PRIME_NUMBER },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            onTriggerAreaEnter =
            {
                [5] = function(player, triggerArea)
                    local hasCompletedPath = player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_WARRIORS_PATH) and 1 or 0

                    return mission:progressEvent(168, { [0] = hasCompletedPath, text_table = 0 })
                end,
            },

            onEventFinish =
            {
                [168] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
