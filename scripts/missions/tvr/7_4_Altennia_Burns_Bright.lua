-----------------------------------
-- Altennia Burns Bright
-- The Voracious Resurgence M7-4
-----------------------------------
-- TODO: Add correct !addmission command
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TVR, xi.mission.id.tvr.ALTENNIA_BURNS_BRIGHT)

mission.reward =
{
    nextMission = { xi.mission.log_id.TVR, xi.mission.id.tvr.MAAT_ON_THE_RAMPAGE },
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
