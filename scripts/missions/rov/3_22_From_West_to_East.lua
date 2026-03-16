-----------------------------------
-- From West to East
-- Rhapsodies of Vana'diel Mission 3-22
-----------------------------------
-- !addmission 13 194
-- Reisenjima - Defeat 11 Obstreperous Panopts, then examine Etched Rock
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.FROM_WEST_TO_EAST)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.GOOD_THINGS_COME_IN_THREES },
}

local killCounter = function(mob, player, optParams)
    if mission:getVar(player, 'KillCount') < 11 then
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
            ['Obstreperous_Panopt'] =
            {
                onMobDeath = killCounter,
            },

            onZoneIn = function(player, prevZone)
                if mission:getVar(player, 'KillCount') >= 11 then
                    mission:complete(player)
                end
            end,

            onTriggerAreaEnter = {
                [0] = function(player, triggerArea)
                    if mission:getVar(player, 'KillCount') >= 11 then
                        mission:complete(player)
                    end
                end,
            },
        },
    },
}

return mission
