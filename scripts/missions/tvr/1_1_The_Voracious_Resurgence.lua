-----------------------------------
-- The Voracious Resurgence
-- The Voracious Resurgence M1-1
-----------------------------------
-- NOTE: This section of the mission menu won't appear
--     : unless you've flagged beyond (and maybe completed?)
--     : ROV: 3-34 The Orb's Radiance (!addmission 13 232)
-- TODO: Add correct !addmission command
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TVR, xi.mission.id.tvr.THE_VORACIOUS_RESURGENCE)

mission.reward =
{
    nextMission = { xi.mission.log_id.TVR, xi.mission.id.tvr.THE_GLOOM_PHANTOMS_APPROACH },
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
