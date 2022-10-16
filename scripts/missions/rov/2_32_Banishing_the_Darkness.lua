-----------------------------------
-- Banishing the Darkness
-- Rhapsodies of Vana'diel Mission 2-32
-----------------------------------
-- !addmission 13 118
-- _700 (Oaken Door) : !pos 97 -7 -12 252
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/rhapsodies')
require('scripts/globals/utils')
require('scripts/globals/zone')
require('scripts/globals/interaction/mission')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.BANISHING_THE_DARKNESS)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.OVER_THE_RAINBOW },
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
                    if xi.rhapsodies.charactersAvailable(player) then
                        -- NOTE: Event parameters use from character with full mission completion status.

                        return mission:progressEvent(288, 3, 23, 1, 9062913, 24644, 973079298, 273045529, 4)
                    else
                        -- NOTE: This is a non-blocking message, but displayed on interaction with the door.
                        player:messageSpecial(norgID.text.UNABLE_TO_PROGRESS_MISSION, 1)
                    end
                end,
            },

            onEventFinish =
            {
                [288] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
