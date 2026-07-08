-----------------------------------
-- Sky, Moon, Incantrix
-- The Voracious Resurgence M6-1
-----------------------------------
-- TODO: Add correct !addmission command
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TVR, xi.mission.id.tvr.SKY_MOON_INCANTRIX)

mission.reward =
{
    nextMission = { xi.mission.log_id.TVR, xi.mission.id.tvr.NIIS_LAST_STAND },
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
