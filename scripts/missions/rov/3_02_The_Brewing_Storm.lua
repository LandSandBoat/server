-----------------------------------
-- The Brewing Storm
-- Rhapsodies of Vana'diel Mission 3-2
-----------------------------------
-- !addmission 13 150
-- Reisenjima - Defeat 3 Perfervid Narakas, then examine Etched Rock
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.THE_BREWING_STORM)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.THE_RIVER_RUNS_RED },
}

local killCounter = function(mob, player, optParams)
    if mission:getVar(player, 'KillCount') < 3 then
        mission:setVar(player, 'KillCount', mission:getVar(player, 'KillCount') + 1)
    end
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.REISENJIMA] =
        {
            ['Perfervid_Naraka'] =
            {
                onMobDeath = killCounter,
            },

            onZoneIn = function(player, prevZone)
                if mission:getVar(player, 'KillCount') >= 3 then
                    mission:complete(player)
                end
            end,

            onTriggerAreaEnter = {
                [0] = function(player, triggerArea)
                    if mission:getVar(player, 'KillCount') >= 3 then
                        mission:complete(player)
                    end
                end,
            },
        },
    },
}

return mission
