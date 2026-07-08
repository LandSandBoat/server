-----------------------------------
-- Nii's Last Stand
-- The Voracious Resurgence M6-2
-----------------------------------
-- TODO: Add correct !addmission command
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TVR, xi.mission.id.tvr.NIIS_LAST_STAND)

mission.reward =
{
    nextMission = { xi.mission.log_id.TVR, xi.mission.id.tvr.DANCE_OF_THE_TENGU },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        -- TODO: Add zones and interactions
    },
}

return mission
