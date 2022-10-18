-----------------------------------
-- Wisdom of Our Forefathers
-- Rhapsodies of Vana'diel Mission 2-25
-----------------------------------
-- !addmission 13 103
-- Granite Door (_4fx) : !pos 340 -1.899 331.656 159
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/utils')
require('scripts/globals/zone')
require('scripts/globals/interaction/mission')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.WISDOM_OF_OUR_FOREFATHERS)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.WHERE_DIVINITIES_COLLIDE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.TEMPLE_OF_UGGALEPIH] =
        {
            -- NOTE: The below parameters are based on minimal completion status, with current CoP mission at
            -- Sheltering Doubt.  Additional captures will be necessary to determine second parameter, as the third
            -- from full completion status appears to be unused.

            ['_4fx'] = mission:progressEvent(94, 0, 1, 1, utils.MAX_UINT32 - 599, 318489, utils.MAX_UINT32 - 1237, 437038, 0),

            onEventFinish =
            {
                [94] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
