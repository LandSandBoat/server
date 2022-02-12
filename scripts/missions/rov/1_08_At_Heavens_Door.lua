-----------------------------------
-- At Heaven's Door
-- Rhapsodies of Vana'diel Mission 1-8
-----------------------------------
-- !addmission 13 18
-- Undulating Confluence : !pos -204.531 -20.027 75.318 126
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.AT_THE_HEAVENS_DOOR)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.THE_LIONS_ROAR },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.QUFIM_ISLAND] =
        {
            ['Undulating_Confluence'] = mission:event(63):setPriority(1005),

            onEventFinish =
            {
                [63] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
