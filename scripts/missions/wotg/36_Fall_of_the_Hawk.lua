-----------------------------------
-- Fall of the Hawk
-- Wings of the Goddess Mission 36
-----------------------------------
-- !addmission 5 35
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.FALL_OF_THE_HAWK)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.DARKNESS_DESCENDS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.CASTLE_ZVAHL_BAILEYS_S] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 4
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
