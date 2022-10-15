-----------------------------------
-- Visions of Dread
-- Rhapsodies of Vana'diel Mission 2-27
-----------------------------------
-- !addmission 13 106
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/zone')
require('scripts/globals/interaction/mission')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.VISIONS_OF_DREAD)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.TO_THE_SKIES },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        -- NOTE: This mission is left intentionally blank at this time, as there is no
        -- existing capture in which the player lands on this mission.  All captures
        -- indicate that it is completed during Where Divinities Collied, and the player is moved
        -- directly to Where To the Skies.

        -- It is possible this mission was only used in the initial implementation of RoV,
        -- prior to future missions becoming available.
    },
}

return mission
