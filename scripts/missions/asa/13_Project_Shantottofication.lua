-----------------------------------
-- Project Shantottofication
-- A Shantotto Ascension M13
-----------------------------------
-- !addmission 11 12
-- Mahogany Door : !pos 300 -1.85 355 163
-- TONBERRY_KEY  : !addkeyitem 1189
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.PROJECT_SHANTOTTOFICATION)

mission.reward =
{
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.AN_UNEASY_PEACE },
}

-- The fight is scripts/battlefields/Sacrificial_Chamber/project_shantottofication.lua, which completes the mission on a win.
mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,
    },
}

return mission
