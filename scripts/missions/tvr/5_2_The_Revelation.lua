-----------------------------------
-- The Revelation
-- The Voracious Resurgence M5-2
-----------------------------------
-- TODO: Add correct !addmission command
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TVR, xi.mission.id.tvr.THE_REVELATION)

mission.reward =
{
    nextMission = { xi.mission.log_id.TVR, xi.mission.id.tvr.TATEEYAS_WORRIES },
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
