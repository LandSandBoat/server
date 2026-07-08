-----------------------------------
-- Raebrimm's Rebirth
-- The Voracious Resurgence M7-1
-----------------------------------
-- TODO: Add correct !addmission command
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TVR, xi.mission.id.tvr.RAEBRIMMS_REBIRTH)

mission.reward =
{
    nextMission = { xi.mission.log_id.TVR, xi.mission.id.tvr.URAN_MAFRAN_OF_THE_MAELSTROM },
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
