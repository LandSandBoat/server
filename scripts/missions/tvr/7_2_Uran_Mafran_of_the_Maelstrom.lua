-----------------------------------
-- Uran-Mafran of the Maelstrom
-- The Voracious Resurgence M7-2
-----------------------------------
-- TODO: Add correct !addmission command
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TVR, xi.mission.id.tvr.URAN_MAFRAN_OF_THE_MAELSTROM)

mission.reward =
{
    nextMission = { xi.mission.log_id.TVR, xi.mission.id.tvr.KORU_MORUS_HYPOTHESIS },
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
