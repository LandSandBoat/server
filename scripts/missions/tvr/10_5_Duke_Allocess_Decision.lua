-----------------------------------
-- Duke Alloces's Decision
-- The Voracious Resurgence M10-5
-----------------------------------
-- TODO: Add correct !addmission command
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TVR, xi.mission.id.tvr.DUKE_ALLOCESS_DECISION)

mission.reward =
{
    nextMission = { xi.mission.log_id.TVR, xi.mission.id.tvr.ODINS_EYE },
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
