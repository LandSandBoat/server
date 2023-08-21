-----------------------------------
-- The New Frontier
-- Zilart M1
-----------------------------------
-- NOTE: xi.mission.id.zilart.THE_NEW_FRONTIER is set after the Nation 5-1 Shadow Lord Battle
-- !addmission 3 0
-- !setrank <name> 6
-- Norg : !zone 252
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_NEW_FRONTIER)

mission.reward =
{
    keyItem     = xi.ki.MAP_OF_NORG,
    nextMission = { xi.mission.log_id.ZILART, xi.mission.id.zilart.WELCOME_TNORG },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                player:getRank(player:getNation()) >= 6
        end,

        [xi.zone.NORG] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 1
                end,
            },

            onEventFinish =
            {
                [1] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.NORG] =
        {
            ['_700']       = mission:event(5):replaceDefault(),
            ['Comitiolus'] = mission:event(6):replaceDefault(),
        },
    },
}

return mission
