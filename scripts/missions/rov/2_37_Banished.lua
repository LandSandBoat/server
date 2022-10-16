-----------------------------------
-- Banished
-- Rhapsodies of Vana'diel Mission 2-37
-----------------------------------
-- !addmission 13 130
-- _700 (Oaken Door) : !pos 97 -7 -12 252
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/rhapsodies')
require('scripts/globals/zone')
require('scripts/globals/interaction/mission')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.BANISHED)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.CALL_OF_THE_VOID },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.NORG] =
        {
            ['_700'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(289, 1, 10, 404423426, 436216135, 941191191, 1612251906, 4137, 0)
                end,
            },

            onEventFinish =
            {
                [289] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
