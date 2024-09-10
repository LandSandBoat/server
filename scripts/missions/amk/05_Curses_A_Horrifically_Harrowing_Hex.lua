-----------------------------------
-- Curses! A Horrifically Harrowing Hex
-- A Moogle Kupo d'Etat M5
-- !addmission 10 4
-- Shantotto : !pos 122 -2 112 239
-----------------------------------

local mission = Mission:new(xi.mission.log_id.AMK, xi.mission.id.amk.CURSES_A_HORRIFICALLY_HARROWING_HEX)

mission.reward =
{
    nextMission = { xi.mission.log_id.AMK, xi.mission.id.amk.AN_ERRAND_THE_PROFESSORS_PRICE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Shantotto'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(506)
                end,
            },

            onEventFinish =
            {
                [506] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
