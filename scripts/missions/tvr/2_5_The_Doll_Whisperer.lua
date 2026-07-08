-----------------------------------
-- The Doll Whisperer
-- The Voracious Resurgence M2-5
-----------------------------------
-- TODO: Add correct !addmission command
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TVR, xi.mission.id.tvr.THE_DOLL_WHISPERER)

mission.reward =
{
    nextMission = { xi.mission.log_id.TVR, xi.mission.id.tvr.DANCING_PRINCE },
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
