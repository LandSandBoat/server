-----------------------------------
-- Maat on the Rampage
-- The Voracious Resurgence M8-1
-----------------------------------
-- TODO: Add correct !addmission command
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TVR, xi.mission.id.tvr.MAAT_ON_THE_RAMPAGE)

mission.reward =
{
    nextMission = { xi.mission.log_id.TVR, xi.mission.id.tvr.NOT_JUST_A_PRETTY_FACE },
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
