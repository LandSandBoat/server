-----------------------------------
-- The Prime Weapons
-- The Voracious Resurgence M9-4
-----------------------------------
-- TODO: Add correct !addmission command
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TVR, xi.mission.id.tvr.THE_PRIME_WEAPONS)

mission.reward =
{
    nextMission = { xi.mission.log_id.TVR, xi.mission.id.tvr.TO_MOVALPOLOS },
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
