-----------------------------------
-- The Cardian's Duty
-- The Voracious Resurgence M2-2
-----------------------------------
-- TODO: Add correct !addmission command
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TVR, xi.mission.id.tvr.THE_CARDIANS_DUTY)

mission.reward =
{
    nextMission = { xi.mission.log_id.TVR, xi.mission.id.tvr.ZHUU_BUXUS_GAMBIT },
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
