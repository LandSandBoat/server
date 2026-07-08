-----------------------------------
-- Uncertain Destinations
-- Rhapsodies of Vana'diel Mission 2-15
-----------------------------------
-- !addmission 13 78
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.UNCERTAIN_DESTINATIONS)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.GANGED_UP_ON },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        -- NOTE: This mission is left intentionally blank at this time, as there is no
        -- existing capture in which the player lands on this mission.  All captures
        -- indicate that it is completed during Cauterize, and the player is moved
        -- directly to Ganged Up On.

        -- It is possible this mission was only used in the initial implementation of RoV,
        -- prior to future missions becoming available.
    },
}

return mission
