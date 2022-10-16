-----------------------------------
-- Over the Rainbow
-- Rhapsodies of Vana'diel Mission 2-33
-----------------------------------
-- !addmission 13 120
-- Shantotto : !pos 122 -2 112 239
-----------------------------------
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/rhapsodies')
require('scripts/globals/zone')
require('scripts/globals/interaction/mission')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.OVER_THE_RAINBOW)

mission.reward =
{
    keyItem     = xi.ki.MOST_CURIOUS_CURIO,
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.CACOPHONOUS_DISCORD },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Shantotto'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(548, 656122745, 0, 0, 0, 0, 45448, 4095, 4)
                end,
            },

            onEventFinish =
            {
                [548] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
